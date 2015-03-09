<?php

/*
 * Exp:resso Store module for ExpressionEngine
 * Copyright (c) 2010-2014 Exp:resso (support@exp-resso.com)
 */

namespace Store\Cp;

use Illuminate\Database\Query\Expression as Raw;
use Store\Model\Order;
use Store\Model\OrderItem;
use Store\Model\Status;
use Store\Model\PaymentMethod;
use Store\Model\Transaction;
use Store\Model\Product;
use Store\Model\Tax;

class OrdersController extends AbstractController
{
    public $data = array();

    public function index()
    {
        $this->setTitle(lang('nav_orders'));

        $data = array();
        $data['currentStatus'] = $this->ee->input->get('status') ?: 'new';
        $data['currentPaid'] = $this->ee->input->get('paid') ?: '@all';


        $data['statusList'] = array();

        $order_statuses = Status::where('site_id', config_item('site_id'))->orderBy('sort')->get();
        foreach ($order_statuses as $status) {
            $data['statusList'][$status->name] = store_order_status_name($status->name);
        }

        $data['statusList']['@incomplete'] = lang('store.incomplete');
        $data['statusList']['@all'] = lang('store.any');

        $data['paidList'] = array();
        $data['paidList']['paid'] = lang('store.paid');
        $data['paidList']['unpaid'] = lang('store.unpaid');
        $data['paidList']['overpaid'] = lang('store.overpaid');
        $data['paidList']['@all'] = lang('store.any');

        $dtconfig = array();
        $dtconfig['name'] = 'orders';
        $dtconfig['sc'] = 'orders';
        $dtconfig['sm'] = 'datatable';
        $dtconfig['pagination'] = 'yes';
        $dtconfig['savestate'] = 'no';
        $dtconfig['fixed_post_data']['order_status'] = $data['currentStatus'];
        $dtconfig['fixed_post_data']['order_paid'] = $data['currentPaid'];
        $dtconfig['cols'][] = array('name' => 'id', 'label' => '#', 'width' => 60);
        $dtconfig['cols'][] = array('name' => 'customer', 'label' => lang('store.customer'));
        $dtconfig['cols'][] = array('name' => 'member', 'label' => lang('store.member'));
        $dtconfig['cols'][] = array('name' => 'date', 'label' => lang('store.order_date'), 'width' => 120);
        $dtconfig['cols'][] = array('name' => 'total_items', 'label' => lang('store.items'), 'width' => 80);
        $dtconfig['cols'][] = array('name' => 'total', 'label' => lang('store.total'), 'width' => 80);
        $dtconfig['cols'][] = array('name' => 'paid', 'label' => lang('store.paid?'), 'width' => 80);
        $dtconfig['cols'][] = array('name' => 'status', 'label' => lang('store.status'), 'width' => 120);

        $data['dt'] = $dtconfig;
        $data['dtconfig'] = json_encode($dtconfig);

        return $this->render('orders/index', $data);
    }

    public function show()
    {
        $order_id = (int) $this->ee->input->get('id');
        $order = Order::where('site_id', config_item('site_id'))->find($order_id);
        if (empty($order)) {
            return $this->show404();
        }

        $this->addBreadcrumb(store_cp_url('orders'), lang('nav_orders'));
        $this->setTitle(lang('store.order_#').$order_id);

        $data = array();
        $data['post_url'] = STORE_CP.'&amp;sc=orders&amp;sm=show&amp;id='.$order_id;
        $data['order'] = $order;
        $data['order_fields'] = $this->ee->store->config->order_fields();
        $data['payment_method'] = PaymentMethod::where('site_id', config_item('site_id'))->where('class', $order->payment_method)->first();
        $data['transactions'] = $order->transactions()->orderBy('date', 'desc')->get();
        $data['history'] = $order->history()->orderBy('order_status_updated', 'desc')->get();
        $data['can_add_payments'] = $this->ee->store->config->has_privilege('can_add_payments');

        $data['status_select_options'] = array();
        $statuses = Status::where('site_id', config_item('site_id'))->orderBy('sort')->get();
        foreach ($statuses as $status) {
            $data['status_select_options'][$status->id] = store_order_status_name($status->name);
        }
        $data['update_status_url'] = STORE_CP.'&amp;sc=orders&amp;sm=update_status&amp;order_id='.$order_id;

        if ($payment_id = (int) $this->ee->input->post('payment_id')) {
            $this->_capture_or_refund_payment($data['order'], $payment_id);
        }

        $data['new_payment_url'] = store_cp_url('orders', 'new_payment', array('order_id' => $order->id));
        $data['print_url'] = store_cp_url('orders', 'show', array('id' => $order->id, 'print' => 1));

        $data['invoice_link'] = config_item('store_order_invoice_url');
        if ( ! empty($data['invoice_link'])) {
            $data['invoice_link'] = str_replace('ORDER_ID', $order->id, $data['invoice_link']);
            $data['invoice_link'] = str_replace('ORDER_HASH', $order->order_hash, $data['invoice_link']);
            $data['invoice_link'] = $this->ee->functions->create_url($data['invoice_link']);
        }

        // Any Custom Fields
        $data['has_custom_fields'] = false;

        foreach ($data['order_fields'] as $field_name => $field) {
            if (strpos($field_name, 'order_custom') !== FALSE) {
                if ($field['title'] != '' || $order->$field_name != '') {
                    $data['has_custom_fields'] = true;
                }
            }
        }

        $html = $this->render('orders/show', $data);

        if ($this->ee->input->get('print')) {
            $layout_data = array(
                'title' => lang('store.order_#').$order->id,
                'body' => $html,
                'class' => 'order',
            );

            echo $this->ee->load->view('print_layout', $layout_data, true);
            exit;
        } else {
            return $html;
        }
    }

    public function capture_transaction()
    {
        $transaction = Transaction::where('site_id', config_item('site_id'))->find($this->ee->input->get('id'));
        if (empty($transaction)) {
            return $this->show404();
        }

        if ($transaction->canCapture()) {
            // capture transaction and display result
            $member_id = $this->ee->session->userdata('member_id');
            $child = $this->ee->store->payments->capture_transaction($transaction, $member_id);

            $message = $child->message ? ' ('.$child->message.')' : '';
            if ($child->status == Transaction::SUCCESS) {
                $this->ee->session->set_flashdata('message_success', lang('store.payment_capture_success').$message);
            } else {
                $this->ee->session->set_flashdata('message_failure', lang('store.payment_capture_failure').$message);
            }
        } else {
            $this->ee->session->set_flashdata('message_failure', lang('store.payment_capture_failure'));
        }

        $this->ee->functions->redirect(store_cp_url('orders', 'show', array('id' => $transaction->order_id)));
    }

    public function refund_transaction()
    {
        $transaction = Transaction::where('site_id', config_item('site_id'))->find($this->ee->input->get('id'));
        if (empty($transaction)) {
            return $this->show404();
        }

        if ($transaction->canRefund()) {
            // refund transaction and display result
            $member_id = $this->ee->session->userdata('member_id');
            $child = $this->ee->store->payments->refund_transaction($transaction, $member_id);

            $message = $child->message ? ' ('.$child->message.')' : '';
            if ($child->status == Transaction::SUCCESS) {
                $this->ee->session->set_flashdata('message_success', lang('store.payment_refund_success').$message);
            } else {
                $this->ee->session->set_flashdata('message_failure', lang('store.payment_refund_failure').$message);
            }
        } else {
            $this->ee->session->set_flashdata('message_failure', lang('store.payment_refund_failure'));
        }

        $this->ee->functions->redirect(store_cp_url('orders', 'show', array('id' => $transaction->order_id)));
    }

    public function delete()
    {
        $this->ee->store->orders->delete_orders($this->ee->input->post('selected'));

        $this->ee->session->set_flashdata('message_success', lang('store.orders_deleted'));
        $this->ee->functions->redirect(store_cp_url('orders'));
    }

    public function new_payment()
    {
        $this->requirePrivilege('can_add_payments');

        $order = Order::where('site_id', config_item('site_id'))->find($this->ee->input->get('order_id'));
        if (empty($order)) {
            return $this->show404();
        }

        $this->addBreadcrumb(store_cp_url('orders'), lang('nav_orders'));
        $this->addBreadcrumb(store_cp_url('orders', 'show', array('id' => $order->id)), lang('store.order_#').$order->id);
        $this->setTitle(lang('store.new_payment'));

        $transaction = new Transaction;
        $transaction->site_id = $order->site_id;
        $transaction->order_id = $order->id;
        $transaction->date = time();
        $transaction->payment_method = 'Manual';
        $transaction->type = Transaction::PURCHASE;
        $transaction->amount = $order->order_owing;
        $transaction->status = Transaction::SUCCESS;
        $transaction->member_id = (int) $this->ee->session->userdata('member_id');

        $this->ee->form_validation->set_rules('transaction[amount]', 'lang:amount', 'required|store_currency_non_zero');
        $this->ee->form_validation->set_rules('transaction[date]', 'lang:date', 'required');

        if ($this->ee->form_validation->run() === true) {
            $post = $this->ee->input->post('transaction', true);

            $transaction->amount = store_parse_decimal($post['amount']);
            $transaction->date = $this->ee->localize->string_to_timestamp($post['date']);
            $transaction->message = $post['message'];
            $transaction->reference = $post['reference'];
            $transaction->save();

            $this->ee->store->payments->update_order_paid_total($order);

            $this->ee->session->set_flashdata('message_success', lang('store.payment_added'));
            $this->ee->functions->redirect(store_cp_url('orders', 'show', array('id' => $order->id)));
        }

        $data = array();
        $data['order'] = $order;
        $data['transaction'] = $transaction;

        $this->ee->cp->add_js_script(array('ui' => 'datepicker'));

        return $this->render('orders/new_payment', $data);
    }

    public function update_status()
    {
        $order = Order::where('site_id', config_item('site_id'))->find($this->ee->input->get('order_id'));
        if (!$order) {
            return $this->show404();
        }
        $order_url = store_cp_url('orders', 'show', array('id' => $order->id));

        $status = Status::where('site_id', config_item('site_id'))->find($this->ee->input->post('status_id', true));
        if (!$status) {
            $this->ee->session->set_flashdata('message_failure', lang('store.invalid_status'));
            $this->ee->functions->redirect($order_url);
        }

        $message = $this->ee->input->post('message', true);
        $member_id = $this->ee->session->userdata('member_id');

        $order->updateStatus($status, $member_id, $message);

        $this->ee->session->set_flashdata('message_success', lang('store.order_status_updated'));
        $this->ee->functions->redirect($order_url);
    }

    public function edit()
    {
        $order_id = $this->ee->input->get('id');
        $item_id = $this->ee->input->get_post('item_id');
        $entry_id = $this->ee->input->get_post('entry_id');

        if (!$order_id ) {
            exit('MISSING ORDER ID');
        }

        $order = Order::find($order_id);

        if (!$order) {
            exit('ORDER NOT FOUND');
        }

        if ($item_id ) {
            $item = OrderItem::find($item_id );
        } else {
            $item = new OrderItem;
            $item->item_qty = 1;
        }

        $data = array();
        $data['order'] = $order;
        $data['item'] = $item;

        $section = $this->ee->input->get('section');

        if ($section == 'custom_fields') {
            exit($this->ee->load->view('orders/edit_order_custom_fields', $data, true));
        }

        if ($section == 'billing_details') {
            $data['country_options'] = $this->ee->store->shipping->get_enabled_country_options($order->billing_country, lang('store.select_country'));
            exit($this->ee->load->view('orders/edit_order_billing_details', $data, true));
        }

        if ($section == 'shipping_details') {
            $data['country_options'] = $this->ee->store->shipping->get_enabled_country_options($order->shipping_country, lang('store.select_country'));
            exit($this->ee->load->view('orders/edit_order_shipping_details', $data, true));
        }

        if ($section == 'tax') {
            $taxes = Tax::where('site_id', $order->site_id)->get();
            $data['taxes'] = array();
            $data['taxes'][] = lang('store.tax_name_select');

            foreach ($taxes as $tax) {
                $data['taxes'][$tax->id] = $tax->name;
            }

            $data['tax'] = $order->tax_override;

            if (!$data['tax']) {
                $data['tax'] = array('tax_id' => '', 'tax_rate' => 0, 'tax_amount' => '');
            }

            if (!isset($data['tax']['tax_id'])) $data['tax']['tax_id'] = '';
            if (!isset($data['tax']['tax_rate'])) $data['tax']['tax_rate'] = 0;
            if (!isset($data['tax']['tax_amount'])) $data['tax']['tax_amount'] = '';

            exit($this->ee->load->view('orders/edit_order_tax', $data, true));
        }

        if ($section == 'shipping') {
            $data['shipping'] = $order->shipping_override;

            if (!$data['shipping']) {
                $data['shipping'] = array('shipping_name' => '', 'shipping_amount' => '');
            }

            if (!isset($data['shipping']['shipping_name'])) $data['shipping']['shipping_name'] = '';
            if (!isset($data['shipping']['shipping_amount'])) $data['shipping']['shipping_amount'] = 0;

            exit($this->ee->load->view('orders/edit_order_shipping', $data, true));
        }

        if ($section == 'item') {
            if ($item->id > 0) {
                $data['modifiers_html'] = $this->get_modifiers_html($item->entry_id, $item);
            }
            exit($this->ee->load->view('orders/edit_order_item', $data, true));
        }
    }

    public function get_modifiers_html($entry_id=false, $item=false)
    {
        if (!$entry_id) {
            $entry_id = $this->ee->input->get_post('entry_id');
        }

        if (!$entry_id) exit();

        $product = Product::where('entry_id', $entry_id)->first();

        if (!$product) exit();

        $selectedModifiers = array();

        if ($item) {
            foreach ($item->modifiers as $mod) {
                if (isset($mod['modifier_id']) == false) continue;
                $selectedModifiers[] = $mod['modifier_id'] .'-'.$mod['option_id'];
            }
        }

        $html = '';

        foreach ($product->modifiers as $modifier) {
            $html .= '<tr>';
            $html .=    '<td style="width:150px">';
            $html .=        $modifier->mod_name;
            $html .=    '</td>';
            $html .=    '<td>';
            $disabled = $item ? 'disabled' : '';
            $html .=        '<select name="modifiers['.$modifier->product_mod_id.']" '.$disabled.'>';

            foreach ($modifier->options as $option) {
                $str = $modifier->product_mod_id . '-' . $option->product_opt_id;
                $selected = in_array($str, $selectedModifiers) ? 'selected' : '';
                $html .=        "<option value='{$option->product_opt_id}' {$selected}>{$option->opt_name}</option>";
            }

            $html .=        '</select>';
            $html .=    '</td>';
            $html .= '</tr>';
        }

        if ($html) {
            $html = '<table class="store_form" style="width:100%"><tbody>' . $html;
            $html .= '</tbody></table>';
        }

        if ($item) return $html;

        exit($html);
    }

    public function save()
    {
        if (!$this->ee->input->get_post('order_id')) {
            exit('MISSING ORDER ID');
        }

        $order = Order::find($this->ee->input->get_post('order_id'));

        if (!$order) {
            exit('ORDER NOT FOUND');
        }

        $section = $this->ee->input->get_post('section');

        if ($section == 'billing_details') {
            $order->billing_first_name = ee()->input->post('billing_first_name');
            $order->billing_last_name = ee()->input->post('billing_last_name');
            $order->billing_address1 = ee()->input->post('billing_address1');
            $order->billing_address2 = ee()->input->post('billing_address2');
            $order->billing_city = ee()->input->post('billing_city');
            $order->billing_state = ee()->input->post('billing_state');
            $order->billing_country = ee()->input->post('billing_country');
            $order->billing_postcode = ee()->input->post('billing_postcode');
            $order->billing_phone = ee()->input->post('billing_phone');
            $order->billing_company = ee()->input->post('billing_company');
            $order->billing_same_as_shipping = ee()->input->post('billing_same_as_shipping');
            $order->save();
        }

        if ($section == 'shipping_details') {
            $order->shipping_first_name = ee()->input->post('shipping_first_name');
            $order->shipping_last_name = ee()->input->post('shipping_last_name');
            $order->shipping_address1 = ee()->input->post('shipping_address1');
            $order->shipping_address2 = ee()->input->post('shipping_address2');
            $order->shipping_city = ee()->input->post('shipping_city');
            $order->shipping_state = ee()->input->post('shipping_state');
            $order->shipping_country = ee()->input->post('shipping_country');
            $order->shipping_postcode = ee()->input->post('shipping_postcode');
            $order->shipping_phone = ee()->input->post('shipping_phone');
            $order->shipping_company = ee()->input->post('shipping_company');
            $order->shipping_same_as_billing = ee()->input->post('shipping_same_as_billing');
            $order->save();
        }

        if ($section == 'custom_fields') {
            $order->order_custom1 = ee()->input->post('order_custom1');
            $order->order_custom2 = ee()->input->post('order_custom2');
            $order->order_custom3 = ee()->input->post('order_custom3');
            $order->order_custom4 = ee()->input->post('order_custom4');
            $order->order_custom5 = ee()->input->post('order_custom5');
            $order->order_custom6 = ee()->input->post('order_custom6');
            $order->order_custom7 = ee()->input->post('order_custom7');
            $order->order_custom8 = ee()->input->post('order_custom8');
            $order->order_custom9 = ee()->input->post('order_custom9');
            $order->save();
        }

        if ($section == 'tax') {
            $order->tax_override = null;

            if (ee()->input->post('tax_id') > 0) {
                $order->tax_override = array(
                    'tax_id' => ee()->input->post('tax_id'),
                    'tax_rate'  => ee()->input->post('tax_rate'),
                    'tax_amount'  => ee()->input->post('tax_amount'),
                );
            }
        }

        if ($section == 'shipping') {
            $order->shipping_override = null;

            if (ee()->input->post('shipping_name')) {
                $order->shipping_override = array(
                    'shipping_name' => ee()->input->post('shipping_name'),
                    'shipping_amount'  => ee()->input->post('shipping_amount'),
                );
            }
        }

        if ($section == 'item') {
            $this->saveItem($order);
        }

        // Recalculate Order
        $order->recalculate();

        exit(json_encode(array('success' => true, $order->getAttributes())));
    }

    private function saveItem($order)
    {
        $item_id = $this->ee->input->get_post('item_id');

        if ($this->ee->input->post('delete') == 'yes' && $item_id > 0) {
            OrderItem::find($item_id)->delete();
            return;
        }

        $attr = array();
        $attr['entry_id'] = $this->ee->input->get_post('entry_id');

        if ($item_id > 0) {
            $attr['item_id'] = $item_id;
            $attr['update_qty'] = $this->ee->input->post('item_qty');
        } else {
            $attr['item_qty'] = $this->ee->input->post('item_qty');
        }

        if (isset($_POST['modifiers'])) {
            $attr['modifiers'] = $_POST['modifiers'];
        }

        $item = $order->addItem($attr, array());

        if ($this->ee->input->post('title')) $item->title = $this->ee->input->post('title');
        if ($this->ee->input->post('price')) $item->price = $this->ee->input->post('price');
        if ($this->ee->input->post('handling')) $item->handling = $this->ee->input->post('handling');
        if ($this->ee->input->post('weight')) $item->weight = $this->ee->input->post('weight');
        if ($this->ee->input->post('length')) $item->length = $this->ee->input->post('length');
        if ($this->ee->input->post('width')) $item->width = $this->ee->input->post('width');
        if ($this->ee->input->post('height')) $item->height = $this->ee->input->post('height');

        if ($this->ee->input->post('tax_exempt')) $item->tax_exempt = ($this->ee->input->post('tax_exempt') == 'y') ? 1 : 0;
        if ($this->ee->input->post('free_shipping')) $item->free_shipping = ($this->ee->input->post('free_shipping') == 'y') ? 1 : 0;

        // We need to save it!
        $item->save();

    }

    public function datatable()
    {
        $post = json_decode(ee()->input->post('params'));

        //----------------------------------------
        // Columns
        //----------------------------------------
        $cols = array();
        $cols_inv = array();

        foreach ($post->columns as $index => $col) {
            $cols[$col->name] = $index;
        }

        $cols_inv = array_flip($cols);

        //----------------------------------------
        // Prepare Data Array
        //----------------------------------------
        $data = array();
        $data['data'] = array();
        $data['recordsFiltered'] = 0; // Total records, after filtering (i.e. the total number of records after filtering has been applied - not just the number of records being returned in this result set)
        $data['draw'] = (int) $post->draw;

        // Total records, before filtering (i.e. the total number of records in the database)
        //$data['recordsTotal'] = $this->db->table('store_orders')->where('site_id', config_item('site_id'))->where('order_completed_date', '>', 0)->count();
        $data['recordsTotal'] = $this->db->table('store_orders')->where('site_id', config_item('site_id'))->count();

        //----------------------------------------
        // Real Query
        //----------------------------------------
        $query = Order::with('member');
        $query->select(array('store_orders.*', $this->db->raw('CONCAT_WS(" ", `billing_first_name`, `billing_last_name`) AS `name`')));
        $query->leftJoin('members', 'members.member_id', '=', 'store_orders.member_id');
        $query->where('site_id', config_item('site_id'));
        //$query->where('order_completed_date', '>', 0);

        //----------------------------------------
        // WHERE/LIKE
        //----------------------------------------
        if (isset($post->search) && $post->search != false) {
            $query->where(function($query) use ($post) {
                $query->where('store_orders.id', $post->search)
                    ->orWhere('order_email', 'like', '%'.$post->search.'%')
                    ->orWhere('members.screen_name', 'like', '%'.$post->search.'%')
                    ->orWhere(new Raw('CONCAT_WS(" ", `billing_first_name`, `billing_last_name`)'), 'like', '%'.$post->search.'%');
            });
        }

        if (isset($post->order_status)) {
            switch ($post->order_status) {
                case '@incomplete':
                    $query->whereNull('order_completed_date');
                    break;
                case '@all':

                    break;
                default:
                    $query->where('order_status_name', $post->order_status);
                    break;
            }
        }

        if (isset($post->order_paid)) {
            switch ($post->order_paid) {
                case 'paid':
                    $query->where('order_paid', '=', new Raw('`order_total`'));
                    break;
                case 'unpaid':
                    $query->where('order_paid', '<', new Raw('`order_total`'));
                    break;
                case 'overpaid':
                    $query->where('order_paid', '>', new Raw('`order_total`'));
                    break;
                default:

                    break;
            }
        }

        //----------------------------------------
        // Sort By
        //----------------------------------------
        foreach ($post->order as $ord) {
            $col = $cols_inv[$ord->column];
            $sort = $ord->dir;

            switch ($col) {
                case 'id':
                    $query->orderBy('store_orders.id', $sort);
                    break;
                case 'date':
                    $query->orderBy('store_orders.order_date', $sort);
                    break;
                case 'total':
                    $query->orderBy('store_orders.order_total', $sort);
                    break;
                case 'paid':
                    $query->orderBy('store_orders.order_paid_date', $sort);
                    break;
                case 'status':
                    $query->orderBy('store_orders.order_status_name', $sort);
                    break;
            }
        }

        if (empty($post->order)) $query->orderBy('store_orders.id', 'DESC');

        //----------------------------------------
        // OFFSET & LIMIT & EXECUTE!
        //----------------------------------------
        $limit = 15;
        if ($post->length !== FALSE) {
            $limit = $post->length;
            if ($limit < 1) $limit = 999999;
        }

        $offset = 0;
        if ($post->start !== FALSE) {
            $offset = $post->start;
        }

        $query->limit($limit);
        $query->offset($offset);

        //----------------------------------------
        // Get total before real SELECT
        //----------------------------------------
        $quick_query = clone($query->getQuery());
        $quick_query->orders = null;
        $quick_query->limit = null;
        $quick_query->offset = null;

        $data['recordsFiltered'] = $quick_query->count();

        $items = $query->get();
        $mcpBaseUrl = $post->mcp_base_url;


        //----------------------------------------
        // Loop Over all
        //----------------------------------------
        foreach ($items as $order)
        {
            if (!$order->order_id) {
                $order->order_id = 'CART_' . $order->id;
            }

            //----------------------------------------
            // Create TR row
            //----------------------------------------
            $trow = array();
            $trow['DT_RowId']  = $order->id;
            $trow['id'] = '<a href="'.store_cp_url('orders', 'show', array('id' => $order->id)).'">'.$order->order_id.'</a>';
            $trow['customer'] = $order->billing_name;
            $trow['member'] = $order->member ? store_member_link($order->member) : '<i>(' . lang('store.guest') . ')</i>';
            $trow['date'] = $this->ee->localize->human_time($order->order_date);
            $trow['total_items'] = $order->order_qty;
            $trow['total'] = '<div class="text-right">' . store_currency($order->order_total) . '</div>';
            $trow['paid'] = store_order_paid($order);
            $trow['status'] = store_order_status($order);

            $data['data'][] = $trow;
        }

        exit(json_encode($data));
    }
}

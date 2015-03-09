<div class="container-fluid">

<div class="row pagehead">
    <div class="col-xs-6">
        <h2><i class="fa fa-list-ul"></i> <?=lang('store.orders')?></h2>
    </div>
    <div class="col-xs-3"></div>
    <div class="col-xs-3">
        <div class="filters">
            <input name="search" type="text" placeholder="<?=lang('store.search')?>" style="border:1px solid #ccc; margin-top:4px;">
        </div>
    </div>
</div>

<div class="osections-toggler row">
<ul>
    <?php foreach ($statusList as $name => $label):?>
    <li <?php if ($currentStatus == $name) echo 'class="selected"';?> >
        <a href="<?=store_cp_url('orders', null, array('status' => $name, 'paid' => $currentPaid))?>"><?=$label?></a>
    </li>
    <?php endforeach;?>
</ul>
<ul style="float:right">
    <?php foreach ($paidList as $name => $label):?>
    <li <?php if ($currentPaid == $name) echo 'class="selected"';?> >
        <a href="<?=store_cp_url('orders', null, array('paid' => $name, 'status' => $currentStatus))?>"><?=$label?></a>
    </li>
    <?php endforeach;?>
</ul>
</div>

<br>

<div class="datatable">
    <table>
        <script type="text/x-subs" class="dtconfig"><?=$dtconfig?></script>
    </table>
</div>


</div>
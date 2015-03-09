<?php

$plugin_info = array(
    'pi_name' => 'NSM Utils',
    'pi_version' => '1.0',
    'pi_author' => 'Newism',
    'pi_author_url' => 'http://newism.com.au',
    'pi_description' => 'Newism Utils for ExpressionEngine',
    'pi_usage' => '',
);

class Nsm_utils
{
    /**
     * @var CI_Controller|null
     */
    private $ee;

    public function debug_override()
    {
        $this->ee =& get_instance();

        $override = $this->ee->TMPL->fetch_param('override', 'ajax');

        // no debugging or output-profiler for ajax
        if (($override == 'all') || ($override == 'ajax' && AJAX_REQUEST)) {
            $this->ee->TMPL->debugging = FALSE;
            $this->ee->output->enable_profiler(FALSE);
        }

    }

}
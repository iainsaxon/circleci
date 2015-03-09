<?php

$plugin_info = array(
    'pi_name' => 'debug_override',
    'pi_version' => '1.0',
    'pi_author' => 'Newism',
    'pi_author_url' => 'http://newism.com.au',
    'pi_description' => 'Disable template and output debugging per template',
    'pi_usage' => '{exp:debug_override override="all|ajax"} default is override on ajax calls',
);

class debug_override
{
    /**
     * @var CI_Controller|null
     */
    private $ee;

    public function __construct()
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
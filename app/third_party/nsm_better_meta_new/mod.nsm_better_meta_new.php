<?php


class Nsm_better_meta_new
{
    /**
     * @var EE_Controller|null
     */
    private $ee;

    public function sitemap_index()
    {
        if(class_exists('Channel') === FALSE)
        {
            require PATH_MOD.'channel/mod.channel'.EXT;
        }

        $this->ee =& get_instance();

        /** @var EE_Template $template */
        $template = $this->ee->TMPL;
        $template->tagparams['disable'] = $template->fetch_param('disable', "categories|custom_fields|category_fields|member_data");
        $template->tagparams['dynamic'] = $template->fetch_param('dynamic', "no");
        $template->tagparams['limit'] = $template->fetch_param('limit', 1);

        /** @var string $tagData */
        $tagData = $template->tagdata;

        /** @var Channel $channelInstance */
        $channelInstance = new Channel();
        $channelInstance->initialize();

        /** @var EE_Pagination $pagination */
        $pagination = $channelInstance->pagination;
        $pagination->paginate = true;

        // Build the sql statement which populates the pagination object
        $channelInstance->build_sql_query();
        if ($channelInstance->sql == '') {
            return $template->no_results();
        }

        // Create the base url based on paginate_base param
        $baseUrl = $this->ee->functions->create_url(
            trim_slashes(ee()->TMPL->fetch_param('paginate_base'))
        );

        $pageLinkArray = array();

        // Loop over all pages creating links
        for ($page = 1; $page <= $pagination->total_pages; $page++) {
            $offset = ($page - 1) * $pagination->per_page;
            $paginationSegment = $pagination->prefix . $offset;
            $pageLinkArray[] = array(
                'pagination_url' => $baseUrl . '/' . $paginationSegment
            );
        }

        $tagData = $template->parse_variables($tagData, $pageLinkArray);

        return $tagData;
    }

}
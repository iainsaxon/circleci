<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Boardworld Extension
 */
class Boardworld_ext
{
    public $version = '1.0.0';
    public $name = 'Boardworld';
    public $description = '';
    public $docs_url = '';
    public $settings_exist = FALSE;
    public $settings = array();

    protected $ee;

    /**
     *
     */
    public function __construct()
    {
        $this->ee = ee();
    }

    /**
     * @param $Channel
     * @param $row
     * @return mixed
     */
    public function channel_entries_row($Channel, $row)
    {
        if ($this->ee->extensions->last_call !== false) {
            $row = $this->ee->extensions->last_call;
        }

        // Load in some topic variables to the row rather than the {categories} loop.
        $row['topic_category_id'] = '';
        $row['topic_category_name'] = '';
        $row['topic_category_url_title'] = '';

        foreach ($Channel->categories as $categoryData) {

            if (true === empty($categoryData)) {
                return $row;
            }

            $categoryData = $categoryData[0];

            $catVars = array(
                'category_name' => $categoryData[2],
                'category_url_title' => $categoryData[6],
                'category_description' => (isset($categoryData[4])) ? $categoryData[4] : '',
                'category_group' => (isset($categoryData[5])) ? $categoryData[5] : '',
                'category_id' => $categoryData[0],
                'parent_id' => $categoryData[1]
            );

            if (10 === (int)$catVars['category_group']) {
                $row['topic_category_id'] = $catVars['category_id'];
                $row['topic_category_name'] = $catVars['category_name'];
                $row['topic_category_url_title'] = $catVars['category_url_title'];
            }
        }

        return $row;
    }
}

<?php

namespace Boardworld\Command;

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;

/**
 * Command to export articles from another sibling database
 */
class ExportArticlesCommand extends Command
{

    protected $name = 'boardworld:export:articles';
    protected $description = 'Exports the articles from the old Boardworld database.';

    /**
     * Run the command
     *
     * @return string
     */
    protected function fire()
    {
        $ee = ee();
        $oldDbConfig = array(
            'dbdriver' => 'mysqli',
            'dbprefix' => 'exp_',
            'hostname' => 'localhost',
            'username' => 'root',
            'password' => '',
            'database' => 'boardworld.com.au',
        );

        // prep the options array
        $formattedOptions = array(
            'limit' => (int) $this->option('limit'),
            'offset' => (int) $this->option('offset'),
            'entry_ids' => array_filter(array_map('trim', explode(',', $this->option('entry_ids')))),
            'pretty_json' => (bool) $this->option('pretty_json'),
        );

        // create a new database connection using these params and return the connector
        $oldDb = $ee->load->database($oldDbConfig, true);

        // build the query to retrieve the articles
        $oldDb->from('channel_titles');
        $oldDb->join('channel_data', 'channel_data.entry_id = channel_titles.entry_id');
        $oldDb->join('members', 'members.member_id = channel_titles.author_id');
        $oldDb->join('channels', 'channels.channel_id = channel_titles.channel_id');
        $oldDb->join('matrix_data', 'matrix_data.entry_id = channel_titles.entry_id', 'left');
        $oldDb->join('assets_selections', 'assets_selections.entry_id = channel_titles.entry_id', 'left');
        $oldDb->join('assets_files', 'assets_files.file_id = assets_selections.file_id', 'left');
        $oldDb->join('category_posts', 'category_posts.entry_id = channel_titles.entry_id');
        $oldDb->join('categories', 'categories.cat_id = category_posts.cat_id');
        $oldDb->group_by('channel_titles.entry_id');
        $oldDb->select('channel_titles.*');
        $oldDb->select('channel_data.*');
        $oldDb->select('members.member_id, members.username, members.screen_name');
        $oldDb->select('channels.channel_name');
        $oldDb->select('assets_files.file_id, assets_files.file_name, assets_files.filedir_id');
        $oldDb->select('GROUP_CONCAT(col_id_3 SEPARATOR "|") AS article_videos');
        $oldDb->select('GROUP_CONCAT(DISTINCT cat_url_title SEPARATOR "|") AS article_categories');
        $oldDb->where(array(
            'channel_name' => 'articles'
        ));
        $oldDb->limit($formattedOptions['limit'], $formattedOptions['offset']);

        // limit by entry ids if specified
        if (count($formattedOptions['entry_ids']) > 0) {
            $oldDb->where_in('channel_titles.entry_id', $formattedOptions['entry_ids']);
        }

        // get the articles
        $getArticles = $oldDb->get();

        // build the array of articles to output in a JSON array format
        $articles = array_map(function($a) use ($ee) {
            $formattedEntryDate = $ee->localize->format_date('%Y%m%d%H%i%s', $a['entry_date']);
            $formattedExpirationDate = $ee->localize->format_date('%Y%m%d%H%i%s', $a['expiration_date']);
            $imageAsset = array(
                'file_id' => (int) $a['file_id'],
                'file_name' => $a['file_name'],
                'filedir_id' => (int) $a['filedir_id'],
                'caption' => $a['field_id_22'],
            );
            $article = array(
                'entry_id' => (int) $a['entry_id'],
                'title' => $a['title'],
                'url_title' => $a['url_title'],
                'channel_name' => $a['channel_name'],
                'status' => $a['status'],
                'entry_date' => $formattedEntryDate,
                'expiration_date' => ($a['expiration_date'] > 0 ? $formattedExpirationDate : null),
                'edit_date' => $a['edit_date'],
                'article_categories' => explode('|', $a['article_categories']),
                'author' => array(
                    'member_id' => (int) $a['author_id'],
                    'username' => $a['username'],
                    'screen_name' => $a['screen_name'],
                ),
                'article_type' => $a['field_id_30'],
                'image_asset' => ($a['file_id'] > 0 ? $imageAsset : null),
                'link_text' => $a['field_id_24'],
                'videos' => explode('|', $a['article_videos']),
                'article_body' => $a['field_id_25'],
            );

            return $article;

        }, $getArticles->result_array());

        if (true === $formattedOptions['pretty_json']) {
            $output = json_encode($articles, JSON_PRETTY_PRINT);
        } else {
            $output = json_encode($articles);
        }

        $this->info($output);
    }

    /**
     * @return array
     */
    public function getOptions()
    {
        return array(
            array(
                'limit', // name
                null, // shortcut
                InputOption::VALUE_REQUIRED, // mode
                'Limit the number of articles returned', // description
                99999999, // default value
            ),
            array(
                'offset', // name
                null, // shortcut
                InputOption::VALUE_REQUIRED, // mode
                'Choose the offset for returned articles', // description
                0, // default value
            ),
            array(
                'entry_ids', // name
                null, // shortcut
                InputOption::VALUE_REQUIRED, // mode
                'Comma-delimited list of entry IDs for articles to filter by', // description
                '', // default value
            ),
            array(
                'pretty_json', // name
                'p', // shortcut
                InputOption::VALUE_NONE, // mode
                'Output JSON in pretty format', // description
            ),

        );
    }
}

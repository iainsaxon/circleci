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

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->ee =& get_instance();
    }

    /**
     * Override Debug Output and Profiler
     */
    public function debug_override()
    {
        $tmpl = $this->ee->TMPL;
        $output = $this->ee->output;

        $override = $tmpl->fetch_param('override', 'ajax');

        // no debugging or output-profiler for ajax
        if (($override == 'all') || ($override == 'ajax' && AJAX_REQUEST)) {
            $tmpl->debugging = FALSE;
            $output->enable_profiler(FALSE);
        }
    }

    /**
     * Get Forum Topics
     *
     * Board Id: {board_id}
     * Board Name: {board_name}
     * Board Forum Trigger: {board_forum_trigger}
     * Board Url: {board_url}
     *
     * Forum Id: {forum_id}
     * Forum Name: {forum_name}
     * Forum Url: {forum_url}
     *
     * Topic Id: {topic_id}
     * Topic Title: {topic_title}
     * Topic Url: {topic_url}
     * Topic Date: {topic_date format='{DATE_W3C}'}
     * Topic Thread Total Count: {topic_thread_total_count}
     * Topic Thread View Count: {topic_thread_view_count}
     *
     * Author Id: {author_id}
     * Author Avatar: {author_avatar}
     * Author Screen Name: {author_screen_name}
     * Author Username: {author_username}
     *
     * Last Post Id: {last_post_id}
     * Last Post Date: {last_post_date format='{DATE_W3C}'}
     * Last Post Author Id: {last_post_author_id}
     * Last Post Author Avatar: {last_post_author_avatar}
     * Last Post Author Screen name: {last_post_author_screen_name}
     * Last Post Author Username: {last_post_author_username}
     *
     * @return mixed
     */
    public function forum_topics()
    {
        $db = $this->ee->db;
        $tmpl = $this->ee->TMPL;
        $config = $this->ee->config;

        $topicId = $tmpl->fetch_param('topic_id', '1|2');
        $orderBy = $tmpl->fetch_param('order_by', 'last_post_date');
        $sort = $tmpl->fetch_param('sort', 'desc');
        $limit = $tmpl->fetch_param('limit', 3);

        $db->select('
                    forum_boards.board_name as board_name,
                    forum_boards.board_forum_trigger as board_forum_trigger,

                    forums.forum_name as forum_name,

                    forum_topics.board_id,
                    forum_topics.forum_id,
                    forum_topics.topic_id,
                    forum_topics.author_id,
                    forum_topics.title as topic_title,
                    forum_topics.topic_date,
                    forum_topics.thread_total as topic_thread_total_count,
                    forum_topics.thread_views as topic_thread_view_count,
                    forum_topics.last_post_date,
                    forum_topics.last_post_author_id,
                    forum_topics.last_post_id,

                    author.username as author_username,
                    author.screen_name as author_screen_name,
                    author.avatar_filename as author_avatar,

                    last_post_author.username as last_post_author_username,
                    last_post_author.screen_name as last_post_author_screen_name,
                    last_post_author.avatar_filename as last_post_author_avatar

                    ');
        $db->from('forum_topics');
        $db->join('forums', 'forum_topics.forum_id = forums.forum_id');
        $db->join('forum_boards', 'forum_topics.board_id = forum_boards.board_id');
        $db->join('members as author', 'forum_topics.author_id = author.member_id');
        $db->join('members as last_post_author', 'forum_topics.last_post_author_id = last_post_author.member_id', 'left');
        $db->order_by($orderBy, $sort);
        $db->limit($limit);

        if ($topicId) {
            $db->where_in('topic_id', explode("|", $topicId));
        }

        $query = $db->get();

        if (0 == $query->num_rows()) {
            return $tmpl->no_results();
        }

        $avatarUrl = $config->item('avatar_url');
        $siteUrl = $config->item('site_url');

        $data = array();

        foreach ($query->result_array() as $result) {
            $result['author_avatar'] = $avatarUrl . $result['author_avatar'];
            $result['last_post_author_avatar'] = $avatarUrl . $result['last_post_author_avatar'];
            $result['board_url'] = $siteUrl . "/" . $result['board_forum_trigger'];
            $result['forum_url'] = $result['board_url'] . "/viewforum/" . $result["forum_id"];
            $result['topic_url'] = $result['board_url'] . "/viewthread/" . $result["topic_id"];
            $data[] = $result;
        }

        return $tmpl->parse_variables($tmpl->tagdata, $data);
    }

    /**
     * Render the page number based on the limit and offset
     *
     * Usage: {exp:nsm_utils:page_number limit='2'}
     */
    public function page_number()
    {
        $tmpl = $this->ee->TMPL;
        $uri = $this->ee->uri;

        $limit = $tmpl->fetch_param('limit');
        $segments = $uri->segment_array();
        $lastSegment = array_pop($segments);
        $offset = 0;

        if (preg_match('#P(\d+)?$#', $lastSegment, $match)) {
            $offset = $match[1];
        }

        $pageNum = ($offset / $limit) + 1;

        return $pageNum;
    }

    /**
     * Explode a string
     *
     * Usage:
     *
     * {exp:nsm_utils:explode string='{gv_facebook_admins}'}
     * <meta property="fb:admins" content="{string}" />
     * {/exp:nsm_utils:explode}
     */
    public function explode()
    {

        $tmpl = $this->ee->TMPL;

        $delimiter = $tmpl->fetch_param('delimiter', '|');
        $string = $tmpl->fetch_param('string', false);

        $data = array();
        $parts = array_filter(explode($delimiter, $string));

        if (true === empty($parts)) {
            return false;
        }

        foreach ($parts as $part) {
            $data[] = array('string' => $part);
        }

        return $tmpl->parse_variables($tmpl->tagdata, $data);
    }

    /**
     * Fetch a relationship child ids
     *
     * @return bool
     */
    public function relationship_child_ids()
    {
        $db = $this->ee->db;
        $tmpl = $this->ee->TMPL;

        $delimiter = $tmpl->fetch_param('delimiter', '|');
        $fieldName = $tmpl->fetch_param('field');
        $entryId = $tmpl->fetch_param('entry_id');

        $db->from("relationships")
            ->select("GROUP_CONCAT(`exp_relationships`.`child_id` SEPARATOR '" . $delimiter . "') as 'child_ids'")
            ->join('channel_fields', 'channel_fields.field_id = relationships.field_id')
            ->where('channel_fields.field_name', $fieldName);

        if ($entryId) {
            $db->where_in('relationships.parent_id', explode("|", $entryId));
        }

        $query = $db->get();

        if ($query->num_rows) {
            return $query->row()->child_ids;
        }

        return false;
    }

    /**
     * Simple string replace
     */
    public function str_replace()
    {
        $tmpl = $this->ee->TMPL;
        $search = $tmpl->fetch_param('search');
        $replace = $tmpl->fetch_param('replace');
        $subject = $tmpl->fetch_param('subject');
        $count = $tmpl->fetch_param('count', null);

        return str_replace($search, $replace, $subject, $count);

    }
}

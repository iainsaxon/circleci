<?php

$topics = array('surf', 'skate', 'snow');
$contentTypes = array('articles', 'brands', 'places', 'products', 'promotions', 'tutorials');

$routes = array(

    // Site Routes
    '/' => 'site/index',
    'four04' => 'site/four04',
    'sitemap.xml' => function ($router) {
        $router->setContentType('text/xml');
        $router->setTemplate('site/sitemap');
    },
    'robots.txt' => function ($router) {
        $router->setContentType('text/plain');
        $router->setTemplate('site/-robots');
    },
    'site/:any' => function (\rsanchez\ResourceRouter\Router $router) {
        $router->set404();
    },

    // Search Routes
    'search' => 'search/index',
    'search/sitemap.xml' => 'search/sitemap',
    'search/sitemap-shortcuts.xml' => 'search/sitemap-shortcuts',
    'search/sitemap-popular.xml' => 'search/sitemap-popular',
    'opensearch.xml' => 'search/opensearch',

    // Account Routes
    'account' => 'account/index',
    'account/login' => 'account/login',
    'account/forgot-password' => 'account/forgot-password',
    'account/create' => 'account/create',
    'account/update' => function (\rsanchez\ResourceRouter\Router $router) {
        if (!ee()->session->userdata['member_id']) {
            $router->redirect("account/login?return=" . urlencode($_SERVER['REQUEST_URI']));
        }
    },

    // Store Routes
    'store' => function (\rsanchez\ResourceRouter\Router $router) {
        $router->redirect("/products");
    },
    'store/sitemap.xml' => 'store/sitemap',
    'store/purchases' => function (\rsanchez\ResourceRouter\Router $router) {
        if (!ee()->session->userdata['member_id']) {
            $router->redirect("account/login?return=" . urlencode($_SERVER['REQUEST_URI']));
        }
    },

    // Topics routes
    'topics/sitemap.xml' => 'topics/sitemap',
    'topics/sitemap-entries/:pagination' => 'topics/sitemap-entries',
);

$contentTypeRoutes = array();

foreach($contentTypes as $contentType) {
    // Create and index topic route
    $contentTypeRoutes[$contentType] = $contentType.'/index';
    $contentTypeRoutes[$contentType.'/search/:all'] = $contentType.'/search';
    $contentTypeRoutes[$contentType.'/details/:url_title'] = $contentType.'/read';
    $contentTypeRoutes[$contentType.'/archive'] = $contentType.'/archive';
    $contentTypeRoutes[$contentType.'/sitemap.xml'] = $contentType.'/sitemap';
    $contentTypeRoutes[$contentType.'/sitemap-entries/:pagination'] = $contentType.'/sitemap-entries';
}

$routes = array_merge($routes, $contentTypeRoutes);

/**
 * Topic based routing
 */

$topicRoutes = array();

foreach($topics as $topic) {

    // Create and index topic route
    $topicRoutes[$topic] = function (\rsanchez\ResourceRouter\Router $router) use ($topic) {
        $router->setTemplate('topics/index');
        $router->setGlobal('rr_page_topic', $topic);
    };

    $topicRoutes[$topic . "/:any:pagination"] = function (
        \rsanchez\ResourceRouter\Router $router,
        \rsanchez\ResourceRouter\Wildcard $wildcard
    ) use ($topic) {

        $shortcutName = $topic . "-" .$wildcard->value;
        $shortcutDataQuery = ee()->db->get_where('low_search_shortcuts', array('shortcut_name' => $shortcutName));

        if(0 === $shortcutDataQuery->num_rows()) {
            $router->set404();
            return;
        }

        $shortcutData = $shortcutDataQuery->row();
        $router->setTemplate('topics/search');
        $router->setGlobal('rr_page_topic', $topic);
        $router->setGlobal('rr_search_shortcut_id', $shortcutData->shortcut_id);
        $router->setGlobal('rr_search_shortcut_group_id', $shortcutData->group_id);
        $router->setGlobal('rr_search_shortcut_name', $shortcutData->shortcut_name);
        $router->setGlobal('rr_search_shortcut_label', $shortcutData->shortcut_label);
    };
}

$routes = array_merge($routes, $topicRoutes);

return $routes;

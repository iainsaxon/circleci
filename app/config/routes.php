<?php

return array(

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
    // Search Routes
    'search' => 'search/index',
    'opensearch.xml' => 'search/opensearch',
    'site/:any' => function (\rsanchez\ResourceRouter\Router $router) {
        $router->set404();
    },


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
    'store/purchases' => function (\rsanchez\ResourceRouter\Router $router) {
        if (!ee()->session->userdata['member_id']) {
            $router->redirect("account/login?return=" . urlencode($_SERVER['REQUEST_URI']));
        }
    },

    // Example Channel Routes
    'news/:pagination' => 'news/index',
    'news/search/:all' => 'news/search',
    'news/details/:all' => 'news/details',
    'news/archive' => 'news/archive',
    'news/:all' => 'news/category',
    'news/sitemap.xml' => function (\rsanchez\ResourceRouter\Router $router) {
        $router->setContentType('text/xml');
        $router->setTemplate('news/sitemap');
    }

);
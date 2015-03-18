CircleCI
========

![Build Status](https://circleci.com/gh/newism/circleci.svg?style=shield&circle-token=ebfe085f0d4abcf3da52c57819950d6267181cf5)

Install & Setup
---------------

1. Create a new local domain http://local.example.com and point it to [web](./web)
2. Install node modules: `npm install`
3. Install composer modules: `composer install`
4. Install bower components: `bower install`
5. Install gems via bundler: `bundle install`

Running Tests
-------------

* Run Behat tests w/ `bin/behat`

Gulp
----

This project implements a gulpfile.js for "building" the project.

* Before developing run `gulp browsersync` to auto build and reload assets across browsers.
* To "build" the project and copy all assets run `gulp build`

Email
-----

Production Email:

* Sent using [MandrillApp](https://mandrillapp.com) SMTP
* Each new site requires a new Mandrill account
* Modify [app/config_bootstrap.php](app/config/parameters.json) with smtp details

Testing Email:

* Sent using [MailTrap](https://mailtrap.io) SMTP
* Each new site requires a new inbox
* Modify [app/config_bootstrap.php](app/config/parameters.json) with smtp details


Building a Site
---------------

### browserconfig.xml

**We don't hate IE11!**

Please read: https://msdn.microsoft.com/en-us/library/ie/dn455106.aspx

### EECLI

eecli: https://github.com/rsanchez/eecli

### CE Image

Photos and avatars should only have one resize which is equal to double their max pixel size.

Deploying a Site
----------------

`bundle exec cap production deploy`



Site Reference
---------------

### Site

#### Template Groups / Templates

    bin/eecli create:template_group site --default
    bin/eecli create:template site/index
    bin/eecli create:template site/sitemap --type="xml"
    bin/eecli create:template site/-layout
    bin/eecli create:template site/-robots
    bin/eecli create:template site/-four04

### Homepage

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Homepages
    bin/eecli create:category_group Homepages
    bin/eecli create:channel homepages Homepages --field_group=Homepages --cat_group=Homepages
    bin/eecli create:field:wygwam "Content" cf_homepage_content Homepages
    bin/eecli create:field:assets "Feature Image" cf_homepage_feature_image Homepages
    bin/eecli create:field:assets "Thumbnail Image" cf_homepage_thumbnail_image Homepages
    bin/eecli create:field:text "Security Token" cf_homepage_security_token Homepages

    bin/eecli create:field:text "Feature Forum Posts" cf_homepage_feature_form_posts Homepages

    bin/eecli create:field:relationship "Most Popular" cf_homepage_most_popular Homepages \
        --channel="articles" \
        --channel="promotions" \
        --channel="places" \
        --channel="tutorials" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_homepage_related_products Homepages \
        --channel="products" \
        --multiple

    bin/eecli create:field:relationship "Related Brands" cf_homepage_related_brands Homepages \
        --channel="brands" \
        --multiple

### Comments

#### Template Groups / Templates

    bin/eecli create:template_group comments
    bin/eecli create:template comments/index
    bin/eecli create:template comments/_form-create
    bin/eecli create:template comments/-entries

### Pages

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Pages
    bin/eecli create:category_group Pages
    bin/eecli create:channel pages Pages --field_group=Pages --cat_group=Pages
    bin/eecli create:field:wygwam "Content" cf_page_content Pages
    bin/eecli create:field:assets "Feature Image" cf_page_feature_image Pages
    bin/eecli create:field:assets "Thumbnail Image" cf_page_thumbnail_image Pages

    bin/eecli create:field:relationship "Related Promotions" cf_page_related_promotions Pages \
        --channel="promotions" \
        --multiple

    bin/eecli create:field:relationship "Related Articles" cf_page_related_articles Pages \
        --channel="articles" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_page_related_products Pages \
        --channel="products" \
        --multiple

#### Template Groups / Templates

    bin/eecli create:template_group pages
    bin/eecli create:template pages/read

### Search

#### Template Groups / Templates

    bin/eecli create:template_group search
    bin/eecli create:template search/index
    bin/eecli create:template search/results
    bin/eecli create:template search/save-shortcut
    bin/eecli create:template search/-opensearch
    bin/eecli create:template search/_form-search-simple
    bin/eecli create:template search/_form-search-advanced
    bin/eecli create:template search/_form-search-save-shortcut

### Account

#### Template Groups / Templates

    bin/eecli create:template_group account
    bin/eecli create:template account/index
    bin/eecli create:template account/login
    bin/eecli create:template account/_session
    bin/eecli create:template account/_form-login
    bin/eecli create:template account/forgot-password
    bin/eecli create:template account/_form-forgot-password
    bin/eecli create:template account/create
    bin/eecli create:template account/_form-create
    bin/eecli create:template account/update
    bin/eecli create:template account/_form-update
    bin/eecli create:template account/_nav

### Store

#### Template Groups / Templates

    bin/eecli create:template_group store --default
    bin/eecli create:template store/index
    bin/eecli create:template store/order-checkout
    bin/eecli create:template store/order-details
    bin/eecli create:template store/order-payment
    bin/eecli create:template store/order-receipt
    bin/eecli create:template store/orders
    bin/eecli create:template store/_cart-simple
    bin/eecli create:template store/_cart-advanced
    bin/eecli create:template store/_form-add-to-cart

### Newsletter

#### Template Groups / Templates

    bin/eecli create:template_group newsletter --default
    bin/eecli create:template newsletter/index
    bin/eecli create:template newsletter/_form-subscribe

### Topics

    bin/eecli create:field_group Topics
    bin/eecli create:category_group Topics
    bin/eecli create:channel topics Topics --field_group=Topics --cat_group=Topics
    bin/eecli create:field:wygwam "Content" cf_topic_content Topics
    bin/eecli create:field:assets "Feature Image" cf_topic_feature_image Topics

    bin/eecli create:field:text "Feature Forum Posts" cf_topic_feature_form_posts Topics

    bin/eecli create:field:relationship "Most Popular" cf_topic_most_popular Topics \
        --channel="articles" \
        --channel="promotions" \
        --channel="places" \
        --channel="tutorials" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_topic_related_products Topics \
        --channel="products" \
        --multiple

    bin/eecli create:field:relationship "Related Brands" cf_topic_related_brands Topics \
        --channel="brands" \
        --multiple

#### Template Groups / Templates

    bin/eecli create:template_group topics
    bin/eecli create:template topics/index
    bin/eecli create:template topics/search

### Advertisements

    bin/eecli create:field_group Advertisements
    bin/eecli create:category_group Advertisements
    bin/eecli create:channel advertisements Advertisements --field_group=Advertisements --cat_group=Advertisements
    bin/eecli create:field:wygwam "Content" cf_advertisement_content Advertisements
    bin/eecli create:field:assets "Feature Image" cf_advertisement_feature_image Advertisements --multiple
    bin/eecli create:field:text "Tags" cf_advertisement_tags Advertisements --searchable
    bin/eecli create:field:text "Outgoing URL" cf_advertisement_url Advertisements
    bin/eecli create:field:text "Click Value" cf_advertisement_click_value Advertisements --searchable
    bin/eecli create:field:text "Impression Value" cf_advertisement_impression_value Advertisements --searchable

#### Template Groups / Templates

    bin/eecli create:template_group advertisements
    bin/eecli create:template advertisements/index
    bin/eecli create:template advertisements/-ad-placeholder
    bin/eecli create:template advertisements/_ad-block

### Articles

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Articles
    bin/eecli create:category_group Articles
    bin/eecli create:channel articles Articles --field_group=Articles --cat_group=Articles
    bin/eecli create:field:assets "Feature Image" cf_article_feature_image Articles
    bin/eecli create:field:text "Feature Video (YouTube Video ID)" cf_article_feature_video Articles
    bin/eecli create:field:wygwam "Content" cf_article_content Articles
    bin/eecli create:field:assets "Thumbnail Image" cf_article_thumbnail_image Articles
    bin/eecli create:field:text "Advertisement Search Query" cf_article_ad_search_query Articles

    bin/eecli create:field:relationship "Related Promotions" cf_article_related_promotions Articles \
        --channel="promotions" \
        --multiple

    bin/eecli create:field:relationship "Related Articles" cf_article_related_articles Articles \
        --channel="articles" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_article_related_products Articles \
        --channel="products" \
        --multiple

#### Template Groups / Templates

    bin/eecli create:template_group articles
    bin/eecli create:template articles/index
    bin/eecli create:template articles/-entries
    bin/eecli create:template articles/search
    bin/eecli create:template articles/_form-search-advanced
    bin/eecli create:template articles/read
    bin/eecli create:template articles/_comments
    bin/eecli create:template site/sitemap --type="xml"

### Blog

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Blog
    bin/eecli create:category_group Blog
    bin/eecli create:channel blog Blog --field_group=Blog --cat_group=Blog
    bin/eecli create:field:wygwam "Content" cf_blog_content Blog
    bin/eecli create:field:assets "Feature Image" cf_blog_feature_image Blog
    bin/eecli create:field:assets "Thumbnail Image" cf_blog_thumbnail_image Blog
    bin/eecli create:field:text "Advertisement Search Query" cf_blog_ad_search_query Blog

    bin/eecli create:field:relationship "Related Promotions" cf_blog_related_promotions Blog \
        --channel="promotions" \
        --multiple

    bin/eecli create:field:relationship "Related Articles" cf_blog_related_articles Blog \
        --channel="articles" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_blog_related_products Blog \
        --channel="products" \
        --multiple

#### Template Groups / Templates

    bin/eecli create:template_group blog
    bin/eecli create:template blog/index
    bin/eecli create:template blog/-entries
    bin/eecli create:template blog/search
    bin/eecli create:template blog/_form-search-advanced
    bin/eecli create:template blog/read
    bin/eecli create:template blog/_comments

### Brands

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Brands
    bin/eecli create:category_group Brands
    bin/eecli create:channel brands Brands --field_group=Brands --cat_group=Brands
    bin/eecli create:field:wygwam "Content" cf_brand_content Brands
    bin/eecli create:field:assets "Feature Image" cf_brand_feature_image Brands
    bin/eecli create:field:assets "Thumbnail Image" cf_brand_thumbnail_image Brands
    bin/eecli create:field:text "Advertisement Search Query" cf_brand_ad_search_query Brands

#### Template Groups / Templates

    bin/eecli create:template_group brands
    bin/eecli create:template brands/index
    bin/eecli create:template brands/-entries
    bin/eecli create:template brands/search
    bin/eecli create:template brands/_form-search-advanced
    bin/eecli create:template brands/read
    bin/eecli create:template brands/_comments

### Businesses

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Businesses
    bin/eecli create:category_group Businesses
    bin/eecli create:channel businesses Businesses --field_group=Businesses --cat_group=Businesses
    bin/eecli create:field:wygwam "Content" cf_business_content Businesses
    bin/eecli create:field:assets "Feature Image" cf_business_feature_image Businesses
    bin/eecli create:field:assets "Thumbnail Image" cf_business_thumbnail_image Businesses
    bin/eecli create:field:text "Advertisement Search Query" cf_business_ad_search_query Businesses

    bin/eecli create:field:relationship "Related Promotions" cf_business_related_promotions Businesses \
        --channel="promotions" \
        --multiple

    bin/eecli create:field:relationship "Related Articles" cf_business_related_articles Businesses \
        --channel="articles" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_business_related_products Businesses \
        --channel="products" \
        --multiple

#### Template Groups / Templates

    bin/eecli create:template_group businesses
    bin/eecli create:template businesses/index
    bin/eecli create:template businesses/-entries
    bin/eecli create:template businesses/search
    bin/eecli create:template businesses/_form-search-advanced
    bin/eecli create:template businesses/read
    bin/eecli create:template businesses/_comments

### Gear

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Gear
    bin/eecli create:category_group Gear
    bin/eecli create:channel gear Gear --field_group=Gear --cat_group=Gear
    bin/eecli create:field:wygwam "Content" cf_gear_content Gear
    bin/eecli create:field:assets "Feature Image" cf_gear_feature_image Gear
    bin/eecli create:field:assets "Thumbnail Image" cf_gear_thumbnail_image Gear
    bin/eecli create:field:assets "Gallery Images" cf_gear_gallery_images Gear
    bin/eecli create:field:textarea "Gear Details" cf_gear_details Gear
    bin/eecli create:field:text "Advertisement Search Query" cf_gear_ad_search_query Gear

    bin/eecli create:field:relationship "Related Promotions" cf_gear_related_promotions Gear \
        --channel="promotions" \
        --multiple

    bin/eecli create:field:relationship "Related Articles" cf_gear_related_articles Gear \
        --channel="articles" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_gear_related_Products Gear \
        --channel="products" \
        --multiple

#### Template Groups / Templates

    bin/eecli create:template_group gear
    bin/eecli create:template gear/index
    bin/eecli create:template gear/-entries
    bin/eecli create:template gear/search
    bin/eecli create:template gear/_form-search-advanced
    bin/eecli create:template gear/read
    bin/eecli create:template gear/_comments

### Places

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Places
    bin/eecli create:category_group Places
    bin/eecli create:channel places Places --field_group=Places --cat_group=Places
    bin/eecli create:field:wygwam "Content" cf_place_content Places
    bin/eecli create:field:assets "Feature Image" cf_place_feature_image Places
    bin/eecli create:field:assets "Thumbnail Image" cf_place_thumbnail_image Places
    bin/eecli create:field:textarea "Address" cf_place_address Places
    bin/eecli create:field:text "Advertisement Search Query" cf_place_ad_search_query Places

    bin/eecli create:field:relationship "Related Promotions" cf_places_related_promotions Places \
        --channel="promotions" \
        --multiple

    bin/eecli create:field:relationship "Related Articles" cf_places_related_articles Places \
        --channel="articles" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_places_related_Products Places \
        --channel="products" \
        --multiple


#### Template Groups / Templates

    bin/eecli create:template_group places
    bin/eecli create:template places/index
    bin/eecli create:template places/-entries
    bin/eecli create:template places/search
    bin/eecli create:template places/_form-search-advanced
    bin/eecli create:template places/read
    bin/eecli create:template places/_comments

### Promotions

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Promotions
    bin/eecli create:category_group Promotions
    bin/eecli create:channel promotions Promotions --field_group=Promotions --cat_group=Promotions
    bin/eecli create:field:wygwam "Content" cf_promotion_content Promotions
    bin/eecli create:field:assets "Feature Image" cf_promotion_feature_image Promotions
    bin/eecli create:field:assets "Thumbnail Image" cf_promotion_thumbnail_image Promotions
    bin/eecli create:field:text "Advertisement Search Query" cf_place_ad_search_query Promotions

#### Template Groups / Templates

    bin/eecli create:template_group promotions
    bin/eecli create:template promotions/index
    bin/eecli create:template promotions/read
    bin/eecli create:template promotions/_comments

### Products

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Products
    bin/eecli create:category_group Products
    bin/eecli create:channel products Products --field_group=Products --cat_group=Products
    bin/eecli create:field:wygwam "Content" cf_product_content Products
    bin/eecli create:field:assets "Feature Image" cf_product_feature_image Products
    bin/eecli create:field:assets "Thumbnail Image" cf_product_thumbnail_image Products
    bin/eecli create:field:text "Advertisement Search Query" cf_product_ad_search_query Products
    bin/eecli create:field:assets "Gallery Images" cf_product_gallery_images Products
    bin/eecli create:field:store "Product Details" cf_product_details Products
    bin/eecli create:field:fieldpack_dropdown "Product Status" cf_product_status Products \
        --option="preorder : Pre-Order" \
        --option="available : Available" \
        --option="discontinued : Discontinued"

    bin/eecli create:field:relationship "Brand" cf_product_related_brand Products \
        --channel="brands"

    bin/eecli create:field:relationship "Related Promotions" cf_product_related_promotions Products \
        --channel="promotions" \
        --multiple

    bin/eecli create:field:relationship "Related Articles" cf_product_related_articles Products \
        --channel="articles" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_product_related_products Products \
        --channel="products" \
        --multiple

#### Template Groups / Templates

    bin/eecli create:template_group products
    bin/eecli create:template products/index
    bin/eecli create:template products/-entries
    bin/eecli create:template products/search
    bin/eecli create:template products/_form-search-advanced
    bin/eecli create:template products/read
    bin/eecli create:template products/_comments

### Staff

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Staff
    bin/eecli create:category_group Staff
    bin/eecli create:channel businesses Staff --field_group=Staff --cat_group=Staff
    bin/eecli create:field:wygwam "Content" cf_staff_content Staff
    bin/eecli create:field:assets "Feature Image" cf_staff_feature_image Staff
    bin/eecli create:field:assets "Thumbnail Image" cf_staff_thumbnail_image Staff
    bin/eecli create:field:text "Advertisement Search Query" cf_staff_ad_search_query Staff

#### Template Groups / Templates

    bin/eecli create:template_group staff
    bin/eecli create:template staff/index
    bin/eecli create:template staff/-entries
    bin/eecli create:template staff/search
    bin/eecli create:template staff/_form-search-advanced
    bin/eecli create:template staff/read
    bin/eecli create:template staff/_comments

### Testimonials

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Testimonials
    bin/eecli create:category_group Testimonials
    bin/eecli create:channel testimonials Testimonials --field_group=Testimonials --cat_group=Testimonials
    bin/eecli create:field:wygwam "Content" cf_testimonial_content Testimonials
    bin/eecli create:field:wygwam "Testifier" cf_testimonial_testifier Testimonials
    bin/eecli create:field:assets "Feature Image" cf_testimonial_feature_image Testimonials
    bin/eecli create:field:assets "Thumbnail Image" cf_testimonial_thumbnail_image Testimonials
    bin/eecli create:field:text "Advertisement Search Query" cf_testimonial_ad_search_query Testimonials

#### Template Groups / Templates

### Tutorials

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Tutorials
    bin/eecli create:category_group Tutorials
    bin/eecli create:channel tutorials Tutorials --field_group=Tutorials --cat_group=Tutorials
    bin/eecli create:field:wygwam "Content" cf_tutorial_content Tutorials
    bin/eecli create:field:assets "Feature Image" cf_tutorial_feature_image Tutorials
    bin/eecli create:field:assets "Thumbnail Image" cf_tutorial_thumbnail_image Tutorials
    bin/eecli create:field:text "Advertisement Search Query" cf_tutorial_ad_search_query Tutorials

    bin/eecli create:field:relationship "Related Promotions" cf_tutorial_related_promotions Tutorials \
        --channel="promotions" \
        --multiple

    bin/eecli create:field:relationship "Related Articles" cf_tutorial_related_articles Tutorials \
        --channel="articles" \
        --multiple

    bin/eecli create:field:relationship "Related Products" cf_tutorial_related_products Tutorials \
        --channel="products" \
        --multiple

#### Template Groups / Templates

    bin/eecli create:template_group tutorials
    bin/eecli create:template tutorials/index
    bin/eecli create:template tutorials/-entries
    bin/eecli create:template tutorials/search
    bin/eecli create:template tutorials/_form-search-advanced
    bin/eecli create:template tutorials/read
    bin/eecli create:template tutorials/_comments

Setting Up Supervisor
---------------------

### Install dependencies:

    # Supervisor
    # See: https://nicksergeant.com/running-supervisor-on-os-x/
    brew install distribute
    sudo easy_install pip
    sudo pip install supervisor

### supervisord.conf

Create a `/usr/local/etc/supervisord.conf` file with the following contents:

    ; Sample supervisor config file.
    ;
    ; For more information on the config file, please see:
    ; http://supervisord.org/configuration.html
    ;
    ; Notes:
    ;  - Shell expansion ("~" or "$HOME") is not supported.  Environment
    ;    variables can be expanded using this syntax: "%(ENV_HOME)s".
    ;  - Comments must have a leading space: "a=b ;comment" not "a=b;comment".

    [unix_http_server]
    file=/tmp/supervisor.sock   ; (the path to the socket file)
    ;chmod=0700                 ; socket file mode (default 0700)
    ;chown=nobody:nogroup       ; socket file uid:gid owner
    ;username=user              ; (default is no username (open server))
    ;password=123               ; (default is no password (open server))

    [inet_http_server]         ; inet (TCP) server disabled by default
    port=127.0.0.1:9011         ; (ip_address:port specifier, *:port for all iface)
    ;username=user              ; (default is no username (open server))
    ;password=123               ; (default is no password (open server))

    [supervisord]
    logfile=/tmp/supervisord.log ; (main log file;default $CWD/supervisord.log)
    logfile_maxbytes=50MB        ; (max main logfile bytes b4 rotation;default 50MB)
    logfile_backups=10           ; (num of main logfile rotation backups;default 10)
    loglevel=info                ; (log level;default info; others: debug,warn,trace)
    pidfile=/tmp/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
    nodaemon=false               ; (start in foreground if true;default false)
    minfds=1024                  ; (min. avail startup file descriptors;default 1024)
    minprocs=200                 ; (min. avail process descriptors;default 200)
    ;umask=022                   ; (process file creation umask;default 022)
    ;user=chrism                 ; (default is current user, required if root)
    ;identifier=supervisor       ; (supervisord identifier, default is 'supervisor')
    ;directory=/tmp              ; (default is not to cd during start)
    ;nocleanup=true              ; (don't clean up tempfiles at start;default false)
    ;childlogdir=/tmp            ; ('AUTO' child log dir, default $TEMP)
    ;environment=KEY="value"     ; (key value pairs to add to environment)
    ;strip_ansi=false            ; (strip ansi escape codes in logs; def. false)

    ; the below section must remain in the config file for RPC
    ; (supervisorctl/web interface) to work, additional interfaces may be
    ; added by defining them in separate rpcinterface: sections
    [rpcinterface:supervisor]
    supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

    [supervisorctl]
    serverurl=unix:///tmp/supervisor.sock ; use a unix:// URL  for a unix socket
    ;serverurl=http://127.0.0.1:9001 ; use an http:// url to specify an inet socket
    ;username=chris              ; should be same as http_username if set
    ;password=123                ; should be same as http_password if set
    ;prompt=mysupervisor         ; cmd line prompt (default "supervisor")
    ;history_file=~/.sc_history  ; use readline history if available

    ; The below sample program section shows all possible program subsection values,
    ; create one or more 'real' program: sections to be able to control them under
    ; supervisor.

    ;[program:theprogramname]
    ;command=/bin/cat              ; the program (relative uses PATH, can take args)
    ;process_name=%(program_name)s ; process_name expr (default %(program_name)s)
    ;numprocs=1                    ; number of processes copies to start (def 1)
    ;directory=/tmp                ; directory to cwd to before exec (def no cwd)
    ;umask=022                     ; umask for process (default None)
    ;priority=999                  ; the relative start priority (default 999)
    ;autostart=true                ; start at supervisord start (default: true)
    ;autorestart=unexpected        ; whether/when to restart (default: unexpected)
    ;startsecs=1                   ; number of secs prog must stay running (def. 1)
    ;startretries=3                ; max # of serial start failures (default 3)
    ;exitcodes=0,2                 ; 'expected' exit codes for process (default 0,2)
    ;stopsignal=QUIT               ; signal used to kill process (default TERM)
    ;stopwaitsecs=10               ; max num secs to wait b4 SIGKILL (default 10)
    ;stopasgroup=false             ; send stop signal to the UNIX process group (default false)
    ;killasgroup=false             ; SIGKILL the UNIX process group (def false)
    ;user=chrism                   ; setuid to this UNIX account to run the program
    ;redirect_stderr=true          ; redirect proc stderr to stdout (default false)
    ;stdout_logfile=/a/path        ; stdout log path, NONE for none; default AUTO
    ;stdout_logfile_maxbytes=1MB   ; max # logfile bytes b4 rotation (default 50MB)
    ;stdout_logfile_backups=10     ; # of stdout logfile backups (default 10)
    ;stdout_capture_maxbytes=1MB   ; number of bytes in 'capturemode' (default 0)
    ;stdout_events_enabled=false   ; emit events on stdout writes (default false)
    ;stderr_logfile=/a/path        ; stderr log path, NONE for none; default AUTO
    ;stderr_logfile_maxbytes=1MB   ; max # logfile bytes b4 rotation (default 50MB)
    ;stderr_logfile_backups=10     ; # of stderr logfile backups (default 10)
    ;stderr_capture_maxbytes=1MB   ; number of bytes in 'capturemode' (default 0)
    ;stderr_events_enabled=false   ; emit events on stderr writes (default false)
    ;environment=A="1",B="2"       ; process environment additions (def no adds)
    ;serverurl=AUTO                ; override serverurl computation (childutils)

    ; The below sample eventlistener section shows all possible
    ; eventlistener subsection values, create one or more 'real'
    ; eventlistener: sections to be able to handle event notifications
    ; sent by supervisor.

    ;[eventlistener:theeventlistenername]
    ;command=/bin/eventlistener    ; the program (relative uses PATH, can take args)
    ;process_name=%(program_name)s ; process_name expr (default %(program_name)s)
    ;numprocs=1                    ; number of processes copies to start (def 1)
    ;events=EVENT                  ; event notif. types to subscribe to (req'd)
    ;buffer_size=10                ; event buffer queue size (default 10)
    ;directory=/tmp                ; directory to cwd to before exec (def no cwd)
    ;umask=022                     ; umask for process (default None)
    ;priority=-1                   ; the relative start priority (default -1)
    ;autostart=true                ; start at supervisord start (default: true)
    ;autorestart=unexpected        ; whether/when to restart (default: unexpected)
    ;startsecs=1                   ; number of secs prog must stay running (def. 1)
    ;startretries=3                ; max # of serial start failures (default 3)
    ;exitcodes=0,2                 ; 'expected' exit codes for process (default 0,2)
    ;stopsignal=QUIT               ; signal used to kill process (default TERM)
    ;stopwaitsecs=10               ; max num secs to wait b4 SIGKILL (default 10)
    ;stopasgroup=false             ; send stop signal to the UNIX process group (default false)
    ;killasgroup=false             ; SIGKILL the UNIX process group (def false)
    ;user=chrism                   ; setuid to this UNIX account to run the program
    ;redirect_stderr=true          ; redirect proc stderr to stdout (default false)
    ;stdout_logfile=/a/path        ; stdout log path, NONE for none; default AUTO
    ;stdout_logfile_maxbytes=1MB   ; max # logfile bytes b4 rotation (default 50MB)
    ;stdout_logfile_backups=10     ; # of stdout logfile backups (default 10)
    ;stdout_events_enabled=false   ; emit events on stdout writes (default false)
    ;stderr_logfile=/a/path        ; stderr log path, NONE for none; default AUTO
    ;stderr_logfile_maxbytes=1MB   ; max # logfile bytes b4 rotation (default 50MB)
    ;stderr_logfile_backups        ; # of stderr logfile backups (default 10)
    ;stderr_events_enabled=false   ; emit events on stderr writes (default false)
    ;environment=A="1",B="2"       ; process environment additions
    ;serverurl=AUTO                ; override serverurl computation (childutils)

    ; The below sample group section shows all possible group values,
    ; create one or more 'real' group: sections to create "heterogeneous"
    ; process groups.

    ;[group:thegroupname]
    ;programs=progname1,progname2  ; each refers to 'x' in [program:x] definitions
    ;priority=999                  ; the relative start priority (default 999)

    ; The [include] section can just contain the "files" setting.  This
    ; setting can list multiple files (separated by whitespace or
    ; newlines).  It can also contain wildcards.  The filenames are
    ; interpreted as relative to this file.  Included files *cannot*
    ; include files themselves.

    [include]
    files = supervisor.d/*.ini

Create a new directory for custom configurations

    mkdir -p /usr/local/etc/supervisor.d

### com.agendaless.supervisord.plist

Create a `/Library/LaunchAgents/com.agendaless.supervisord.plist` file with the following code:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>KeepAlive</key>
        <dict>
            <key>SuccessfulExit</key>
            <false/>
        </dict>
        <key>Label</key>
        <string>com.agendaless.supervisord</string>
        <key>ProgramArguments</key>
        <array>
            <string>/usr/local/bin/supervisord</string>
            <string>-n</string>
            <string>-c</string>
            <string>/usr/local/etc/supervisord.conf</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
    </plist>

Register the plist:

    launchctl load /Library/LaunchAgents/com.agendaless.supervisord.plist

Start / Stop the daemon

    lunchy start supervisord
    lunchy stop supervisord

### Admin UI

Start and stop services in the admin ui

    open http://127.0.0.1:9011

Setting Up Varnish
------------------

### Install dependencies:

    brew install varnish

### default.vcl

Create a `/usr/local/etc/varnish/default.vcl` with the following:

    vcl 4.0;

    backend deckee {
    # Define deckee backend
      .host = "local.deckee.com"; # IP or Hostname of backend
      .port = "80"; # Port Apache or whatever is listening
      .max_connections = 300; # That's it
      .first_byte_timeout     = 300s;   # How long to wait before we receive a first byte from our backend?
      .connect_timeout        = 100s;     # How long to wait for a backend connection?
      .between_bytes_timeout  = 100s;     # How long to wait between bytes received from our backend?
    }

    backend example {
    # Define example backend
      .host = "local.example"; # IP or Hostname of backend
      .port = "80"; # Port Apache or whatever is listening
      .max_connections = 300; # That's it
      .first_byte_timeout     = 300s;   # How long to wait before we receive a first byte from our backend?
      .connect_timeout        = 100s;     # How long to wait for a backend connection?
      .between_bytes_timeout  = 100s;     # How long to wait between bytes received from our backend?
    }

    sub vcl_recv {
        unset req.http.cookie;
    }

    sub vcl_backend_response {

        unset beresp.http.set-cookie;
        unset beresp.http.Cache-Control;
        set beresp.ttl = 120s;

        # Test deckee backend
        if (req.http.host == "local.deckee.com") {
            set beresp.backend = deckee;
            return (lookup);
        }

        # Test example backend
        if (req.http.host == "local.example") {
            set beresp.backend = example;
            return (lookup);
        }

    }

### Create a supervisord ini file

Note: This should work but doesn't. Start and Stop Varnish via the command line (see below).

Create a `/usr/local/etc/varnish/default.vcl` with the following:

    [program:varnishd]
    command=sudo /usr/local/opt/varnish/sbin/varnishd -n /usr/local/var/varnish -f /usr/local/etc/varnish/default.vcl -s malloc,1G  -a :8080
    autorestart=false

Start and stop services via supervisord

    open http://127.0.0.1:9011

### Start and Stop via command line

Start

    sudo /usr/local/opt/varnish/sbin/varnishd -n /usr/local/var/varnish -f /usr/local/etc/varnish/default.vcl -s malloc,1G  -a :8080

Stop

    sudo pkill varnishd

Upgrading from MySQL to MariaDB
-------------------------------

Backup local databases:

    mysqldump -uroot --all-databases > ~/Desktop/all_databases_dump.sql

Remove mysql (from this post)[https://coderwall.com/p/os6woq/uninstall-all-those-broken-versions-of-mysql-and-re-install-it-with-brew-on-mac-mavericks]:

    ps -ax | grep mysql*
    sudo pkill mysql*
    mv /usr/local/var/mysql /usr/local/var/mysql.bk
    brew remove mysql
    sudo rm /usr/local/mysql
    sudo rm -rf /usr/local/var/mysql
    sudo rm -rf /usr/local/mysql*
    sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
    sudo rm -rf /Library/StartupItems/MySQLCOM
    sudo rm -rf /Library/PreferencePanes/My*
    sudo rm -rf ~/Library/PreferencePanes/My*
    sudo rm -rf /Library/Receipts/mysql*
    sudo rm -rf /Library/Receipts/MySQL*
    sudo rm -rf /private/var/db/receipts/*mysql*
    sudo shutdown -r now

Install MariaDB:

    brew install mariadb
    ln -sfv /usr/local/opt/mariadb/*.plist ~/Library/LaunchAgents
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mariadb.plist

Import Databases:

    mysql -uroot < ~/Desktop/all_databases_dump.sql

Done!

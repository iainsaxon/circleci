CircleCI
========

![Build Status](https://circleci.com/gh/newism/circleci.svg?style=shield&circle-token=ebfe085f0d4abcf3da52c57819950d6267181cf5)


Server Requirements
-------------------

    brew install varnish
    brew install virtualbox

Install & Setup
---------------

1. Create a new local domain http://local.circle and point it to [web](./web)
2. Install node modules: `npm install`
3. Install composer modules: `composer install`
4. Install bower components: `bower install`

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

* Email is sent using [MandrillApp](https://mandrillapp.com) SMTP
* Each new site requires a new Mandrill account
* Modify [app/config_bootstrap.php](app/config_bootstrap.php) with smtp details

Building a Site
---------------

### browserconfig.xml

**We don't hate IE11!**

Please read: https://msdn.microsoft.com/en-us/library/ie/dn455106.aspx




### EECLI

eecli: https://github.com/rsanchez/eecli

### CE Image

Photos and avatars should only have one resize which is equal to double their max pixel size.

Site Reference
---------------

### Site

#### Template Groups / Templates

    bin/eecli create:template_group site --default
    bin/eecli create:template site/index
    bin/eecli create:template site/-robots
    bin/eecli create:template site/-four04
    bin/eecli create:template site/sitemap --type="xml"
    bin/eecli create:template site/_layout
    bin/eecli create:template site/_comments

### Pages

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Pages
    bin/eecli create:category_group Pages
    bin/eecli create:channel blog Blog --field_group=Pages --cat_group=Pages
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
    bin/eecli create:template search/opensearch
    bin/eecli create:template search/_form-simple-search
    bin/eecli create:template search/_form-advanced-search


### Store

#### Template Groups / Templates

    bin/eecli create:template_group store --default
    bin/eecli create:template store/index
    bin/eecli create:template store/order-checkout
    bin/eecli create:template store/order-details
    bin/eecli create:template store/order-payment
    bin/eecli create:template store/order-receipt
    bin/eecli create:template store/purchases
    bin/eecli create:template store/_cart-simple
    bin/eecli create:template store/_cart-advanced

### Topics

#### Template Groups / Templates

    bin/eecli create:template_group topics
    bin/eecli create:template topics/index

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

### Articles

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Articles
    bin/eecli create:category_group Articles
    bin/eecli create:channel articles Articles --field_group=Articles --cat_group=Articles
    bin/eecli create:field:wygwam "Content" cf_article_content Articles
    bin/eecli create:field:assets "Feature Image" cf_article_feature_image Articles
    bin/eecli create:field:assets "Thumbnail Image" cf_article_thumbnail_image Articles

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
    bin/eecli create:template articles/_entries
    bin/eecli create:template articles/search
    bin/eecli create:template articles/_form-search-advanced
    bin/eecli create:template articles/read
    bin/eecli create:template articles/_comments

### Blog

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Blog
    bin/eecli create:category_group Blog
    bin/eecli create:channel blog Blog --field_group=Blog --cat_group=Blog
    bin/eecli create:field:wygwam "Content" cf_blog_content Blog
    bin/eecli create:field:assets "Feature Image" cf_blog_feature_image Blog
    bin/eecli create:field:assets "Thumbnail Image" cf_blog_thumbnail_image Blog

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
    bin/eecli create:template blog/_entries
    bin/eecli create:template blog/search
    bin/eecli create:template blog/_form-search-advanced
    bin/eecli create:template blog/read
    bin/eecli create:template blog/_comments

### Brands

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Brands
    bin/eecli create:category_group Brands
    bin/eecli create:channel brand Brands --field_group=Brands --cat_group=Brands
    bin/eecli create:field:wygwam "Content" cf_brand_content Brands
    bin/eecli create:field:assets "Feature Image" cf_brand_feature_image Brands
    bin/eecli create:field:assets "Thumbnail Image" cf_brand_thumbnail_image Brands

#### Template Groups / Templates

    bin/eecli create:template_group brands
    bin/eecli create:template brands/index
    bin/eecli create:template brands/_entries
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
    bin/eecli create:template businesses/_entries
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
    bin/eecli create:template gear/_entries
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

#### Template Groups / Templates

    bin/eecli create:template_group places
    bin/eecli create:template places/index
    bin/eecli create:template places/_entries
    bin/eecli create:template places/search
    bin/eecli create:template places/_form-search-advanced
    bin/eecli create:template places/read
    bin/eecli create:template places/_comments

### Promotions

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Promotions
    bin/eecli create:category_group Promotions
    bin/eecli create:channel promotions Promotions --field_group=Promotions --cat_group=Promotions
    bin/eecli create:field:wygwam "Content" cf_page_content Promotions
    bin/eecli create:field:assets "Feature Image" cf_page_feature_image Promotions
    bin/eecli create:field:assets "Thumbnail Image" cf_page_thumbnail_image Promotions

#### Template Groups / Templates

    bin/eecli create:template_group promotions
    bin/eecli create:template promotions/index
    bin/eecli create:template promotions/read
    bin/eecli create:template promotions/_comments
    bin/eecli create:template promotions/_cta

### Products

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Products
    bin/eecli create:category_group Products
    bin/eecli create:channel products Products --field_group=Products --cat_group=Products
    bin/eecli create:field:wygwam "Content" cf_product_content Products
    bin/eecli create:field:assets "Feature Image" cf_product_feature_image Products
    bin/eecli create:field:assets "Thumbnail Image" cf_product_thumbnail_image Products
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
    bin/eecli create:template products/_entries
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

#### Template Groups / Templates

    bin/eecli create:template_group staff
    bin/eecli create:template staff/index
    bin/eecli create:template staff/_entries
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

#### Template Groups / Templates

### Tutorials

#### Channels / Category Groups / Field Groups / Fields

    bin/eecli create:field_group Tutorials
    bin/eecli create:category_group Tutorials
    bin/eecli create:channel tutorials Tutorials --field_group=Tutorials --cat_group=Tutorials
    bin/eecli create:field:wygwam "Content" cf_tutorial_content Tutorials
    bin/eecli create:field:assets "Feature Image" cf_tutorial_feature_image Tutorials
    bin/eecli create:field:assets "Thumbnail Image" cf_tutorial_thumbnail_image Tutorials

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
    bin/eecli create:template tutorials/_entries
    bin/eecli create:template tutorials/search
    bin/eecli create:template tutorials/_form-search-advanced
    bin/eecli create:template tutorials/read
    bin/eecli create:template tutorials/_comments

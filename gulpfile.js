'use strict';

var path = require('path');
var del = require('del');
var fs = require('fs');
var wrench = require('wrench');
var chalk = require('chalk');

// CLI Argument Parsing
var minimist = require('minimist');

// Gulp + Plugins
var gulp = require('gulp');
var $ = require('gulp-load-plugins')();

var runSequence = require('run-sequence');
var transform = require('vinyl-transform');

var browserify = require('browserify');

// CLI Options
var options = minimist(process.argv.slice(2));
var siteName = options.siteName || "default_site";
var target = options.target || "prod";
var isProduction = options.production || options.prod || false;
var isDebug = options.debug || false;

// Path Config
var paths = {
    themes: "web/themes/site_themes/" + siteName,
    themesSrc: "web/themes/site_themes/src/" + siteName,
    themesProd: "web/themes/site_themes/" + target + "/" + siteName,
    views: "app/views/" + siteName,
    viewsSrc: "app/views/src/" + siteName,
    viewsProd: "app/views/"  + target + "/" + siteName,
    cache: ""
};

/**
 * Parses .scss into .css w/ sourcemaps & autoprefixer
 */
gulp.task('styles', function () {

    var autoprefixer = require('autoprefixer-core');

    return gulp.src(paths.themesSrc + '/scss/*.scss')
        .pipe($.if(isDebug, $.debug({title: 'styles:'})))
        .pipe($.if(isProduction, $.scssLint()))
        .pipe($.sourcemaps.init())
        .pipe($.sass({
            outputStyle: 'nested', // libsass doesn't support expanded yet
            precision: 10,
            includePaths: ['.'],
            onError: console.error.bind(console, 'Sass error:')
        }))
        .pipe($.postcss([
            autoprefixer({browsers: ['last 1 version']})
        ]))
        .pipe($.sourcemaps.write())
        .pipe(gulp.dest(paths.themesSrc + '/styles'))
        ;
});

/**
 * Converts icons into spritesheets
 */

var spriteIcons1x = paths.themesSrc + '/images/icons/*@1x.png';
var spriteIcons2x = paths.themesSrc + '/images/icons/*@2x.png';
var spritePadding = 50;

gulp.task('images:sprite:icons@1x', function () {
    var spriteData = gulp.src([spriteIcons1x])
        .pipe($.debug({title: 'spriteIcons1x:'}))
        .pipe($.spritesmith({
            imgName: 'images/icon-sprite@1x.png',
            imgPath: '../images/icon-sprite@1x.png',
            cssName: 'scss/screen/_icon_sprite.scss',
            padding: spritePadding,
            cssTemplate: paths.themesSrc + '/scss/spritesmith-retina-mixins.template.mustache',
            cssVarMap: function (sprite) {
                sprite.name = sprite.name.replace("@1x", "");
                sprite.image_2x = sprite.image.replace("@1x", "@2x");
                sprite.escaped_image_2x = sprite.image_2x.replace(/['"\(\)\s]/g, function encodeCssUri (chr) {
                    return '%' + chr.charCodeAt(0).toString(16);
                });;
            }
        }));
    spriteData.img.pipe(gulp.dest(paths.themesSrc));
    spriteData.css.pipe(gulp.dest(paths.themesSrc));
});

gulp.task('images:sprite:icons@2x', function () {
    var spriteData = gulp.src([spriteIcons2x])
        .pipe($.debug({title: 'spriteIcons2x:'}))
        .pipe($.spritesmith({
            imgName: 'images/icon-sprite@2x.png',
            imgPath: '../images/icon-sprite@2x.png',
            padding: spritePadding * 2,
            // This task filters out the sprite image
            // so the name cssName and cssTemplate don't matter
            // the template returns a blank string to speed up processing
            cssName: 'scss/screen/_sprites@2x.scss',
            cssTemplate: function(params){ return ''; }
            //cssTemplate: paths.themesSrc + '/scss/spritesmith-retina-mixins.template.mustache',
            //cssVarMap: function (sprite) {
            //    sprite.name = sprite.name.replace("@2x", "");
            //}
        }));

    return spriteData.img.pipe(gulp.dest(paths.themesSrc));
});

gulp.task('images:sprite:icons', ['images:sprite:icons@2x', 'images:sprite:icons@1x']);

/**
 * Browserify scripts w/ sourcemaps
 */
gulp.task('scripts', function () {

    var browserified = transform(function (filename) {
        var b = browserify(filename);
        return b.bundle();
    });

    return gulp.src(paths.themesSrc + '/scripts/app.js')
        .pipe($.if(isDebug, $.debug({title: 'scripts:'})))
        .pipe(browserified)
        .pipe($.sourcemaps.init())
        .pipe($.if(isProduction, $.uglify()))
        .pipe($.sourcemaps.write())
        .pipe($.rename("bundled.js"))
        .pipe(gulp.dest(paths.themesSrc + '/scripts'))
        ;
});

gulp.task('scripts:compile-bower-scripts', function () {

    return gulp.src(require('main-bower-files')({
            filter: '**/*.js'
        }))
        .pipe($.if(isDebug, $.debug({title: 'scripts:compile-bower-scripts'})))
        .pipe($.sourcemaps.init())
        // Add transformation tasks to the pipeline here.
        .pipe($.size())
        .pipe($.if(isProduction, $.uglify()))
        .pipe($.sourcemaps.write())
        .pipe($.concat('bundled-bower.js'))
        .pipe($.size())
        .pipe(gulp.dest(paths.themesSrc + '/scripts'))
        ;
});

/**
 * Copy styles to production updating paths
 */
gulp.task('copy:styles', ['styles'], function () {
    return gulp.src(paths.themesSrc + '/styles/*.css')
        .pipe($.plumber())
        .pipe($.if(isDebug, $.debug({title: 'copy:styles:'})))
        .pipe($.replace(/themes\/src/g, 'themes/' + target))
        .pipe(gulp.dest(paths.themesProd + '/styles'))
        ;
});

/**
 * Copy scripts to production updating paths
 */
gulp.task('copy:scripts', ['scripts'], function () {
    return gulp.src(paths.themesSrc + '/scripts/**/*.js')
        .pipe($.if(isDebug, $.debug({title: 'copy:scripts:'})))
        .pipe($.replace(/themes\/src/g, 'themes/' + target))
        .pipe(gulp.dest(paths.themesProd + '/scripts'))
        ;
});

/**
 * Copy images to production crushing as we go
 */
gulp.task('copy:images', function () {
    return gulp.src(paths.themesSrc + '/images/**/*')
        .pipe($.if(isDebug, $.debug({title: 'copy:images:'})))
        .pipe($.cache($.imagemin({
            progressive: true,
            interlaced: true,
            // don't remove IDs from SVGs, they are often used
            // as hooks for embedding and styling
            svgoPlugins: [{cleanupIDs: false}]
        })))
        .pipe(gulp.dest(paths.themesProd + '/images'));
});

/**
 * Copy fonts production including bower fonts
 */
gulp.task('copy:fonts', function () {
    return gulp.src(require('main-bower-files')({
        filter: '**/*.{eot,svg,ttf,woff,woff2}'
    })
        .concat(paths.themesSrc + '/fonts/**/*'))
        .pipe($.if(isDebug, $.debug({title: 'copy:fonts:'})))
        .pipe(gulp.dest(paths.themesProd + '/fonts'));
});

/**
 * Copy html views to production
 */
gulp.task('copy:html', function () {

    return gulp.src(paths.viewsSrc + '/**/*')
        .pipe($.if(isDebug, $.debug({title: 'copy:html:'})))
        .pipe($.replace(/themes\/src/g, 'themes/' + target))
        .pipe(gulp.dest(paths.viewsProd));
});

/**
 * Create a rev map of all assets
 */
gulp.task('rev', function () {
    // by default, gulp would pick `assets/css` as the base,
    // so we need to set it explicitly:
    return gulp.src([
        paths.themesProd + "/styles/*.css",
        paths.themesProd + "/scripts/**/*.js",
        paths.themesProd + "/images/**/*.*",
        paths.themesProd + "/fonts/**/*.{eot,svg,ttf,woff,woff2}"
    ], {base: path.join(process.cwd(), paths.themesProd)})
        .pipe($.if(isDebug, $.debug({title: 'rev:'})))
        .pipe($.rev())
        .pipe(gulp.dest(paths.themesProd))  // write rev'd assets to build dir
        .pipe($.rev.manifest())
        .pipe(gulp.dest(paths.themesProd)); // write manifest to build dir
});

/**
 * Replace all asset urls with the revved filenames in views
 */
gulp.task("revReplace:html", function () {
    var manifest = gulp.src(paths.themesProd + "/rev-manifest.json");

    return gulp.src(paths.viewsProd + '/**/*.html')
        .pipe($.if(isDebug, $.debug({title: 'revReplace:html:'})))
        .pipe($.revReplace({manifest: manifest}))
        .pipe(gulp.dest(paths.viewsProd));
});

/**
 * Replace all asset urls with the revved filenames in css / js
 */
gulp.task("revReplace:themeAssets", function () {
    var manifest = gulp.src(paths.themesProd + "/rev-manifest.json");

    return gulp.src([
        paths.themesProd + '/styles/**/*.css',
        paths.themesProd + '/scripts/**/*.js'
    ], {base: paths.themesProd + "/"})
        .pipe($.if(isDebug, $.debug({title: 'revReplace:themeAssets:'})))
        .pipe($.revReplace({manifest: manifest}))
        .pipe(gulp.dest(paths.themesProd));
});

/**
 * Fireup browsersync syncing all assets across browsers
 */
gulp.task('browserSync', function () {

    var browserSync = require('browser-sync');
    var reload = browserSync.reload;

    browserSync({
        notify: true,
        proxy: "local.example.com"
    });

    /**
     * Watch these files for changes and reload browsersync
     */
    gulp.watch([
        paths.viewsSrc + '/**/*.html',
        paths.themesSrc + '/scripts/**/*.js',
        paths.themesSrc + '/styles/**/*.css',
        paths.themesSrc + '/images/**/*',
        paths.themesSrc + '/fonts/**/*'
    ]).on('change', reload);

});



/**
 * Run jshint to validate javascripts
 */
gulp.task('jshint', function () {
    return gulp.src([
        paths.themesSrc + '/scripts/**/*.js',
        "!" + paths.themesSrc + '/scripts/bundled.js',
        "!" + paths.themesSrc + '/scripts/bundled-bower.js'
    ])
        .pipe($.if(isDebug, $.debug({title: 'jshint:'})))
        //.pipe(reload({stream: true, once: true}))
        .pipe($.jshint())
        .pipe($.jshint.reporter('jshint-stylish'))
        .pipe($.jshint.reporter('fail'));
});

/**
 * Wireup Bower dependencies
 */
gulp.task('wiredep', function () {

    var wiredep = require('wiredep').stream;

    gulp.src(paths.themesSrc + '/*.scss')
        .pipe(wiredep({
            ignorePath: /^(\.\.\/)*web/
        }))
        .pipe(gulp.dest(paths.themesSrc));

    gulp.src(paths.viewsSrc + '/**/*.html')
        .pipe(wiredep({
            ignorePath: /^(\.\.\/)*web/
        }))
        .pipe(gulp.dest(paths.viewsSrc));
});

/**
 * Clean production directories
 */
gulp.task('clean', del.bind(null, [paths.themesProd, paths.viewsProd]));

gulp.task('setPermissions:config', function () {
    return gulp.src([
        'app/system/expressionengine/config/config.php',
        'app/system/expressionengine/config/database.php'
    ])
        .pipe($.if(isDebug, $.debug({title: 'setPermissions:'})))
        .pipe($.chmod(666))
        .pipe(gulp.dest('app/system/expressionengine/config'))
        .pipe($.debug({title: 'setPermissions:'}))
        ;
});

gulp.task('setPermissions:cache', function(){
    wrench.chmodSyncRecursive('app/system/expressionengine/cache', '0775');
    wrench.chmodSyncRecursive('var/cache', '0775')
});

gulp.task('setPermissions:logs', function(){
    wrench.chmodSyncRecursive('var/logs', '0775')
});

/**
 * Build production assets
 */
gulp.task('build', function (callback) {

    $.util.log(chalk.green('Building Target: ' + target + ' isProduction: ' + isProduction));

    runSequence(
        'jshint',
        'clean',
        [
            'copy:styles',
            'copy:scripts',
            'copy:images',
            'copy:fonts',
            'copy:html'
        ],
        'rev',
        ['revReplace:html', 'revReplace:themeAssets'],
        callback
    );
});

/**
 * Watch files for changes and run tasks
 */
gulp.task('watch', function () {
    gulp.watch([paths.themesSrc + '/images/icons/*.*'], ['images:sprites']);
    gulp.watch([paths.themesSrc + '/scss/**/*.scss'], ['styles']);
    gulp.watch([paths.themesSrc + '/scripts/**/*.js', "!" + paths.themesSrc + '/scripts/bundled.js'], ['scripts']);
    //gulp.watch('bower.json', ['wiredep', 'fonts']);
});

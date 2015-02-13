'use strict';

var path = require('path');
var del = require('del');

// CLI Argument Parsing
var minimist = require('minimist');

// Gulp + Plugins
var gulp = require('gulp');
var $ = require('gulp-load-plugins')();

var runSequence = require('run-sequence');
var autoprefixer = require('autoprefixer-core');
var transform = require('vinyl-transform');

var browserSync = require('browser-sync');
var reload = browserSync.reload;

var browserify = require('browserify');

// CLI Options
var options = minimist(process.argv.slice(2));
var siteName = options.siteName || "default_site";
var target = options.target || "prod";

// Path Config
var paths = {
    themes: "web/themes/site_themes/" + siteName,
    themesSrc: "web/themes/site_themes/" + siteName + "/src",
    themesProd: "web/themes/site_themes/" + siteName + "/" + target,
    views: "app/views/" + siteName,
    viewsSrc: "app/views/" + siteName + "/src",
    viewsProd: "app/views/" + siteName + "/" + target
};

/**
 * Parses .scss into .css w/ sourcemaps & autoprefixer
 */
gulp.task('styles', function () {
    return gulp.src(paths.themesSrc + '/scss/*.scss')
        .pipe($.debug({title: 'styles:'}))
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
gulp.task('images:sprites', function () {

    var spriteIconsSrc = paths.themesSrc + '/images/icons/**/*.png';
    var retinaSpriteIconsSrc = paths.themesSrc + '/images/icons/**/*@2x.png';

    var retinaSpriteData = gulp.src(retinaSpriteIconsSrc)
        .pipe($.debug({title: 'retinaSpriteData:'}))
        .pipe($.spritesmith({
            imgName: 'images/sprite@2x.png',
            cssName: 'scss/screen/_sprites.scss',
            padding: 50
        }));

    retinaSpriteData.pipe(gulp.dest(paths.themesSrc));

    var spriteData = gulp.src([spriteIconsSrc, "!" + retinaSpriteIconsSrc])
        .pipe($.debug({title: 'spriteData:'}))
        .pipe($.spritesmith({
            imgName: 'images/sprite.png',
            imgPath: '../images/sprite.png',
            cssName: 'scss/screen/_sprites.scss',
            padding: 25,
            cssTemplate: paths.themesSrc + '/scss/spritesmith-retina-mixins.template.mustache'
        }));

    spriteData.pipe(gulp.dest(paths.themesSrc));
});

/**
 * Browserify scripts w/ sourcemaps
 */
gulp.task('scripts', function () {

    var browserified = transform(function (filename) {
        var b = browserify(filename);
        return b.bundle();
    });

    return gulp.src(paths.themesSrc + '/scripts/app.js')
        .pipe($.debug({title: 'scripts:'}))
        .pipe(browserified)
        .pipe($.sourcemaps.init())
        // Add transformation tasks to the pipeline here.
        .pipe($.uglify())
        .pipe($.sourcemaps.write())
        .pipe($.rename("bundled.js"))
        .pipe(gulp.dest(paths.themesSrc + '/scripts'))
        ;
});

/**
 * Copy styles to production updating paths
 */
gulp.task('copy:styles', ['styles'], function () {
    return gulp.src(paths.themesSrc + '/styles/*.css')
        .pipe($.plumber())
        .pipe($.debug({title: 'copy:styles:'}))
        .pipe($.replace(/themes\/src/g, 'themes/' + target))
        .pipe(gulp.dest(paths.themesProd + '/styles'))
        ;
});

/**
 * Copy scripts to production updating paths
 */
gulp.task('copy:scripts', ['scripts'], function () {
    return gulp.src(paths.themesSrc + '/scripts/**/*.js')
        .pipe($.debug({title: 'copy:scripts:'}))
        .pipe($.replace(/themes\/src/g, 'themes/' + target))
        .pipe(gulp.dest(paths.themesProd + '/scripts'))
        ;
});

/**
 * Copy images to production crushing as we go
 */
gulp.task('copy:images', ['images:sprites'], function () {
    return gulp.src(paths.themesSrc + '/images/**/*')
        .pipe($.debug({title: 'copy:images:'}))
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
        .pipe($.debug({title: 'copy:fonts:'}))
        .pipe(gulp.dest(paths.themesProd + '/fonts'));
});

/**
 * Copy html views to production
 */
gulp.task('copy:html', function () {

    return gulp.src(paths.viewsSrc + '/**/*')
        .pipe($.debug({title: 'copy:html:'}))
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
        .pipe($.debug({title: 'rev:'}))
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
        .pipe($.debug({title: 'revReplace:html:'}))
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
        .pipe($.debug({title: 'revReplace:themeAssets:'}))
        .pipe($.revReplace({manifest: manifest}))
        .pipe(gulp.dest(paths.themesProd));
});

/**
 * Fireup browsersync syncing all assets across browsers
 */
gulp.task('browserSync', function () {
    browserSync({
        notify: true,
        proxy: "local.circle"
    });
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

/**
 * Run jshint to validate javascripts
 */
gulp.task('jshint', function () {
    return gulp.src([
        paths.themesSrc + '/scripts/**/*.js',
        "!" + paths.themesSrc + '/scripts/bundled.js'
    ])
        .pipe($.debug({title: 'jshint:'}))
        //.pipe(reload({stream: true, once: true}))
        .pipe($.jshint())
        .pipe($.jshint.reporter('jshint-stylish'))
        .pipe($.if(!browserSync.active, $.jshint.reporter('fail')));
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

/**
 * Build production assets
 */
gulp.task('build', function (callback) {
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
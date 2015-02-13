CircleCI
========

![Build Status](https://circleci.com/gh/newism/circleci.svg?style=shield&circle-token=ebfe085f0d4abcf3da52c57819950d6267181cf5)

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
example
========

Setup
-----

### Pre-requisites

Firstly install Vagrant and VirtualBox:

    brew install vagrant
    brew cask install virtualbox

#### Site Setup

Add the following to your hosts file:

    92.168.57.199 local.example

To launch the site run:

    vagrant up
    open http://local.example

### Connecting to MySQL:

You'll need to connect via SSH with the following:

* MySQL Host: `127.0.0.1`
* Username: `dbuser`
* Password: `123`
* Database: `dbname`
* SSH Host: `192.168.57.199`
* SSH User: `vagrant`
* SSH Key: `./.vagrant/machines/default/virtualbox/private_key`

Note: The SSH key is unique to each box when initially built.

### Running Gulp / Build Tasks

The working directory for this site is: [./var/www/example](./var/www/example). All gulp tasks must be run from this directory.
NSM Better Meta - Changelog
===========================

v1.1.7
------

* [bug] Add-on version increments properly and sitemap generation in EE 2.8.0 fixed

v1.1.6
------

* [bug] Fixed issues related to EE 2.8.0 compatibility

v1.1.5.1
--------

* [bug] Hotfix for version v1.1.5 to get Better Meta working for EE 2.6.0

v1.1.5
------

* [bug] Fixed extension settings fatal PHP error under EE 2.6.0
* [enhancement] Better Meta now using the URL_THIRD_THEMES constant for EE 2.4.0 onwards

v1.1.4
------

* [bug] Fixed issue where saving entries would create new Better Meta database rows even when not in Better Meta enabled channels

v1.1.3
------

* [bug] No longer using the CP class for layout functions
* [bug] Improved addon settings cache handling
* [enhancement] Tab now hidden when no Better Meta fields are assigned to a channel

v1.1.2
______

* [bug] Fixed column data-type for 'entry_default' in the NSM Better Meta table
* [bug] Fixed output for 'template' tag to support UTF-8

v1.1.0
------

* [bug] Fixed robot meta
* [bug] Site divider glue setting sticks
* [bug] Fixed missing language key
* [enhancement] Changed all true / false meta settings to y / n
* [enhancement] Updated style for Morphine 2.0
* [enhancement] Added sample templates
* Removed Dublin Core meta tags
* Changed all references from http://expressionengine-addons.com to http://ee-garage.com
* Added /system/expressionengine/templates/nsm-better-meta.group for easier setup

v1.0.4
------

- Fixed site title divider
- Fixed robots meta tags

v1.0.3
------

* Fixed bug with SAEF forms
* Fixed issue saving meta

v1.0.2
------

* PHP < 5.1.6 compatibility
* Added character counters for description, keywords recommended length
* Improved custom publish layout compatibility

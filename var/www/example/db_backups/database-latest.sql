# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.22)
# Database: database
# Generation Time: 2015-03-10 01:44:22 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table exp_accessories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_accessories`;

CREATE TABLE `exp_accessories` (
  `accessory_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(75) NOT NULL DEFAULT '',
  `member_groups` varchar(255) NOT NULL DEFAULT 'all',
  `controllers` text,
  `accessory_version` varchar(12) NOT NULL,
  PRIMARY KEY (`accessory_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_actions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_actions`;

CREATE TABLE `exp_actions` (
  `action_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `csrf_exempt` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`action_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_actions` WRITE;
/*!40000 ALTER TABLE `exp_actions` DISABLE KEYS */;

INSERT INTO `exp_actions` (`action_id`, `class`, `method`, `csrf_exempt`)
VALUES
	(1,'Channel','submit_entry',0),
	(2,'Channel','filemanager_endpoint',0),
	(3,'Channel','smiley_pop',0),
	(4,'Channel','combo_loader',0),
	(5,'Member','registration_form',0),
	(6,'Member','register_member',0),
	(7,'Member','activate_member',0),
	(8,'Member','member_login',0),
	(9,'Member','member_logout',0),
	(10,'Member','send_reset_token',0),
	(11,'Member','process_reset_password',0),
	(12,'Member','send_member_email',0),
	(13,'Member','update_un_pw',0),
	(14,'Member','member_search',0),
	(15,'Member','member_delete',0),
	(16,'Rte','get_js',0),
	(17,'Assets_mcp','upload_file',0),
	(18,'Assets_mcp','get_files_view_by_folders',0),
	(19,'Assets_mcp','get_props',0),
	(20,'Assets_mcp','save_props',0),
	(21,'Assets_mcp','get_ordered_files_view',0),
	(22,'Assets_mcp','get_session_id',0),
	(23,'Assets_mcp','start_index',0),
	(24,'Assets_mcp','perform_index',0),
	(25,'Assets_mcp','finish_index',0),
	(26,'Assets_mcp','get_s3_buckets',0),
	(27,'Assets_mcp','get_gc_buckets',0),
	(28,'Assets_mcp','get_rs_regions',0),
	(29,'Assets_mcp','get_rs_containers',0),
	(30,'Assets_mcp','move_folder',0),
	(31,'Assets_mcp','rename_folder',0),
	(32,'Assets_mcp','create_folder',0),
	(33,'Assets_mcp','delete_folder',0),
	(34,'Assets_mcp','view_file',0),
	(35,'Assets_mcp','move_file',0),
	(36,'Assets_mcp','delete_file',0),
	(37,'Assets_mcp','view_thumbnail',0),
	(38,'Assets_mcp','build_sheet',0),
	(39,'Assets_mcp','get_selected_files',0),
	(40,'Store','act_checkout',0),
	(41,'Store','act_download_file',0),
	(42,'Store','act_payment',0),
	(43,'Store','act_payment_return',1);

/*!40000 ALTER TABLE `exp_actions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_assets_files
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_assets_files`;

CREATE TABLE `exp_assets_files` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `folder_id` int(10) unsigned NOT NULL,
  `source_type` varchar(2) NOT NULL DEFAULT 'ee',
  `source_id` int(10) unsigned DEFAULT NULL,
  `filedir_id` int(4) unsigned DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `date` int(10) unsigned DEFAULT NULL,
  `alt_text` tinytext,
  `caption` tinytext,
  `author` tinytext,
  `desc` text,
  `location` tinytext,
  `keywords` text,
  `date_modified` int(10) unsigned DEFAULT NULL,
  `kind` varchar(5) DEFAULT NULL,
  `width` int(2) DEFAULT NULL,
  `height` int(2) DEFAULT NULL,
  `size` int(3) DEFAULT NULL,
  `search_keywords` text,
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `unq_folder_id__file_name` (`folder_id`,`file_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_assets_folders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_assets_folders`;

CREATE TABLE `exp_assets_folders` (
  `folder_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_type` varchar(2) NOT NULL DEFAULT 'ee',
  `folder_name` varchar(255) NOT NULL,
  `full_path` varchar(255) DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL,
  `filedir_id` int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`folder_id`),
  UNIQUE KEY `unq_source_type__source_id__filedir_id__parent_id__folder_name` (`source_type`,`source_id`,`filedir_id`,`parent_id`,`folder_name`),
  UNIQUE KEY `unq_source_type__source_id__filedir_id__full_path` (`source_type`,`source_id`,`filedir_id`,`full_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_assets_index_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_assets_index_data`;

CREATE TABLE `exp_assets_index_data` (
  `session_id` char(36) DEFAULT NULL,
  `source_type` varchar(2) NOT NULL DEFAULT 'ee',
  `source_id` int(10) unsigned DEFAULT NULL,
  `offset` int(10) unsigned DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `filesize` int(10) unsigned DEFAULT NULL,
  `type` enum('file','folder') DEFAULT NULL,
  `record_id` int(10) unsigned DEFAULT NULL,
  UNIQUE KEY `unq__session_id__source_type__source_id__offset` (`session_id`,`source_type`,`source_id`,`offset`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_assets_rackspace_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_assets_rackspace_access`;

CREATE TABLE `exp_assets_rackspace_access` (
  `connection_key` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `storage_url` varchar(255) NOT NULL,
  `cdn_url` varchar(255) NOT NULL,
  PRIMARY KEY (`connection_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_assets_selections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_assets_selections`;

CREATE TABLE `exp_assets_selections` (
  `file_id` int(10) unsigned DEFAULT NULL,
  `entry_id` int(10) unsigned DEFAULT NULL,
  `field_id` int(6) unsigned DEFAULT NULL,
  `col_id` int(6) unsigned DEFAULT NULL,
  `row_id` int(10) unsigned DEFAULT NULL,
  `var_id` int(6) unsigned DEFAULT NULL,
  `element_id` varchar(255) DEFAULT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `sort_order` int(4) unsigned DEFAULT NULL,
  `is_draft` tinyint(1) unsigned DEFAULT '0',
  KEY `file_id` (`file_id`),
  KEY `entry_id` (`entry_id`),
  KEY `field_id` (`field_id`),
  KEY `col_id` (`col_id`),
  KEY `row_id` (`row_id`),
  KEY `var_id` (`var_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_assets_sources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_assets_sources`;

CREATE TABLE `exp_assets_sources` (
  `source_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_type` varchar(2) NOT NULL DEFAULT 's3',
  `name` varchar(255) NOT NULL DEFAULT '',
  `settings` text NOT NULL,
  PRIMARY KEY (`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_captcha
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_captcha`;

CREATE TABLE `exp_captcha` (
  `captcha_id` bigint(13) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `word` varchar(20) NOT NULL,
  PRIMARY KEY (`captcha_id`),
  KEY `word` (`word`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_categories`;

CREATE TABLE `exp_categories` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(6) unsigned NOT NULL,
  `parent_id` int(4) unsigned NOT NULL,
  `cat_name` varchar(100) NOT NULL,
  `cat_url_title` varchar(75) NOT NULL,
  `cat_description` text,
  `cat_image` varchar(120) DEFAULT NULL,
  `cat_order` int(4) unsigned NOT NULL,
  PRIMARY KEY (`cat_id`),
  KEY `group_id` (`group_id`),
  KEY `cat_name` (`cat_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_category_field_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_category_field_data`;

CREATE TABLE `exp_category_field_data` (
  `cat_id` int(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  PRIMARY KEY (`cat_id`),
  KEY `site_id` (`site_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_category_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_category_fields`;

CREATE TABLE `exp_category_fields` (
  `field_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `field_label` varchar(50) NOT NULL DEFAULT '',
  `field_type` varchar(12) NOT NULL DEFAULT 'text',
  `field_list_items` text NOT NULL,
  `field_maxl` smallint(3) NOT NULL DEFAULT '128',
  `field_ta_rows` tinyint(2) NOT NULL DEFAULT '8',
  `field_default_fmt` varchar(40) NOT NULL DEFAULT 'none',
  `field_show_fmt` char(1) NOT NULL DEFAULT 'y',
  `field_text_direction` char(3) NOT NULL DEFAULT 'ltr',
  `field_required` char(1) NOT NULL DEFAULT 'n',
  `field_order` int(3) unsigned NOT NULL,
  PRIMARY KEY (`field_id`),
  KEY `site_id` (`site_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_category_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_category_groups`;

CREATE TABLE `exp_category_groups` (
  `group_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  `sort_order` char(1) NOT NULL DEFAULT 'a',
  `exclude_group` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `field_html_formatting` char(4) NOT NULL DEFAULT 'all',
  `can_edit_categories` text,
  `can_delete_categories` text,
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_category_groups` WRITE;
/*!40000 ALTER TABLE `exp_category_groups` DISABLE KEYS */;

INSERT INTO `exp_category_groups` (`group_id`, `site_id`, `group_name`, `sort_order`, `exclude_group`, `field_html_formatting`, `can_edit_categories`, `can_delete_categories`)
VALUES
	(1,1,'Pages','a',0,'all','',''),
	(2,1,'Articles','a',0,'all','',''),
	(3,1,'Brands','a',0,'all','','');

/*!40000 ALTER TABLE `exp_category_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_category_posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_category_posts`;

CREATE TABLE `exp_category_posts` (
  `entry_id` int(10) unsigned NOT NULL,
  `cat_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entry_id`,`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_channel_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_channel_data`;

CREATE TABLE `exp_channel_data` (
  `entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `field_id_0` varchar(8) DEFAULT NULL,
  `field_ft_0` tinytext,
  `field_id_1` text,
  `field_ft_1` tinytext,
  `field_id_2` text,
  `field_ft_2` tinytext,
  `field_id_3` text,
  `field_ft_3` tinytext,
  `field_id_4` text,
  `field_ft_4` tinytext,
  `field_id_5` text,
  `field_ft_5` tinytext,
  `field_id_6` text,
  `field_ft_6` tinytext,
  `field_id_7` varchar(8) DEFAULT NULL,
  `field_ft_7` tinytext,
  PRIMARY KEY (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_channel_entries_autosave
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_channel_entries_autosave`;

CREATE TABLE `exp_channel_entries_autosave` (
  `entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `original_entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `forum_topic_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL,
  `url_title` varchar(75) NOT NULL,
  `status` varchar(50) NOT NULL,
  `versioning_enabled` char(1) NOT NULL DEFAULT 'n',
  `view_count_one` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_two` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_three` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_four` int(10) unsigned NOT NULL DEFAULT '0',
  `allow_comments` varchar(1) NOT NULL DEFAULT 'y',
  `sticky` varchar(1) NOT NULL DEFAULT 'n',
  `entry_date` int(10) NOT NULL,
  `year` char(4) NOT NULL,
  `month` char(2) NOT NULL,
  `day` char(3) NOT NULL,
  `expiration_date` int(10) NOT NULL DEFAULT '0',
  `comment_expiration_date` int(10) NOT NULL DEFAULT '0',
  `edit_date` bigint(14) DEFAULT NULL,
  `recent_comment_date` int(10) DEFAULT NULL,
  `comment_total` int(4) unsigned NOT NULL DEFAULT '0',
  `entry_data` text,
  PRIMARY KEY (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `author_id` (`author_id`),
  KEY `url_title` (`url_title`),
  KEY `status` (`status`),
  KEY `entry_date` (`entry_date`),
  KEY `expiration_date` (`expiration_date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_channel_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_channel_fields`;

CREATE TABLE `exp_channel_fields` (
  `field_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `field_name` varchar(32) NOT NULL,
  `field_label` varchar(50) NOT NULL,
  `field_instructions` text,
  `field_type` varchar(50) NOT NULL DEFAULT 'text',
  `field_list_items` text NOT NULL,
  `field_pre_populate` char(1) NOT NULL DEFAULT 'n',
  `field_pre_channel_id` int(6) unsigned DEFAULT NULL,
  `field_pre_field_id` int(6) unsigned DEFAULT NULL,
  `field_ta_rows` tinyint(2) DEFAULT '8',
  `field_maxl` smallint(3) DEFAULT NULL,
  `field_required` char(1) NOT NULL DEFAULT 'n',
  `field_text_direction` char(3) NOT NULL DEFAULT 'ltr',
  `field_search` char(1) NOT NULL DEFAULT 'n',
  `field_is_hidden` char(1) NOT NULL DEFAULT 'n',
  `field_fmt` varchar(40) NOT NULL DEFAULT 'xhtml',
  `field_show_fmt` char(1) NOT NULL DEFAULT 'y',
  `field_order` int(3) unsigned NOT NULL,
  `field_content_type` varchar(20) NOT NULL DEFAULT 'any',
  `field_settings` text,
  PRIMARY KEY (`field_id`),
  KEY `group_id` (`group_id`),
  KEY `field_type` (`field_type`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_channel_fields` WRITE;
/*!40000 ALTER TABLE `exp_channel_fields` DISABLE KEYS */;

INSERT INTO `exp_channel_fields` (`field_id`, `site_id`, `group_id`, `field_name`, `field_label`, `field_instructions`, `field_type`, `field_list_items`, `field_pre_populate`, `field_pre_channel_id`, `field_pre_field_id`, `field_ta_rows`, `field_maxl`, `field_required`, `field_text_direction`, `field_search`, `field_is_hidden`, `field_fmt`, `field_show_fmt`, `field_order`, `field_content_type`, `field_settings`)
VALUES
	(1,1,1,'cf_page_content','Content','','wygwam','','0',0,0,6,128,'n','ltr','n','n','none','n',1,'any','YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
	(2,1,1,'cf_page_feature_image','Feature Image','','assets','','0',0,0,6,128,'n','ltr','n','n','none','n',2,'any','YToxMjp7czo4OiJmaWxlZGlycyI7YToxOntpOjA7czozOiJhbGwiO31zOjQ6InZpZXciO3M6NjoidGh1bWJzIjtzOjEwOiJ0aHVtYl9zaXplIjtzOjU6InNtYWxsIjtzOjk6InNob3dfY29scyI7YTozOntpOjA7czo2OiJmb2xkZXIiO2k6MTtzOjQ6ImRhdGUiO2k6MjtzOjQ6InNpemUiO31zOjE0OiJzaG93X2ZpbGVuYW1lcyI7czoxOiJuIjtzOjU6Im11bHRpIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
	(3,1,1,'cf_page_thumbnail_image','Thumbnail Image','','assets','','0',0,0,6,128,'n','ltr','n','n','none','n',3,'any','YToxMjp7czo4OiJmaWxlZGlycyI7YToxOntpOjA7czozOiJhbGwiO31zOjQ6InZpZXciO3M6NjoidGh1bWJzIjtzOjEwOiJ0aHVtYl9zaXplIjtzOjU6InNtYWxsIjtzOjk6InNob3dfY29scyI7YTozOntpOjA7czo2OiJmb2xkZXIiO2k6MTtzOjQ6ImRhdGUiO2k6MjtzOjQ6InNpemUiO31zOjE0OiJzaG93X2ZpbGVuYW1lcyI7czoxOiJuIjtzOjU6Im11bHRpIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
	(4,1,2,'cf_article_content','Content','','wygwam','','0',0,0,6,128,'n','ltr','n','n','none','n',1,'any','YTo4OntzOjY6ImNvbmZpZyI7czoxOiIxIjtzOjU6ImRlZmVyIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
	(5,1,2,'cf_article_feature_image','Feature Image','','assets','','0',0,0,6,128,'n','ltr','n','n','none','n',2,'any','YToxMjp7czo4OiJmaWxlZGlycyI7YToxOntpOjA7czozOiJhbGwiO31zOjQ6InZpZXciO3M6NjoidGh1bWJzIjtzOjEwOiJ0aHVtYl9zaXplIjtzOjU6InNtYWxsIjtzOjk6InNob3dfY29scyI7YTozOntpOjA7czo2OiJmb2xkZXIiO2k6MTtzOjQ6ImRhdGUiO2k6MjtzOjQ6InNpemUiO31zOjE0OiJzaG93X2ZpbGVuYW1lcyI7czoxOiJuIjtzOjU6Im11bHRpIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
	(6,1,2,'cf_article_thumbnail_image','Thumbnail Image','','assets','','0',0,0,6,128,'n','ltr','n','n','none','n',3,'any','YToxMjp7czo4OiJmaWxlZGlycyI7YToxOntpOjA7czozOiJhbGwiO31zOjQ6InZpZXciO3M6NjoidGh1bWJzIjtzOjEwOiJ0aHVtYl9zaXplIjtzOjU6InNtYWxsIjtzOjk6InNob3dfY29scyI7YTozOntpOjA7czo2OiJmb2xkZXIiO2k6MTtzOjQ6ImRhdGUiO2k6MjtzOjQ6InNpemUiO31zOjE0OiJzaG93X2ZpbGVuYW1lcyI7czoxOiJuIjtzOjU6Im11bHRpIjtzOjE6Im4iO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
	(7,1,1,'cf_page_related_articles','Related Articles','','relationship','','0',0,0,6,128,'n','ltr','n','n','xhtml','n',4,'any','YToxNjp7czo4OiJjaGFubmVscyI7YToxOntpOjA7czoxOiIyIjt9czo3OiJleHBpcmVkIjtiOjA7czo2OiJmdXR1cmUiO2I6MDtzOjEwOiJjYXRlZ29yaWVzIjthOjA6e31zOjc6ImF1dGhvcnMiO2E6MDp7fXM6ODoic3RhdHVzZXMiO2E6MDp7fXM6NToibGltaXQiO2k6MTAwO3M6MTE6Im9yZGVyX2ZpZWxkIjtzOjU6InRpdGxlIjtzOjk6Im9yZGVyX2RpciI7czozOiJhc2MiO3M6MTQ6ImFsbG93X211bHRpcGxlIjtiOjE7czoxODoiZmllbGRfc2hvd19zbWlsZXlzIjtzOjE6Im4iO3M6MTk6ImZpZWxkX3Nob3dfZ2xvc3NhcnkiO3M6MToibiI7czoyMToiZmllbGRfc2hvd19zcGVsbGNoZWNrIjtzOjE6Im4iO3M6MjY6ImZpZWxkX3Nob3dfZm9ybWF0dGluZ19idG5zIjtzOjE6Im4iO3M6MjQ6ImZpZWxkX3Nob3dfZmlsZV9zZWxlY3RvciI7czoxOiJuIjtzOjIwOiJmaWVsZF9zaG93X3dyaXRlbW9kZSI7czoxOiJuIjt9');

/*!40000 ALTER TABLE `exp_channel_fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_channel_form_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_channel_form_settings`;

CREATE TABLE `exp_channel_form_settings` (
  `channel_form_settings_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '0',
  `channel_id` int(6) unsigned NOT NULL DEFAULT '0',
  `default_status` varchar(50) NOT NULL DEFAULT 'open',
  `require_captcha` char(1) NOT NULL DEFAULT 'n',
  `allow_guest_posts` char(1) NOT NULL DEFAULT 'n',
  `default_author` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`channel_form_settings_id`),
  KEY `site_id` (`site_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_channel_member_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_channel_member_groups`;

CREATE TABLE `exp_channel_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `channel_id` int(6) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_channel_titles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_channel_titles`;

CREATE TABLE `exp_channel_titles` (
  `entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `forum_topic_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL,
  `url_title` varchar(75) NOT NULL,
  `status` varchar(50) NOT NULL,
  `versioning_enabled` char(1) NOT NULL DEFAULT 'n',
  `view_count_one` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_two` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_three` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_four` int(10) unsigned NOT NULL DEFAULT '0',
  `allow_comments` varchar(1) NOT NULL DEFAULT 'y',
  `sticky` varchar(1) NOT NULL DEFAULT 'n',
  `entry_date` int(10) NOT NULL,
  `year` char(4) NOT NULL,
  `month` char(2) NOT NULL,
  `day` char(3) NOT NULL,
  `expiration_date` int(10) NOT NULL DEFAULT '0',
  `comment_expiration_date` int(10) NOT NULL DEFAULT '0',
  `edit_date` bigint(14) DEFAULT NULL,
  `recent_comment_date` int(10) DEFAULT NULL,
  `comment_total` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry_id`),
  KEY `channel_id` (`channel_id`),
  KEY `author_id` (`author_id`),
  KEY `url_title` (`url_title`),
  KEY `status` (`status`),
  KEY `entry_date` (`entry_date`),
  KEY `expiration_date` (`expiration_date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_channels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_channels`;

CREATE TABLE `exp_channels` (
  `channel_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_name` varchar(40) NOT NULL,
  `channel_title` varchar(100) NOT NULL,
  `channel_url` varchar(100) NOT NULL,
  `channel_description` varchar(255) DEFAULT NULL,
  `channel_lang` varchar(12) NOT NULL,
  `total_entries` mediumint(8) NOT NULL DEFAULT '0',
  `total_comments` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `cat_group` varchar(255) DEFAULT NULL,
  `status_group` int(4) unsigned DEFAULT NULL,
  `deft_status` varchar(50) NOT NULL DEFAULT 'open',
  `field_group` int(4) unsigned DEFAULT NULL,
  `search_excerpt` int(4) unsigned DEFAULT NULL,
  `deft_category` varchar(60) DEFAULT NULL,
  `deft_comments` char(1) NOT NULL DEFAULT 'y',
  `channel_require_membership` char(1) NOT NULL DEFAULT 'y',
  `channel_max_chars` int(5) unsigned DEFAULT NULL,
  `channel_html_formatting` char(4) NOT NULL DEFAULT 'all',
  `channel_allow_img_urls` char(1) NOT NULL DEFAULT 'y',
  `channel_auto_link_urls` char(1) NOT NULL DEFAULT 'n',
  `channel_notify` char(1) NOT NULL DEFAULT 'n',
  `channel_notify_emails` varchar(255) DEFAULT NULL,
  `comment_url` varchar(80) DEFAULT NULL,
  `comment_system_enabled` char(1) NOT NULL DEFAULT 'y',
  `comment_require_membership` char(1) NOT NULL DEFAULT 'n',
  `comment_use_captcha` char(1) NOT NULL DEFAULT 'n',
  `comment_moderate` char(1) NOT NULL DEFAULT 'n',
  `comment_max_chars` int(5) unsigned DEFAULT '5000',
  `comment_timelock` int(5) unsigned NOT NULL DEFAULT '0',
  `comment_require_email` char(1) NOT NULL DEFAULT 'y',
  `comment_text_formatting` char(5) NOT NULL DEFAULT 'xhtml',
  `comment_html_formatting` char(4) NOT NULL DEFAULT 'safe',
  `comment_allow_img_urls` char(1) NOT NULL DEFAULT 'n',
  `comment_auto_link_urls` char(1) NOT NULL DEFAULT 'y',
  `comment_notify` char(1) NOT NULL DEFAULT 'n',
  `comment_notify_authors` char(1) NOT NULL DEFAULT 'n',
  `comment_notify_emails` varchar(255) DEFAULT NULL,
  `comment_expiration` int(4) unsigned NOT NULL DEFAULT '0',
  `search_results_url` varchar(80) DEFAULT NULL,
  `show_button_cluster` char(1) NOT NULL DEFAULT 'y',
  `rss_url` varchar(80) DEFAULT NULL,
  `enable_versioning` char(1) NOT NULL DEFAULT 'n',
  `max_revisions` smallint(4) unsigned NOT NULL DEFAULT '10',
  `default_entry_title` varchar(100) DEFAULT NULL,
  `url_title_prefix` varchar(80) DEFAULT NULL,
  `live_look_template` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`channel_id`),
  KEY `cat_group` (`cat_group`),
  KEY `status_group` (`status_group`),
  KEY `field_group` (`field_group`),
  KEY `channel_name` (`channel_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_channels` WRITE;
/*!40000 ALTER TABLE `exp_channels` DISABLE KEYS */;

INSERT INTO `exp_channels` (`channel_id`, `site_id`, `channel_name`, `channel_title`, `channel_url`, `channel_description`, `channel_lang`, `total_entries`, `total_comments`, `last_entry_date`, `last_comment_date`, `cat_group`, `status_group`, `deft_status`, `field_group`, `search_excerpt`, `deft_category`, `deft_comments`, `channel_require_membership`, `channel_max_chars`, `channel_html_formatting`, `channel_allow_img_urls`, `channel_auto_link_urls`, `channel_notify`, `channel_notify_emails`, `comment_url`, `comment_system_enabled`, `comment_require_membership`, `comment_use_captcha`, `comment_moderate`, `comment_max_chars`, `comment_timelock`, `comment_require_email`, `comment_text_formatting`, `comment_html_formatting`, `comment_allow_img_urls`, `comment_auto_link_urls`, `comment_notify`, `comment_notify_authors`, `comment_notify_emails`, `comment_expiration`, `search_results_url`, `show_button_cluster`, `rss_url`, `enable_versioning`, `max_revisions`, `default_entry_title`, `url_title_prefix`, `live_look_template`)
VALUES
	(1,1,'blog','Blog','',NULL,'en',0,0,0,0,'1',1,'open',1,NULL,NULL,'y','y',NULL,'all','y','n','n',NULL,NULL,'y','n','n','n',5000,0,'y','xhtml','safe','n','y','n','n',NULL,0,NULL,'y',NULL,'n',10,NULL,NULL,0),
	(2,1,'articles','Articles','',NULL,'en',0,0,0,0,'2',1,'open',2,NULL,NULL,'y','y',NULL,'all','y','n','n',NULL,NULL,'y','n','n','n',5000,0,'y','xhtml','safe','n','y','n','n',NULL,0,NULL,'y',NULL,'n',10,NULL,NULL,0),
	(3,1,'brand','Brands','',NULL,'en',0,0,0,0,'3|1',1,'open',3,NULL,NULL,'y','y',NULL,'all','y','n','n',NULL,NULL,'y','n','n','n',5000,0,'y','xhtml','safe','n','y','n','n',NULL,0,NULL,'y',NULL,'n',10,NULL,NULL,0);

/*!40000 ALTER TABLE `exp_channels` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_content_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_content_types`;

CREATE TABLE `exp_content_types` (
  `content_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_type_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_content_types` WRITE;
/*!40000 ALTER TABLE `exp_content_types` DISABLE KEYS */;

INSERT INTO `exp_content_types` (`content_type_id`, `name`)
VALUES
	(1,'grid'),
	(2,'channel');

/*!40000 ALTER TABLE `exp_content_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_cp_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_cp_log`;

CREATE TABLE `exp_cp_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) unsigned NOT NULL,
  `username` varchar(32) NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `act_date` int(10) NOT NULL,
  `action` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_cp_log` WRITE;
/*!40000 ALTER TABLE `exp_cp_log` DISABLE KEYS */;

INSERT INTO `exp_cp_log` (`id`, `site_id`, `member_id`, `username`, `ip_address`, `act_date`, `action`)
VALUES
	(1,1,1,'leevigraham','127.0.0.1',1425471998,'Logged in'),
	(2,1,1,'leevigraham','127.0.0.1',1425476168,'Logged in'),
	(3,1,1,'leevigraham','127.0.0.1',1425478467,'Logged in'),
	(4,1,1,'leevigraham','127.0.0.1',1425479181,'Channel Created:&nbsp;&nbsp;Pages'),
	(5,1,1,'leevigraham','127.0.0.1',1425479198,'Channel Created:&nbsp;&nbsp;News'),
	(6,1,1,'leevigraham','127.0.0.1',1425479931,'Field Group Created:&nbsp;pages'),
	(7,1,1,'leevigraham','127.0.0.1',1425480384,'Channel Created:&nbsp;&nbsp;Blog'),
	(8,1,1,'leevigraham','127.0.0.1',1425482483,'Category Group Created:&nbsp;&nbsp;Blog'),
	(9,1,1,'leevigraham','127.0.0.1',1425482504,'Channel Created:&nbsp;&nbsp;Blog2'),
	(10,1,1,'leevigraham','127.0.0.1',1425483368,'Field Group Created:&nbsp;Products'),
	(11,1,1,'leevigraham','127.0.0.1',1425483372,'Category Group Created:&nbsp;&nbsp;Products'),
	(12,1,1,'leevigraham','127.0.0.1',1425483388,'Channel Created:&nbsp;&nbsp;Products'),
	(13,1,1,'leevigraham','127.0.0.1',1425484203,'Field Group Created:&nbsp;Articles'),
	(14,1,1,'leevigraham','127.0.0.1',1425484204,'Channel Created:&nbsp;&nbsp;Articles'),
	(15,1,1,'leevigraham','127.0.0.1',1425484251,'Channel Deleted:&nbsp;&nbsp;Articles'),
	(16,1,1,'leevigraham','127.0.0.1',1425484253,'Channel Deleted:&nbsp;&nbsp;Blog'),
	(17,1,1,'leevigraham','127.0.0.1',1425484254,'Channel Deleted:&nbsp;&nbsp;Blog2'),
	(18,1,1,'leevigraham','127.0.0.1',1425484256,'Channel Deleted:&nbsp;&nbsp;Products'),
	(19,1,1,'leevigraham','127.0.0.1',1425484269,'Category Group Deleted:&nbsp;&nbsp;Blog'),
	(20,1,1,'leevigraham','127.0.0.1',1425484271,'Category Group Deleted:&nbsp;&nbsp;Products'),
	(21,1,1,'leevigraham','127.0.0.1',1425484277,'Field group Deleted:&nbsp;&nbsp;Articles'),
	(22,1,1,'leevigraham','127.0.0.1',1425484279,'Field group Deleted:&nbsp;&nbsp;Blog'),
	(23,1,1,'leevigraham','127.0.0.1',1425484281,'Field group Deleted:&nbsp;&nbsp;pages'),
	(24,1,1,'leevigraham','127.0.0.1',1425484282,'Field group Deleted:&nbsp;&nbsp;Products'),
	(25,1,1,'leevigraham','127.0.0.1',1425484293,'Field Group Created:&nbsp;Articles'),
	(26,1,1,'leevigraham','127.0.0.1',1425484316,'Category Group Created:&nbsp;&nbsp;Articles'),
	(27,1,1,'leevigraham','127.0.0.1',1425484320,'Channel Created:&nbsp;&nbsp;Articles'),
	(28,1,1,'leevigraham','127.0.0.1',1425484353,'Field Group Created:&nbsp;Brands'),
	(29,1,1,'leevigraham','127.0.0.1',1425484353,'Category Group Created:&nbsp;&nbsp;Brands'),
	(30,1,1,'leevigraham','127.0.0.1',1425484353,'Channel Created:&nbsp;&nbsp;Brands'),
	(31,1,1,'leevigraham','127.0.0.1',1425484355,'Field Group Created:&nbsp;Products'),
	(32,1,1,'leevigraham','127.0.0.1',1425484356,'Category Group Created:&nbsp;&nbsp;Products'),
	(33,1,1,'leevigraham','127.0.0.1',1425484356,'Channel Created:&nbsp;&nbsp;Products'),
	(34,1,1,'leevigraham','127.0.0.1',1425484527,'Field group Deleted:&nbsp;&nbsp;Products'),
	(35,1,1,'leevigraham','127.0.0.1',1425484541,'Field group Deleted:&nbsp;&nbsp;Articles'),
	(36,1,1,'leevigraham','127.0.0.1',1425484543,'Field group Deleted:&nbsp;&nbsp;Brands'),
	(37,1,1,'leevigraham','127.0.0.1',1425484556,'Field Group Created:&nbsp;Brands'),
	(38,1,1,'leevigraham','127.0.0.1',1425484571,'Category Group Deleted:&nbsp;&nbsp;Articles'),
	(39,1,1,'leevigraham','127.0.0.1',1425484574,'Category Group Deleted:&nbsp;&nbsp;Brands'),
	(40,1,1,'leevigraham','127.0.0.1',1425484575,'Category Group Deleted:&nbsp;&nbsp;Products'),
	(41,1,1,'leevigraham','127.0.0.1',1425484595,'Category Group Created:&nbsp;&nbsp;Brands'),
	(42,1,1,'leevigraham','127.0.0.1',1425484599,'Channel Created:&nbsp;&nbsp;Brands'),
	(43,1,1,'leevigraham','127.0.0.1',1425484615,'Field Group Created:&nbsp;Products'),
	(44,1,1,'leevigraham','127.0.0.1',1425484616,'Category Group Created:&nbsp;&nbsp;Products'),
	(45,1,1,'leevigraham','127.0.0.1',1425484616,'Channel Created:&nbsp;&nbsp;Products'),
	(46,1,1,'leevigraham','127.0.0.1',1425484724,'Field Group Created:&nbsp;Articles'),
	(47,1,1,'leevigraham','127.0.0.1',1425484724,'Category Group Created:&nbsp;&nbsp;Articles'),
	(48,1,1,'leevigraham','127.0.0.1',1425484725,'Channel Created:&nbsp;&nbsp;Articles'),
	(49,1,1,'leevigraham','127.0.0.1',1425501987,'Logged in'),
	(50,1,1,'leevigraham','127.0.0.1',1425516596,'Logged in'),
	(51,1,1,'leevigraham','127.0.0.1',1425519062,'Logged in'),
	(52,1,1,'leevigraham','127.0.0.1',1425549038,'Logged in'),
	(53,1,1,'leevigraham','127.0.0.1',1425549049,'Channel Deleted:&nbsp;&nbsp;Articles'),
	(54,1,1,'leevigraham','127.0.0.1',1425549050,'Channel Deleted:&nbsp;&nbsp;Brands'),
	(55,1,1,'leevigraham','127.0.0.1',1425549052,'Channel Deleted:&nbsp;&nbsp;Products'),
	(56,1,1,'leevigraham','127.0.0.1',1425549063,'Field group Deleted:&nbsp;&nbsp;Articles'),
	(57,1,1,'leevigraham','127.0.0.1',1425549065,'Field group Deleted:&nbsp;&nbsp;Brands'),
	(58,1,1,'leevigraham','127.0.0.1',1425549066,'Field group Deleted:&nbsp;&nbsp;Products'),
	(59,1,1,'leevigraham','127.0.0.1',1425549074,'Category Group Deleted:&nbsp;&nbsp;Articles'),
	(60,1,1,'leevigraham','127.0.0.1',1425549076,'Category Group Deleted:&nbsp;&nbsp;Brands'),
	(61,1,1,'leevigraham','127.0.0.1',1425549077,'Category Group Deleted:&nbsp;&nbsp;Products'),
	(62,1,1,'leevigraham','127.0.0.1',1425865486,'Field Group Created:&nbsp;Pages'),
	(63,1,1,'leevigraham','127.0.0.1',1425865487,'Category Group Created:&nbsp;&nbsp;Pages'),
	(64,1,1,'leevigraham','127.0.0.1',1425865494,'Channel Created:&nbsp;&nbsp;Blog'),
	(65,1,1,'leevigraham','127.0.0.1',1425865507,'Logged in'),
	(66,1,1,'leevigraham','127.0.0.1',1425865567,'Field Group Created:&nbsp;Articles'),
	(67,1,1,'leevigraham','127.0.0.1',1425865567,'Category Group Created:&nbsp;&nbsp;Articles'),
	(68,1,1,'leevigraham','127.0.0.1',1425865568,'Channel Created:&nbsp;&nbsp;Articles'),
	(69,1,1,'leevigraham','127.0.0.1',1425866402,'Field Group Created:&nbsp;Brands'),
	(70,1,1,'leevigraham','127.0.0.1',1425866402,'Category Group Created:&nbsp;&nbsp;Brands'),
	(71,1,1,'leevigraham','127.0.0.1',1425866418,'Channel Created:&nbsp;&nbsp;Brands');

/*!40000 ALTER TABLE `exp_cp_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_cp_search_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_cp_search_index`;

CREATE TABLE `exp_cp_search_index` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `controller` varchar(20) DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `access` varchar(50) DEFAULT NULL,
  `keywords` text,
  PRIMARY KEY (`search_id`),
  FULLTEXT KEY `keywords` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_developer_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_developer_log`;

CREATE TABLE `exp_developer_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` int(10) unsigned NOT NULL,
  `viewed` char(1) NOT NULL DEFAULT 'n',
  `description` text,
  `function` varchar(100) DEFAULT NULL,
  `line` int(10) unsigned DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `deprecated_since` varchar(10) DEFAULT NULL,
  `use_instead` varchar(100) DEFAULT NULL,
  `template_id` int(10) unsigned NOT NULL DEFAULT '0',
  `template_name` varchar(100) DEFAULT NULL,
  `template_group` varchar(100) DEFAULT NULL,
  `addon_module` varchar(100) DEFAULT NULL,
  `addon_method` varchar(100) DEFAULT NULL,
  `snippets` text,
  `hash` char(32) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_email_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_email_cache`;

CREATE TABLE `exp_email_cache` (
  `cache_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `cache_date` int(10) unsigned NOT NULL DEFAULT '0',
  `total_sent` int(6) unsigned NOT NULL,
  `from_name` varchar(70) NOT NULL,
  `from_email` varchar(75) NOT NULL,
  `recipient` text NOT NULL,
  `cc` text NOT NULL,
  `bcc` text NOT NULL,
  `recipient_array` mediumtext NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` mediumtext NOT NULL,
  `plaintext_alt` mediumtext NOT NULL,
  `mailinglist` char(1) NOT NULL DEFAULT 'n',
  `mailtype` varchar(6) NOT NULL,
  `text_fmt` varchar(40) NOT NULL,
  `wordwrap` char(1) NOT NULL DEFAULT 'y',
  `priority` char(1) NOT NULL DEFAULT '3',
  PRIMARY KEY (`cache_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_email_cache_mg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_email_cache_mg`;

CREATE TABLE `exp_email_cache_mg` (
  `cache_id` int(6) unsigned NOT NULL,
  `group_id` smallint(4) NOT NULL,
  PRIMARY KEY (`cache_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_email_cache_ml
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_email_cache_ml`;

CREATE TABLE `exp_email_cache_ml` (
  `cache_id` int(6) unsigned NOT NULL,
  `list_id` smallint(4) NOT NULL,
  PRIMARY KEY (`cache_id`,`list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_email_console_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_email_console_cache`;

CREATE TABLE `exp_email_console_cache` (
  `cache_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `cache_date` int(10) unsigned NOT NULL DEFAULT '0',
  `member_id` int(10) unsigned NOT NULL,
  `member_name` varchar(50) NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `recipient` varchar(75) NOT NULL,
  `recipient_name` varchar(50) NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` mediumtext NOT NULL,
  PRIMARY KEY (`cache_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_entry_versioning
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_entry_versioning`;

CREATE TABLE `exp_entry_versioning` (
  `version_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned NOT NULL,
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `version_date` int(10) NOT NULL,
  `version_data` mediumtext NOT NULL,
  PRIMARY KEY (`version_id`),
  KEY `entry_id` (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_extensions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_extensions`;

CREATE TABLE `exp_extensions` (
  `extension_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(50) NOT NULL DEFAULT '',
  `method` varchar(50) NOT NULL DEFAULT '',
  `hook` varchar(50) NOT NULL DEFAULT '',
  `settings` text NOT NULL,
  `priority` int(2) NOT NULL DEFAULT '10',
  `version` varchar(10) NOT NULL DEFAULT '',
  `enabled` char(1) NOT NULL DEFAULT 'y',
  PRIMARY KEY (`extension_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_extensions` WRITE;
/*!40000 ALTER TABLE `exp_extensions` DISABLE KEYS */;

INSERT INTO `exp_extensions` (`extension_id`, `class`, `method`, `hook`, `settings`, `priority`, `version`, `enabled`)
VALUES
	(1,'Rte_ext','myaccount_nav_setup','myaccount_nav_setup','',10,'1.0.1','y'),
	(2,'Rte_ext','cp_menu_array','cp_menu_array','',10,'1.0.1','y'),
	(3,'Assets_ext','channel_entries_query_result','channel_entries_query_result','',10,'2.5','y'),
	(4,'Assets_ext','file_after_save','file_after_save','',9,'2.5','y'),
	(5,'Assets_ext','files_after_delete','files_after_delete','',8,'2.5','y'),
	(6,'Store_ext','channel_entries_query_result','channel_entries_query_result','',10,'2.5.0','y'),
	(7,'Store_ext','cp_menu_array','cp_menu_array','',10,'2.5.0','y'),
	(8,'Store_ext','sessions_end','sessions_end','',10,'2.5.0','y'),
	(9,'Store_ext','member_member_logout','member_member_logout','',10,'2.5.0','y');

/*!40000 ALTER TABLE `exp_extensions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_field_formatting
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_field_formatting`;

CREATE TABLE `exp_field_formatting` (
  `formatting_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(10) unsigned NOT NULL,
  `field_fmt` varchar(40) NOT NULL,
  PRIMARY KEY (`formatting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_field_formatting` WRITE;
/*!40000 ALTER TABLE `exp_field_formatting` DISABLE KEYS */;

INSERT INTO `exp_field_formatting` (`formatting_id`, `field_id`, `field_fmt`)
VALUES
	(1,1,'none'),
	(2,1,'br'),
	(3,1,'markdown'),
	(4,1,'xhtml'),
	(5,2,'none'),
	(6,2,'br'),
	(7,2,'markdown'),
	(8,2,'xhtml'),
	(9,3,'none'),
	(10,3,'br'),
	(11,3,'markdown'),
	(12,3,'xhtml'),
	(13,4,'none'),
	(14,4,'br'),
	(15,4,'markdown'),
	(16,4,'xhtml'),
	(17,5,'none'),
	(18,5,'br'),
	(19,5,'markdown'),
	(20,5,'xhtml'),
	(21,6,'none'),
	(22,6,'br'),
	(23,6,'markdown'),
	(24,6,'xhtml'),
	(25,7,'none'),
	(26,7,'br'),
	(27,7,'markdown'),
	(28,7,'xhtml');

/*!40000 ALTER TABLE `exp_field_formatting` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_field_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_field_groups`;

CREATE TABLE `exp_field_groups` (
  `group_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_field_groups` WRITE;
/*!40000 ALTER TABLE `exp_field_groups` DISABLE KEYS */;

INSERT INTO `exp_field_groups` (`group_id`, `site_id`, `group_name`)
VALUES
	(1,1,'Pages'),
	(2,1,'Articles'),
	(3,1,'Brands');

/*!40000 ALTER TABLE `exp_field_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_fieldtypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_fieldtypes`;

CREATE TABLE `exp_fieldtypes` (
  `fieldtype_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `version` varchar(12) NOT NULL,
  `settings` text,
  `has_global_settings` char(1) DEFAULT 'n',
  PRIMARY KEY (`fieldtype_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_fieldtypes` WRITE;
/*!40000 ALTER TABLE `exp_fieldtypes` DISABLE KEYS */;

INSERT INTO `exp_fieldtypes` (`fieldtype_id`, `name`, `version`, `settings`, `has_global_settings`)
VALUES
	(1,'select','1.0','YTowOnt9','n'),
	(2,'text','1.0','YTowOnt9','n'),
	(3,'textarea','1.0','YTowOnt9','n'),
	(4,'date','1.0','YTowOnt9','n'),
	(5,'file','1.0','YTowOnt9','n'),
	(6,'grid','1.0','YTowOnt9','n'),
	(7,'multi_select','1.0','YTowOnt9','n'),
	(8,'checkboxes','1.0','YTowOnt9','n'),
	(9,'radio','1.0','YTowOnt9','n'),
	(10,'relationship','1.0','YTowOnt9','n'),
	(11,'rte','1.0','YTowOnt9','n'),
	(12,'wygwam','3.3.3','YTowOnt9','y'),
	(13,'assets','2.5','YTowOnt9','y'),
	(14,'fieldpack_pill','2.2','YTowOnt9','n'),
	(15,'fieldpack_dropdown','2.2','YTowOnt9','n'),
	(16,'store','2.5.0','YTowOnt9','n');

/*!40000 ALTER TABLE `exp_fieldtypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_file_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_file_categories`;

CREATE TABLE `exp_file_categories` (
  `file_id` int(10) unsigned DEFAULT NULL,
  `cat_id` int(10) unsigned DEFAULT NULL,
  `sort` int(10) unsigned DEFAULT '0',
  `is_cover` char(1) DEFAULT 'n',
  KEY `file_id` (`file_id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_file_dimensions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_file_dimensions`;

CREATE TABLE `exp_file_dimensions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `upload_location_id` int(4) unsigned DEFAULT NULL,
  `title` varchar(255) DEFAULT '',
  `short_name` varchar(255) DEFAULT '',
  `resize_type` varchar(50) DEFAULT '',
  `width` int(10) DEFAULT '0',
  `height` int(10) DEFAULT '0',
  `watermark_id` int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `upload_location_id` (`upload_location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_file_watermarks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_file_watermarks`;

CREATE TABLE `exp_file_watermarks` (
  `wm_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `wm_name` varchar(80) DEFAULT NULL,
  `wm_type` varchar(10) DEFAULT 'text',
  `wm_image_path` varchar(100) DEFAULT NULL,
  `wm_test_image_path` varchar(100) DEFAULT NULL,
  `wm_use_font` char(1) DEFAULT 'y',
  `wm_font` varchar(30) DEFAULT NULL,
  `wm_font_size` int(3) unsigned DEFAULT NULL,
  `wm_text` varchar(100) DEFAULT NULL,
  `wm_vrt_alignment` varchar(10) DEFAULT 'top',
  `wm_hor_alignment` varchar(10) DEFAULT 'left',
  `wm_padding` int(3) unsigned DEFAULT NULL,
  `wm_opacity` int(3) unsigned DEFAULT NULL,
  `wm_hor_offset` int(4) unsigned DEFAULT NULL,
  `wm_vrt_offset` int(4) unsigned DEFAULT NULL,
  `wm_x_transp` int(4) DEFAULT NULL,
  `wm_y_transp` int(4) DEFAULT NULL,
  `wm_font_color` varchar(7) DEFAULT NULL,
  `wm_use_drop_shadow` char(1) DEFAULT 'y',
  `wm_shadow_distance` int(3) unsigned DEFAULT NULL,
  `wm_shadow_color` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`wm_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_files
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_files`;

CREATE TABLE `exp_files` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned DEFAULT '1',
  `title` varchar(255) DEFAULT NULL,
  `upload_location_id` int(4) unsigned DEFAULT '0',
  `rel_path` varchar(255) DEFAULT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(10) DEFAULT '0',
  `description` text,
  `credit` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `uploaded_by_member_id` int(10) unsigned DEFAULT '0',
  `upload_date` int(10) DEFAULT NULL,
  `modified_by_member_id` int(10) unsigned DEFAULT '0',
  `modified_date` int(10) DEFAULT NULL,
  `file_hw_original` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`file_id`),
  KEY `upload_location_id` (`upload_location_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_global_variables
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_global_variables`;

CREATE TABLE `exp_global_variables` (
  `variable_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `variable_name` varchar(50) NOT NULL,
  `variable_data` text NOT NULL,
  PRIMARY KEY (`variable_id`),
  KEY `variable_name` (`variable_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_grid_columns
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_grid_columns`;

CREATE TABLE `exp_grid_columns` (
  `col_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(10) unsigned DEFAULT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  `col_order` int(3) unsigned DEFAULT NULL,
  `col_type` varchar(50) DEFAULT NULL,
  `col_label` varchar(50) DEFAULT NULL,
  `col_name` varchar(32) DEFAULT NULL,
  `col_instructions` text,
  `col_required` char(1) DEFAULT NULL,
  `col_search` char(1) DEFAULT NULL,
  `col_width` int(3) unsigned DEFAULT NULL,
  `col_settings` text,
  PRIMARY KEY (`col_id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_html_buttons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_html_buttons`;

CREATE TABLE `exp_html_buttons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `tag_name` varchar(32) NOT NULL,
  `tag_open` varchar(120) NOT NULL,
  `tag_close` varchar(120) NOT NULL,
  `accesskey` varchar(32) NOT NULL,
  `tag_order` int(3) unsigned NOT NULL,
  `tag_row` char(1) NOT NULL DEFAULT '1',
  `classname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_html_buttons` WRITE;
/*!40000 ALTER TABLE `exp_html_buttons` DISABLE KEYS */;

INSERT INTO `exp_html_buttons` (`id`, `site_id`, `member_id`, `tag_name`, `tag_open`, `tag_close`, `accesskey`, `tag_order`, `tag_row`, `classname`)
VALUES
	(1,1,0,'b','<strong>','</strong>','b',1,'1','btn_b'),
	(2,1,0,'i','<em>','</em>','i',2,'1','btn_i'),
	(3,1,0,'blockquote','<blockquote>','</blockquote>','q',3,'1','btn_blockquote'),
	(4,1,0,'a','<a href=\"[![Link:!:http://]!]\"(!( title=\"[![Title]!]\")!)>','</a>','a',4,'1','btn_a'),
	(5,1,0,'img','<img src=\"[![Link:!:http://]!]\" alt=\"[![Alternative text]!]\" />','','',5,'1','btn_img');

/*!40000 ALTER TABLE `exp_html_buttons` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_layout_publish
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_layout_publish`;

CREATE TABLE `exp_layout_publish` (
  `layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_group` int(4) unsigned NOT NULL DEFAULT '0',
  `channel_id` int(4) unsigned NOT NULL DEFAULT '0',
  `field_layout` text,
  PRIMARY KEY (`layout_id`),
  KEY `site_id` (`site_id`),
  KEY `member_group` (`member_group`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_low_search_collections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_low_search_collections`;

CREATE TABLE `exp_low_search_collections` (
  `collection_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL,
  `channel_id` int(6) unsigned NOT NULL,
  `collection_name` varchar(40) NOT NULL,
  `collection_label` varchar(100) NOT NULL,
  `language` varchar(5) DEFAULT NULL,
  `modifier` decimal(4,1) unsigned NOT NULL DEFAULT '1.0',
  `excerpt` int(6) unsigned NOT NULL DEFAULT '0',
  `settings` text NOT NULL,
  `edit_date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`collection_id`),
  KEY `site_id` (`site_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_low_search_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_low_search_groups`;

CREATE TABLE `exp_low_search_groups` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL,
  `group_label` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_low_search_indexes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_low_search_indexes`;

CREATE TABLE `exp_low_search_indexes` (
  `collection_id` int(10) unsigned NOT NULL,
  `entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL,
  `index_text` longtext NOT NULL,
  `index_date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`collection_id`,`entry_id`),
  KEY `collection_id` (`collection_id`),
  KEY `site_id` (`site_id`),
  FULLTEXT KEY `index_text` (`index_text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_low_search_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_low_search_log`;

CREATE TABLE `exp_low_search_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `search_date` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  `keywords` varchar(150) NOT NULL,
  `parameters` text NOT NULL,
  `num_results` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_low_search_replace_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_low_search_replace_log`;

CREATE TABLE `exp_low_search_replace_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `replace_date` int(10) unsigned NOT NULL,
  `keywords` varchar(150) NOT NULL,
  `replacement` varchar(150) NOT NULL,
  `fields` text NOT NULL,
  `entries` text NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_low_search_shortcuts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_low_search_shortcuts`;

CREATE TABLE `exp_low_search_shortcuts` (
  `shortcut_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL,
  `group_id` int(4) unsigned NOT NULL,
  `shortcut_name` varchar(40) NOT NULL,
  `shortcut_label` varchar(150) DEFAULT NULL,
  `parameters` text NOT NULL,
  `sort_order` int(4) unsigned NOT NULL,
  PRIMARY KEY (`shortcut_id`),
  KEY `site_id` (`site_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_low_search_words
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_low_search_words`;

CREATE TABLE `exp_low_search_words` (
  `site_id` int(4) unsigned NOT NULL,
  `language` varchar(5) NOT NULL,
  `word` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `length` int(4) unsigned NOT NULL,
  `sound` char(4) DEFAULT NULL,
  `clean` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`site_id`,`language`,`word`),
  KEY `length` (`length`),
  KEY `sound` (`sound`),
  KEY `clean` (`clean`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_member_bulletin_board
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_member_bulletin_board`;

CREATE TABLE `exp_member_bulletin_board` (
  `bulletin_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) unsigned NOT NULL,
  `bulletin_group` int(8) unsigned NOT NULL,
  `bulletin_date` int(10) unsigned NOT NULL,
  `hash` varchar(10) NOT NULL DEFAULT '',
  `bulletin_expires` int(10) unsigned NOT NULL DEFAULT '0',
  `bulletin_message` text NOT NULL,
  PRIMARY KEY (`bulletin_id`),
  KEY `sender_id` (`sender_id`),
  KEY `hash` (`hash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_member_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_member_data`;

CREATE TABLE `exp_member_data` (
  `member_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_member_data` WRITE;
/*!40000 ALTER TABLE `exp_member_data` DISABLE KEYS */;

INSERT INTO `exp_member_data` (`member_id`)
VALUES
	(1);

/*!40000 ALTER TABLE `exp_member_data` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_member_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_member_fields`;

CREATE TABLE `exp_member_fields` (
  `m_field_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `m_field_name` varchar(32) NOT NULL,
  `m_field_label` varchar(50) NOT NULL,
  `m_field_description` text NOT NULL,
  `m_field_type` varchar(12) NOT NULL DEFAULT 'text',
  `m_field_list_items` text NOT NULL,
  `m_field_ta_rows` tinyint(2) DEFAULT '8',
  `m_field_maxl` smallint(3) NOT NULL,
  `m_field_width` varchar(6) NOT NULL,
  `m_field_search` char(1) NOT NULL DEFAULT 'y',
  `m_field_required` char(1) NOT NULL DEFAULT 'n',
  `m_field_public` char(1) NOT NULL DEFAULT 'y',
  `m_field_reg` char(1) NOT NULL DEFAULT 'n',
  `m_field_cp_reg` char(1) NOT NULL DEFAULT 'n',
  `m_field_fmt` char(5) NOT NULL DEFAULT 'none',
  `m_field_order` int(3) unsigned NOT NULL,
  PRIMARY KEY (`m_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_member_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_member_groups`;

CREATE TABLE `exp_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_title` varchar(100) NOT NULL,
  `group_description` text NOT NULL,
  `is_locked` char(1) NOT NULL DEFAULT 'y',
  `can_view_offline_system` char(1) NOT NULL DEFAULT 'n',
  `can_view_online_system` char(1) NOT NULL DEFAULT 'y',
  `can_access_cp` char(1) NOT NULL DEFAULT 'y',
  `can_access_content` char(1) NOT NULL DEFAULT 'n',
  `can_access_publish` char(1) NOT NULL DEFAULT 'n',
  `can_access_edit` char(1) NOT NULL DEFAULT 'n',
  `can_access_files` char(1) NOT NULL DEFAULT 'n',
  `can_access_fieldtypes` char(1) NOT NULL DEFAULT 'n',
  `can_access_design` char(1) NOT NULL DEFAULT 'n',
  `can_access_addons` char(1) NOT NULL DEFAULT 'n',
  `can_access_modules` char(1) NOT NULL DEFAULT 'n',
  `can_access_extensions` char(1) NOT NULL DEFAULT 'n',
  `can_access_accessories` char(1) NOT NULL DEFAULT 'n',
  `can_access_plugins` char(1) NOT NULL DEFAULT 'n',
  `can_access_members` char(1) NOT NULL DEFAULT 'n',
  `can_access_admin` char(1) NOT NULL DEFAULT 'n',
  `can_access_sys_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_access_content_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_access_tools` char(1) NOT NULL DEFAULT 'n',
  `can_access_comm` char(1) NOT NULL DEFAULT 'n',
  `can_access_utilities` char(1) NOT NULL DEFAULT 'n',
  `can_access_data` char(1) NOT NULL DEFAULT 'n',
  `can_access_logs` char(1) NOT NULL DEFAULT 'n',
  `can_admin_channels` char(1) NOT NULL DEFAULT 'n',
  `can_admin_upload_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_admin_design` char(1) NOT NULL DEFAULT 'n',
  `can_admin_members` char(1) NOT NULL DEFAULT 'n',
  `can_delete_members` char(1) NOT NULL DEFAULT 'n',
  `can_admin_mbr_groups` char(1) NOT NULL DEFAULT 'n',
  `can_admin_mbr_templates` char(1) NOT NULL DEFAULT 'n',
  `can_ban_users` char(1) NOT NULL DEFAULT 'n',
  `can_admin_modules` char(1) NOT NULL DEFAULT 'n',
  `can_admin_templates` char(1) NOT NULL DEFAULT 'n',
  `can_edit_categories` char(1) NOT NULL DEFAULT 'n',
  `can_delete_categories` char(1) NOT NULL DEFAULT 'n',
  `can_view_other_entries` char(1) NOT NULL DEFAULT 'n',
  `can_edit_other_entries` char(1) NOT NULL DEFAULT 'n',
  `can_assign_post_authors` char(1) NOT NULL DEFAULT 'n',
  `can_delete_self_entries` char(1) NOT NULL DEFAULT 'n',
  `can_delete_all_entries` char(1) NOT NULL DEFAULT 'n',
  `can_view_other_comments` char(1) NOT NULL DEFAULT 'n',
  `can_edit_own_comments` char(1) NOT NULL DEFAULT 'n',
  `can_delete_own_comments` char(1) NOT NULL DEFAULT 'n',
  `can_edit_all_comments` char(1) NOT NULL DEFAULT 'n',
  `can_delete_all_comments` char(1) NOT NULL DEFAULT 'n',
  `can_moderate_comments` char(1) NOT NULL DEFAULT 'n',
  `can_send_email` char(1) NOT NULL DEFAULT 'n',
  `can_send_cached_email` char(1) NOT NULL DEFAULT 'n',
  `can_email_member_groups` char(1) NOT NULL DEFAULT 'n',
  `can_email_mailinglist` char(1) NOT NULL DEFAULT 'n',
  `can_email_from_profile` char(1) NOT NULL DEFAULT 'n',
  `can_view_profiles` char(1) NOT NULL DEFAULT 'n',
  `can_edit_html_buttons` char(1) NOT NULL DEFAULT 'n',
  `can_delete_self` char(1) NOT NULL DEFAULT 'n',
  `mbr_delete_notify_emails` varchar(255) DEFAULT NULL,
  `can_post_comments` char(1) NOT NULL DEFAULT 'n',
  `exclude_from_moderation` char(1) NOT NULL DEFAULT 'n',
  `can_search` char(1) NOT NULL DEFAULT 'n',
  `search_flood_control` mediumint(5) unsigned NOT NULL,
  `can_send_private_messages` char(1) NOT NULL DEFAULT 'n',
  `prv_msg_send_limit` smallint(5) unsigned NOT NULL DEFAULT '20',
  `prv_msg_storage_limit` smallint(5) unsigned NOT NULL DEFAULT '60',
  `can_attach_in_private_messages` char(1) NOT NULL DEFAULT 'n',
  `can_send_bulletins` char(1) NOT NULL DEFAULT 'n',
  `include_in_authorlist` char(1) NOT NULL DEFAULT 'n',
  `include_in_memberlist` char(1) NOT NULL DEFAULT 'y',
  `include_in_mailinglists` char(1) NOT NULL DEFAULT 'y',
  PRIMARY KEY (`group_id`,`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_member_groups` WRITE;
/*!40000 ALTER TABLE `exp_member_groups` DISABLE KEYS */;

INSERT INTO `exp_member_groups` (`group_id`, `site_id`, `group_title`, `group_description`, `is_locked`, `can_view_offline_system`, `can_view_online_system`, `can_access_cp`, `can_access_content`, `can_access_publish`, `can_access_edit`, `can_access_files`, `can_access_fieldtypes`, `can_access_design`, `can_access_addons`, `can_access_modules`, `can_access_extensions`, `can_access_accessories`, `can_access_plugins`, `can_access_members`, `can_access_admin`, `can_access_sys_prefs`, `can_access_content_prefs`, `can_access_tools`, `can_access_comm`, `can_access_utilities`, `can_access_data`, `can_access_logs`, `can_admin_channels`, `can_admin_upload_prefs`, `can_admin_design`, `can_admin_members`, `can_delete_members`, `can_admin_mbr_groups`, `can_admin_mbr_templates`, `can_ban_users`, `can_admin_modules`, `can_admin_templates`, `can_edit_categories`, `can_delete_categories`, `can_view_other_entries`, `can_edit_other_entries`, `can_assign_post_authors`, `can_delete_self_entries`, `can_delete_all_entries`, `can_view_other_comments`, `can_edit_own_comments`, `can_delete_own_comments`, `can_edit_all_comments`, `can_delete_all_comments`, `can_moderate_comments`, `can_send_email`, `can_send_cached_email`, `can_email_member_groups`, `can_email_mailinglist`, `can_email_from_profile`, `can_view_profiles`, `can_edit_html_buttons`, `can_delete_self`, `mbr_delete_notify_emails`, `can_post_comments`, `exclude_from_moderation`, `can_search`, `search_flood_control`, `can_send_private_messages`, `prv_msg_send_limit`, `prv_msg_storage_limit`, `can_attach_in_private_messages`, `can_send_bulletins`, `include_in_authorlist`, `include_in_memberlist`, `include_in_mailinglists`)
VALUES
	(1,1,'Super Admins','','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','','y','y','y',0,'y',20,60,'y','y','y','y','y'),
	(2,1,'Banned','','y','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','','n','n','n',60,'n',20,60,'n','n','n','n','n'),
	(3,1,'Guests','','y','n','y','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','y','n','n','n','n','','y','n','y',15,'n',20,60,'n','n','n','n','n'),
	(4,1,'Pending','','y','n','y','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','y','n','n','n','n','','y','n','y',15,'n',20,60,'n','n','n','n','n'),
	(5,1,'Members','','y','n','y','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','n','y','y','y','n','','y','n','y',10,'y',20,60,'y','n','n','y','y');

/*!40000 ALTER TABLE `exp_member_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_member_homepage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_member_homepage`;

CREATE TABLE `exp_member_homepage` (
  `member_id` int(10) unsigned NOT NULL,
  `recent_entries` char(1) NOT NULL DEFAULT 'l',
  `recent_entries_order` int(3) unsigned NOT NULL DEFAULT '0',
  `recent_comments` char(1) NOT NULL DEFAULT 'l',
  `recent_comments_order` int(3) unsigned NOT NULL DEFAULT '0',
  `recent_members` char(1) NOT NULL DEFAULT 'n',
  `recent_members_order` int(3) unsigned NOT NULL DEFAULT '0',
  `site_statistics` char(1) NOT NULL DEFAULT 'r',
  `site_statistics_order` int(3) unsigned NOT NULL DEFAULT '0',
  `member_search_form` char(1) NOT NULL DEFAULT 'n',
  `member_search_form_order` int(3) unsigned NOT NULL DEFAULT '0',
  `notepad` char(1) NOT NULL DEFAULT 'r',
  `notepad_order` int(3) unsigned NOT NULL DEFAULT '0',
  `bulletin_board` char(1) NOT NULL DEFAULT 'r',
  `bulletin_board_order` int(3) unsigned NOT NULL DEFAULT '0',
  `pmachine_news_feed` char(1) NOT NULL DEFAULT 'n',
  `pmachine_news_feed_order` int(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_member_homepage` WRITE;
/*!40000 ALTER TABLE `exp_member_homepage` DISABLE KEYS */;

INSERT INTO `exp_member_homepage` (`member_id`, `recent_entries`, `recent_entries_order`, `recent_comments`, `recent_comments_order`, `recent_members`, `recent_members_order`, `site_statistics`, `site_statistics_order`, `member_search_form`, `member_search_form_order`, `notepad`, `notepad_order`, `bulletin_board`, `bulletin_board_order`, `pmachine_news_feed`, `pmachine_news_feed_order`)
VALUES
	(1,'l',1,'l',2,'n',0,'r',1,'n',0,'r',2,'r',0,'l',0);

/*!40000 ALTER TABLE `exp_member_homepage` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_member_search
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_member_search`;

CREATE TABLE `exp_member_search` (
  `search_id` varchar(32) NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `search_date` int(10) unsigned NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `fields` varchar(200) NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `total_results` int(8) unsigned NOT NULL,
  `query` text NOT NULL,
  PRIMARY KEY (`search_id`),
  KEY `member_id` (`member_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_members
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_members`;

CREATE TABLE `exp_members` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` smallint(4) NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL,
  `screen_name` varchar(50) NOT NULL,
  `password` varchar(128) NOT NULL,
  `salt` varchar(128) NOT NULL DEFAULT '',
  `unique_id` varchar(40) NOT NULL,
  `crypt_key` varchar(40) DEFAULT NULL,
  `authcode` varchar(10) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `url` varchar(150) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `occupation` varchar(80) DEFAULT NULL,
  `interests` varchar(120) DEFAULT NULL,
  `bday_d` int(2) DEFAULT NULL,
  `bday_m` int(2) DEFAULT NULL,
  `bday_y` int(4) DEFAULT NULL,
  `aol_im` varchar(50) DEFAULT NULL,
  `yahoo_im` varchar(50) DEFAULT NULL,
  `msn_im` varchar(50) DEFAULT NULL,
  `icq` varchar(50) DEFAULT NULL,
  `bio` text,
  `signature` text,
  `avatar_filename` varchar(120) DEFAULT NULL,
  `avatar_width` int(4) unsigned DEFAULT NULL,
  `avatar_height` int(4) unsigned DEFAULT NULL,
  `photo_filename` varchar(120) DEFAULT NULL,
  `photo_width` int(4) unsigned DEFAULT NULL,
  `photo_height` int(4) unsigned DEFAULT NULL,
  `sig_img_filename` varchar(120) DEFAULT NULL,
  `sig_img_width` int(4) unsigned DEFAULT NULL,
  `sig_img_height` int(4) unsigned DEFAULT NULL,
  `ignore_list` text,
  `private_messages` int(4) unsigned NOT NULL DEFAULT '0',
  `accept_messages` char(1) NOT NULL DEFAULT 'y',
  `last_view_bulletins` int(10) NOT NULL DEFAULT '0',
  `last_bulletin_date` int(10) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `join_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_visit` int(10) unsigned NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `total_entries` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `total_comments` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `total_forum_topics` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_posts` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_forum_post_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_email_date` int(10) unsigned NOT NULL DEFAULT '0',
  `in_authorlist` char(1) NOT NULL DEFAULT 'n',
  `accept_admin_email` char(1) NOT NULL DEFAULT 'y',
  `accept_user_email` char(1) NOT NULL DEFAULT 'y',
  `notify_by_default` char(1) NOT NULL DEFAULT 'y',
  `notify_of_pm` char(1) NOT NULL DEFAULT 'y',
  `display_avatars` char(1) NOT NULL DEFAULT 'y',
  `display_signatures` char(1) NOT NULL DEFAULT 'y',
  `parse_smileys` char(1) NOT NULL DEFAULT 'y',
  `smart_notifications` char(1) NOT NULL DEFAULT 'y',
  `language` varchar(50) NOT NULL,
  `timezone` varchar(50) NOT NULL,
  `time_format` char(2) NOT NULL DEFAULT '12',
  `date_format` varchar(8) NOT NULL DEFAULT '%n/%j/%y',
  `include_seconds` char(1) NOT NULL DEFAULT 'n',
  `cp_theme` varchar(32) DEFAULT NULL,
  `profile_theme` varchar(32) DEFAULT NULL,
  `forum_theme` varchar(32) DEFAULT NULL,
  `tracker` text,
  `template_size` varchar(2) NOT NULL DEFAULT '28',
  `notepad` text,
  `notepad_size` varchar(2) NOT NULL DEFAULT '18',
  `quick_links` text,
  `quick_tabs` text,
  `show_sidebar` char(1) NOT NULL DEFAULT 'n',
  `pmember_id` int(10) NOT NULL DEFAULT '0',
  `rte_enabled` char(1) NOT NULL DEFAULT 'y',
  `rte_toolset_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`member_id`),
  KEY `group_id` (`group_id`),
  KEY `unique_id` (`unique_id`),
  KEY `password` (`password`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_members` WRITE;
/*!40000 ALTER TABLE `exp_members` DISABLE KEYS */;

INSERT INTO `exp_members` (`member_id`, `group_id`, `username`, `screen_name`, `password`, `salt`, `unique_id`, `crypt_key`, `authcode`, `email`, `url`, `location`, `occupation`, `interests`, `bday_d`, `bday_m`, `bday_y`, `aol_im`, `yahoo_im`, `msn_im`, `icq`, `bio`, `signature`, `avatar_filename`, `avatar_width`, `avatar_height`, `photo_filename`, `photo_width`, `photo_height`, `sig_img_filename`, `sig_img_width`, `sig_img_height`, `ignore_list`, `private_messages`, `accept_messages`, `last_view_bulletins`, `last_bulletin_date`, `ip_address`, `join_date`, `last_visit`, `last_activity`, `total_entries`, `total_comments`, `total_forum_topics`, `total_forum_posts`, `last_entry_date`, `last_comment_date`, `last_forum_post_date`, `last_email_date`, `in_authorlist`, `accept_admin_email`, `accept_user_email`, `notify_by_default`, `notify_of_pm`, `display_avatars`, `display_signatures`, `parse_smileys`, `smart_notifications`, `language`, `timezone`, `time_format`, `date_format`, `include_seconds`, `cp_theme`, `profile_theme`, `forum_theme`, `tracker`, `template_size`, `notepad`, `notepad_size`, `quick_links`, `quick_tabs`, `show_sidebar`, `pmember_id`, `rte_enabled`, `rte_toolset_id`)
VALUES
	(1,1,'leevigraham','leevigraham','39bad71983313f51ceb28ab4cbea959fc621041cb9f14b317d627ef4eda51002cda0d28e7e9c37ce993487d0e52b076e2f0e340eeea54279e4b1f59cf598318c','W`}2N}6@TG;JbR8HSkebZ?sm=w\"cF+^x%-8Fz:fA)m8w8j+AWfzwH~F4Tjsf[(LtZ)G#*Nnq+[v&emXdt]H7:6dGt~F<~mNX;fdD$\"-fG\"+#P2#\'COk?yW2CFrEmSmd<','65cc5165e20e21b63e5c2588a2859b57da5be43a','23b191c91f412205e5c8b6eaf2da1f4c33a6d26f',NULL,'leevi@newism.com.au',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'y',0,0,'127.0.0.1',1425471974,1425549039,1425872751,0,0,0,0,0,0,0,0,'n','y','y','y','y','y','y','y','y','english','Australia/Sydney','12','%n/%j/%y','n',NULL,NULL,NULL,NULL,'28',NULL,'18','',NULL,'n',0,'y',0);

/*!40000 ALTER TABLE `exp_members` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_message_attachments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_message_attachments`;

CREATE TABLE `exp_message_attachments` (
  `attachment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_name` varchar(50) NOT NULL DEFAULT '',
  `attachment_hash` varchar(40) NOT NULL DEFAULT '',
  `attachment_extension` varchar(20) NOT NULL DEFAULT '',
  `attachment_location` varchar(150) NOT NULL DEFAULT '',
  `attachment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_size` int(10) unsigned NOT NULL DEFAULT '0',
  `is_temp` char(1) NOT NULL DEFAULT 'y',
  PRIMARY KEY (`attachment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_message_copies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_message_copies`;

CREATE TABLE `exp_message_copies` (
  `copy_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `recipient_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_received` char(1) NOT NULL DEFAULT 'n',
  `message_read` char(1) NOT NULL DEFAULT 'n',
  `message_time_read` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_downloaded` char(1) NOT NULL DEFAULT 'n',
  `message_folder` int(10) unsigned NOT NULL DEFAULT '1',
  `message_authcode` varchar(10) NOT NULL DEFAULT '',
  `message_deleted` char(1) NOT NULL DEFAULT 'n',
  `message_status` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`copy_id`),
  KEY `message_id` (`message_id`),
  KEY `recipient_id` (`recipient_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_message_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_message_data`;

CREATE TABLE `exp_message_data` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_date` int(10) unsigned NOT NULL DEFAULT '0',
  `message_subject` varchar(255) NOT NULL DEFAULT '',
  `message_body` text NOT NULL,
  `message_tracking` char(1) NOT NULL DEFAULT 'y',
  `message_attachments` char(1) NOT NULL DEFAULT 'n',
  `message_recipients` varchar(200) NOT NULL DEFAULT '',
  `message_cc` varchar(200) NOT NULL DEFAULT '',
  `message_hide_cc` char(1) NOT NULL DEFAULT 'n',
  `message_sent_copy` char(1) NOT NULL DEFAULT 'n',
  `total_recipients` int(5) unsigned NOT NULL DEFAULT '0',
  `message_status` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`message_id`),
  KEY `sender_id` (`sender_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_message_folders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_message_folders`;

CREATE TABLE `exp_message_folders` (
  `member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `folder1_name` varchar(50) NOT NULL DEFAULT 'InBox',
  `folder2_name` varchar(50) NOT NULL DEFAULT 'Sent',
  `folder3_name` varchar(50) NOT NULL DEFAULT '',
  `folder4_name` varchar(50) NOT NULL DEFAULT '',
  `folder5_name` varchar(50) NOT NULL DEFAULT '',
  `folder6_name` varchar(50) NOT NULL DEFAULT '',
  `folder7_name` varchar(50) NOT NULL DEFAULT '',
  `folder8_name` varchar(50) NOT NULL DEFAULT '',
  `folder9_name` varchar(50) NOT NULL DEFAULT '',
  `folder10_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_message_listed
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_message_listed`;

CREATE TABLE `exp_message_listed` (
  `listed_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `listed_member` int(10) unsigned NOT NULL DEFAULT '0',
  `listed_description` varchar(100) NOT NULL DEFAULT '',
  `listed_type` varchar(10) NOT NULL DEFAULT 'blocked',
  PRIMARY KEY (`listed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_module_member_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_module_member_groups`;

CREATE TABLE `exp_module_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `module_id` mediumint(5) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_modules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_modules`;

CREATE TABLE `exp_modules` (
  `module_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) NOT NULL,
  `module_version` varchar(12) NOT NULL,
  `has_cp_backend` char(1) NOT NULL DEFAULT 'n',
  `has_publish_fields` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_modules` WRITE;
/*!40000 ALTER TABLE `exp_modules` DISABLE KEYS */;

INSERT INTO `exp_modules` (`module_id`, `module_name`, `module_version`, `has_cp_backend`, `has_publish_fields`)
VALUES
	(1,'Channel','2.0.1','n','n'),
	(2,'Member','2.1','n','n'),
	(3,'Stats','2.0','n','n'),
	(4,'Rte','1.0.1','y','n'),
	(5,'Wygwam','3.3.3','y','n'),
	(6,'Assets','2.5','y','n'),
	(7,'Store','2.5.0','y','n');

/*!40000 ALTER TABLE `exp_modules` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_online_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_online_users`;

CREATE TABLE `exp_online_users` (
  `online_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `in_forum` char(1) NOT NULL DEFAULT 'n',
  `name` varchar(50) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  `anon` char(1) NOT NULL,
  PRIMARY KEY (`online_id`),
  KEY `date` (`date`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_online_users` WRITE;
/*!40000 ALTER TABLE `exp_online_users` DISABLE KEYS */;

INSERT INTO `exp_online_users` (`online_id`, `site_id`, `member_id`, `in_forum`, `name`, `ip_address`, `date`, `anon`)
VALUES
	(1,1,1,'n','leevigraham','127.0.0.1',1425476469,'');

/*!40000 ALTER TABLE `exp_online_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_password_lockout
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_password_lockout`;

CREATE TABLE `exp_password_lockout` (
  `lockout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login_date` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `username` varchar(50) NOT NULL,
  PRIMARY KEY (`lockout_id`),
  KEY `login_date` (`login_date`),
  KEY `ip_address` (`ip_address`),
  KEY `user_agent` (`user_agent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_relationships
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_relationships`;

CREATE TABLE `exp_relationships` (
  `relationship_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `child_id` int(10) unsigned NOT NULL DEFAULT '0',
  `field_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grid_field_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grid_col_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grid_row_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`relationship_id`),
  KEY `parent_id` (`parent_id`),
  KEY `child_id` (`child_id`),
  KEY `field_id` (`field_id`),
  KEY `grid_row_id` (`grid_row_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_remember_me
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_remember_me`;

CREATE TABLE `exp_remember_me` (
  `remember_me_id` varchar(40) NOT NULL DEFAULT '0',
  `member_id` int(10) DEFAULT '0',
  `ip_address` varchar(45) DEFAULT '0',
  `user_agent` varchar(120) DEFAULT '',
  `admin_sess` tinyint(1) DEFAULT '0',
  `site_id` int(4) DEFAULT '1',
  `expiration` int(10) DEFAULT '0',
  `last_refresh` int(10) DEFAULT '0',
  PRIMARY KEY (`remember_me_id`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_reset_password
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_reset_password`;

CREATE TABLE `exp_reset_password` (
  `reset_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `resetcode` varchar(12) NOT NULL,
  `date` int(10) NOT NULL,
  PRIMARY KEY (`reset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_revision_tracker
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_revision_tracker`;

CREATE TABLE `exp_revision_tracker` (
  `tracker_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `item_table` varchar(20) NOT NULL,
  `item_field` varchar(20) NOT NULL,
  `item_date` int(10) NOT NULL,
  `item_author_id` int(10) unsigned NOT NULL,
  `item_data` mediumtext NOT NULL,
  PRIMARY KEY (`tracker_id`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_revision_tracker` WRITE;
/*!40000 ALTER TABLE `exp_revision_tracker` DISABLE KEYS */;

INSERT INTO `exp_revision_tracker` (`tracker_id`, `item_id`, `item_table`, `item_field`, `item_date`, `item_author_id`, `item_data`)
VALUES
	(1,2,'exp_templates','template_data',1425476284,1,''),
	(2,4,'exp_templates','template_data',1425501903,1,''),
	(3,5,'exp_templates','template_data',1425501926,1,''),
	(4,6,'exp_templates','template_data',1425501966,1,''),
	(5,7,'exp_templates','template_data',1425503781,1,''),
	(6,9,'exp_templates','template_data',1425517013,1,''),
	(7,1,'exp_templates','template_data',1425867154,1,''),
	(8,2,'exp_templates','template_data',1425867154,1,'');

/*!40000 ALTER TABLE `exp_revision_tracker` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_rte_tools
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_rte_tools`;

CREATE TABLE `exp_rte_tools` (
  `tool_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(75) DEFAULT NULL,
  `class` varchar(75) DEFAULT NULL,
  `enabled` char(1) DEFAULT 'y',
  PRIMARY KEY (`tool_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exp_rte_tools` WRITE;
/*!40000 ALTER TABLE `exp_rte_tools` DISABLE KEYS */;

INSERT INTO `exp_rte_tools` (`tool_id`, `name`, `class`, `enabled`)
VALUES
	(1,'Blockquote','Blockquote_rte','y'),
	(2,'Bold','Bold_rte','y'),
	(3,'Headings','Headings_rte','y'),
	(4,'Image','Image_rte','y'),
	(5,'Italic','Italic_rte','y'),
	(6,'Link','Link_rte','y'),
	(7,'Ordered List','Ordered_list_rte','y'),
	(8,'Underline','Underline_rte','y'),
	(9,'Unordered List','Unordered_list_rte','y'),
	(10,'View Source','View_source_rte','y');

/*!40000 ALTER TABLE `exp_rte_tools` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_rte_toolsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_rte_toolsets`;

CREATE TABLE `exp_rte_toolsets` (
  `toolset_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `tools` text,
  `enabled` char(1) DEFAULT 'y',
  PRIMARY KEY (`toolset_id`),
  KEY `member_id` (`member_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exp_rte_toolsets` WRITE;
/*!40000 ALTER TABLE `exp_rte_toolsets` DISABLE KEYS */;

INSERT INTO `exp_rte_toolsets` (`toolset_id`, `member_id`, `name`, `tools`, `enabled`)
VALUES
	(1,0,'Default','3|2|5|1|9|7|6|4|10','y');

/*!40000 ALTER TABLE `exp_rte_toolsets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_security_hashes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_security_hashes`;

CREATE TABLE `exp_security_hashes` (
  `hash_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(10) unsigned NOT NULL,
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `hash` varchar(40) NOT NULL,
  PRIMARY KEY (`hash_id`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_security_hashes` WRITE;
/*!40000 ALTER TABLE `exp_security_hashes` DISABLE KEYS */;

INSERT INTO `exp_security_hashes` (`hash_id`, `date`, `session_id`, `hash`)
VALUES
	(1,1425471999,'b64eef4dc4bcd0d05928979c29d65c571433b577','d4406f93f404aa08ee3cea8b5c1f3cc5e42daf0b'),
	(2,1425476168,'916fa0446232c880c4edfcf1528bdf55a5d759d5','2cfb44f5bd483b500bda68e61b3e5c2587bdb434'),
	(3,1425478467,'b1676b5d8aa2c66d3620c86d188c470b0e60d810','846eed0da5c38de38e4739e089db9421b1af2909'),
	(4,1425501987,'154c8c94d1dc5a6154de0d29c81631cb3eb37278','14fd0980bc9448a53e48fefab9f8d44aa9811934'),
	(5,1425516596,'207b12fd218d08ccc89a4760369dcd8a21dbff3f','586fc1bf372a39aba8cec2bf7a72cc411ecff072'),
	(6,1425519062,'9e0b67827e684caa495490e970bc40ca948f294d','dbf8dbcd4ac76f063d973ec1c4f187e1b96c6a5b'),
	(7,1425549039,'5125d7bbf63fe7ae715134306609726d428eefec','74e44d1c13fe9be5c41f1fc6a7ad637a5be25f3f'),
	(8,1425865507,'1740036a7c91f8416a97faa2221f407613cf352e','23c6bf8533e7c2128aba8bf377fb50c78f636c9b'),
	(9,1425869985,'c9e69db9f589ceb334f14028ac65cd0d5886e80c','cce8f39cc904ef382aa43222a156f78ce2ac54cf');

/*!40000 ALTER TABLE `exp_security_hashes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_sessions`;

CREATE TABLE `exp_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `admin_sess` tinyint(1) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `fingerprint` varchar(40) NOT NULL,
  `sess_start` int(10) unsigned NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`session_id`),
  KEY `member_id` (`member_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_sessions` WRITE;
/*!40000 ALTER TABLE `exp_sessions` DISABLE KEYS */;

INSERT INTO `exp_sessions` (`session_id`, `member_id`, `admin_sess`, `ip_address`, `user_agent`, `fingerprint`, `sess_start`, `last_activity`)
VALUES
	('1740036a7c91f8416a97faa2221f407613cf352e',1,1,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36','b3d722e6bc158aeeb6091c440a61a8a8',1425869985,1425872751);

/*!40000 ALTER TABLE `exp_sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_sites`;

CREATE TABLE `exp_sites` (
  `site_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `site_label` varchar(100) NOT NULL DEFAULT '',
  `site_name` varchar(50) NOT NULL DEFAULT '',
  `site_description` text,
  `site_system_preferences` mediumtext NOT NULL,
  `site_mailinglist_preferences` text NOT NULL,
  `site_member_preferences` text NOT NULL,
  `site_template_preferences` text NOT NULL,
  `site_channel_preferences` text NOT NULL,
  `site_bootstrap_checksums` text NOT NULL,
  PRIMARY KEY (`site_id`),
  KEY `site_name` (`site_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_sites` WRITE;
/*!40000 ALTER TABLE `exp_sites` DISABLE KEYS */;

INSERT INTO `exp_sites` (`site_id`, `site_label`, `site_name`, `site_description`, `site_system_preferences`, `site_mailinglist_preferences`, `site_member_preferences`, `site_template_preferences`, `site_channel_preferences`, `site_bootstrap_checksums`)
VALUES
	(1,'local.circle','default_site',NULL,'YTo4ODp7czoxMDoic2l0ZV9pbmRleCI7czowOiIiO3M6ODoic2l0ZV91cmwiO3M6MjA6Imh0dHA6Ly9sb2NhbC5jaXJjbGUvIjtzOjE2OiJ0aGVtZV9mb2xkZXJfdXJsIjtzOjI3OiJodHRwOi8vbG9jYWwuY2lyY2xlL3RoZW1lcy8iO3M6MTU6IndlYm1hc3Rlcl9lbWFpbCI7czoxODoidGVhbUBuZXdpc20uY29tLmF1IjtzOjE0OiJ3ZWJtYXN0ZXJfbmFtZSI7czowOiIiO3M6MjA6ImNoYW5uZWxfbm9tZW5jbGF0dXJlIjtzOjc6ImNoYW5uZWwiO3M6MTA6Im1heF9jYWNoZXMiO3M6MzoiMTUwIjtzOjExOiJjYXB0Y2hhX3VybCI7czozNjoiaHR0cDovL2xvY2FsLmNpcmNsZS9pbWFnZXMvY2FwdGNoYXMvIjtzOjEyOiJjYXB0Y2hhX3BhdGgiO3M6MToiLyI7czoxMjoiY2FwdGNoYV9mb250IjtzOjE6InkiO3M6MTI6ImNhcHRjaGFfcmFuZCI7czoxOiJ5IjtzOjIzOiJjYXB0Y2hhX3JlcXVpcmVfbWVtYmVycyI7czoxOiJuIjtzOjE3OiJlbmFibGVfZGJfY2FjaGluZyI7czoxOiJuIjtzOjE4OiJlbmFibGVfc3FsX2NhY2hpbmciO3M6MToibiI7czoxODoiZm9yY2VfcXVlcnlfc3RyaW5nIjtzOjE6Im4iO3M6MTM6InNob3dfcHJvZmlsZXIiO3M6MToibiI7czoxODoidGVtcGxhdGVfZGVidWdnaW5nIjtzOjE6Im4iO3M6MTU6ImluY2x1ZGVfc2Vjb25kcyI7czoxOiJuIjtzOjEzOiJjb29raWVfZG9tYWluIjtzOjA6IiI7czoxMToiY29va2llX3BhdGgiO3M6MDoiIjtzOjIwOiJ3ZWJzaXRlX3Nlc3Npb25fdHlwZSI7czoxOiJjIjtzOjE1OiJjcF9zZXNzaW9uX3R5cGUiO3M6MjoiY3MiO3M6MjE6ImFsbG93X3VzZXJuYW1lX2NoYW5nZSI7czoxOiJ5IjtzOjE4OiJhbGxvd19tdWx0aV9sb2dpbnMiO3M6MToieSI7czoxNjoicGFzc3dvcmRfbG9ja291dCI7czoxOiJ5IjtzOjI1OiJwYXNzd29yZF9sb2Nrb3V0X2ludGVydmFsIjtzOjE6IjEiO3M6MjA6InJlcXVpcmVfaXBfZm9yX2xvZ2luIjtzOjE6InkiO3M6MjI6InJlcXVpcmVfaXBfZm9yX3Bvc3RpbmciO3M6MToieSI7czoyNDoicmVxdWlyZV9zZWN1cmVfcGFzc3dvcmRzIjtzOjE6Im4iO3M6MTk6ImFsbG93X2RpY3Rpb25hcnlfcHciO3M6MToieSI7czoyMzoibmFtZV9vZl9kaWN0aW9uYXJ5X2ZpbGUiO3M6MDoiIjtzOjE3OiJ4c3NfY2xlYW5fdXBsb2FkcyI7czoxOiJ5IjtzOjE1OiJyZWRpcmVjdF9tZXRob2QiO3M6ODoicmVkaXJlY3QiO3M6OToiZGVmdF9sYW5nIjtzOjc6ImVuZ2xpc2giO3M6ODoieG1sX2xhbmciO3M6MjoiZW4iO3M6MTI6InNlbmRfaGVhZGVycyI7czoxOiJ5IjtzOjExOiJnemlwX291dHB1dCI7czoxOiJuIjtzOjEzOiJsb2dfcmVmZXJyZXJzIjtzOjE6Im4iO3M6MTM6Im1heF9yZWZlcnJlcnMiO3M6MzoiNTAwIjtzOjExOiJkYXRlX2Zvcm1hdCI7czo4OiIlbi8lai8leSI7czoxMToidGltZV9mb3JtYXQiO3M6MjoiMTIiO3M6MTM6InNlcnZlcl9vZmZzZXQiO3M6MDoiIjtzOjIxOiJkZWZhdWx0X3NpdGVfdGltZXpvbmUiO3M6MTY6IkF1c3RyYWxpYS9TeWRuZXkiO3M6MTM6Im1haWxfcHJvdG9jb2wiO3M6NDoibWFpbCI7czoxMToic210cF9zZXJ2ZXIiO3M6MDoiIjtzOjEzOiJzbXRwX3VzZXJuYW1lIjtzOjA6IiI7czoxMzoic210cF9wYXNzd29yZCI7czowOiIiO3M6MTE6ImVtYWlsX2RlYnVnIjtzOjE6Im4iO3M6MTM6ImVtYWlsX2NoYXJzZXQiO3M6NToidXRmLTgiO3M6MTU6ImVtYWlsX2JhdGNobW9kZSI7czoxOiJuIjtzOjE2OiJlbWFpbF9iYXRjaF9zaXplIjtzOjA6IiI7czoxMToibWFpbF9mb3JtYXQiO3M6NToicGxhaW4iO3M6OToid29yZF93cmFwIjtzOjE6InkiO3M6MjI6ImVtYWlsX2NvbnNvbGVfdGltZWxvY2siO3M6MToiNSI7czoyMjoibG9nX2VtYWlsX2NvbnNvbGVfbXNncyI7czoxOiJ5IjtzOjg6ImNwX3RoZW1lIjtzOjc6ImRlZmF1bHQiO3M6MjE6ImVtYWlsX21vZHVsZV9jYXB0Y2hhcyI7czoxOiJuIjtzOjE2OiJsb2dfc2VhcmNoX3Rlcm1zIjtzOjE6InkiO3M6MTk6ImRlbnlfZHVwbGljYXRlX2RhdGEiO3M6MToieSI7czoyNDoicmVkaXJlY3Rfc3VibWl0dGVkX2xpbmtzIjtzOjE6Im4iO3M6MTY6ImVuYWJsZV9jZW5zb3JpbmciO3M6MToibiI7czoxNDoiY2Vuc29yZWRfd29yZHMiO3M6MDoiIjtzOjE4OiJjZW5zb3JfcmVwbGFjZW1lbnQiO3M6MDoiIjtzOjEwOiJiYW5uZWRfaXBzIjtzOjA6IiI7czoxMzoiYmFubmVkX2VtYWlscyI7czowOiIiO3M6MTY6ImJhbm5lZF91c2VybmFtZXMiO3M6MDoiIjtzOjE5OiJiYW5uZWRfc2NyZWVuX25hbWVzIjtzOjA6IiI7czoxMDoiYmFuX2FjdGlvbiI7czo4OiJyZXN0cmljdCI7czoxMToiYmFuX21lc3NhZ2UiO3M6MzQ6IlRoaXMgc2l0ZSBpcyBjdXJyZW50bHkgdW5hdmFpbGFibGUiO3M6MTU6ImJhbl9kZXN0aW5hdGlvbiI7czoyMToiaHR0cDovL3d3dy55YWhvby5jb20vIjtzOjE2OiJlbmFibGVfZW1vdGljb25zIjtzOjE6InkiO3M6MTI6ImVtb3RpY29uX3VybCI7czozNToiaHR0cDovL2xvY2FsLmNpcmNsZS9pbWFnZXMvc21pbGV5cy8iO3M6MTk6InJlY291bnRfYmF0Y2hfdG90YWwiO3M6NDoiMTAwMCI7czoxNzoibmV3X3ZlcnNpb25fY2hlY2siO3M6MToieSI7czoxNzoiZW5hYmxlX3Rocm90dGxpbmciO3M6MToibiI7czoxNzoiYmFuaXNoX21hc2tlZF9pcHMiO3M6MToieSI7czoxNDoibWF4X3BhZ2VfbG9hZHMiO3M6MjoiMTAiO3M6MTM6InRpbWVfaW50ZXJ2YWwiO3M6MToiOCI7czoxMjoibG9ja291dF90aW1lIjtzOjI6IjMwIjtzOjE1OiJiYW5pc2htZW50X3R5cGUiO3M6NzoibWVzc2FnZSI7czoxNDoiYmFuaXNobWVudF91cmwiO3M6MDoiIjtzOjE4OiJiYW5pc2htZW50X21lc3NhZ2UiO3M6NTA6IllvdSBoYXZlIGV4Y2VlZGVkIHRoZSBhbGxvd2VkIHBhZ2UgbG9hZCBmcmVxdWVuY3kuIjtzOjE3OiJlbmFibGVfc2VhcmNoX2xvZyI7czoxOiJ5IjtzOjE5OiJtYXhfbG9nZ2VkX3NlYXJjaGVzIjtzOjM6IjUwMCI7czoxNzoidGhlbWVfZm9sZGVyX3BhdGgiO3M6NDk6Ii9Wb2x1bWVzL1NpdGVzL1dvcmsvSW50ZXJuYWwvY2lyY2xlY2kvd2ViL3RoZW1lcy8iO3M6MTA6ImlzX3NpdGVfb24iO3M6MToieSI7czoxMToicnRlX2VuYWJsZWQiO3M6MToieSI7czoyMjoicnRlX2RlZmF1bHRfdG9vbHNldF9pZCI7czoxOiIxIjt9','YTozOntzOjE5OiJtYWlsaW5nbGlzdF9lbmFibGVkIjtzOjE6InkiO3M6MTg6Im1haWxpbmdsaXN0X25vdGlmeSI7czoxOiJuIjtzOjI1OiJtYWlsaW5nbGlzdF9ub3RpZnlfZW1haWxzIjtzOjA6IiI7fQ==','YTo0NDp7czoxMDoidW5fbWluX2xlbiI7czoxOiI0IjtzOjEwOiJwd19taW5fbGVuIjtzOjE6IjUiO3M6MjU6ImFsbG93X21lbWJlcl9yZWdpc3RyYXRpb24iO3M6MToibiI7czoyNToiYWxsb3dfbWVtYmVyX2xvY2FsaXphdGlvbiI7czoxOiJ5IjtzOjE4OiJyZXFfbWJyX2FjdGl2YXRpb24iO3M6NToiZW1haWwiO3M6MjM6Im5ld19tZW1iZXJfbm90aWZpY2F0aW9uIjtzOjE6Im4iO3M6MjM6Im1icl9ub3RpZmljYXRpb25fZW1haWxzIjtzOjA6IiI7czoyNDoicmVxdWlyZV90ZXJtc19vZl9zZXJ2aWNlIjtzOjE6InkiO3M6MjI6InVzZV9tZW1iZXJzaGlwX2NhcHRjaGEiO3M6MToibiI7czoyMDoiZGVmYXVsdF9tZW1iZXJfZ3JvdXAiO3M6MToiNSI7czoxNToicHJvZmlsZV90cmlnZ2VyIjtzOjY6Im1lbWJlciI7czoxMjoibWVtYmVyX3RoZW1lIjtzOjc6ImRlZmF1bHQiO3M6MTQ6ImVuYWJsZV9hdmF0YXJzIjtzOjE6InkiO3M6MjA6ImFsbG93X2F2YXRhcl91cGxvYWRzIjtzOjE6Im4iO3M6MTA6ImF2YXRhcl91cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbC5jaXJjbGUvaW1hZ2VzL2F2YXRhcnMvIjtzOjExOiJhdmF0YXJfcGF0aCI7czoxOiIvIjtzOjE2OiJhdmF0YXJfbWF4X3dpZHRoIjtzOjM6IjEwMCI7czoxNzoiYXZhdGFyX21heF9oZWlnaHQiO3M6MzoiMTAwIjtzOjEzOiJhdmF0YXJfbWF4X2tiIjtzOjI6IjUwIjtzOjEzOiJlbmFibGVfcGhvdG9zIjtzOjE6Im4iO3M6OToicGhvdG9fdXJsIjtzOjQxOiJodHRwOi8vbG9jYWwuY2lyY2xlL2ltYWdlcy9tZW1iZXJfcGhvdG9zLyI7czoxMDoicGhvdG9fcGF0aCI7czoxOiIvIjtzOjE1OiJwaG90b19tYXhfd2lkdGgiO3M6MzoiMTAwIjtzOjE2OiJwaG90b19tYXhfaGVpZ2h0IjtzOjM6IjEwMCI7czoxMjoicGhvdG9fbWF4X2tiIjtzOjI6IjUwIjtzOjE2OiJhbGxvd19zaWduYXR1cmVzIjtzOjE6InkiO3M6MTM6InNpZ19tYXhsZW5ndGgiO3M6MzoiNTAwIjtzOjIxOiJzaWdfYWxsb3dfaW1nX2hvdGxpbmsiO3M6MToibiI7czoyMDoic2lnX2FsbG93X2ltZ191cGxvYWQiO3M6MToibiI7czoxMToic2lnX2ltZ191cmwiO3M6NDk6Imh0dHA6Ly9sb2NhbC5jaXJjbGUvaW1hZ2VzL3NpZ25hdHVyZV9hdHRhY2htZW50cy8iO3M6MTI6InNpZ19pbWdfcGF0aCI7czoxOiIvIjtzOjE3OiJzaWdfaW1nX21heF93aWR0aCI7czozOiI0ODAiO3M6MTg6InNpZ19pbWdfbWF4X2hlaWdodCI7czoyOiI4MCI7czoxNDoic2lnX2ltZ19tYXhfa2IiO3M6MjoiMzAiO3M6MTk6InBydl9tc2dfdXBsb2FkX3BhdGgiO3M6MToiLyI7czoyMzoicHJ2X21zZ19tYXhfYXR0YWNobWVudHMiO3M6MToiMyI7czoyMjoicHJ2X21zZ19hdHRhY2hfbWF4c2l6ZSI7czozOiIyNTAiO3M6MjA6InBydl9tc2dfYXR0YWNoX3RvdGFsIjtzOjM6IjEwMCI7czoxOToicHJ2X21zZ19odG1sX2Zvcm1hdCI7czo0OiJzYWZlIjtzOjE4OiJwcnZfbXNnX2F1dG9fbGlua3MiO3M6MToieSI7czoxNzoicHJ2X21zZ19tYXhfY2hhcnMiO3M6NDoiNjAwMCI7czoxOToibWVtYmVybGlzdF9vcmRlcl9ieSI7czoxMToidG90YWxfcG9zdHMiO3M6MjE6Im1lbWJlcmxpc3Rfc29ydF9vcmRlciI7czo0OiJkZXNjIjtzOjIwOiJtZW1iZXJsaXN0X3Jvd19saW1pdCI7czoyOiIyMCI7fQ==','YTo3OntzOjIyOiJlbmFibGVfdGVtcGxhdGVfcm91dGVzIjtzOjE6Im4iO3M6MTE6InN0cmljdF91cmxzIjtzOjE6InkiO3M6ODoic2l0ZV80MDQiO3M6MTE6InNpdGUvZm91cjA0IjtzOjE5OiJzYXZlX3RtcGxfcmV2aXNpb25zIjtzOjE6InkiO3M6MTg6Im1heF90bXBsX3JldmlzaW9ucyI7czoyOiIzMCI7czoxNToic2F2ZV90bXBsX2ZpbGVzIjtzOjE6InkiO3M6MTg6InRtcGxfZmlsZV9iYXNlcGF0aCI7czo1MToiL1ZvbHVtZXMvU2l0ZXMvV29yay9JbnRlcm5hbC9jaXJjbGVjaS9hcHAvdmlld3Mvc3JjIjt9','YTo5OntzOjIxOiJpbWFnZV9yZXNpemVfcHJvdG9jb2wiO3M6MzoiZ2QyIjtzOjE4OiJpbWFnZV9saWJyYXJ5X3BhdGgiO3M6MDoiIjtzOjE2OiJ0aHVtYm5haWxfcHJlZml4IjtzOjU6InRodW1iIjtzOjE0OiJ3b3JkX3NlcGFyYXRvciI7czo0OiJkYXNoIjtzOjE3OiJ1c2VfY2F0ZWdvcnlfbmFtZSI7czoxOiJuIjtzOjIyOiJyZXNlcnZlZF9jYXRlZ29yeV93b3JkIjtzOjg6ImNhdGVnb3J5IjtzOjIzOiJhdXRvX2NvbnZlcnRfaGlnaF9hc2NpaSI7czoxOiJuIjtzOjIyOiJuZXdfcG9zdHNfY2xlYXJfY2FjaGVzIjtzOjE6InkiO3M6MjM6ImF1dG9fYXNzaWduX2NhdF9wYXJlbnRzIjtzOjE6InkiO30=','YToxOntzOjUxOiIvVm9sdW1lcy9TaXRlcy9Xb3JrL0ludGVybmFsL2NpcmNsZWNpL3dlYi9pbmRleC5waHAiO3M6MzI6ImVlZTg3YjlmYzU1NDU5MTMxNDkzNDYwZTg1NGQ4NzFlIjt9');

/*!40000 ALTER TABLE `exp_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_snippets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_snippets`;

CREATE TABLE `exp_snippets` (
  `snippet_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) NOT NULL,
  `snippet_name` varchar(75) NOT NULL,
  `snippet_contents` text,
  PRIMARY KEY (`snippet_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_specialty_templates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_specialty_templates`;

CREATE TABLE `exp_specialty_templates` (
  `template_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `enable_template` char(1) NOT NULL DEFAULT 'y',
  `template_name` varchar(50) NOT NULL,
  `data_title` varchar(80) NOT NULL,
  `template_data` text NOT NULL,
  PRIMARY KEY (`template_id`),
  KEY `template_name` (`template_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_specialty_templates` WRITE;
/*!40000 ALTER TABLE `exp_specialty_templates` DISABLE KEYS */;

INSERT INTO `exp_specialty_templates` (`template_id`, `site_id`, `enable_template`, `template_name`, `data_title`, `template_data`)
VALUES
	(1,1,'y','offline_template','','<html>\n<head>\n\n<title>System Offline</title>\n\n<style type=\"text/css\">\n\nbody {\nbackground-color:	#ffffff;\nmargin:				50px;\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size:			11px;\ncolor:				#000;\nbackground-color:	#fff;\n}\n\na {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nletter-spacing:		.09em;\ntext-decoration:	none;\ncolor:			  #330099;\nbackground-color:	transparent;\n}\n\na:visited {\ncolor:				#330099;\nbackground-color:	transparent;\n}\n\na:hover {\ncolor:				#000;\ntext-decoration:	underline;\nbackground-color:	transparent;\n}\n\n#content  {\nborder:				#999999 1px solid;\npadding:			22px 25px 14px 25px;\n}\n\nh1 {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nfont-size:			14px;\ncolor:				#000;\nmargin-top: 		0;\nmargin-bottom:		14px;\n}\n\np {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		12px;\nmargin-bottom: 		14px;\ncolor: 				#000;\n}\n</style>\n\n</head>\n\n<body>\n\n<div id=\"content\">\n\n<h1>System Offline</h1>\n\n<p>This site is currently offline</p>\n\n</div>\n\n</body>\n\n</html>'),
	(2,1,'y','message_template','','<html>\n<head>\n\n<title>{title}</title>\n\n<meta http-equiv=\'content-type\' content=\'text/html; charset={charset}\' />\n\n{meta_refresh}\n\n<style type=\"text/css\">\n\nbody {\nbackground-color:	#ffffff;\nmargin:				50px;\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size:			11px;\ncolor:				#000;\nbackground-color:	#fff;\n}\n\na {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nletter-spacing:		.09em;\ntext-decoration:	none;\ncolor:			  #330099;\nbackground-color:	transparent;\n}\n\na:visited {\ncolor:				#330099;\nbackground-color:	transparent;\n}\n\na:active {\ncolor:				#ccc;\nbackground-color:	transparent;\n}\n\na:hover {\ncolor:				#000;\ntext-decoration:	underline;\nbackground-color:	transparent;\n}\n\n#content  {\nborder:				#000 1px solid;\nbackground-color: 	#DEDFE3;\npadding:			22px 25px 14px 25px;\n}\n\nh1 {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nfont-size:			14px;\ncolor:				#000;\nmargin-top: 		0;\nmargin-bottom:		14px;\n}\n\np {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		12px;\nmargin-bottom: 		14px;\ncolor: 				#000;\n}\n\nul {\nmargin-bottom: 		16px;\n}\n\nli {\nlist-style:			square;\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		8px;\nmargin-bottom: 		8px;\ncolor: 				#000;\n}\n\n</style>\n\n</head>\n\n<body>\n\n<div id=\"content\">\n\n<h1>{heading}</h1>\n\n{content}\n\n<p>{link}</p>\n\n</div>\n\n</body>\n\n</html>'),
	(3,1,'y','admin_notify_reg','Notification of new member registration','New member registration site: {site_name}\n\nScreen name: {name}\nUser name: {username}\nEmail: {email}\n\nYour control panel URL: {control_panel_url}'),
	(4,1,'y','admin_notify_entry','A new channel entry has been posted','A new entry has been posted in the following channel:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nPosted by: {name}\nEmail: {email}\n\nTo read the entry please visit:\n{entry_url}\n'),
	(5,1,'y','admin_notify_mailinglist','Someone has subscribed to your mailing list','A new mailing list subscription has been accepted.\n\nEmail Address: {email}\nMailing List: {mailing_list}'),
	(6,1,'y','admin_notify_comment','You have just received a comment','You have just received a comment for the following channel:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nLocated at:\n{comment_url}\n\nPosted by: {name}\nEmail: {email}\nURL: {url}\nLocation: {location}\n\n{comment}'),
	(7,1,'y','mbr_activation_instructions','Enclosed is your activation code','Thank you for your new member registration.\n\nTo activate your new account, please visit the following URL:\n\n{unwrap}{activation_url}{/unwrap}\n\nThank You!\n\n{site_name}\n\n{site_url}'),
	(8,1,'y','forgot_password_instructions','Login information','{name},\n\nTo reset your password, please go to the following page:\n\n{reset_url}\n\nThen log in with your username: {username}\n\nIf you do not wish to reset your password, ignore this message. It will expire in 24 hours.\n\n{site_name}\n{site_url}'),
	(9,1,'y','validated_member_notify','Your membership account has been activated','{name},\n\nYour membership account has been activated and is ready for use.\n\nThank You!\n\n{site_name}\n{site_url}'),
	(10,1,'y','decline_member_validation','Your membership account has been declined','{name},\n\nWe\'re sorry but our staff has decided not to validate your membership.\n\n{site_name}\n{site_url}'),
	(11,1,'y','mailinglist_activation_instructions','Email Confirmation','Thank you for joining the \"{mailing_list}\" mailing list!\n\nPlease click the link below to confirm your email.\n\nIf you do not want to be added to our list, ignore this email.\n\n{unwrap}{activation_url}{/unwrap}\n\nThank You!\n\n{site_name}'),
	(12,1,'y','comment_notification','Someone just responded to your comment','{name_of_commenter} just responded to the entry you subscribed to at:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nYou can see the comment at the following URL:\n{comment_url}\n\n{comment}\n\nTo stop receiving notifications for this comment, click here:\n{notification_removal_url}'),
	(13,1,'y','comments_opened_notification','New comments have been added','Responses have been added to the entry you subscribed to at:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nYou can see the comments at the following URL:\n{comment_url}\n\n{comments}\n{comment}\n{/comments}\n\nTo stop receiving notifications for this entry, click here:\n{notification_removal_url}'),
	(14,1,'y','private_message_notification','Someone has sent you a Private Message','\n{recipient_name},\n\n{sender_name} has just sent you a Private Message titled ‘{message_subject}’.\n\nYou can see the Private Message by logging in and viewing your inbox at:\n{site_url}\n\nContent:\n\n{message_content}\n\nTo stop receiving notifications of Private Messages, turn the option off in your Email Settings.\n\n{site_name}\n{site_url}'),
	(15,1,'y','pm_inbox_full','Your private message mailbox is full','{recipient_name},\n\n{sender_name} has just attempted to send you a Private Message,\nbut your inbox is full, exceeding the maximum of {pm_storage_limit}.\n\nPlease log in and remove unwanted messages from your inbox at:\n{site_url}');

/*!40000 ALTER TABLE `exp_specialty_templates` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_stats
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_stats`;

CREATE TABLE `exp_stats` (
  `stat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `total_members` mediumint(7) NOT NULL DEFAULT '0',
  `recent_member_id` int(10) NOT NULL DEFAULT '0',
  `recent_member` varchar(50) NOT NULL,
  `total_entries` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_topics` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_posts` mediumint(8) NOT NULL DEFAULT '0',
  `total_comments` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_forum_post_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_visitor_date` int(10) unsigned NOT NULL DEFAULT '0',
  `most_visitors` mediumint(7) NOT NULL DEFAULT '0',
  `most_visitor_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_cache_clear` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`stat_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_stats` WRITE;
/*!40000 ALTER TABLE `exp_stats` DISABLE KEYS */;

INSERT INTO `exp_stats` (`stat_id`, `site_id`, `total_members`, `recent_member_id`, `recent_member`, `total_entries`, `total_forum_topics`, `total_forum_posts`, `total_comments`, `last_entry_date`, `last_forum_post_date`, `last_comment_date`, `last_visitor_date`, `most_visitors`, `most_visitor_date`, `last_cache_clear`)
VALUES
	(1,1,1,1,'leevigraham',0,0,0,0,0,0,0,1425476469,1,1425474746,1426079546);

/*!40000 ALTER TABLE `exp_stats` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_status_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_status_groups`;

CREATE TABLE `exp_status_groups` (
  `group_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_status_groups` WRITE;
/*!40000 ALTER TABLE `exp_status_groups` DISABLE KEYS */;

INSERT INTO `exp_status_groups` (`group_id`, `site_id`, `group_name`)
VALUES
	(1,1,'Statuses');

/*!40000 ALTER TABLE `exp_status_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_status_no_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_status_no_access`;

CREATE TABLE `exp_status_no_access` (
  `status_id` int(6) unsigned NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`status_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_statuses`;

CREATE TABLE `exp_statuses` (
  `status_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `status` varchar(50) NOT NULL,
  `status_order` int(3) unsigned NOT NULL,
  `highlight` varchar(30) NOT NULL,
  PRIMARY KEY (`status_id`),
  KEY `group_id` (`group_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_statuses` WRITE;
/*!40000 ALTER TABLE `exp_statuses` DISABLE KEYS */;

INSERT INTO `exp_statuses` (`status_id`, `site_id`, `group_id`, `status`, `status_order`, `highlight`)
VALUES
	(1,1,1,'open',1,'009933'),
	(2,1,1,'closed',2,'990000');

/*!40000 ALTER TABLE `exp_statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_store_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_config`;

CREATE TABLE `exp_store_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `preference` varchar(255) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exp_store_config` WRITE;
/*!40000 ALTER TABLE `exp_store_config` DISABLE KEYS */;

INSERT INTO `exp_store_config` (`id`, `site_id`, `preference`, `value`)
VALUES
	(1,1,'store_cart_expiry','1440'),
	(2,1,'store_cc_payment_method','\"purchase\"'),
	(3,1,'store_conversion_tracking_extra','\"\"'),
	(4,1,'store_currency_code','\"USD\"'),
	(5,1,'store_currency_dec_point','\".\"'),
	(6,1,'store_currency_decimals','2'),
	(7,1,'store_currency_suffix','\"\"'),
	(8,1,'store_currency_symbol','\"$\"'),
	(9,1,'store_currency_thousands_sep','\",\"'),
	(10,1,'store_default_country','\"\"'),
	(11,1,'store_default_order_address','\"none\"'),
	(12,1,'store_default_shipping_method_id','\"\"'),
	(13,1,'store_default_state','\"\"'),
	(14,1,'store_dimension_units','\"mm\"'),
	(15,1,'store_unofficial_payment_gateways','\"0\"'),
	(16,1,'store_force_member_login','\"0\"'),
	(17,1,'store_from_email','\"\"'),
	(18,1,'store_from_name','\"\"'),
	(19,1,'store_google_analytics_ecommerce','\"1\"'),
	(20,1,'store_order_fields','\"\"'),
	(21,1,'store_order_id_start','\"1\"'),
	(22,1,'store_order_invoice_url','\"\"'),
	(23,1,'store_secure_template_tags','\"0\"'),
	(24,1,'store_security','\"\"'),
	(25,1,'store_reporting_timezone','null'),
	(26,1,'store_weight_units','\"g\"'),
	(27,1,'store_site_enabled','false');

/*!40000 ALTER TABLE `exp_store_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_store_countries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_countries`;

CREATE TABLE `exp_store_countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `code` char(2) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exp_store_countries` WRITE;
/*!40000 ALTER TABLE `exp_store_countries` DISABLE KEYS */;

INSERT INTO `exp_store_countries` (`id`, `site_id`, `code`, `name`, `enabled`)
VALUES
	(1,1,'AD','Andorra',1),
	(2,1,'AE','United Arab Emirates',1),
	(3,1,'AF','Afghanistan',1),
	(4,1,'AG','Antigua and Barbuda',1),
	(5,1,'AI','Anguilla',1),
	(6,1,'AL','Albania',1),
	(7,1,'AM','Armenia',1),
	(8,1,'AO','Angola',1),
	(9,1,'AQ','Antarctica',1),
	(10,1,'AR','Argentina',1),
	(11,1,'AS','American Samoa',1),
	(12,1,'AT','Austria',1),
	(13,1,'AU','Australia',1),
	(14,1,'AW','Aruba',1),
	(15,1,'AX','Aland Islands',1),
	(16,1,'AZ','Azerbaijan',1),
	(17,1,'BA','Bosnia and Herzegovina',1),
	(18,1,'BB','Barbados',1),
	(19,1,'BD','Bangladesh',1),
	(20,1,'BE','Belgium',1),
	(21,1,'BF','Burkina Faso',1),
	(22,1,'BG','Bulgaria',1),
	(23,1,'BH','Bahrain',1),
	(24,1,'BI','Burundi',1),
	(25,1,'BJ','Benin',1),
	(26,1,'BL','Saint Barthelemy',1),
	(27,1,'BM','Bermuda',1),
	(28,1,'BN','Brunei Darussalam',1),
	(29,1,'BO','Bolivia',1),
	(30,1,'BQ','Bonaire, Sint Eustatius and Saba',1),
	(31,1,'BR','Brazil',1),
	(32,1,'BS','Bahamas',1),
	(33,1,'BT','Bhutan',1),
	(34,1,'BV','Bouvet Island',1),
	(35,1,'BW','Botswana',1),
	(36,1,'BY','Belarus',1),
	(37,1,'BZ','Belize',1),
	(38,1,'CA','Canada',1),
	(39,1,'CC','Cocos (Keeling) Islands',1),
	(40,1,'CD','Democratic Republic of Congo',1),
	(41,1,'CF','Central African Republic',1),
	(42,1,'CG','Congo',1),
	(43,1,'CH','Switzerland',1),
	(44,1,'CI','Ivory Coast',1),
	(45,1,'CK','Cook Islands',1),
	(46,1,'CL','Chile',1),
	(47,1,'CM','Cameroon',1),
	(48,1,'CN','China',1),
	(49,1,'CO','Colombia',1),
	(50,1,'CR','Costa Rica',1),
	(51,1,'CU','Cuba',1),
	(52,1,'CV','Cape Verde',1),
	(53,1,'CW','Curacao',1),
	(54,1,'CX','Christmas Island',1),
	(55,1,'CY','Cyprus',1),
	(56,1,'CZ','Czech Republic',1),
	(57,1,'DE','Germany',1),
	(58,1,'DJ','Djibouti',1),
	(59,1,'DK','Denmark',1),
	(60,1,'DM','Dominica',1),
	(61,1,'DO','Dominican Republic',1),
	(62,1,'DZ','Algeria',1),
	(63,1,'EC','Ecuador',1),
	(64,1,'EE','Estonia',1),
	(65,1,'EG','Egypt',1),
	(66,1,'EH','Western Sahara',1),
	(67,1,'ER','Eritrea',1),
	(68,1,'ES','Spain',1),
	(69,1,'ET','Ethiopia',1),
	(70,1,'FI','Finland',1),
	(71,1,'FJ','Fiji',1),
	(72,1,'FK','Falkland Islands (Malvinas)',1),
	(73,1,'FM','Micronesia',1),
	(74,1,'FO','Faroe Islands',1),
	(75,1,'FR','France',1),
	(76,1,'GA','Gabon',1),
	(77,1,'GB','United Kingdom',1),
	(78,1,'GD','Grenada',1),
	(79,1,'GE','Georgia',1),
	(80,1,'GF','French Guiana',1),
	(81,1,'GG','Guernsey',1),
	(82,1,'GH','Ghana',1),
	(83,1,'GI','Gibraltar',1),
	(84,1,'GL','Greenland',1),
	(85,1,'GM','Gambia',1),
	(86,1,'GN','Guinea',1),
	(87,1,'GP','Guadeloupe',1),
	(88,1,'GQ','Equatorial Guinea',1),
	(89,1,'GR','Greece',1),
	(90,1,'GS','S. Georgia and S. Sandwich Isls.',1),
	(91,1,'GT','Guatemala',1),
	(92,1,'GU','Guam',1),
	(93,1,'GW','Guinea-Bissau',1),
	(94,1,'GY','Guyana',1),
	(95,1,'HK','Hong Kong',1),
	(96,1,'HM','Heard and McDonald Islands',1),
	(97,1,'HN','Honduras',1),
	(98,1,'HR','Croatia (Hrvatska)',1),
	(99,1,'HT','Haiti',1),
	(100,1,'HU','Hungary',1),
	(101,1,'ID','Indonesia',1),
	(102,1,'IE','Ireland',1),
	(103,1,'IL','Israel',1),
	(104,1,'IM','Isle Of Man',1),
	(105,1,'IN','India',1),
	(106,1,'IO','British Indian Ocean Territory',1),
	(107,1,'IQ','Iraq',1),
	(108,1,'IR','Iran',1),
	(109,1,'IS','Iceland',1),
	(110,1,'IT','Italy',1),
	(111,1,'JE','Jersey',1),
	(112,1,'JM','Jamaica',1),
	(113,1,'JO','Jordan',1),
	(114,1,'JP','Japan',1),
	(115,1,'KE','Kenya',1),
	(116,1,'KG','Kyrgyzstan',1),
	(117,1,'KH','Cambodia',1),
	(118,1,'KI','Kiribati',1),
	(119,1,'KM','Comoros',1),
	(120,1,'KN','Saint Kitts and Nevis',1),
	(121,1,'KP','Korea (North)',1),
	(122,1,'KR','Korea (South)',1),
	(123,1,'KW','Kuwait',1),
	(124,1,'KY','Cayman Islands',1),
	(125,1,'KZ','Kazakhstan',1),
	(126,1,'LA','Laos',1),
	(127,1,'LB','Lebanon',1),
	(128,1,'LC','Saint Lucia',1),
	(129,1,'LI','Liechtenstein',1),
	(130,1,'LK','Sri Lanka',1),
	(131,1,'LR','Liberia',1),
	(132,1,'LS','Lesotho',1),
	(133,1,'LT','Lithuania',1),
	(134,1,'LU','Luxembourg',1),
	(135,1,'LV','Latvia',1),
	(136,1,'LY','Libya',1),
	(137,1,'MA','Morocco',1),
	(138,1,'MC','Monaco',1),
	(139,1,'MD','Moldova',1),
	(140,1,'ME','Montenegro',1),
	(141,1,'MF','Saint Martin (French part)',1),
	(142,1,'MG','Madagascar',1),
	(143,1,'MH','Marshall Islands',1),
	(144,1,'MK','Macedonia',1),
	(145,1,'ML','Mali',1),
	(146,1,'MM','Burma (Myanmar)',1),
	(147,1,'MN','Mongolia',1),
	(148,1,'MO','Macau',1),
	(149,1,'MP','Northern Mariana Islands',1),
	(150,1,'MQ','Martinique',1),
	(151,1,'MR','Mauritania',1),
	(152,1,'MS','Montserrat',1),
	(153,1,'MT','Malta',1),
	(154,1,'MU','Mauritius',1),
	(155,1,'MV','Maldives',1),
	(156,1,'MW','Malawi',1),
	(157,1,'MX','Mexico',1),
	(158,1,'MY','Malaysia',1),
	(159,1,'MZ','Mozambique',1),
	(160,1,'NA','Namibia',1),
	(161,1,'NC','New Caledonia',1),
	(162,1,'NE','Niger',1),
	(163,1,'NF','Norfolk Island',1),
	(164,1,'NG','Nigeria',1),
	(165,1,'NI','Nicaragua',1),
	(166,1,'NL','Netherlands',1),
	(167,1,'NO','Norway',1),
	(168,1,'NP','Nepal',1),
	(169,1,'NR','Nauru',1),
	(170,1,'NU','Niue',1),
	(171,1,'NZ','New Zealand',1),
	(172,1,'OM','Oman',1),
	(173,1,'PA','Panama',1),
	(174,1,'PE','Peru',1),
	(175,1,'PF','French Polynesia',1),
	(176,1,'PG','Papua New Guinea',1),
	(177,1,'PH','Philippines',1),
	(178,1,'PK','Pakistan',1),
	(179,1,'PL','Poland',1),
	(180,1,'PM','St. Pierre and Miquelon',1),
	(181,1,'PN','Pitcairn',1),
	(182,1,'PR','Puerto Rico',1),
	(183,1,'PS','Palestinian Territory, Occupied',1),
	(184,1,'PT','Portugal',1),
	(185,1,'PW','Palau',1),
	(186,1,'PY','Paraguay',1),
	(187,1,'QA','Qatar',1),
	(188,1,'RE','Reunion',1),
	(189,1,'RO','Romania',1),
	(190,1,'RS','Republic of Serbia',1),
	(191,1,'RU','Russia',1),
	(192,1,'RW','Rwanda',1),
	(193,1,'SA','Saudi Arabia',1),
	(194,1,'SB','Solomon Islands',1),
	(195,1,'SC','Seychelles',1),
	(196,1,'SD','Sudan',1),
	(197,1,'SE','Sweden',1),
	(198,1,'SG','Singapore',1),
	(199,1,'SH','St. Helena',1),
	(200,1,'SI','Slovenia',1),
	(201,1,'SJ','Svalbard and Jan Mayen Islands',1),
	(202,1,'SK','Slovak Republic',1),
	(203,1,'SL','Sierra Leone',1),
	(204,1,'SM','San Marino',1),
	(205,1,'SN','Senegal',1),
	(206,1,'SO','Somalia',1),
	(207,1,'SR','Suriname',1),
	(208,1,'SS','South Sudan',1),
	(209,1,'ST','Sao Tome and Principe',1),
	(210,1,'SV','El Salvador',1),
	(211,1,'SX','Sint Maarten (Dutch part)',1),
	(212,1,'SY','Syria',1),
	(213,1,'SZ','Swaziland',1),
	(214,1,'TC','Turks and Caicos Islands',1),
	(215,1,'TD','Chad',1),
	(216,1,'TF','French Southern Territories',1),
	(217,1,'TG','Togo',1),
	(218,1,'TH','Thailand',1),
	(219,1,'TJ','Tajikistan',1),
	(220,1,'TK','Tokelau',1),
	(221,1,'TL','Timor-Leste',1),
	(222,1,'TM','Turkmenistan',1),
	(223,1,'TN','Tunisia',1),
	(224,1,'TO','Tonga',1),
	(225,1,'TR','Turkey',1),
	(226,1,'TT','Trinidad and Tobago',1),
	(227,1,'TV','Tuvalu',1),
	(228,1,'TW','Taiwan',1),
	(229,1,'TZ','Tanzania',1),
	(230,1,'UA','Ukraine',1),
	(231,1,'UG','Uganda',1),
	(232,1,'UM','United States Minor Outlying Islands',1),
	(233,1,'US','United States',1),
	(234,1,'UY','Uruguay',1),
	(235,1,'UZ','Uzbekistan',1),
	(236,1,'VA','Vatican City State (Holy See)',1),
	(237,1,'VC','Saint Vincent and the Grenadines',1),
	(238,1,'VE','Venezuela',1),
	(239,1,'VG','Virgin Islands (British)',1),
	(240,1,'VI','Virgin Islands (U.S.)',1),
	(241,1,'VN','Viet Nam',1),
	(242,1,'VU','Vanuatu',1),
	(243,1,'WF','Wallis and Futuna Islands',1),
	(244,1,'WS','Samoa',1),
	(245,1,'YE','Yemen',1),
	(246,1,'YT','Mayotte',1),
	(247,1,'ZA','South Africa',1),
	(248,1,'ZM','Zambia',1),
	(249,1,'ZW','Zimbabwe',1);

/*!40000 ALTER TABLE `exp_store_countries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_store_discounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_discounts`;

CREATE TABLE `exp_store_discounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL DEFAULT '',
  `start_date` int(10) unsigned DEFAULT NULL,
  `end_date` int(10) unsigned DEFAULT NULL,
  `member_group_ids` varchar(255) DEFAULT NULL,
  `entry_ids` varchar(255) DEFAULT NULL,
  `category_ids` varchar(255) DEFAULT NULL,
  `exclude_on_sale` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(10) NOT NULL DEFAULT '',
  `purchase_qty` int(4) unsigned DEFAULT NULL,
  `purchase_total` decimal(19,4) DEFAULT NULL,
  `step_qty` int(4) unsigned DEFAULT NULL,
  `discount_qty` int(4) unsigned DEFAULT NULL,
  `match_items_on` varchar(50) DEFAULT NULL,
  `base_discount` decimal(19,4) DEFAULT NULL,
  `per_item_discount` decimal(19,4) DEFAULT NULL,
  `percent_discount` decimal(8,5) DEFAULT NULL,
  `free_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `per_user_limit` int(4) unsigned DEFAULT NULL,
  `total_use_limit` int(4) unsigned DEFAULT NULL,
  `total_use_count` int(4) unsigned NOT NULL DEFAULT '0',
  `break` tinyint(1) NOT NULL DEFAULT '0',
  `notes` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_emails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_emails`;

CREATE TABLE `exp_store_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL,
  `name` varchar(30) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `contents` text NOT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `mail_format` varchar(5) NOT NULL,
  `word_wrap` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exp_store_emails` WRITE;
/*!40000 ALTER TABLE `exp_store_emails` DISABLE KEYS */;

INSERT INTO `exp_store_emails` (`id`, `site_id`, `name`, `subject`, `contents`, `bcc`, `to`, `mail_format`, `word_wrap`, `enabled`)
VALUES
	(1,1,'Order Confirmation','Order Confirmation','Hi {billing_first_name},\nThank you for placing your order with us.\nYour order details are -\n\nOrder Id    - {order_id}\nOrder Total - {order_total}\n\nOrder Items:\n{items}\nItem - {title}, Qty - {item_qty}, Item Total - {item_total}\n{/items}\n\nShipping Details:\nName     - {shipping_name}\nAddress  - {shipping_address1}\nAddress  - {shipping_address2}\nCity     - {shipping_city}\nState    - {shipping_state}\nCountry  - {shipping_country}\nPostcode - {shipping_postcode}\n\nPlease contact us if any of the above details appear incorrect.\nThank You!\n',NULL,'{order_email}','text',1,1);

/*!40000 ALTER TABLE `exp_store_emails` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_store_order_adjustments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_order_adjustments`;

CREATE TABLE `exp_store_order_adjustments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `rate` decimal(8,5) NOT NULL DEFAULT '0.00000',
  `amount` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `taxable` tinyint(1) NOT NULL DEFAULT '0',
  `included` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_order_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_order_history`;

CREATE TABLE `exp_store_order_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `order_status_name` varchar(20) NOT NULL DEFAULT '',
  `order_status_updated` int(10) unsigned NOT NULL DEFAULT '0',
  `order_status_member_id` int(10) NOT NULL DEFAULT '0',
  `order_status_message` text,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_order_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_order_items`;

CREATE TABLE `exp_store_order_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `order_id` int(10) unsigned NOT NULL,
  `entry_id` int(10) unsigned DEFAULT NULL,
  `stock_id` int(10) NOT NULL DEFAULT '0',
  `sku` varchar(255) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `url_title` varchar(255) NOT NULL DEFAULT '',
  `channel_id` int(10) NOT NULL DEFAULT '0',
  `category_ids` varchar(255) DEFAULT NULL,
  `modifiers` text,
  `price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `regular_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `on_sale` tinyint(1) NOT NULL DEFAULT '0',
  `weight` double DEFAULT NULL,
  `length` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `handling` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `handling_tax` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `free_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `tax_exempt` tinyint(1) NOT NULL DEFAULT '0',
  `item_qty` int(4) unsigned NOT NULL DEFAULT '0',
  `item_subtotal` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `item_discount` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `item_tax` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `item_total` decimal(19,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_orders`;

CREATE TABLE `exp_store_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `order_hash` varchar(32) NOT NULL,
  `member_id` int(10) unsigned DEFAULT NULL,
  `order_date` int(10) unsigned NOT NULL,
  `order_completed_date` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(40) NOT NULL,
  `order_status_name` varchar(20) DEFAULT NULL,
  `order_status_updated` int(10) unsigned DEFAULT NULL,
  `order_status_member_id` int(10) DEFAULT NULL,
  `order_status_message` text,
  `order_qty` int(4) unsigned NOT NULL DEFAULT '0',
  `order_subtotal` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_subtotal_tax` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_discount` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_discount_tax` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_shipping` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_shipping_discount` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_shipping_tax` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_shipping_total` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_handling` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_handling_tax` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_handling_total` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_tax` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_total` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_paid` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `order_paid_date` int(10) unsigned DEFAULT NULL,
  `order_email` varchar(100) DEFAULT NULL,
  `discount_id` int(10) unsigned DEFAULT NULL,
  `promo_code` varchar(255) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `shipping_method_name` varchar(255) DEFAULT NULL,
  `shipping_method` varchar(255) DEFAULT NULL,
  `shipping_method_class` varchar(255) DEFAULT NULL,
  `shipping_method_rule` varchar(50) DEFAULT NULL,
  `shipping_override` text,
  `tax_id` int(10) unsigned DEFAULT NULL,
  `tax_name` varchar(40) DEFAULT NULL,
  `tax_rate` decimal(8,5) NOT NULL DEFAULT '0.00000',
  `tax_override` text NOT NULL,
  `order_length` double NOT NULL DEFAULT '0',
  `order_width` double NOT NULL DEFAULT '0',
  `order_height` double NOT NULL DEFAULT '0',
  `dimension_units` varchar(5) NOT NULL DEFAULT '',
  `order_weight` double NOT NULL DEFAULT '0',
  `weight_units` varchar(5) NOT NULL DEFAULT '',
  `billing_first_name` varchar(255) DEFAULT NULL,
  `billing_last_name` varchar(255) DEFAULT NULL,
  `billing_address1` varchar(255) DEFAULT NULL,
  `billing_address2` varchar(255) DEFAULT NULL,
  `billing_city` varchar(255) DEFAULT NULL,
  `billing_state` varchar(255) DEFAULT NULL,
  `billing_country` char(2) DEFAULT NULL,
  `billing_postcode` varchar(255) DEFAULT NULL,
  `billing_phone` varchar(255) DEFAULT NULL,
  `billing_company` varchar(255) DEFAULT NULL,
  `shipping_first_name` varchar(255) DEFAULT NULL,
  `shipping_last_name` varchar(255) DEFAULT NULL,
  `shipping_address1` varchar(255) DEFAULT NULL,
  `shipping_address2` varchar(255) DEFAULT NULL,
  `shipping_city` varchar(255) DEFAULT NULL,
  `shipping_state` varchar(255) DEFAULT NULL,
  `shipping_country` char(2) DEFAULT NULL,
  `shipping_postcode` varchar(255) DEFAULT NULL,
  `shipping_phone` varchar(255) DEFAULT NULL,
  `shipping_company` varchar(255) DEFAULT NULL,
  `billing_same_as_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `shipping_same_as_billing` tinyint(1) NOT NULL DEFAULT '0',
  `order_custom1` text,
  `order_custom2` text,
  `order_custom3` text,
  `order_custom4` text,
  `order_custom5` text,
  `order_custom6` text,
  `order_custom7` text,
  `order_custom8` text,
  `order_custom9` text,
  `return_url` varchar(255) DEFAULT NULL,
  `cancel_url` varchar(255) DEFAULT NULL,
  `ip_country` char(2) DEFAULT NULL,
  `member_data_loaded` tinyint(1) NOT NULL DEFAULT '0',
  `tax_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `accept_terms` tinyint(1) NOT NULL DEFAULT '0',
  `register_member` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  `screen_name` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `password_salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_hash` (`order_hash`),
  KEY `order_id` (`order_id`),
  KEY `site_id` (`site_id`),
  KEY `member_id` (`member_id`),
  KEY `order_date` (`order_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_payment_methods
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_payment_methods`;

CREATE TABLE `exp_store_payment_methods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `class` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_product_modifiers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_product_modifiers`;

CREATE TABLE `exp_store_product_modifiers` (
  `product_mod_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned NOT NULL,
  `mod_type` varchar(20) NOT NULL,
  `mod_name` varchar(100) NOT NULL,
  `mod_instructions` text,
  `mod_order` int(4) unsigned NOT NULL,
  PRIMARY KEY (`product_mod_id`),
  KEY `entry_id` (`entry_id`),
  KEY `mod_order` (`mod_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_product_options
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_product_options`;

CREATE TABLE `exp_store_product_options` (
  `product_opt_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_mod_id` int(10) unsigned NOT NULL,
  `opt_name` varchar(100) NOT NULL,
  `opt_price_mod` decimal(19,4) DEFAULT NULL,
  `opt_order` int(4) unsigned NOT NULL,
  PRIMARY KEY (`product_opt_id`),
  KEY `product_mod_id` (`product_mod_id`),
  KEY `opt_order` (`opt_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_products
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_products`;

CREATE TABLE `exp_store_products` (
  `entry_id` int(10) unsigned NOT NULL DEFAULT '0',
  `price` decimal(19,4) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `length` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `handling` decimal(19,4) DEFAULT NULL,
  `free_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `tax_exempt` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_sales
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_sales`;

CREATE TABLE `exp_store_sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `start_date` int(10) unsigned DEFAULT NULL,
  `end_date` int(10) unsigned DEFAULT NULL,
  `member_group_ids` varchar(255) DEFAULT NULL,
  `entry_ids` varchar(255) DEFAULT NULL,
  `category_ids` varchar(255) DEFAULT NULL,
  `per_item_discount` decimal(19,4) DEFAULT NULL,
  `percent_discount` decimal(8,5) DEFAULT NULL,
  `notes` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_shipping_methods
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_shipping_methods`;

CREATE TABLE `exp_store_shipping_methods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_shipping_rules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_shipping_rules`;

CREATE TABLE `exp_store_shipping_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shipping_method_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `country_code` char(2) DEFAULT NULL,
  `state_code` varchar(5) DEFAULT NULL,
  `postcode` varchar(10) NOT NULL DEFAULT '',
  `min_weight` double DEFAULT NULL,
  `max_weight` double DEFAULT NULL,
  `min_order_total` decimal(19,4) DEFAULT NULL,
  `max_order_total` decimal(19,4) DEFAULT NULL,
  `min_order_qty` int(4) unsigned DEFAULT NULL,
  `max_order_qty` int(4) unsigned DEFAULT NULL,
  `base_rate` decimal(19,4) DEFAULT NULL,
  `per_item_rate` decimal(19,4) DEFAULT NULL,
  `per_weight_rate` decimal(19,4) DEFAULT NULL,
  `percent_rate` double DEFAULT NULL,
  `min_rate` decimal(19,4) DEFAULT NULL,
  `max_rate` decimal(19,4) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `shipping_method_id` (`shipping_method_id`),
  KEY `country_code` (`country_code`),
  KEY `region_code` (`state_code`),
  KEY `postcode` (`postcode`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_states
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_states`;

CREATE TABLE `exp_store_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `country_id` int(10) unsigned NOT NULL DEFAULT '0',
  `code` varchar(5) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exp_store_states` WRITE;
/*!40000 ALTER TABLE `exp_store_states` DISABLE KEYS */;

INSERT INTO `exp_store_states` (`id`, `site_id`, `country_id`, `code`, `name`)
VALUES
	(1,1,13,'ACT','Australian Capital Territory'),
	(2,1,13,'NSW','New South Wales'),
	(3,1,13,'NT','Northern Territory'),
	(4,1,13,'QLD','Queensland'),
	(5,1,13,'SA','South Australia'),
	(6,1,13,'TAS','Tasmania'),
	(7,1,13,'VIC','Victoria'),
	(8,1,13,'WA','Western Australia'),
	(9,1,38,'AB','Alberta'),
	(10,1,38,'BC','British Columbia'),
	(11,1,38,'MB','Manitoba'),
	(12,1,38,'NB','New Brunswick'),
	(13,1,38,'NL','Newfoundland and Labrador'),
	(14,1,38,'NT','Northwest Territories'),
	(15,1,38,'NS','Nova Scotia'),
	(16,1,38,'NU','Nunavut'),
	(17,1,38,'ON','Ontario'),
	(18,1,38,'PE','Prince Edward Island'),
	(19,1,38,'QC','Quebec'),
	(20,1,38,'SK','Saskatchewan'),
	(21,1,38,'YT','Yukon'),
	(22,1,233,'AL','Alabama'),
	(23,1,233,'AK','Alaska'),
	(24,1,233,'AZ','Arizona'),
	(25,1,233,'AR','Arkansas'),
	(26,1,233,'CA','California'),
	(27,1,233,'CO','Colorado'),
	(28,1,233,'CT','Connecticut'),
	(29,1,233,'DE','Delaware'),
	(30,1,233,'DC','District of Columbia'),
	(31,1,233,'FL','Florida'),
	(32,1,233,'GA','Georgia'),
	(33,1,233,'HI','Hawaii'),
	(34,1,233,'ID','Idaho'),
	(35,1,233,'IL','Illinois'),
	(36,1,233,'IN','Indiana'),
	(37,1,233,'IA','Iowa'),
	(38,1,233,'KS','Kansas'),
	(39,1,233,'KY','Kentucky'),
	(40,1,233,'LA','Louisiana'),
	(41,1,233,'ME','Maine'),
	(42,1,233,'MD','Maryland'),
	(43,1,233,'MA','Massachusetts'),
	(44,1,233,'MI','Michigan'),
	(45,1,233,'MN','Minnesota'),
	(46,1,233,'MS','Mississippi'),
	(47,1,233,'MO','Missouri'),
	(48,1,233,'MT','Montana'),
	(49,1,233,'NE','Nebraska'),
	(50,1,233,'NV','Nevada'),
	(51,1,233,'NH','New Hampshire'),
	(52,1,233,'NJ','New Jersey'),
	(53,1,233,'NM','New Mexico'),
	(54,1,233,'NY','New York'),
	(55,1,233,'NC','North Carolina'),
	(56,1,233,'ND','North Dakota'),
	(57,1,233,'OH','Ohio'),
	(58,1,233,'OK','Oklahoma'),
	(59,1,233,'OR','Oregon'),
	(60,1,233,'PA','Pennsylvania'),
	(61,1,233,'RI','Rhode Island'),
	(62,1,233,'SC','South Carolina'),
	(63,1,233,'SD','South Dakota'),
	(64,1,233,'TN','Tennessee'),
	(65,1,233,'TX','Texas'),
	(66,1,233,'UT','Utah'),
	(67,1,233,'VT','Vermont'),
	(68,1,233,'VA','Virginia'),
	(69,1,233,'WA','Washington'),
	(70,1,233,'WV','West Virginia'),
	(71,1,233,'WI','Wisconsin'),
	(72,1,233,'WY','Wyoming');

/*!40000 ALTER TABLE `exp_store_states` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_store_statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_statuses`;

CREATE TABLE `exp_store_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `email_ids` varchar(255) DEFAULT NULL,
  `sort` int(4) unsigned NOT NULL DEFAULT '0',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exp_store_statuses` WRITE;
/*!40000 ALTER TABLE `exp_store_statuses` DISABLE KEYS */;

INSERT INTO `exp_store_statuses` (`id`, `site_id`, `name`, `color`, `email_ids`, `sort`, `is_default`)
VALUES
	(1,1,'new',NULL,'1',0,1);

/*!40000 ALTER TABLE `exp_store_statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_store_stock
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_stock`;

CREATE TABLE `exp_store_stock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned NOT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `stock_level` int(4) DEFAULT NULL,
  `min_order_qty` int(4) DEFAULT NULL,
  `track_stock` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sku` (`sku`),
  KEY `entry_id` (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_stock_options
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_stock_options`;

CREATE TABLE `exp_store_stock_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stock_id` int(10) unsigned NOT NULL,
  `entry_id` int(10) unsigned NOT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `product_mod_id` int(10) unsigned NOT NULL,
  `product_opt_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sku` (`sku`),
  KEY `stock_id` (`stock_id`),
  KEY `product_mod_id` (`product_mod_id`),
  KEY `product_opt_id` (`product_opt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_taxes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_taxes`;

CREATE TABLE `exp_store_taxes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` decimal(8,5) NOT NULL,
  `country_code` char(2) DEFAULT NULL,
  `state_code` varchar(5) DEFAULT NULL,
  `apply_to_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `included` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_taxes_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_taxes_categories`;

CREATE TABLE `exp_store_taxes_categories` (
  `tax_id` int(10) unsigned NOT NULL DEFAULT '0',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`tax_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_store_transactions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_store_transactions`;

CREATE TABLE `exp_store_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(5) NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned DEFAULT NULL,
  `hash` varchar(32) NOT NULL DEFAULT '',
  `date` int(10) unsigned DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `amount` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `status` varchar(10) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `message` text,
  `response_data` text,
  `brand` varchar(32) DEFAULT NULL,
  `last_four` char(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table exp_template_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_template_groups`;

CREATE TABLE `exp_template_groups` (
  `group_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  `group_order` int(3) unsigned NOT NULL,
  `is_site_default` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`group_id`),
  KEY `site_id` (`site_id`),
  KEY `group_name_idx` (`group_name`),
  KEY `group_order_idx` (`group_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_template_groups` WRITE;
/*!40000 ALTER TABLE `exp_template_groups` DISABLE KEYS */;

INSERT INTO `exp_template_groups` (`group_id`, `site_id`, `group_name`, `group_order`, `is_site_default`)
VALUES
	(1,1,'account',1,'n'),
	(2,1,'site',2,'n');

/*!40000 ALTER TABLE `exp_template_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_template_member_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_template_member_groups`;

CREATE TABLE `exp_template_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `template_group_id` mediumint(5) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`template_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_template_member_groups` WRITE;
/*!40000 ALTER TABLE `exp_template_member_groups` DISABLE KEYS */;

INSERT INTO `exp_template_member_groups` (`group_id`, `template_group_id`)
VALUES
	(3,2);

/*!40000 ALTER TABLE `exp_template_member_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_template_no_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_template_no_access`;

CREATE TABLE `exp_template_no_access` (
  `template_id` int(6) unsigned NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`template_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_template_routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_template_routes`;

CREATE TABLE `exp_template_routes` (
  `route_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` int(10) unsigned NOT NULL,
  `order` int(10) unsigned DEFAULT NULL,
  `route` varchar(512) DEFAULT NULL,
  `route_parsed` varchar(512) DEFAULT NULL,
  `route_required` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`route_id`),
  KEY `template_id` (`template_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_templates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_templates`;

CREATE TABLE `exp_templates` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(6) unsigned NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `save_template_file` char(1) NOT NULL DEFAULT 'n',
  `template_type` varchar(16) NOT NULL DEFAULT 'webpage',
  `template_data` mediumtext,
  `template_notes` text,
  `edit_date` int(10) NOT NULL DEFAULT '0',
  `last_author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cache` char(1) NOT NULL DEFAULT 'n',
  `refresh` int(6) unsigned NOT NULL DEFAULT '0',
  `no_auth_bounce` varchar(50) NOT NULL DEFAULT '',
  `enable_http_auth` char(1) NOT NULL DEFAULT 'n',
  `allow_php` char(1) NOT NULL DEFAULT 'n',
  `php_parse_location` char(1) NOT NULL DEFAULT 'o',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `protect_javascript` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`template_id`),
  KEY `group_id` (`group_id`),
  KEY `template_name` (`template_name`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `exp_templates` WRITE;
/*!40000 ALTER TABLE `exp_templates` DISABLE KEYS */;

INSERT INTO `exp_templates` (`template_id`, `site_id`, `group_id`, `template_name`, `save_template_file`, `template_type`, `template_data`, `template_notes`, `edit_date`, `last_author_id`, `cache`, `refresh`, `no_auth_bounce`, `enable_http_auth`, `allow_php`, `php_parse_location`, `hits`, `protect_javascript`)
VALUES
	(1,1,1,'index','y','webpage','',NULL,1425867154,1,'n',0,'','n','n','o',0,'n'),
	(2,1,1,'_session','y','webpage','',NULL,1425867154,1,'n',0,'','n','n','o',0,'n'),
	(3,1,2,'index','y','webpage','{layout=\"site/-layout\"}\nsite/index',NULL,1425876137,1,'n',0,'','n','n','o',0,'n'),
	(4,1,2,'-layout','y','webpage','<!doctype html>\n<html class=\"no-js\" lang=\"\">\n<head>\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n\n    <title></title>\n    <meta name=\"description\" content=\"\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n\n    {!--\n    Home link\n    See: http://microformats.org/wiki/rel-home\n    See:\n    --}\n    <link rel=\"home\" href=\"{site_url}\"/>\n\n    {!--\n    Sitemap link\n    See: http://microformats.org/wiki/rel-sitemap\n    See: https://github.com/h5bp/html5-boilerplate/blob/v5.0.0/dist/doc/extend.md#direct-search-spiders-to-your-sitemap\n    --}\n    <link rel=\"sitemap\" type=\"application/xml\" title=\"Sitemap\" href=\"/sitemap.xml\">\n\n    {!--\n    IE Browser Config\n    See: https://msdn.microsoft.com/en-us/library/ie/dn320426%28v=vs.85%29.aspx\n    See: https://github.com/h5bp/html5-boilerplate/blob/v5.0.0/dist/doc/misc.md#browserconfigxml\n    --}\n    <meta name=\"msapplication-config\" content=\"browserconfig.xml\" />\n\n    {!--\n    Apple Touch Icon\n    See: https://github.com/h5bp/html5-boilerplate/issues/1615\n    See: https://developer.apple.com/library/mac/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html\n    --}\n    <link rel=\"apple-touch-icon\" href=\"apple-touch-icon.png\">\n\n    {!--\n    Favicon: Place favicon.ico in the root directory\n    See: https://github.com/h5bp/html5-boilerplate/issues/1285\n    See: https://github.com/h5bp/html5-boilerplate/issues/1285#issuecomment-12062847\n    --}\n\n    {!--\n    Facebook Insights\n    Note: Note: Additional fb:admins should be declared in a new tag.\n    See: https://developers.facebook.com/docs/platforminsights/domains\n    --}\n    <meta property=\"fb:admins\" content=\"1234\" />\n    <meta property=\"fb:admins\" content=\"5678\" />\n    <meta property=\"fb:app_id\" content=\"your_app_id\" />\n\n    {!--\n    Opensearch\n    href maps to ee template search/opensource. Double check routes.php\n    See: http://www.opensearch.org/Home\n    --}\n    <link rel=\"search\" title=\"{site_name} Search\" type=\"application/opensearchdescription+xml\" href=\"opensearch.xml\">\n\n    <script>\n        window.app = {}\n    </script>\n\n    {if gv_segmentio_write_key}\n    <script type=\"text/javascript\">\n        !function () {\n            var analytics = window.analytics = window.analytics || [];\n            if (!analytics.initialize)if (analytics.invoked)window.console && console.error && console.error(\"Segment snippet included twice.\"); else {\n                analytics.invoked = !0;\n                analytics.methods = [\"trackSubmit\", \"trackClick\", \"trackLink\", \"trackForm\", \"pageview\", \"identify\", \"group\", \"track\", \"ready\", \"alias\", \"page\", \"once\", \"off\", \"on\"];\n                analytics.factory = function (t) {\n                    return function () {\n                        var e = Array.prototype.slice.call(arguments);\n                        e.unshift(t);\n                        analytics.push(e);\n                        return analytics\n                    }\n                };\n                for (var t = 0; t < analytics.methods.length; t++) {\n                    var e = analytics.methods[t];\n                    analytics[e] = analytics.factory(e)\n                }\n                analytics.load = function (t) {\n                    var e = document.createElement(\"script\");\n                    e.type = \"text/javascript\";\n                    e.async = !0;\n                    e.src = (\"https:\" === document.location.protocol ? \"https://\" : \"http://\") + \"cdn.segment.com/analytics.js/v1/\" + t + \"/analytics.min.js\";\n                    var n = document.getElementsByTagName(\"script\")[0];\n                    n.parentNode.insertBefore(e, n)\n                };\n                analytics.SNIPPET_VERSION = \"3.0.1\";\n                analytics.load(\"{gv_segmentio_write_key}\");\n            }\n        }();\n    </script>\n    {/if}\n\n    {if gv_chartbeat_domain}\n    <script type=\"text/javascript\">var _sf_startpt=(new Date()).getTime()</script>\n    {/if}\n\n</head>\n<body>\n\n<!--[if lt IE 8]>\n<p class=\"browserupgrade\">You are using an <strong>outdated</strong> browser. Please <a href=\"http://browsehappy.com/\">upgrade\n    your browser</a> to improve your experience.</p>\n<![endif]-->\n\n{layout:contents}\n\n{if gv_disqus_short_name}\n<script type=\"text/javascript\">\n    (function () {\n        var disqus_shortname = \"{gv_disqus_short_name}\",\n                dsq = document.createElement(\'script\');\n        dsq.type = \'text/javascript\';\n        dsq.async = true;\n        dsq.src = \'//\' + disqus_shortname + \'.disqus.com/embed.js\';\n        (document.getElementsByTagName(\'head\')[0] || document.getElementsByTagName(\'body\')[0]).appendChild(dsq);\n    })();\n</script>\n{/if}\n\n{if gv_chartbeat_domain}\n<script type=\"text/javascript\">\n    var _sf_async_config={};\n    /** CONFIGURATION START **/\n    _sf_async_config.uid = 29625;\n    _sf_async_config.domain = \"{gv_chartbeat_domain}\";\n    /** CONFIGURATION END **/\n    (function(){\n        function loadChartbeat() {\n            window._sf_endpt=(new Date()).getTime();\n            var e = document.createElement(\"script\");\n            e.setAttribute(\"language\", \"javascript\");\n            e.setAttribute(\"type\", \"text/javascript\");\n            e.setAttribute(\'src\', \'//static.chartbeat.com/js/chartbeat.js\');\n            document.body.appendChild(e);\n        }\n        var oldonload = window.onload;\n        window.onload = (typeof window.onload != \"function\") ?\n                loadChartbeat : function() { try { oldonload(); } catch (e) { loadChartbeat(); throw e} loadChartbeat(); };\n\n    })();\n</script>\n{/if}\n\n{if gv_google_analytics_key}\n<script>\n    (function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\n        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\n            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\n    })(window,document,\'script\',\'//www.google-analytics.com/analytics.js\',\'ga\');\n\n    ga(\'create\', \'{gv_google_analytics_key}\', \'auto\');\n    ga(\'send\', \'pageview\');\n\n</script>\n{/if}\n\n</body>\n</html>',NULL,1425876137,1,'n',0,'','n','n','o',0,'n');

/*!40000 ALTER TABLE `exp_templates` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table exp_throttle
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_throttle`;

CREATE TABLE `exp_throttle` (
  `throttle_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL,
  `locked_out` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`throttle_id`),
  KEY `ip_address` (`ip_address`),
  KEY `last_activity` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_upload_no_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_upload_no_access`;

CREATE TABLE `exp_upload_no_access` (
  `upload_id` int(6) unsigned NOT NULL,
  `upload_loc` varchar(3) NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`upload_id`,`member_group`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_upload_prefs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_upload_prefs`;

CREATE TABLE `exp_upload_prefs` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `name` varchar(50) NOT NULL,
  `server_path` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(100) NOT NULL,
  `allowed_types` varchar(3) NOT NULL DEFAULT 'img',
  `max_size` varchar(16) DEFAULT NULL,
  `max_height` varchar(6) DEFAULT NULL,
  `max_width` varchar(6) DEFAULT NULL,
  `properties` varchar(120) DEFAULT NULL,
  `pre_format` varchar(120) DEFAULT NULL,
  `post_format` varchar(120) DEFAULT NULL,
  `file_properties` varchar(120) DEFAULT NULL,
  `file_pre_format` varchar(120) DEFAULT NULL,
  `file_post_format` varchar(120) DEFAULT NULL,
  `cat_group` varchar(255) DEFAULT NULL,
  `batch_location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table exp_wygwam_configs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `exp_wygwam_configs`;

CREATE TABLE `exp_wygwam_configs` (
  `config_id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `config_name` varchar(32) DEFAULT NULL,
  `settings` text,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `exp_wygwam_configs` WRITE;
/*!40000 ALTER TABLE `exp_wygwam_configs` DISABLE KEYS */;

INSERT INTO `exp_wygwam_configs` (`config_id`, `config_name`, `settings`)
VALUES
	(1,'Basic','YTo3OntzOjc6InRvb2xiYXIiO2E6ODp7aTowO3M6NDoiQm9sZCI7aToxO3M6NjoiSXRhbGljIjtpOjI7czo5OiJVbmRlcmxpbmUiO2k6MztzOjEyOiJOdW1iZXJlZExpc3QiO2k6NDtzOjEyOiJCdWxsZXRlZExpc3QiO2k6NTtzOjQ6IkxpbmsiO2k6NjtzOjY6IlVubGluayI7aTo3O3M6NjoiQW5jaG9yIjt9czo2OiJoZWlnaHQiO3M6MzoiMjAwIjtzOjE0OiJyZXNpemVfZW5hYmxlZCI7czoxOiJ5IjtzOjExOiJjb250ZW50c0NzcyI7YTowOnt9czo5OiJwYXJzZV9jc3MiO2I6MDtzOjEzOiJyZXN0cmljdF9odG1sIjtzOjE6InkiO3M6MTA6InVwbG9hZF9kaXIiO3M6MDoiIjt9'),
	(2,'Full','YTo3OntzOjc6InRvb2xiYXIiO2E6Mjk6e2k6MDtzOjY6IlNvdXJjZSI7aToxO3M6MzoiQ3V0IjtpOjI7czo0OiJDb3B5IjtpOjM7czo1OiJQYXN0ZSI7aTo0O3M6OToiUGFzdGVUZXh0IjtpOjU7czoxMzoiUGFzdGVGcm9tV29yZCI7aTo2O3M6NDoiVW5kbyI7aTo3O3M6NDoiUmVkbyI7aTo4O3M6NToiU2NheXQiO2k6OTtzOjQ6IkJvbGQiO2k6MTA7czo2OiJJdGFsaWMiO2k6MTE7czo2OiJTdHJpa2UiO2k6MTI7czoxMjoiUmVtb3ZlRm9ybWF0IjtpOjEzO3M6MTI6Ik51bWJlcmVkTGlzdCI7aToxNDtzOjEyOiJCdWxsZXRlZExpc3QiO2k6MTU7czo3OiJPdXRkZW50IjtpOjE2O3M6NjoiSW5kZW50IjtpOjE3O3M6MTA6IkJsb2NrcXVvdGUiO2k6MTg7czo0OiJMaW5rIjtpOjE5O3M6NjoiVW5saW5rIjtpOjIwO3M6NjoiQW5jaG9yIjtpOjIxO3M6NToiSW1hZ2UiO2k6MjI7czo1OiJUYWJsZSI7aToyMztzOjE0OiJIb3Jpem9udGFsUnVsZSI7aToyNDtzOjExOiJTcGVjaWFsQ2hhciI7aToyNTtzOjg6IlJlYWRNb3JlIjtpOjI2O3M6NjoiU3R5bGVzIjtpOjI3O3M6NjoiRm9ybWF0IjtpOjI4O3M6ODoiTWF4aW1pemUiO31zOjY6ImhlaWdodCI7czozOiIyMDAiO3M6MTQ6InJlc2l6ZV9lbmFibGVkIjtzOjE6InkiO3M6MTE6ImNvbnRlbnRzQ3NzIjthOjA6e31zOjk6InBhcnNlX2NzcyI7YjowO3M6MTM6InJlc3RyaWN0X2h0bWwiO3M6MToieSI7czoxMDoidXBsb2FkX2RpciI7czowOiIiO30=');

/*!40000 ALTER TABLE `exp_wygwam_configs` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

/*
SQLyog Community v12.4.0 (64 bit)
MySQL - 5.6.12-log : Database - firdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`firdb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `firdb`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `auth_group` */

insert  into `auth_group`(`id`,`name`) values 
(1,'admin group');

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `auth_group_permissions` */

insert  into `auth_group_permissions`(`id`,`group_id`,`permission_id`) values 
(2,1,1),
(5,1,20),
(6,1,23),
(7,1,26),
(8,1,29),
(1,1,32),
(3,1,38),
(4,1,41);

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can add permission',2,'add_permission'),
(5,'Can change permission',2,'change_permission'),
(6,'Can delete permission',2,'delete_permission'),
(7,'Can add group',3,'add_group'),
(8,'Can change group',3,'change_group'),
(9,'Can delete group',3,'delete_group'),
(10,'Can add user',4,'add_user'),
(11,'Can change user',4,'change_user'),
(12,'Can delete user',4,'delete_user'),
(13,'Can add content type',5,'add_contenttype'),
(14,'Can change content type',5,'change_contenttype'),
(15,'Can delete content type',5,'delete_contenttype'),
(16,'Can add session',6,'add_session'),
(17,'Can change session',6,'change_session'),
(18,'Can delete session',6,'delete_session'),
(19,'Can add donation',7,'add_donation'),
(20,'Can change donation',7,'change_donation'),
(21,'Can delete donation',7,'delete_donation'),
(22,'Can add evidence',8,'add_evidence'),
(23,'Can change evidence',8,'change_evidence'),
(24,'Can delete evidence',8,'delete_evidence'),
(25,'Can add fir',9,'add_fir'),
(26,'Can change fir',9,'change_fir'),
(27,'Can delete fir',9,'delete_fir'),
(28,'Can add fir timeline',10,'add_firtimeline'),
(29,'Can change fir timeline',10,'change_firtimeline'),
(30,'Can delete fir timeline',10,'delete_firtimeline'),
(31,'Can add police',11,'add_police'),
(32,'Can change police',11,'change_police'),
(33,'Can delete police',11,'delete_police'),
(34,'Can add register',12,'add_register'),
(35,'Can change register',12,'change_register'),
(36,'Can delete register',12,'delete_register'),
(37,'Can add sos',13,'add_sos'),
(38,'Can change sos',13,'change_sos'),
(39,'Can delete sos',13,'delete_sos'),
(40,'Can add sos_status',14,'add_sos_status'),
(41,'Can change sos_status',14,'change_sos_status'),
(42,'Can delete sos_status',14,'delete_sos_status');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$100000$S5ZQ627pmejE$iY5lcIctZeNWpS6iIrDZkfth1kvPz3z3WWxlYvQuSv0=','2026-04-25 07:44:59.824862',1,'admin','','','',1,1,'2026-04-16 07:40:45.408900'),
(2,'pbkdf2_sha256$100000$u8wwL4afbcqn$8oGxkUUKqT6ZeC2Gk/9Y6gZC9wvGzhuBNIvAZnt1SKg=','2026-04-25 07:38:36.165508',0,'abi@gmail.com','abi','','',0,1,'2026-04-16 07:43:40.890025'),
(3,'pbkdf2_sha256$100000$Cdl28AxyM3OH$Fch5S4rQMdmRLpzjpDflRm46hmA7k+NCNg3PJej7Q1c=','2026-04-25 07:42:26.030034',0,'suman@gmail.com','suman','','',0,1,'2026-04-16 07:46:50.595931'),
(4,'pbkdf2_sha256$100000$eO1xSk3ujrbd$e8PhA6fKNszjiTDAsfY7f5E9dmCGPDAtWClx5U4W4RQ=','2026-04-17 06:31:23.365379',0,'coderA@gmail.com','coder nnc','','',0,1,'2026-04-17 06:30:54.456827'),
(5,'pbkdf2_sha256$100000$hzOiGzxQ1exJ$PPchjtHsLnYVxWP0qMsLW1P1qy/f4kxqH1C5S+wIFcA=',NULL,0,'biju@gmail.com','biju','','',0,1,'2026-04-17 06:42:56.717191'),
(6,'pbkdf2_sha256$100000$Z5sERavsyQT4$A8rGmRy7eABZhqAg7ybdYffNrGEuAtGG+3bY/Cev5kc=','2026-04-23 04:32:03.160958',0,'coder@gmail.com','coder','','',0,1,'2026-04-23 04:28:14.096281'),
(7,'pbkdf2_sha256$100000$5XG0zdZE0DcC$qADUQPPNAhEMMBwYztj38e2A0PCRx/3X2ZAK3W807Zs=','2026-04-25 07:47:04.079380',0,'admingroup63@gmail.com','group','admin','admingroup63@gmail.com',1,1,'2026-04-24 10:57:24.000000');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_groups` */

insert  into `auth_user_groups`(`id`,`user_id`,`group_id`) values 
(1,7,1);

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values 
(1,'2026-04-16 07:47:25.966746','1','suman',2,'[{\"changed\": {\"fields\": [\"badge_id\", \"post\", \"status\"]}}]',11,1),
(2,'2026-04-23 04:31:29.160178','3','KL-2026-0003 - coder',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',9,1),
(3,'2026-04-23 05:04:02.949222','1','Approved',1,'[{\"added\": {}}]',14,1),
(4,'2026-04-23 05:04:31.539864','2','seen',1,'[{\"added\": {}}]',14,1),
(5,'2026-04-23 05:04:38.283003','3','on the  way',1,'[{\"added\": {}}]',14,1),
(6,'2026-04-24 10:40:58.780612','1','admin group',1,'[{\"added\": {}}]',3,1),
(7,'2026-04-24 10:57:24.739417','7','admingroup63@gmail.com',1,'[{\"added\": {}}]',4,1),
(8,'2026-04-24 11:00:46.354113','7','admingroup63@gmail.com',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"email\", \"is_staff\", \"groups\"]}}]',4,1),
(9,'2026-04-25 07:45:15.141253','1','suman',2,'[{\"changed\": {\"fields\": [\"post\"]}}]',11,1);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(7,'my_app','donation'),
(8,'my_app','evidence'),
(9,'my_app','fir'),
(10,'my_app','firtimeline'),
(11,'my_app','police'),
(12,'my_app','register'),
(13,'my_app','sos'),
(14,'my_app','sos_status'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2026-04-16 07:35:48.955594'),
(2,'auth','0001_initial','2026-04-16 07:35:49.974039'),
(3,'admin','0001_initial','2026-04-16 07:35:50.234527'),
(4,'admin','0002_logentry_remove_auto_add','2026-04-16 07:35:50.244621'),
(5,'contenttypes','0002_remove_content_type_name','2026-04-16 07:35:50.374587'),
(6,'auth','0002_alter_permission_name_max_length','2026-04-16 07:35:50.428522'),
(7,'auth','0003_alter_user_email_max_length','2026-04-16 07:35:50.488596'),
(8,'auth','0004_alter_user_username_opts','2026-04-16 07:35:50.504527'),
(9,'auth','0005_alter_user_last_login_null','2026-04-16 07:35:50.557512'),
(10,'auth','0006_require_contenttypes_0002','2026-04-16 07:35:50.562545'),
(11,'auth','0007_alter_validators_add_error_messages','2026-04-16 07:35:50.572516'),
(12,'auth','0008_alter_user_username_max_length','2026-04-16 07:35:50.638643'),
(13,'auth','0009_alter_user_last_name_max_length','2026-04-16 07:35:50.693523'),
(14,'my_app','0001_initial','2026-04-16 07:35:52.190939'),
(15,'sessions','0001_initial','2026-04-16 07:35:52.259436'),
(16,'my_app','0002_auto_20260419_1208','2026-04-19 06:38:47.859862'),
(17,'my_app','0003_donation_order_id','2026-04-19 06:51:52.045509'),
(18,'my_app','0004_auto_20260423_1028','2026-04-23 04:59:07.330676');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('ckacw2jusi64rlejzhylwe716g6gjtpi','NTNiOGI0ODMxNjk1MDNkMWJlM2U2MWUyMzAzNzQwM2FkNTBhZTg1MDp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjM5MWYxOTg2ZWI1OTQ3ZjMzMGM3MjUwMDFhMDlhNWJjNmFkNmE3In0=','2026-05-09 07:47:04.085966'),
('eotykkzsx7iedf6fen84frya8io7t56k','ZTVhZDJiMDY2YTUyZjQ0NDQwODNjODU5NjA4Y2Q0OTUxYjZmMWVhYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MGM1ZDcwNjAyMDk4MWNlZTM1YWRkMmQxZTEwOWU3ODI1ZTM0Y2I1In0=','2026-05-08 10:14:52.618405'),
('lk87sgou1z4v86qs3dwegjwg2j6d7amz','OGUxMjc0MTFkMjJkMmQ1ODc2YjhkMTU3MzM0M2MwZDBkNjU0YWY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjYWJjODU2OWExN2ZjMDNhMWVjMjlhMjIxYTVmYTdiMWYwMzRhZDFmIn0=','2026-05-09 07:42:26.047036');

/*Table structure for table `my_app_donation` */

DROP TABLE IF EXISTS `my_app_donation`;

CREATE TABLE `my_app_donation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `amount` int(11) NOT NULL,
  `payment_id` varchar(200) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `order_id` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `my_app_donation` */

insert  into `my_app_donation`(`id`,`name`,`email`,`amount`,`payment_id`,`created_at`,`order_id`) values 
(1,'abijith p','abijithjr63@gmail.com',65,'pay_SfGBsM87NRWKSG','2026-04-19 06:47:49.938429',NULL),
(2,'abijith p','abijithjr63@gmail.com',65,NULL,'2026-04-19 06:56:24.655433','order_SfGBjx2XJvZ4Vt'),
(3,'abijith p','abijithjr63@gmail.com',100,'pay_SfGMab2rzAke2r','2026-04-19 07:06:27.940420','order_SfGMMRgeBhsxm5'),
(4,'abijith p','abijithjr63@gmail.com',500,NULL,'2026-04-19 07:08:52.634274','order_SfGOuOp2xcPd18'),
(5,'hacker ','metryhack4@gmail.com',1000,'pay_SfGQ5JR0YdzdTO','2026-04-19 07:09:14.525276','order_SfGPIHHd1blaGK'),
(6,'abijith p','abijithjr63@gmail.com',100,'pay_SfGhlc5mx2aiTk','2026-04-19 07:26:37.558066','order_SfGhenpdksABXi'),
(7,'abijith p','abijithjr63@gmail.com',500,'pay_Sgnw4lp61119O0','2026-04-23 04:35:57.890970','order_SgnvntzRqdU2MU');

/*Table structure for table `my_app_evidence` */

DROP TABLE IF EXISTS `my_app_evidence`;

CREATE TABLE `my_app_evidence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `fir_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_app_evidence_fir_id_b79c0685_fk_my_app_fir_id` (`fir_id`),
  CONSTRAINT `my_app_evidence_fir_id_b79c0685_fk_my_app_fir_id` FOREIGN KEY (`fir_id`) REFERENCES `my_app_fir` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `my_app_evidence` */

insert  into `my_app_evidence`(`id`,`file`,`uploaded_at`,`fir_id`) values 
(1,'fir_evidence/dhyan_pan.jpeg','2026-04-16 07:45:15.254627',1),
(2,'fir_evidence/background.png','2026-04-16 07:45:15.284749',1),
(3,'fir_evidence/trailimg.png','2026-04-16 07:45:15.309633',1),
(4,'fir_evidence/background_Z8YUVIS.png','2026-04-17 06:52:02.723155',2),
(5,'fir_evidence/trailimg_LQ48Upo.png','2026-04-17 06:52:02.751131',2),
(6,'fir_evidence/shutter_Ds28lNO.jpg','2026-04-17 06:52:02.775121',2),
(7,'fir_evidence/shutter_1nse5Mz.jpg','2026-04-23 04:30:31.450413',3),
(8,'fir_evidence/model2_Kkjc8oI.jpg','2026-04-23 04:30:31.476400',3),
(9,'fir_evidence/background_ybXBeAG.png','2026-04-25 07:40:42.481183',4),
(10,'fir_evidence/trailimg_kh1xKOp.png','2026-04-25 07:40:42.521713',4),
(11,'fir_evidence/shutter_S8d6DCG.jpg','2026-04-25 07:40:42.550708',4);

/*Table structure for table `my_app_fir` */

DROP TABLE IF EXISTS `my_app_fir`;

CREATE TABLE `my_app_fir` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `address` longtext,
  `district` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `crime_type` varchar(100) NOT NULL,
  `incident_date` date DEFAULT NULL,
  `incident_time` time(6) DEFAULT NULL,
  `incident_place` varchar(200) DEFAULT NULL,
  `police_station` varchar(100) DEFAULT NULL,
  `description` longtext,
  `suspect_name` varchar(100) DEFAULT NULL,
  `suspect_details` longtext,
  `priority` varchar(20) NOT NULL,
  `is_emergency` tinyint(1) NOT NULL,
  `status` varchar(50) NOT NULL,
  `fir_number` varchar(30) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `assigned_by_id` int(11) DEFAULT NULL,
  `assigned_officer_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_app_fir_assigned_by_id_b2824712_fk_my_app_police_id` (`assigned_by_id`),
  KEY `my_app_fir_assigned_officer_id_1816e316_fk_my_app_police_id` (`assigned_officer_id`),
  KEY `my_app_fir_user_id_2d9c1e7a_fk_auth_user_id` (`user_id`),
  CONSTRAINT `my_app_fir_assigned_by_id_b2824712_fk_my_app_police_id` FOREIGN KEY (`assigned_by_id`) REFERENCES `my_app_police` (`id`),
  CONSTRAINT `my_app_fir_assigned_officer_id_1816e316_fk_my_app_police_id` FOREIGN KEY (`assigned_officer_id`) REFERENCES `my_app_police` (`id`),
  CONSTRAINT `my_app_fir_user_id_2d9c1e7a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `my_app_fir` */

insert  into `my_app_fir`(`id`,`name`,`phone`,`email`,`address`,`district`,`state`,`pincode`,`crime_type`,`incident_date`,`incident_time`,`incident_place`,`police_station`,`description`,`suspect_name`,`suspect_details`,`priority`,`is_emergency`,`status`,`fir_number`,`created_at`,`updated_at`,`assigned_by_id`,`assigned_officer_id`,`user_id`) values 
(1,'abi','1234567891','abi@gmail.com','hacker city ','Thrissur','karnataka','680684','Robbery','2026-04-16','11:15:00.000000','pudukkad','pudhukkad','i seen an robbery','','','Normal',0,'Closed','KL-2026-0001','2026-04-16 07:45:15.232629','2026-04-24 12:02:56.181847',NULL,NULL,2),
(2,'jack','1234567891','abi@gmail.com','hacker city ','Thrissur','karnataka','680684','Assault','2026-04-16','09:24:00.000000','pudukkad','pudhukkad','assault hai hai hello iam here',NULL,NULL,'Normal',0,'Assigned','KL-2026-0002','2026-04-17 06:52:02.690117','2026-04-25 07:43:33.081020',NULL,1,2),
(3,'coder','1234567899','coder@gmail.com','hdhickbck','Thrissur','Kerala','680684','Accident','2026-04-23','09:59:00.000000','kodakara','kodakara','an bike hits a car hedhllrjflkflkmrf',NULL,'','Normal',0,'Closed','KL-2026-0003','2026-04-23 04:30:31.434396','2026-04-24 12:00:07.917678',NULL,NULL,6),
(4,'abi','1234567891','abi@gmail.com','hacker city','','Kerala','680684','Cyber Crime','2026-04-24','12:09:00.000000','pudukkad','pudhukkad','my phone hacked hdskjjnlck',NULL,NULL,'Normal',0,'Approved','KL-2026-0004','2026-04-25 07:40:42.417198','2026-04-25 07:46:02.181446',NULL,NULL,2);

/*Table structure for table `my_app_firtimeline` */

DROP TABLE IF EXISTS `my_app_firtimeline`;

CREATE TABLE `my_app_firtimeline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `note` longtext,
  `created_at` datetime(6) NOT NULL,
  `fir_id` int(11) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `my_app_firtimeline_fir_id_22ba60b6_fk_my_app_fir_id` (`fir_id`),
  KEY `my_app_firtimeline_updated_by_id_4c9d3aa6_fk_my_app_police_id` (`updated_by_id`),
  CONSTRAINT `my_app_firtimeline_fir_id_22ba60b6_fk_my_app_fir_id` FOREIGN KEY (`fir_id`) REFERENCES `my_app_fir` (`id`),
  CONSTRAINT `my_app_firtimeline_updated_by_id_4c9d3aa6_fk_my_app_police_id` FOREIGN KEY (`updated_by_id`) REFERENCES `my_app_police` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `my_app_firtimeline` */

insert  into `my_app_firtimeline`(`id`,`status`,`note`,`created_at`,`fir_id`,`updated_by_id`) values 
(1,'Approved','case approved','2026-04-16 07:49:02.906602',1,1),
(2,'Approved','Case approved by admin','2026-04-24 11:48:57.533049',2,NULL),
(3,'Closed','Case Closed by admin','2026-04-24 12:00:07.919677',3,NULL),
(4,'Closed','Case Closed by admin','2026-04-24 12:02:56.188207',1,NULL),
(5,'Assigned','Assigned to suman','2026-04-25 07:43:33.087079',2,1),
(6,'Approved','case approved','2026-04-25 07:46:02.191457',4,1);

/*Table structure for table `my_app_police` */

DROP TABLE IF EXISTS `my_app_police`;

CREATE TABLE `my_app_police` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `badge_id` varchar(20) DEFAULT NULL,
  `post` varchar(50) DEFAULT NULL,
  `station` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `badge_id` (`badge_id`),
  KEY `my_app_police_user_id_b67d25a9_fk_auth_user_id` (`user_id`),
  CONSTRAINT `my_app_police_user_id_b67d25a9_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `my_app_police` */

insert  into `my_app_police`(`id`,`name`,`email`,`phone`,`badge_id`,`post`,`station`,`district`,`status`,`password`,`created_at`,`user_id`) values 
(1,'suman','suman@gmail.com','9999888822','KP-2026-1023','SP','pudhukkad','Thrissur','Approved','suman','2026-04-16 07:46:50.665639',3),
(2,'biju','biju@gmail.com','1234567121',NULL,NULL,'kodakara','Thrissur','Approved','Biju@2004','2026-04-17 06:42:56.909181',5);

/*Table structure for table `my_app_register` */

DROP TABLE IF EXISTS `my_app_register`;

CREATE TABLE `my_app_register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `my_app_register_user_id_a4b41bbe_fk_auth_user_id` (`user_id`),
  CONSTRAINT `my_app_register_user_id_a4b41bbe_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `my_app_register` */

insert  into `my_app_register`(`id`,`name`,`email`,`phone`,`address`,`city`,`state`,`password`,`user_id`) values 
(1,'abi','abi@gmail.com','1234567891','hacker city ','bangloore','karnataka','abi',2),
(2,'coder nnc','coderA@gmail.com','1234567890','hai hello','ejfjfjfj','kekfiorjfijf','Codernnc@2004',4),
(3,'coder','coder@gmail.com','1234567899','hdhickbck','Thrissur','Kerala','Codernnc@2004',6);

/*Table structure for table `my_app_sos` */

DROP TABLE IF EXISTS `my_app_sos`;

CREATE TABLE `my_app_sos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `message` longtext,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `my_app_sos_status_id_e51aaff2_fk_my_app_sos_status_id` (`status_id`),
  CONSTRAINT `my_app_sos_status_id_e51aaff2_fk_my_app_sos_status_id` FOREIGN KEY (`status_id`) REFERENCES `my_app_sos_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `my_app_sos` */

insert  into `my_app_sos`(`id`,`name`,`phone`,`message`,`latitude`,`longitude`,`created_at`,`status_id`) values 
(1,'abijith','1209874367','jdihwkfjvenkjvkjbvkj','10.522633674248928','76.20292915922747','2026-04-23 04:59:55.149274',1),
(2,'dhyan','1209874367','jlkjvnmv','10.522571837124463','76.20294097178112','2026-04-23 05:01:50.650956',3),
(3,'ravi','1234567890','hhvfvkkjfvkjnvkjn','10.522633674248928','76.20292915922747','2026-04-23 05:05:53.697768',1),
(4,'rajeev','3344556677','hkjiigigigygugug','10.52250705643777','76.20296940665237','2026-04-23 05:12:08.141493',1),
(5,'dhyan','1234567890','jffknvkjvnkjvnkjvnkjnvjnfnlfn','10.52255997085318','76.20294058801386','2026-04-25 06:54:02.098792',1),
(6,'pavan','3344556677','feenvjkrnvinviriviinrijnvin','10.522517500000001','76.20293625','2026-04-25 07:07:09.920417',2);

/*Table structure for table `my_app_sos_status` */

DROP TABLE IF EXISTS `my_app_sos_status`;

CREATE TABLE `my_app_sos_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `my_app_sos_status` */

insert  into `my_app_sos_status`(`id`,`status`) values 
(1,'Approved'),
(2,'seen'),
(3,'on the  way');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

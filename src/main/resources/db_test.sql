/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.7.12-log : Database - db_test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_test` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_test`;

/*Table structure for table `t_depart` */

DROP TABLE IF EXISTS `t_depart`;

CREATE TABLE `t_depart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='部门表';

/*Data for the table `t_depart` */

insert  into `t_depart`(`id`,`name`) values (1,'管理部');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `password` varchar(128) NOT NULL,
  `depart_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_depart_id` (`depart_id`),
  CONSTRAINT `fk_depart_id` FOREIGN KEY (`depart_id`) REFERENCES `t_depart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户登录表';

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`username`,`password`,`depart_id`) values (1,'root','202cb962ac59075b964b07152d234b70',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

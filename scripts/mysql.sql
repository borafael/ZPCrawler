CREATE DATABASE zonaprop;

USE zonaprop;

CREATE TABLE `avisos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdatedOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `codigo` bigint(20) NOT NULL,
  `url` varchar(256) NOT NULL,
  `tipo` varchar(16) DEFAULT NULL,
  `barrio` varchar(128) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `supTotal` double DEFAULT NULL,
  `supCubierta` double DEFAULT NULL,
  `cantAmbientes` bigint(20) DEFAULT NULL,
  `cantDormitorios` bigint(20) DEFAULT NULL,
  `cantBanos` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2781 DEFAULT CHARSET=latin1

-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.27-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para instagram_clone
CREATE DATABASE IF NOT EXISTS `instagram_clone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `instagram_clone`;

-- Volcando estructura para tabla instagram_clone.coments
CREATE TABLE IF NOT EXISTS `coments` (
  `id_coment` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `comentario` text NOT NULL,
  PRIMARY KEY (`id_coment`),
  KEY `FK_likes_usuarios` (`id_usuario`),
  KEY `FK_likes_publicaciones` (`id_publicacion`),
  CONSTRAINT `FK_likes_publicaciones` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_likes_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.coments: ~0 rows (aproximadamente)
DELETE FROM `coments`;

-- Volcando estructura para tabla instagram_clone.historias
CREATE TABLE IF NOT EXISTS `historias` (
  `id_historia` int(11) NOT NULL AUTO_INCREMENT,
  `media_url` varchar(250) NOT NULL,
  `fecha_publicacion` datetime NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_historia`) USING BTREE,
  KEY `FK1_id_usuario` (`id_usuario`),
  CONSTRAINT `FK1_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.historias: ~5 rows (aproximadamente)
DELETE FROM `historias`;
INSERT INTO `historias` (`id_historia`, `media_url`, `fecha_publicacion`, `id_usuario`) VALUES
	(1, 'https://plus.unsplash.com/premium_photo-1710965560034-778eedc929ff?q=80&w=415&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-13 19:28:32', 6),
	(2, 'https://images.unsplash.com/photo-1710409054657-32ecc3c7dda0?q=80&w=435&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-13 12:00:00', 6),
	(3, 'https://plus.unsplash.com/premium_photo-1666264200737-acad542a92ff?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-13 13:00:00', 6),
	(4, 'https://images.unsplash.com/photo-1734961227421-ebbb6b0710ba?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-15 08:30:12', 3),
	(5, 'https://images.unsplash.com/photo-1702643337035-340c636d3b3c?q=80&w=327&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-15 23:11:28', 3);

-- Volcando estructura para tabla instagram_clone.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `id_like` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `cantidad_like` int(11) NOT NULL,
  PRIMARY KEY (`id_like`),
  KEY `FK_likes_usuarios` (`id_usuario`),
  KEY `FK_likes_publicaciones` (`id_publicacion`),
  CONSTRAINT `FK_likes_publicaciones` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_likes_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.likes: ~2 rows (aproximadamente)
DELETE FROM `likes`;
INSERT INTO `likes` (`id_like`, `id_usuario`, `id_publicacion`, `cantidad_like`) VALUES
	(1, 4, 2, 100),
	(2, 6, 1, 50);

-- Volcando estructura para tabla instagram_clone.notificaciones
CREATE TABLE IF NOT EXISTS `notificaciones` (
  `id_notificacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_notificacion`),
  KEY `FK3_id_usuario` (`id_usuario`),
  CONSTRAINT `FK3_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.notificaciones: ~0 rows (aproximadamente)
DELETE FROM `notificaciones`;

-- Volcando estructura para tabla instagram_clone.perfiles
CREATE TABLE IF NOT EXISTS `perfiles` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `foto` varchar(250) NOT NULL,
  `biografia` text NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_perfil`),
  KEY `FK_id_usuario` (`id_usuario`),
  CONSTRAINT `FK_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.perfiles: ~0 rows (aproximadamente)
DELETE FROM `perfiles`;
INSERT INTO `perfiles` (`id_perfil`, `foto`, `biografia`, `id_usuario`) VALUES
	(3, 'https://dus6dayednven.cloudfront.net/app/uploads/2022/05/1-DSC00855-Editar_baja.jpg', 'prueba de usuario', 6),
	(4, 'https://dus6dayednven.cloudfront.net/app/uploads/2022/05/1-DSC00855-Editar_baja.jpg', 'prueba de usuario', 4);

-- Volcando estructura para tabla instagram_clone.publicaciones
CREATE TABLE IF NOT EXISTS `publicaciones` (
  `id_publicacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL DEFAULT 0,
  `media_url` varchar(250) NOT NULL,
  `fecha_publicacion` datetime NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY (`id_publicacion`),
  KEY `FK2_id_usuario` (`id_usuario`),
  CONSTRAINT `FK2_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.publicaciones: ~2 rows (aproximadamente)
DELETE FROM `publicaciones`;
INSERT INTO `publicaciones` (`id_publicacion`, `id_usuario`, `media_url`, `fecha_publicacion`, `descripcion`) VALUES
	(1, 6, 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg', '2025-07-25 15:25:41', 'Primera foto de prueba'),
	(2, 4, 'https://wallpapers.com/images/featured/fotos-de-perfil-xj8jigxkai9jag4g.jpg', '2025-08-12 16:55:02', 'Segundo post, probando la galeria'),
	(4, 6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY5UaMxoNO_SNMkYtaLLF0jhli-AJvsG4PuA&s', '2025-08-15 23:53:13', 'Primera foto de prueba');

-- Volcando estructura para tabla instagram_clone.tipo_usuarios
CREATE TABLE IF NOT EXISTS `tipo_usuarios` (
  `id_tipo_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.tipo_usuarios: ~3 rows (aproximadamente)
DELETE FROM `tipo_usuarios`;
INSERT INTO `tipo_usuarios` (`id_tipo_usuario`, `tipo_usuario`) VALUES
	(1, 'Usuario'),
	(2, 'Telefono'),
	(3, 'Correo Electronico');

-- Volcando estructura para tabla instagram_clone.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `telefono_o_correo` varchar(50) NOT NULL DEFAULT '0',
  `contrasena` varchar(100) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  PRIMARY KEY (`id_usuario`) USING BTREE,
  KEY `FK1_id_tipo_usuario` (`id_tipo_usuario`),
  CONSTRAINT `FK1_id_tipo_usuario` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipo_usuarios` (`id_tipo_usuario`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.usuarios: ~4 rows (aproximadamente)
DELETE FROM `usuarios`;
INSERT INTO `usuarios` (`id_usuario`, `telefono_o_correo`, `contrasena`, `nombre_completo`, `usuario`, `id_tipo_usuario`, `fecha_nacimiento`) VALUES
	(3, '2147483647', '$2y$10$NkoNxRNG3qbKoD9LtB9AB.AdE3Wiepvmwfk77pl5l6E0lEkr4Pgba', 'prueba uno', 'prueba', 1, '2025-08-03'),
	(4, '21474836477', '$2y$10$l1gMu8FmxFxY05z8QLKT9u.2tqai7/xB0OKfEpw58JAAoFcn3y4NS', 'adriana', 'adrti', 1, '1990-05-12'),
	(5, '7418529630', '$2y$10$4JZcbtKkhiZ7QeKUNfrUruqdy5B6lDDYY3TbZZk9Jx5vAORMr/dBS', 'cvbn', ' gh', 1, '2007-09-08'),
	(6, '3178848595', '$2y$10$nPw91iFqEP3XVV.gX9lwJetOEVJ1QWrYIiEqNYPP8G7fHoYOknvp2', 'usuario', 'usuario123', 1, '1955-03-15');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

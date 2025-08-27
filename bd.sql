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
  `id_coment` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `comentario` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.coments: ~0 rows (aproximadamente)

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
INSERT IGNORE INTO `historias` (`id_historia`, `media_url`, `fecha_publicacion`, `id_usuario`) VALUES
	(1, 'https://plus.unsplash.com/premium_photo-1710965560034-778eedc929ff?q=80&w=415&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-13 19:28:32', 6),
	(2, 'https://images.unsplash.com/photo-1710409054657-32ecc3c7dda0?q=80&w=435&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-13 12:00:00', 4),
	(3, 'https://plus.unsplash.com/premium_photo-1666264200737-acad542a92ff?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-13 13:00:00', 5),
	(4, 'https://images.unsplash.com/photo-1734961227421-ebbb6b0710ba?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-15 08:30:12', 3),
	(5, 'https://images.unsplash.com/photo-1702643337035-340c636d3b3c?q=80&w=327&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2025-08-15 23:11:28', 3);

-- Volcando estructura para tabla instagram_clone.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `id_like` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_usuario_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  PRIMARY KEY (`id_like`),
  KEY `FK_likes_usuarios` (`id_usuario`),
  KEY `FK_likes_publicaciones` (`id_publicacion`),
  KEY `FK_likes_usuarios_2` (`id_usuario_like`),
  CONSTRAINT `FK_likes_publicaciones` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_likes_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_likes_usuarios_2` FOREIGN KEY (`id_usuario_like`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.likes: ~3 rows (aproximadamente)
INSERT IGNORE INTO `likes` (`id_like`, `id_usuario`, `id_usuario_like`, `id_publicacion`) VALUES
	(1, 4, 3, 2),
	(2, 4, 4, 2),
	(3, 6, 3, 1);

-- Volcando estructura para tabla instagram_clone.notificaciones
CREATE TABLE IF NOT EXISTS `notificaciones` (
  `id_notificacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_notificacion`),
  KEY `FK3_id_usuario` (`id_usuario`),
  CONSTRAINT `FK3_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.notificaciones: ~0 rows (aproximadamente)

-- Volcando estructura para tabla instagram_clone.perfiles
CREATE TABLE IF NOT EXISTS `perfiles` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `foto` varchar(250) NOT NULL,
  `biografia` text NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_perfil`),
  KEY `FK_id_usuario` (`id_usuario`),
  CONSTRAINT `FK_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.perfiles: ~4 rows (aproximadamente)
INSERT IGNORE INTO `perfiles` (`id_perfil`, `foto`, `biografia`, `id_usuario`) VALUES
	(3, 'https://i.pinimg.com/736x/b2/c4/8d/b2c48d04aea1c00b361652d20d09867c.jpg', 'prueba de usuario', 6),
	(4, 'https://wallpapers.com/images/featured/fotos-de-perfil-xj8jigxkai9jag4g.jpg', 'prueba de usuario', 4),
	(5, 'https://i.pinimg.com/474x/5a/ac/51/5aac5164e1aa4a6e181aeb9b78a45483.jpg', 'prueba de usuario', 5),
	(6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY5UaMxoNO_SNMkYtaLLF0jhli-AJvsG4PuA&s', 'prueba de usuario', 3);

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.publicaciones: ~8 rows (aproximadamente)
INSERT IGNORE INTO `publicaciones` (`id_publicacion`, `id_usuario`, `media_url`, `fecha_publicacion`, `descripcion`) VALUES
	(1, 6, 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg', '2025-07-25 15:25:41', 'Primera foto de prueba'),
	(2, 4, 'https://wallpapers.com/images/featured/fotos-de-perfil-xj8jigxkai9jag4g.jpg', '2025-08-12 16:55:02', 'Segundo post, probando la galeria'),
	(4, 6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY5UaMxoNO_SNMkYtaLLF0jhli-AJvsG4PuA&s', '2025-08-15 23:53:13', 'Primera foto de prueba'),
	(5, 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_kjfNG3NG9UJwg_EDki3WLtG7k0Nhm-kMVg&s', '2025-08-22 12:51:32', 'Querer ser alguien que no seas tu mismo es un desperdicio de lo que eres.'),
	(6, 4, 'https://i.pinimg.com/474x/5a/ac/51/5aac5164e1aa4a6e181aeb9b78a45483.jpg', '2025-08-01 15:27:11', 'Solo una persona puede cambiar tu vida: tu '),
	(7, 6, 'https://i.pinimg.com/736x/b2/c4/8d/b2c48d04aea1c00b361652d20d09867c.jpg', '2025-08-06 12:13:00', 'No busques ser una persona de exito, sino alguien de valor.'),
	(8, 6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQavHQ2zk1xqZQdORn0-OjFkwlKTCVKqFPwvw&s', '2025-06-12 11:22:23', 'Sabes que eres feliz cuando no quieres dormir, porque la realidad finalmente es mejor que tus suenos'),
	(9, 3, 'https://www.blogdelfotografo.com/wp-content/uploads/2022/01/silueta-atardecer-foto-perfil.webp', '2025-08-11 14:58:22', 'Algunas personas necesitan abrir sus pequenas mentes en lugar de sus grandes bocas.');

-- Volcando estructura para tabla instagram_clone.tipo_usuarios
CREATE TABLE IF NOT EXISTS `tipo_usuarios` (
  `id_tipo_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_tipo_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.tipo_usuarios: ~3 rows (aproximadamente)
INSERT IGNORE INTO `tipo_usuarios` (`id_tipo_usuario`, `tipo_usuario`) VALUES
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
INSERT IGNORE INTO `usuarios` (`id_usuario`, `telefono_o_correo`, `contrasena`, `nombre_completo`, `usuario`, `id_tipo_usuario`, `fecha_nacimiento`) VALUES
	(3, '2147483647', '$2y$10$NkoNxRNG3qbKoD9LtB9AB.AdE3Wiepvmwfk77pl5l6E0lEkr4Pgba', 'valentina maestre', 'valentinamm', 1, '2025-08-03'),
	(4, '21474836477', '$2y$10$l1gMu8FmxFxY05z8QLKT9u.2tqai7/xB0OKfEpw58JAAoFcn3y4NS', 'wilson Sanchez', 'wilsonsanchez', 1, '1990-05-12'),
	(5, '7418529630', '$2y$10$4JZcbtKkhiZ7QeKUNfrUruqdy5B6lDDYY3TbZZk9Jx5vAORMr/dBS', 'andrea gonzales', 'andreago', 1, '2007-09-08'),
	(6, '3178848595', '$2y$10$nPw91iFqEP3XVV.gX9lwJetOEVJ1QWrYIiEqNYPP8G7fHoYOknvp2', 'adriana ortiz', 'alop', 1, '1955-03-15');

-- Volcando estructura para tabla instagram_clone.usuarios_seguidos
CREATE TABLE IF NOT EXISTS `usuarios_seguidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_usuario_seguido` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `Índice 4` (`id_usuario`,`id_usuario_seguido`),
  KEY `FK_usuarios_seguidos_usuarios_2` (`id_usuario_seguido`),
  CONSTRAINT `FK_usuarios_seguidos_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_usuarios_seguidos_usuarios_2` FOREIGN KEY (`id_usuario_seguido`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla instagram_clone.usuarios_seguidos: ~3 rows (aproximadamente)
INSERT IGNORE INTO `usuarios_seguidos` (`id`, `id_usuario`, `id_usuario_seguido`) VALUES
	(3, 6, 3),
	(4, 6, 4),
	(6, 6, 5);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

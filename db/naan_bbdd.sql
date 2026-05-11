-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 09-05-2026 a las 21:07:32
-- Versión del servidor: 8.0.44
-- Versión de PHP: 8.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `naan_bbdd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `id_auditoria` int NOT NULL,
  `tabla_afectada` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_registro` int DEFAULT NULL,
  `operacion` enum('INSERT','UPDATE','DELETE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datos_anteriores` json DEFAULT NULL,
  `datos_nuevos` json DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `auditoria`
--

INSERT INTO `auditoria` (`id_auditoria`, `tabla_afectada`, `id_registro`, `operacion`, `datos_anteriores`, `datos_nuevos`, `fecha`) VALUES
(1, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-02-28 16:40:57'),
(2, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-04 15:40:02'),
(3, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-04 15:40:23'),
(4, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-04 15:40:35'),
(5, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-04 15:40:36'),
(6, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-04 15:40:41'),
(7, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-04 15:41:27'),
(8, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-04 15:41:58'),
(9, 'Categoria', 1, 'UPDATE', '{\"nombre\": \"Ropa\", \"descripcion\": \"Ropa de todo tipo\"}', '{\"nombre\": \"Guayaberas Editado\", \"descripcion\": \"Ropa de todo tipo\"}', '2026-03-04 15:47:15'),
(10, 'Categoria', 1, 'UPDATE', '{\"nombre\": \"Guayaberas Editado\", \"descripcion\": \"Ropa de todo tipo\"}', '{\"nombre\": \"Ropa\", \"descripcion\": \"Ropa de todo tipo\"}', '2026-03-04 15:47:30'),
(11, 'Categoria', 2, 'UPDATE', '{\"nombre\": \"Guayaberas\", \"descripcion\": \"Ropa presidencial de Mexico\"}', '{\"nombre\": \"Guayabera Editado\", \"descripcion\": \"Ropa presidencial de Mexico\"}', '2026-03-04 15:47:39'),
(12, 'Pedido', 1, 'UPDATE', '{\"total\": 0.0, \"estado\": \"pendiente\"}', '{\"total\": 0.0, \"estado\": \"pagado\"}', '2026-03-04 16:07:28'),
(13, 'Pedido', 1, 'UPDATE', '{\"total\": 0.0, \"estado\": \"pagado\"}', '{\"total\": 0.0, \"estado\": \"enviado\"}', '2026-03-04 16:07:35'),
(14, 'Pedido', 1, 'UPDATE', '{\"total\": 0.0, \"estado\": \"enviado\"}', '{\"total\": 0.0, \"estado\": \"cancelado\"}', '2026-03-04 16:07:47'),
(15, 'Pedido', 1, 'UPDATE', '{\"total\": 0.0, \"estado\": \"cancelado\"}', '{\"total\": 39.98, \"estado\": \"cancelado\"}', '2026-03-04 16:38:18'),
(16, 'Pedido', 1, 'UPDATE', '{\"total\": 39.98, \"estado\": \"cancelado\"}', '{\"total\": 0.0, \"estado\": \"cancelado\"}', '2026-03-04 16:38:45'),
(17, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 11:47:41'),
(18, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:02:33'),
(19, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:02:35'),
(20, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:02:36'),
(21, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:02:37'),
(22, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:02:38'),
(23, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:02:38'),
(24, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:02:39'),
(25, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:02:40'),
(26, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:02:41'),
(27, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:02:41'),
(28, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:02:43'),
(29, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:02:49'),
(30, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:02:50'),
(31, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:04:54'),
(32, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:04:55'),
(33, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:04:57'),
(34, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:04:57'),
(35, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:04:58'),
(36, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:04:59'),
(37, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:05:00'),
(38, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:05:01'),
(39, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:05:02'),
(40, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:05:02'),
(41, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:10:38'),
(42, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:13:05'),
(43, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:13:06'),
(44, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:13:08'),
(45, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:13:09'),
(46, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:13:09'),
(47, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:13:10'),
(48, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:13:11'),
(49, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:13:11'),
(50, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:13:16'),
(51, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:13:28'),
(52, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:14:25'),
(53, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:20:06'),
(54, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:20:07'),
(55, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:20:08'),
(56, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:20:08'),
(57, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:20:09'),
(58, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:20:10'),
(59, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:21:37'),
(60, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:21:38'),
(61, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:21:38'),
(62, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:24:00'),
(63, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:24:03'),
(64, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:24:05'),
(65, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:24:07'),
(66, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:24:11'),
(67, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:24:18'),
(68, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:24:22'),
(69, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:24:41'),
(70, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:24:46'),
(71, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:24:48'),
(72, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:24:50'),
(73, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:24:54'),
(74, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:24:55'),
(75, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:24:56'),
(76, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:24:57'),
(77, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:26:51'),
(78, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:26:53'),
(79, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:26:55'),
(80, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:26:56'),
(81, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:26:59'),
(82, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:27:03'),
(83, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:27:04'),
(84, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:28:09'),
(85, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:31:36'),
(86, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:31:40'),
(87, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:31:42'),
(88, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:31:42'),
(89, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:31:43'),
(90, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:31:44'),
(91, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:31:53'),
(92, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:31:54'),
(93, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:31:55'),
(94, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:31:56'),
(95, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:32:00'),
(96, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:34:41'),
(97, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:34:46'),
(98, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:35:24'),
(99, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:36:05'),
(100, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:36:07'),
(101, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:36:13'),
(102, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:36:15'),
(103, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:36:16'),
(104, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:36:17'),
(105, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:36:18'),
(106, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:38:56'),
(107, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:38:59'),
(108, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:39:00'),
(109, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:39:01'),
(110, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:39:06'),
(111, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:39:08'),
(112, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:39:09'),
(113, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:39:10'),
(114, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:40:12'),
(115, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:40:13'),
(116, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:40:14'),
(117, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:40:15'),
(118, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:40:27'),
(119, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:40:28'),
(120, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:40:29'),
(121, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:40:29'),
(122, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:41:31'),
(123, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:41:32'),
(124, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:41:33'),
(125, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:41:39'),
(126, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:41:40'),
(127, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:41:42'),
(128, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:45:02'),
(129, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:45:03'),
(130, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:45:04'),
(131, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:45:06'),
(132, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:45:07'),
(133, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:45:08'),
(134, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:46:43'),
(135, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:46:45'),
(136, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:46:47'),
(137, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:47:30'),
(138, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:47:32'),
(139, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:47:33'),
(140, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:48:45'),
(141, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:48:50'),
(142, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-16 12:48:51'),
(143, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:48:51'),
(144, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 12:48:53'),
(145, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:50:26'),
(146, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:51:04'),
(147, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-16 12:51:05'),
(148, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 12:51:06'),
(149, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 13:16:12'),
(150, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-16 16:25:03'),
(151, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 16:25:05'),
(152, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-16 20:56:19'),
(153, 'Producto', 4, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:39:18'),
(154, 'Producto', 1, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:39:34'),
(155, 'Producto', 1, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:39:54'),
(156, 'Producto', 1, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:39:56'),
(157, 'Producto', 1, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:39:57'),
(158, 'Producto', 1, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:39:58'),
(159, 'Producto', 1, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:39:59'),
(160, 'Producto', 1, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:40:39'),
(161, 'Producto', 1, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:40:40'),
(162, 'Producto', 1, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:40:43'),
(163, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:43:01'),
(164, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:43:02'),
(165, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:43:07'),
(166, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:43:34'),
(167, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:43:59'),
(168, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:44:15'),
(169, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:44:17'),
(170, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:46:46'),
(171, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:46:50'),
(172, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:46:51'),
(173, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:46:52'),
(174, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:47:00'),
(175, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:47:05'),
(176, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:47:14'),
(177, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:47:17'),
(178, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:47:20'),
(179, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:47:25'),
(180, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:47:38'),
(181, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:48:18'),
(182, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-17 10:50:14'),
(183, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:55:27'),
(184, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:56:47'),
(185, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 10:57:24'),
(186, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 10:59:42'),
(187, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:01:47'),
(188, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:01:50'),
(189, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:01:56'),
(190, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:01:59'),
(191, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:02:01'),
(192, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:02:20'),
(193, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:02:55'),
(194, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:02:57'),
(195, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:02:58'),
(196, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:05:44'),
(197, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:05:46'),
(198, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-17 11:05:48'),
(199, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:05:53'),
(200, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-17 11:05:55'),
(201, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:05:58'),
(202, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:06:02'),
(203, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:06:25'),
(204, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-03-17 11:07:10'),
(205, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:13:34'),
(206, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:13:42'),
(207, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:15:38'),
(208, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:17:13'),
(209, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:17:50'),
(210, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:18:04'),
(211, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:18:09'),
(212, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:18:14'),
(213, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:19:52'),
(214, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:20:53'),
(215, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-03-17 11:20:58'),
(216, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:21:07'),
(217, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:22:01'),
(218, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:22:01'),
(219, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:55:33'),
(220, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:55:35'),
(221, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:55:37'),
(222, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 11:55:42'),
(223, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:59:42'),
(224, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 11:59:46'),
(225, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 12:01:48'),
(226, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 12:02:26'),
(227, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 12:02:32'),
(228, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 12:02:49'),
(229, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 12:02:54'),
(230, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 12:04:42'),
(231, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-17 12:04:55'),
(232, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-17 12:04:57'),
(233, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-18 10:59:16'),
(234, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-03-18 10:59:24'),
(235, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-03-18 11:02:41'),
(236, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-03-18 17:31:43'),
(237, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-03-24 12:06:36'),
(238, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-03-24 12:06:48'),
(239, 'Categoria', 1, 'UPDATE', '{\"nombre\": \"Ropa\", \"descripcion\": \"Ropa de todo tipo\"}', '{\"nombre\": \"Ropa editada\", \"descripcion\": \"Ropa de todo tipo\"}', '2026-03-25 11:21:44'),
(240, 'Pedido', 2, 'UPDATE', '{\"total\": 0.0, \"estado\": \"pendiente\"}', '{\"total\": 0.0, \"estado\": \"pagado\"}', '2026-03-25 16:20:44'),
(241, 'Pedido', 2, 'UPDATE', '{\"total\": 0.0, \"estado\": \"pagado\"}', '{\"total\": 0.0, \"estado\": \"enviado\"}', '2026-03-25 16:20:53'),
(242, 'Pedido', 2, 'UPDATE', '{\"total\": 0.0, \"estado\": \"enviado\"}', '{\"total\": 0.0, \"estado\": \"entregado\"}', '2026-03-25 16:20:58'),
(243, 'Pedido', 3, 'UPDATE', '{\"total\": 0.0, \"estado\": \"pendiente\"}', '{\"total\": 0.0, \"estado\": \"cancelado\"}', '2026-03-25 16:28:35'),
(244, 'Categoria', 1, 'UPDATE', '{\"nombre\": \"Ropa editada\", \"descripcion\": \"Ropa de todo tipo\"}', '{\"nombre\": \"Ropa editada\", \"descripcion\": \"Ropa de todo tipo editado\"}', '2026-03-25 19:43:06'),
(245, 'Pedido', 4, 'UPDATE', '{\"total\": 0.0, \"estado\": \"pendiente\"}', '{\"total\": 0.0, \"estado\": \"pendiente\"}', '2026-04-08 21:24:14'),
(246, 'Pedido', 4, 'UPDATE', '{\"total\": 0.0, \"estado\": \"pendiente\"}', '{\"total\": 0.0, \"estado\": \"pendiente\"}', '2026-04-08 21:31:13'),
(247, 'Pedido', 4, 'UPDATE', '{\"total\": 0.0, \"estado\": \"pendiente\"}', '{\"total\": 24.0, \"estado\": \"pendiente\"}', '2026-04-08 21:34:55'),
(248, 'Pedido', 4, 'UPDATE', '{\"total\": 24.0, \"estado\": \"pendiente\"}', '{\"total\": 43.99, \"estado\": \"pendiente\"}', '2026-04-08 21:34:55'),
(249, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.0}', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.0}', '2026-04-09 18:26:02'),
(250, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.0}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.0}', '2026-04-09 18:26:09'),
(251, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.0}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.0}', '2026-04-09 18:26:30'),
(252, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.0}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.0}', '2026-04-09 18:26:33'),
(253, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.0}', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.0}', '2026-04-09 18:26:40'),
(254, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.0}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.0}', '2026-04-09 18:26:47'),
(255, 'Producto', 54, 'UPDATE', '{\"stock\": 13, \"activo\": 1, \"precio\": 18.99}', '{\"stock\": 13, \"activo\": 1, \"precio\": 18.99}', '2026-04-09 20:21:44'),
(256, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-04-11 22:49:24'),
(257, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-04-11 22:49:36'),
(258, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-04-11 22:50:07'),
(259, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '2026-04-11 22:50:11'),
(260, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-04-11 22:50:14'),
(261, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-04-11 22:50:18'),
(262, 'Producto', 40, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 18.50}', '{\"stock\": 25, \"activo\": 1, \"precio\": 18.50}', '2026-04-11 22:50:23'),
(263, 'Producto', 54, 'UPDATE', '{\"stock\": 13, \"activo\": 1, \"precio\": 18.99}', '{\"stock\": 13, \"activo\": 1, \"precio\": 18.99}', '2026-04-11 22:50:26'),
(264, 'Producto', 55, 'UPDATE', '{\"stock\": 16, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 16, \"activo\": 1, \"precio\": 24.99}', '2026-04-11 22:50:29'),
(265, 'Producto', 9, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-04-11 22:50:32'),
(266, 'Producto', 10, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-04-11 22:50:35'),
(267, 'Producto', 56, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 31.99}', '{\"stock\": 11, \"activo\": 1, \"precio\": 31.99}', '2026-04-11 22:50:39'),
(268, 'Producto', 57, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 27.50}', '{\"stock\": 12, \"activo\": 1, \"precio\": 27.50}', '2026-04-11 22:50:42'),
(269, 'Producto', 58, 'UPDATE', '{\"stock\": 7, \"activo\": 1, \"precio\": 89.99}', '{\"stock\": 7, \"activo\": 1, \"precio\": 89.99}', '2026-04-11 22:50:44'),
(270, 'Producto', 59, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 55.00}', '{\"stock\": 15, \"activo\": 1, \"precio\": 55.00}', '2026-04-11 22:50:47'),
(271, 'Producto', 60, 'UPDATE', '{\"stock\": 19, \"activo\": 1, \"precio\": 13.99}', '{\"stock\": 19, \"activo\": 1, \"precio\": 13.99}', '2026-04-11 22:50:50'),
(272, 'Producto', 61, 'UPDATE', '{\"stock\": 17, \"activo\": 1, \"precio\": 23.99}', '{\"stock\": 17, \"activo\": 1, \"precio\": 23.99}', '2026-04-11 22:50:52'),
(273, 'Producto', 63, 'UPDATE', '{\"stock\": 8, \"activo\": 1, \"precio\": 37.00}', '{\"stock\": 8, \"activo\": 1, \"precio\": 37.00}', '2026-04-11 22:50:55'),
(274, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '2026-04-12 00:18:56'),
(275, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '2026-04-12 00:40:41'),
(276, 'Pedido', 6, 'UPDATE', '{\"total\": 22.74, \"estado\": \"pendiente\"}', '{\"total\": 16.75, \"estado\": \"pendiente\"}', '2026-04-15 16:09:05'),
(277, 'Pedido', 7, 'UPDATE', '{\"total\": 56.23, \"estado\": \"pendiente\"}', '{\"total\": 16.75, \"estado\": \"pendiente\"}', '2026-04-15 16:18:31'),
(278, 'Pedido', 7, 'UPDATE', '{\"total\": 16.75, \"estado\": \"pendiente\"}', '{\"total\": 35.25, \"estado\": \"pendiente\"}', '2026-04-15 16:18:32'),
(279, 'Pedido', 7, 'UPDATE', '{\"total\": 35.25, \"estado\": \"pendiente\"}', '{\"total\": 50.24, \"estado\": \"pendiente\"}', '2026-04-15 16:18:33'),
(280, 'Pedido', 8, 'UPDATE', '{\"total\": 175.71, \"estado\": \"pendiente\"}', '{\"total\": 49.98, \"estado\": \"pendiente\"}', '2026-04-18 19:18:01'),
(281, 'Pedido', 8, 'UPDATE', '{\"total\": 49.98, \"estado\": \"pendiente\"}', '{\"total\": 86.98, \"estado\": \"pendiente\"}', '2026-04-18 19:18:02'),
(282, 'Pedido', 8, 'UPDATE', '{\"total\": 86.98, \"estado\": \"pendiente\"}', '{\"total\": 137.23, \"estado\": \"pendiente\"}', '2026-04-18 19:18:03'),
(283, 'Pedido', 8, 'UPDATE', '{\"total\": 137.23, \"estado\": \"pendiente\"}', '{\"total\": 155.73, \"estado\": \"pendiente\"}', '2026-04-18 19:18:04'),
(284, 'Pedido', 8, 'UPDATE', '{\"total\": 155.73, \"estado\": \"pendiente\"}', '{\"total\": 169.72, \"estado\": \"pendiente\"}', '2026-04-18 19:18:05'),
(285, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-04-29 19:11:18'),
(286, 'Pedido', 9, 'UPDATE', '{\"total\": 95.98, \"estado\": \"pagado\"}', '{\"total\": 89.99, \"estado\": \"pagado\"}', '2026-04-29 19:17:56'),
(287, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-04-30 20:00:46'),
(288, 'Producto', 67, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 22.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 22.99}', '2026-04-30 20:15:39'),
(289, 'Producto', 73, 'UPDATE', '{\"stock\": 10, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 10, \"activo\": 1, \"precio\": 24.99}', '2026-04-30 20:20:59'),
(290, 'Producto', 85, 'UPDATE', '{\"stock\": 17, \"activo\": 1, \"precio\": 18.50}', '{\"stock\": 17, \"activo\": 1, \"precio\": 18.50}', '2026-04-30 20:21:04'),
(291, 'Producto', 88, 'UPDATE', '{\"stock\": 13, \"activo\": 1, \"precio\": 21.50}', '{\"stock\": 13, \"activo\": 1, \"precio\": 21.50}', '2026-04-30 20:21:09'),
(292, 'Producto', 87, 'UPDATE', '{\"stock\": 24, \"activo\": 1, \"precio\": 16.75}', '{\"stock\": 24, \"activo\": 1, \"precio\": 16.75}', '2026-04-30 20:21:12'),
(293, 'Producto', 79, 'UPDATE', '{\"stock\": 19, \"activo\": 1, \"precio\": 18.50}', '{\"stock\": 19, \"activo\": 1, \"precio\": 18.50}', '2026-04-30 20:21:16'),
(294, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-04-30 23:03:10'),
(295, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-04-30 23:03:59'),
(296, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-04-30 23:04:04'),
(297, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-04-30 23:04:07'),
(298, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '2026-04-30 23:04:11'),
(299, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-04-30 23:48:02'),
(300, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-04-30 23:51:05'),
(301, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '2026-05-02 18:26:41'),
(302, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '2026-05-02 18:27:03'),
(303, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '2026-05-02 18:27:24'),
(304, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '2026-05-02 18:27:35'),
(305, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '2026-05-02 18:27:48'),
(306, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '2026-05-02 18:27:53'),
(307, 'Categoria', 1, 'UPDATE', '{\"nombre\": \"Ropa editada\", \"descripcion\": \"Ropa de todo tipo editado\"}', '{\"nombre\": \"Camisetas\", \"descripcion\": \"Ropa de todo tipo editado\"}', '2026-05-03 18:15:14'),
(308, 'Categoria', 2, 'UPDATE', '{\"nombre\": \"Guayabera Editado\", \"descripcion\": \"Ropa presidencial de Mexico\"}', '{\"nombre\": \"Pantalones\", \"descripcion\": \"Ropa presidencial de Mexico\"}', '2026-05-03 18:15:21'),
(309, 'Categoria', 5, 'UPDATE', '{\"nombre\": \"Camisetas\", \"descripcion\": null}', '{\"nombre\": \"Shorts\", \"descripcion\": null}', '2026-05-03 18:15:44'),
(310, 'Categoria', 6, 'UPDATE', '{\"nombre\": \"Pantalones\", \"descripcion\": null}', '{\"nombre\": \"\", \"descripcion\": null}', '2026-05-03 18:15:57'),
(311, 'Categoria', 5, 'UPDATE', '{\"nombre\": \"Shorts\", \"descripcion\": null}', '{\"nombre\": \"Pantalones\", \"descripcion\": null}', '2026-05-03 18:16:05'),
(312, 'Categoria', 2, 'UPDATE', '{\"nombre\": \"Pantalones\", \"descripcion\": \"Ropa presidencial de Mexico\"}', '{\"nombre\": \"Chaquetas\", \"descripcion\": \"Ropa presidencial de Mexico\"}', '2026-05-03 18:16:11'),
(313, 'Categoria', 6, 'UPDATE', '{\"nombre\": \"\", \"descripcion\": null}', '{\"nombre\": \"Shorts\", \"descripcion\": null}', '2026-05-03 18:16:16');
INSERT INTO `auditoria` (`id_auditoria`, `tabla_afectada`, `id_registro`, `operacion`, `datos_anteriores`, `datos_nuevos`, `fecha`) VALUES
(314, 'Categoria', 7, 'UPDATE', '{\"nombre\": \"Ropa mujer\", \"descripcion\": null}', '{\"nombre\": \"Calzado\", \"descripcion\": null}', '2026-05-03 18:16:22'),
(315, 'Categoria', 1, 'UPDATE', '{\"nombre\": \"Camisetas\", \"descripcion\": \"Ropa de todo tipo editado\"}', '{\"nombre\": \"Camisetas\", \"descripcion\": \"Camisetas, parte de arriba\"}', '2026-05-03 18:17:10'),
(316, 'Categoria', 2, 'UPDATE', '{\"nombre\": \"Chaquetas\", \"descripcion\": \"Ropa presidencial de Mexico\"}', '{\"nombre\": \"Chaquetas\", \"descripcion\": \"Prendas de abrigo finas\"}', '2026-05-03 18:17:18'),
(317, 'Categoria', 5, 'UPDATE', '{\"nombre\": \"Pantalones\", \"descripcion\": null}', '{\"nombre\": \"Pantalones\", \"descripcion\": \"Pantalones de todo tipo\"}', '2026-05-03 18:17:24'),
(318, 'Categoria', 6, 'UPDATE', '{\"nombre\": \"Shorts\", \"descripcion\": null}', '{\"nombre\": \"Shorts\", \"descripcion\": \"Pantalones cortos\"}', '2026-05-03 18:17:29'),
(319, 'Categoria', 7, 'UPDATE', '{\"nombre\": \"Calzado\", \"descripcion\": null}', '{\"nombre\": \"Calzado\", \"descripcion\": \"Calzado para los pies\"}', '2026-05-03 18:17:35'),
(320, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:25:28'),
(321, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:25:36'),
(322, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-05-03 18:25:43'),
(323, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:26:05'),
(324, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 0, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:26:20'),
(325, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:27:08'),
(326, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:27:27'),
(327, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:27:30'),
(328, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-05-03 18:27:33'),
(329, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:27:36'),
(330, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:28:35'),
(331, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:28:35'),
(332, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-05-03 18:28:35'),
(333, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:28:35'),
(334, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:28:35'),
(335, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '2026-05-03 18:28:35'),
(336, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-03 18:28:35'),
(337, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:28:35'),
(338, 'Producto', 9, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-03 18:28:35'),
(339, 'Producto', 10, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:28:35'),
(340, 'Producto', 40, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 18.50}', '{\"stock\": 25, \"activo\": 1, \"precio\": 18.50}', '2026-05-03 18:28:35'),
(341, 'Producto', 54, 'UPDATE', '{\"stock\": 13, \"activo\": 1, \"precio\": 18.99}', '{\"stock\": 13, \"activo\": 1, \"precio\": 18.99}', '2026-05-03 18:28:35'),
(342, 'Producto', 55, 'UPDATE', '{\"stock\": 16, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 16, \"activo\": 1, \"precio\": 24.99}', '2026-05-03 18:28:35'),
(343, 'Producto', 56, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 31.99}', '{\"stock\": 11, \"activo\": 1, \"precio\": 31.99}', '2026-05-03 18:28:35'),
(344, 'Producto', 57, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 27.50}', '{\"stock\": 12, \"activo\": 1, \"precio\": 27.50}', '2026-05-03 18:28:35'),
(345, 'Producto', 58, 'UPDATE', '{\"stock\": 7, \"activo\": 1, \"precio\": 89.99}', '{\"stock\": 7, \"activo\": 1, \"precio\": 89.99}', '2026-05-03 18:28:35'),
(346, 'Producto', 59, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 55.00}', '{\"stock\": 15, \"activo\": 1, \"precio\": 55.00}', '2026-05-03 18:28:35'),
(347, 'Producto', 60, 'UPDATE', '{\"stock\": 19, \"activo\": 1, \"precio\": 13.99}', '{\"stock\": 19, \"activo\": 1, \"precio\": 13.99}', '2026-05-03 18:28:35'),
(348, 'Producto', 63, 'UPDATE', '{\"stock\": 8, \"activo\": 1, \"precio\": 37.00}', '{\"stock\": 8, \"activo\": 1, \"precio\": 37.00}', '2026-05-03 18:28:35'),
(349, 'Producto', 64, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 14.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 14.99}', '2026-05-03 18:28:35'),
(350, 'Producto', 65, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 17.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 17.99}', '2026-05-03 18:28:35'),
(351, 'Producto', 66, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 19.99}', '2026-05-03 18:28:35'),
(352, 'Producto', 67, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 22.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 22.99}', '2026-05-03 18:28:35'),
(353, 'Producto', 68, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 16.50}', '{\"stock\": 40, \"activo\": 1, \"precio\": 16.50}', '2026-05-03 18:28:35'),
(354, 'Producto', 69, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 18.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 18.99}', '2026-05-03 18:28:35'),
(355, 'Producto', 70, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 15.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 15.99}', '2026-05-03 18:28:35'),
(356, 'Producto', 71, 'UPDATE', '{\"stock\": 18, \"activo\": 1, \"precio\": 17.50}', '{\"stock\": 18, \"activo\": 1, \"precio\": 17.50}', '2026-05-03 18:28:35'),
(357, 'Producto', 72, 'UPDATE', '{\"stock\": 60, \"activo\": 1, \"precio\": 13.99}', '{\"stock\": 60, \"activo\": 1, \"precio\": 13.99}', '2026-05-03 18:28:35'),
(358, 'Producto', 73, 'UPDATE', '{\"stock\": 10, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 10, \"activo\": 1, \"precio\": 24.99}', '2026-05-03 18:28:35'),
(359, 'Producto', 74, 'UPDATE', '{\"stock\": 22, \"activo\": 1, \"precio\": 19.50}', '{\"stock\": 22, \"activo\": 1, \"precio\": 19.50}', '2026-05-03 18:28:35'),
(360, 'Producto', 75, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 21.99}', '{\"stock\": 12, \"activo\": 1, \"precio\": 21.99}', '2026-05-03 18:28:35'),
(361, 'Producto', 76, 'UPDATE', '{\"stock\": 8, \"activo\": 1, \"precio\": 26.99}', '{\"stock\": 8, \"activo\": 1, \"precio\": 26.99}', '2026-05-03 18:28:35'),
(362, 'Producto', 77, 'UPDATE', '{\"stock\": 14, \"activo\": 1, \"precio\": 23.99}', '{\"stock\": 14, \"activo\": 1, \"precio\": 23.99}', '2026-05-03 18:28:35'),
(363, 'Producto', 78, 'UPDATE', '{\"stock\": 27, \"activo\": 1, \"precio\": 16.99}', '{\"stock\": 27, \"activo\": 1, \"precio\": 16.99}', '2026-05-03 18:28:35'),
(364, 'Producto', 79, 'UPDATE', '{\"stock\": 19, \"activo\": 1, \"precio\": 18.50}', '{\"stock\": 19, \"activo\": 1, \"precio\": 18.50}', '2026-05-03 18:28:35'),
(365, 'Producto', 80, 'UPDATE', '{\"stock\": 21, \"activo\": 1, \"precio\": 15.50}', '{\"stock\": 21, \"activo\": 1, \"precio\": 15.50}', '2026-05-03 18:28:35'),
(366, 'Producto', 81, 'UPDATE', '{\"stock\": 45, \"activo\": 1, \"precio\": 14.50}', '{\"stock\": 45, \"activo\": 1, \"precio\": 14.50}', '2026-05-03 18:28:35'),
(367, 'Producto', 82, 'UPDATE', '{\"stock\": 33, \"activo\": 1, \"precio\": 17.00}', '{\"stock\": 33, \"activo\": 1, \"precio\": 17.00}', '2026-05-03 18:28:35'),
(368, 'Producto', 83, 'UPDATE', '{\"stock\": 26, \"activo\": 1, \"precio\": 16.75}', '{\"stock\": 26, \"activo\": 1, \"precio\": 16.75}', '2026-05-03 18:28:35'),
(369, 'Producto', 84, 'UPDATE', '{\"stock\": 28, \"activo\": 1, \"precio\": 15.99}', '{\"stock\": 28, \"activo\": 1, \"precio\": 15.99}', '2026-05-03 18:28:35'),
(370, 'Producto', 85, 'UPDATE', '{\"stock\": 17, \"activo\": 1, \"precio\": 18.50}', '{\"stock\": 17, \"activo\": 1, \"precio\": 18.50}', '2026-05-03 18:28:35'),
(371, 'Producto', 86, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 23.99}', '{\"stock\": 11, \"activo\": 1, \"precio\": 23.99}', '2026-05-03 18:28:35'),
(372, 'Producto', 87, 'UPDATE', '{\"stock\": 24, \"activo\": 1, \"precio\": 16.75}', '{\"stock\": 24, \"activo\": 1, \"precio\": 16.75}', '2026-05-03 18:28:35'),
(373, 'Producto', 88, 'UPDATE', '{\"stock\": 13, \"activo\": 1, \"precio\": 21.50}', '{\"stock\": 13, \"activo\": 1, \"precio\": 21.50}', '2026-05-03 18:28:35'),
(374, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:28:47'),
(375, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-05-03 18:28:51'),
(376, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:28:56'),
(377, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 10000.00}', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '2026-05-03 18:29:18'),
(378, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:29:25'),
(379, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:29:29'),
(380, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:29:40'),
(381, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '2026-05-03 18:29:43'),
(382, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '2026-05-03 18:29:47'),
(383, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:30:43'),
(384, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-03 18:31:05'),
(385, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-03 18:31:08'),
(386, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:31:29'),
(387, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:31:32'),
(388, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:31:47'),
(389, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-03 18:31:52'),
(390, 'Producto', 9, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-03 18:32:36'),
(391, 'Producto', 9, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-03 18:32:47'),
(392, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:33:03'),
(393, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-03 18:33:06'),
(394, 'Producto', 10, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:33:26'),
(395, 'Producto', 10, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:33:32'),
(396, 'Producto', 40, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 18.50}', '{\"stock\": 25, \"activo\": 1, \"precio\": 18.50}', '2026-05-03 18:33:50'),
(397, 'Producto', 10, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-03 18:38:08'),
(398, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '2026-05-04 15:31:09'),
(399, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-05-04 15:31:23'),
(400, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-04 15:31:26'),
(401, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-05-04 15:31:29'),
(402, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 0, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-05-04 15:31:32'),
(403, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '2026-05-04 15:35:17'),
(404, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-05-04 16:10:08'),
(405, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-04 16:10:11'),
(406, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-04 16:10:15'),
(407, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '2026-05-04 16:10:18'),
(408, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-05-04 16:10:21'),
(409, 'Producto', 80, 'UPDATE', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '2026-05-04 16:22:08'),
(410, 'Producto', 80, 'UPDATE', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '2026-05-04 16:22:13'),
(411, 'Producto', 80, 'UPDATE', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '2026-05-04 16:22:17'),
(412, 'Producto', 79, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '2026-05-04 16:22:20'),
(413, 'Producto', 73, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 29.99}', '2026-05-04 16:22:24'),
(414, 'Producto', 73, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 29.99}', '2026-05-04 16:22:36'),
(415, 'Producto', 56, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 59.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 59.99}', '2026-05-04 16:27:59'),
(416, 'Producto', 57, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 89.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 89.99}', '2026-05-04 16:28:02'),
(417, 'Producto', 58, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 64.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 64.99}', '2026-05-04 16:28:05'),
(418, 'Producto', 59, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '2026-05-04 16:28:08'),
(419, 'Producto', 60, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 74.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 74.99}', '2026-05-04 16:28:10'),
(420, 'Producto', 74, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 17.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 17.99}', '2026-05-04 16:28:59'),
(421, 'Pedido', 10, 'UPDATE', '{\"total\": 105.98, \"estado\": \"pagado\"}', '{\"total\": 99.99, \"estado\": \"pagado\"}', '2026-05-04 16:41:19'),
(422, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-06 19:31:51'),
(423, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-06 19:32:10'),
(424, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:12:28'),
(425, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:12:34'),
(426, 'Producto', 79, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '2026-05-09 22:19:18'),
(427, 'Producto', 80, 'UPDATE', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '2026-05-09 22:19:32'),
(428, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-09 22:22:31'),
(429, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:22:37'),
(430, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:26:54'),
(431, 'Producto', 61, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:30:17'),
(432, 'Producto', 62, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 29.99}', '2026-05-09 22:30:22'),
(433, 'Producto', 63, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:30:34'),
(434, 'Producto', 64, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 34.99}', '2026-05-09 22:30:45'),
(435, 'Producto', 65, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 32.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 32.99}', '2026-05-09 22:30:50'),
(436, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:31:49'),
(437, 'Producto', 46, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 49.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 49.99}', '2026-05-09 22:32:20'),
(438, 'Producto', 47, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 54.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 54.99}', '2026-05-09 22:32:25'),
(439, 'Producto', 48, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:32:30'),
(440, 'Producto', 46, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 49.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 49.99}', '2026-05-09 22:32:46'),
(441, 'Producto', 47, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 54.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 54.99}', '2026-05-09 22:32:51'),
(442, 'Producto', 48, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:32:56'),
(443, 'Producto', 49, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 69.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 69.99}', '2026-05-09 22:33:01'),
(444, 'Producto', 50, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:33:07'),
(445, 'Producto', 51, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:33:19'),
(446, 'Producto', 52, 'UPDATE', '{\"stock\": 45, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 45, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:33:23'),
(447, 'Producto', 53, 'UPDATE', '{\"stock\": 60, \"activo\": 1, \"precio\": 17.99}', '{\"stock\": 60, \"activo\": 1, \"precio\": 17.99}', '2026-05-09 22:33:29'),
(448, 'Producto', 54, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 22.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 22.99}', '2026-05-09 22:33:36'),
(449, 'Producto', 55, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 29.99}', '2026-05-09 22:33:41'),
(450, 'Producto', 66, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:33:54'),
(451, 'Producto', 67, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '2026-05-09 22:34:02'),
(452, 'Producto', 68, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:34:10'),
(453, 'Producto', 69, 'UPDATE', '{\"stock\": 45, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 45, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:34:18'),
(454, 'Producto', 70, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 59.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 59.99}', '2026-05-09 22:34:20'),
(455, 'Producto', 76, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 99.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 99.99}', '2026-05-09 22:34:32'),
(456, 'Producto', 77, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 84.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 84.99}', '2026-05-09 22:34:42'),
(457, 'Producto', 78, 'UPDATE', '{\"stock\": 10, \"activo\": 1, \"precio\": 109.99}', '{\"stock\": 10, \"activo\": 1, \"precio\": 109.99}', '2026-05-09 22:34:44'),
(458, 'Producto', 79, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '2026-05-09 22:34:47'),
(459, 'Producto', 80, 'UPDATE', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '2026-05-09 22:34:49'),
(460, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-09 22:36:58'),
(461, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:37:01'),
(462, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:37:06'),
(463, 'Producto', 72, 'UPDATE', '{\"stock\": 80, \"activo\": 1, \"precio\": 14.99}', '{\"stock\": 80, \"activo\": 1, \"precio\": 14.99}', '2026-05-09 22:37:15'),
(464, 'Producto', 71, 'UPDATE', '{\"stock\": 60, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 60, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:37:18'),
(465, 'Producto', 75, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:39:09'),
(466, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-09 22:42:58'),
(467, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:43:01'),
(468, 'Producto', 10, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:43:04'),
(469, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:43:09'),
(470, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:43:14'),
(471, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-09 22:51:01'),
(472, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(473, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(474, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:51:06'),
(475, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(476, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:51:06'),
(477, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:51:06'),
(478, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-09 22:51:06'),
(479, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:51:06'),
(480, 'Producto', 10, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:51:06'),
(481, 'Producto', 46, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 49.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 49.99}', '2026-05-09 22:51:06'),
(482, 'Producto', 47, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 54.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 54.99}', '2026-05-09 22:51:06'),
(483, 'Producto', 48, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:51:06'),
(484, 'Producto', 49, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 69.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 69.99}', '2026-05-09 22:51:06'),
(485, 'Producto', 50, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:51:06'),
(486, 'Producto', 51, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(487, 'Producto', 52, 'UPDATE', '{\"stock\": 45, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 45, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:51:06'),
(488, 'Producto', 53, 'UPDATE', '{\"stock\": 60, \"activo\": 1, \"precio\": 17.99}', '{\"stock\": 60, \"activo\": 1, \"precio\": 17.99}', '2026-05-09 22:51:06'),
(489, 'Producto', 54, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 22.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 22.99}', '2026-05-09 22:51:06'),
(490, 'Producto', 55, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 29.99}', '2026-05-09 22:51:06'),
(491, 'Producto', 56, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 59.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 59.99}', '2026-05-09 22:51:06'),
(492, 'Producto', 57, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 89.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 89.99}', '2026-05-09 22:51:06'),
(493, 'Producto', 58, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 64.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 64.99}', '2026-05-09 22:51:06'),
(494, 'Producto', 59, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '2026-05-09 22:51:06'),
(495, 'Producto', 60, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 74.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 74.99}', '2026-05-09 22:51:06'),
(496, 'Producto', 61, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:51:06'),
(497, 'Producto', 62, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 29.99}', '2026-05-09 22:51:06'),
(498, 'Producto', 63, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:51:06'),
(499, 'Producto', 64, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 34.99}', '2026-05-09 22:51:06'),
(500, 'Producto', 65, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 32.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 32.99}', '2026-05-09 22:51:06'),
(501, 'Producto', 66, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:51:06'),
(502, 'Producto', 67, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '2026-05-09 22:51:06'),
(503, 'Producto', 68, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:51:06'),
(504, 'Producto', 69, 'UPDATE', '{\"stock\": 45, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 45, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(505, 'Producto', 70, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 59.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 59.99}', '2026-05-09 22:51:06'),
(506, 'Producto', 71, 'UPDATE', '{\"stock\": 60, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 60, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(507, 'Producto', 72, 'UPDATE', '{\"stock\": 80, \"activo\": 1, \"precio\": 14.99}', '{\"stock\": 80, \"activo\": 1, \"precio\": 14.99}', '2026-05-09 22:51:06'),
(508, 'Producto', 73, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 29.99}', '2026-05-09 22:51:06'),
(509, 'Producto', 74, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 17.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 17.99}', '2026-05-09 22:51:06'),
(510, 'Producto', 75, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:51:06'),
(511, 'Producto', 76, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 99.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 99.99}', '2026-05-09 22:51:06'),
(512, 'Producto', 77, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 84.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 84.99}', '2026-05-09 22:51:06'),
(513, 'Producto', 78, 'UPDATE', '{\"stock\": 10, \"activo\": 1, \"precio\": 109.99}', '{\"stock\": 10, \"activo\": 1, \"precio\": 109.99}', '2026-05-09 22:51:06'),
(514, 'Producto', 79, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '2026-05-09 22:51:06'),
(515, 'Producto', 80, 'UPDATE', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '2026-05-09 22:51:06'),
(516, 'Producto', 1, 'UPDATE', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '{\"stock\": 52, \"activo\": 0, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(517, 'Producto', 2, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(518, 'Producto', 3, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:51:06'),
(519, 'Producto', 4, 'UPDATE', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 51, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(520, 'Producto', 5, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 12, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:51:06'),
(521, 'Producto', 6, 'UPDATE', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 1, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:51:06'),
(522, 'Producto', 7, 'UPDATE', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '{\"stock\": 0, \"activo\": 1, \"precio\": 14.00}', '2026-05-09 22:51:06'),
(523, 'Producto', 8, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:51:06'),
(524, 'Producto', 10, 'UPDATE', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '{\"stock\": 11, \"activo\": 1, \"precio\": 12.00}', '2026-05-09 22:51:06'),
(525, 'Producto', 46, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 49.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 49.99}', '2026-05-09 22:51:06'),
(526, 'Producto', 47, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 54.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 54.99}', '2026-05-09 22:51:06'),
(527, 'Producto', 48, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:51:06'),
(528, 'Producto', 49, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 69.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 69.99}', '2026-05-09 22:51:06'),
(529, 'Producto', 50, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:51:06'),
(530, 'Producto', 51, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(531, 'Producto', 52, 'UPDATE', '{\"stock\": 45, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 45, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:51:06'),
(532, 'Producto', 53, 'UPDATE', '{\"stock\": 60, \"activo\": 1, \"precio\": 17.99}', '{\"stock\": 60, \"activo\": 1, \"precio\": 17.99}', '2026-05-09 22:51:06'),
(533, 'Producto', 54, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 22.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 22.99}', '2026-05-09 22:51:06'),
(534, 'Producto', 55, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 29.99}', '2026-05-09 22:51:06'),
(535, 'Producto', 56, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 59.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 59.99}', '2026-05-09 22:51:06'),
(536, 'Producto', 57, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 89.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 89.99}', '2026-05-09 22:51:06'),
(537, 'Producto', 58, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 64.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 64.99}', '2026-05-09 22:51:06'),
(538, 'Producto', 59, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '2026-05-09 22:51:06'),
(539, 'Producto', 60, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 74.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 74.99}', '2026-05-09 22:51:06'),
(540, 'Producto', 61, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:51:06'),
(541, 'Producto', 62, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 29.99}', '2026-05-09 22:51:06'),
(542, 'Producto', 63, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:51:06'),
(543, 'Producto', 64, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 34.99}', '2026-05-09 22:51:06'),
(544, 'Producto', 65, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 32.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 32.99}', '2026-05-09 22:51:06'),
(545, 'Producto', 66, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 24.99}', '2026-05-09 22:51:06'),
(546, 'Producto', 67, 'UPDATE', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '{\"stock\": 40, \"activo\": 1, \"precio\": 34.99}', '2026-05-09 22:51:06'),
(547, 'Producto', 68, 'UPDATE', '{\"stock\": 30, \"activo\": 1, \"precio\": 44.99}', '{\"stock\": 30, \"activo\": 1, \"precio\": 44.99}', '2026-05-09 22:51:06'),
(548, 'Producto', 69, 'UPDATE', '{\"stock\": 45, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 45, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(549, 'Producto', 70, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 59.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 59.99}', '2026-05-09 22:51:06'),
(550, 'Producto', 71, 'UPDATE', '{\"stock\": 60, \"activo\": 1, \"precio\": 19.99}', '{\"stock\": 60, \"activo\": 1, \"precio\": 19.99}', '2026-05-09 22:51:06'),
(551, 'Producto', 72, 'UPDATE', '{\"stock\": 80, \"activo\": 1, \"precio\": 14.99}', '{\"stock\": 80, \"activo\": 1, \"precio\": 14.99}', '2026-05-09 22:51:06'),
(552, 'Producto', 73, 'UPDATE', '{\"stock\": 35, \"activo\": 1, \"precio\": 29.99}', '{\"stock\": 35, \"activo\": 1, \"precio\": 29.99}', '2026-05-09 22:51:06'),
(553, 'Producto', 74, 'UPDATE', '{\"stock\": 50, \"activo\": 1, \"precio\": 17.99}', '{\"stock\": 50, \"activo\": 1, \"precio\": 17.99}', '2026-05-09 22:51:06'),
(554, 'Producto', 75, 'UPDATE', '{\"stock\": 25, \"activo\": 1, \"precio\": 39.99}', '{\"stock\": 25, \"activo\": 1, \"precio\": 39.99}', '2026-05-09 22:51:06'),
(555, 'Producto', 76, 'UPDATE', '{\"stock\": 15, \"activo\": 1, \"precio\": 99.99}', '{\"stock\": 15, \"activo\": 1, \"precio\": 99.99}', '2026-05-09 22:51:06'),
(556, 'Producto', 77, 'UPDATE', '{\"stock\": 20, \"activo\": 1, \"precio\": 84.99}', '{\"stock\": 20, \"activo\": 1, \"precio\": 84.99}', '2026-05-09 22:51:06'),
(557, 'Producto', 78, 'UPDATE', '{\"stock\": 10, \"activo\": 1, \"precio\": 109.99}', '{\"stock\": 10, \"activo\": 1, \"precio\": 109.99}', '2026-05-09 22:51:06'),
(558, 'Producto', 79, 'UPDATE', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '{\"stock\": 12, \"activo\": 1, \"precio\": 119.99}', '2026-05-09 22:51:06'),
(559, 'Producto', 80, 'UPDATE', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '{\"stock\": 18, \"activo\": 1, \"precio\": 94.99}', '2026-05-09 22:51:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `avatar_3d`
--

CREATE TABLE `avatar_3d` (
  `id_avatar` int NOT NULL,
  `id_usuario` int NOT NULL,
  `pecho` decimal(5,2) DEFAULT NULL,
  `cintura` decimal(5,2) DEFAULT NULL,
  `cadera` decimal(5,2) DEFAULT NULL,
  `estatura` decimal(5,2) DEFAULT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `edad` int DEFAULT NULL,
  `talla` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `avatar_3d`
--

INSERT INTO `avatar_3d` (`id_avatar`, `id_usuario`, `pecho`, `cintura`, `cadera`, `estatura`, `peso`, `edad`, `talla`) VALUES
(2, 4, 1.00, 1.00, 1.00, 1.00, 1.00, 12, 'L');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id_carrito` int NOT NULL,
  `id_usuario` int NOT NULL,
  `total` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id_carrito`, `id_usuario`, `total`) VALUES
(1, 4, 0.00),
(6, 8, 0.00),
(7, 9, 0.00),
(9, 11, 394.96),
(10, 3, 0.00),
(11, 12, 189.98);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nombre`, `descripcion`) VALUES
(1, 'Camisetas', 'Camisetas, parte de arriba'),
(2, 'Chaquetas', 'Prendas de abrigo finas'),
(5, 'Pantalones', 'Pantalones de todo tipo'),
(6, 'Shorts', 'Pantalones cortos'),
(7, 'Calzado', 'Calzado para los pies'),
(8, 'Jerseys', 'Jerseys y sueters de abrigo'),
(9, 'Deportiva', 'Ropa y calzado deportivo'),
(10, 'Accesorios', 'Cinturones, gorras y complementos'),
(11, 'Abrigos', 'Abrigos y ropa de temporada');

--
-- Disparadores `categoria`
--
DELIMITER $$
CREATE TRIGGER `trg_audit_categoria_update` AFTER UPDATE ON `categoria` FOR EACH ROW BEGIN
    INSERT INTO Auditoria(
        tabla_afectada,
        id_registro,
        operacion,
        datos_anteriores,
        datos_nuevos
    )
    VALUES(
        'Categoria',
        NEW.id_categoria,
        'UPDATE',
        JSON_OBJECT('nombre', OLD.nombre, 'descripcion', OLD.descripcion),
        JSON_OBJECT('nombre', NEW.nombre, 'descripcion', NEW.descripcion)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_carrito`
--

CREATE TABLE `detalle_carrito` (
  `id_detalle_carrito` int NOT NULL,
  `id_carrito` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `talla` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_carrito`
--

INSERT INTO `detalle_carrito` (`id_detalle_carrito`, `id_carrito`, `id_producto`, `cantidad`, `talla`, `precio_unitario`) VALUES
(38, 11, 76, 1, 'M', 99.99),
(39, 11, 57, 1, 'M', 89.99),
(43, 9, 80, 2, 'S', 94.99),
(44, 9, 79, 1, 'XL', 119.99),
(45, 9, 77, 1, 'L', 84.99);

--
-- Disparadores `detalle_carrito`
--
DELIMITER $$
CREATE TRIGGER `trg_carrito_total_delete` AFTER DELETE ON `detalle_carrito` FOR EACH ROW BEGIN
    UPDATE carrito
    SET total = (SELECT COALESCE(SUM(cantidad*precio_unitario),0)
                 FROM detalle_carrito
                 WHERE id_carrito = OLD.id_carrito)
    WHERE id_carrito = OLD.id_carrito;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_carrito_total_insert` AFTER INSERT ON `detalle_carrito` FOR EACH ROW BEGIN
    UPDATE carrito
    SET total = (SELECT COALESCE(SUM(cantidad*precio_unitario),0)
                 FROM detalle_carrito
                 WHERE id_carrito = NEW.id_carrito)
    WHERE id_carrito = NEW.id_carrito;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_carrito_total_update` AFTER UPDATE ON `detalle_carrito` FOR EACH ROW BEGIN
    UPDATE carrito
    SET total = (SELECT COALESCE(SUM(cantidad*precio_unitario),0)
                 FROM detalle_carrito
                 WHERE id_carrito = NEW.id_carrito)
    WHERE id_carrito = NEW.id_carrito;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id_detalle_pedido` int NOT NULL,
  `id_pedido` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_en_el_momento` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`id_detalle_pedido`, `id_pedido`, `id_producto`, `cantidad`, `precio_en_el_momento`) VALUES
(14, 10, 76, 1, 99.99);

--
-- Disparadores `detalle_pedido`
--
DELIMITER $$
CREATE TRIGGER `trg_pedido_total_delete` AFTER DELETE ON `detalle_pedido` FOR EACH ROW BEGIN
    UPDATE Pedido
    SET total = (
        SELECT COALESCE(SUM(cantidad * precio_en_el_momento), 0)
        FROM Detalle_Pedido
        WHERE id_pedido = OLD.id_pedido
    )
    WHERE id_pedido = OLD.id_pedido;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_pedido_total_insert` AFTER INSERT ON `detalle_pedido` FOR EACH ROW BEGIN
    UPDATE Pedido
    SET total = (
        SELECT COALESCE(SUM(cantidad * precio_en_el_momento), 0)
        FROM Detalle_Pedido
        WHERE id_pedido = NEW.id_pedido
    )
    WHERE id_pedido = NEW.id_pedido;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_pedido_total_update` AFTER UPDATE ON `detalle_pedido` FOR EACH ROW BEGIN
    UPDATE Pedido
    SET total = (
        SELECT COALESCE(SUM(cantidad * precio_en_el_momento), 0)
        FROM Detalle_Pedido
        WHERE id_pedido = NEW.id_pedido
    )
    WHERE id_pedido = NEW.id_pedido;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE `direccion` (
  `id_direccion` int NOT NULL,
  `id_usuario` int NOT NULL,
  `calle` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provincia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_postal` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pais` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`id_direccion`, `id_usuario`, `calle`, `numero`, `ciudad`, `provincia`, `codigo_postal`, `pais`) VALUES
(1, 4, 'Calle 1', '1', 'Logroño', 'La Rioja', '26003', 'España'),
(4, 11, 'luis 11', '12', 'madrid', 'madrid', '12345', 'España'),
(5, 8, 'avd', '6', 'Logroño', 'La Rioja', '26007', 'España'),
(6, 3, 'a', '1', 'a', 'a', '1', 'España');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favorito`
--

CREATE TABLE `favorito` (
  `id_usuario` int NOT NULL,
  `id_producto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `favorito`
--

INSERT INTO `favorito` (`id_usuario`, `id_producto`) VALUES
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(11, 6),
(11, 76),
(11, 80);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_estado_pedido`
--

CREATE TABLE `historial_estado_pedido` (
  `id_historial` int NOT NULL,
  `id_pedido` int NOT NULL,
  `estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comentario` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo_pago`
--

CREATE TABLE `metodo_pago` (
  `id_metodo_pago` int NOT NULL,
  `id_usuario` int NOT NULL,
  `tipo` enum('paypal','tarjeta','bizum','google_pay') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_enmascarado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `es_predeterminado` tinyint(1) DEFAULT '0',
  `fecha_expiracion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `metodo_pago`
--

INSERT INTO `metodo_pago` (`id_metodo_pago`, `id_usuario`, `tipo`, `numero_enmascarado`, `es_predeterminado`, `fecha_expiracion`) VALUES
(1, 4, 'paypal', '2', 0, '2036-03-01'),
(3, 4, 'paypal', '1234', 0, '2027-12-12'),
(6, 8, 'bizum', '+34 111111111', 1, NULL),
(7, 8, 'paypal', 'ignaciolangarica68@gmail.com', 0, NULL),
(8, 11, 'bizum', '+34 123456789', 0, NULL),
(9, 11, 'paypal', 'nadia@gmail.com', 1, NULL),
(10, 11, 'paypal', 'nadia@gmail.com', 0, NULL),
(11, 8, 'google_pay', 'asdsdasd', 0, NULL),
(12, 3, 'paypal', 'asdasd@gmail.com', 1, NULL),
(13, 11, 'tarjeta', '**** **** **** gdfg', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(5, '2026_02_23_130126_create_personal_access_tokens_table', 2),
(7, '2026_04_09_160208_add_talla_to_detalle_carrito', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_metodo_pago` int DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_direccion` int NOT NULL,
  `gastos_envio` decimal(10,2) DEFAULT '0.00',
  `codigo_seguimiento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','pagado','enviado','entregado','cancelado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `id_usuario`, `id_metodo_pago`, `fecha`, `id_direccion`, `gastos_envio`, `codigo_seguimiento`, `total`, `estado`) VALUES
(10, 11, 8, '2026-05-04 16:41:19', 4, 5.99, NULL, 99.99, 'pagado');

--
-- Disparadores `pedido`
--
DELIMITER $$
CREATE TRIGGER `trg_audit_pedido_update` AFTER UPDATE ON `pedido` FOR EACH ROW BEGIN
    INSERT INTO auditoria(tabla_afectada,id_registro,operacion,datos_anteriores,datos_nuevos)
    VALUES(
        'Pedido',
        NEW.id_pedido,
        'UPDATE',
        JSON_OBJECT('estado',OLD.estado,'total',OLD.total),
        JSON_OBJECT('estado',NEW.estado,'total',NEW.total)
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_historial_estado` AFTER UPDATE ON `pedido` FOR EACH ROW BEGIN
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO historial_estado_pedido(id_pedido, estado, fecha)
        VALUES (NEW.id_pedido, NEW.estado, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 8, 'token_login', 'c2441ba1397ed7338022538e85744cad091ec6e435c012bebec5d19f3943a7eb', '[\"*\"]', '2026-04-10 15:45:50', NULL, '2026-04-09 09:38:59', '2026-04-10 15:45:50'),
(2, 'App\\Models\\User', 10, 'token_registro', '539924df491d3f8265a5abaf89cbec1a2e246a8c246003870ebcae6b23a7835e', '[\"*\"]', '2026-04-11 10:33:58', NULL, '2026-04-11 10:32:09', '2026-04-11 10:33:58'),
(3, 'App\\Models\\User', 11, 'token_registro', 'a44b9519578bc4ff9684c2cd488624d382e73660febaa12d49a77a56e22effec', '[\"*\"]', NULL, NULL, '2026-04-11 10:34:39', '2026-04-11 10:34:39'),
(4, 'App\\Models\\User', 11, 'token_login', 'cb40e994d6fe9f3ef2219f13c0e8ef1cd235798057e2d80ad18a7d6431a0fb0d', '[\"*\"]', '2026-04-11 21:13:26', NULL, '2026-04-11 10:35:15', '2026-04-11 21:13:26'),
(5, 'App\\Models\\User', 11, 'token_login', '15ad2af1065f5123dedb76b8591fce846d1018b6f1f40fbe9eb780fa31ec19a3', '[\"*\"]', '2026-04-15 15:24:06', NULL, '2026-04-12 10:32:34', '2026-04-15 15:24:06'),
(6, 'App\\Models\\User', 8, 'token_login', '57d952f6521097e2187112e90869a0bd15942ed07b04513a3ae6447502b7ee9d', '[\"*\"]', '2026-04-15 15:30:30', NULL, '2026-04-15 15:25:48', '2026-04-15 15:30:30'),
(7, 'App\\Models\\User', 3, 'token_login', 'a2d14052f7d6eaeae21fa170529b35b9d14141f1220acd970049f89fe153a001', '[\"*\"]', '2026-04-15 15:31:09', NULL, '2026-04-15 15:31:07', '2026-04-15 15:31:09'),
(8, 'App\\Models\\User', 11, 'token_login', 'd1bf9ce91fef6cdd520b98e303bfefac2e8cd00682bb35448f3c707960648b18', '[\"*\"]', '2026-04-18 15:30:20', NULL, '2026-04-18 13:39:41', '2026-04-18 15:30:20'),
(9, 'App\\Models\\User', 11, 'token_login', '1ca9156def59049b8ceb96033a2bf393f6e125706e80f6cd80ff83eb1d75d5df', '[\"*\"]', '2026-04-29 15:09:57', NULL, '2026-04-29 14:27:56', '2026-04-29 15:09:57'),
(10, 'App\\Models\\User', 3, 'token_login', '02e2500cd29b131a73a7ad8ea12cff112d5a1c6d597fb9c4308770b71fa550c4', '[\"*\"]', '2026-04-29 15:11:42', NULL, '2026-04-29 15:10:07', '2026-04-29 15:11:42'),
(11, 'App\\Models\\User', 3, 'token_login', '902feaf6e8d7663e8d53350e8b69147513027ccbead8f41e253bcce110b36ed6', '[\"*\"]', '2026-04-29 15:25:29', NULL, '2026-04-29 15:12:17', '2026-04-29 15:25:29'),
(12, 'App\\Models\\User', 3, 'token_login', '5f6248b91948ea12191ab788eaa46148a36562a2fae8516c5ff710cbf2a87c23', '[\"*\"]', '2026-04-29 15:32:24', NULL, '2026-04-29 15:31:51', '2026-04-29 15:32:24'),
(13, 'App\\Models\\User', 3, 'token_login', '9c9459df5bcd3f7e71dbe7b11826d735f261026499c8f2061429b3c09116c516', '[\"*\"]', '2026-04-29 15:34:09', NULL, '2026-04-29 15:33:46', '2026-04-29 15:34:09'),
(14, 'App\\Models\\User', 3, 'token_login', 'f2b65591b01ab6e62bfb50bcfeaf5742281f4408e222aa03d6d940f4cf9231e9', '[\"*\"]', '2026-04-30 16:03:17', NULL, '2026-04-29 15:36:17', '2026-04-30 16:03:17'),
(15, 'App\\Models\\User', 11, 'token_login', '11e108bf2e2e3ebf46bfd431fbeb617bb53ae8db49e9f3a9e9cb81b3ecf502fb', '[\"*\"]', '2026-04-30 17:57:31', NULL, '2026-04-30 16:45:40', '2026-04-30 17:57:31'),
(16, 'App\\Models\\User', 11, 'token_login', 'd4828a463eddc2878a445c631694d7ec4e85f93b9a7f952d8e1734d45d30e607', '[\"*\"]', '2026-04-30 18:03:01', NULL, '2026-04-30 17:57:42', '2026-04-30 18:03:01'),
(17, 'App\\Models\\User', 11, 'token_login', 'd3aa72cf41d7a4d45a49fa13e8481a20f890d8c731cab4553a7a2fbc5761fb44', '[\"*\"]', '2026-04-30 18:10:45', NULL, '2026-04-30 18:10:43', '2026-04-30 18:10:45'),
(18, 'App\\Models\\User', 11, 'token_login', 'e2ba4e79e532c007d3cf838a116abf658ad1f85633d0ab233a29cf8746bd1c29', '[\"*\"]', '2026-04-30 18:33:42', NULL, '2026-04-30 18:11:07', '2026-04-30 18:33:42'),
(19, 'App\\Models\\User', 11, 'token_login', 'f05daeee9d82e9f62971b2c44e6e79827e597252859bb7bda7d279786c68e3b5', '[\"*\"]', '2026-04-30 18:34:35', NULL, '2026-04-30 18:33:57', '2026-04-30 18:34:35'),
(20, 'App\\Models\\User', 11, 'token_login', 'b24281ee8ff9ed7fd0273811e72f1cc0c87ba41e456a8b6470612a9821c50e62', '[\"*\"]', '2026-04-30 18:36:20', NULL, '2026-04-30 18:34:45', '2026-04-30 18:36:20'),
(21, 'App\\Models\\User', 11, 'token_login', 'd2aef1160fbcf3372c6c6ef5765236ad7595fc508f6ce284f5669d12d05097e9', '[\"*\"]', '2026-04-30 18:36:31', NULL, '2026-04-30 18:36:30', '2026-04-30 18:36:31'),
(22, 'App\\Models\\User', 11, 'token_login', 'd86120c4192b2a98cf999c94de2fa90fb2265334c44f1d581eb986e9b7d1ee14', '[\"*\"]', '2026-04-30 18:49:06', NULL, '2026-04-30 18:48:08', '2026-04-30 18:49:06'),
(23, 'App\\Models\\User', 11, 'token_login', '087121e804ef292fb32e1c1eaace6736ff96f7f8c39f851376516dae8fb410cd', '[\"*\"]', '2026-04-30 19:22:07', NULL, '2026-04-30 18:49:18', '2026-04-30 19:22:07'),
(24, 'App\\Models\\User', 11, 'token_login', '26cfc82cf8ac0f7a1c80b8ca6bbe8ca0b360fec5dec67e16e788f336c8fde996', '[\"*\"]', '2026-04-30 19:24:04', NULL, '2026-04-30 19:23:14', '2026-04-30 19:24:04'),
(25, 'App\\Models\\User', 12, 'token_registro', '3b7f0c97d0ebc307d8b781067eee5c5a354ce8baf83e4d3caa3a8f3e82d6868c', '[\"*\"]', NULL, NULL, '2026-04-30 19:24:35', '2026-04-30 19:24:35'),
(26, 'App\\Models\\User', 12, 'token_login', 'ecef93b862923f79beee3c4754e65cd5e23940669667534a142c754d1a928ce0', '[\"*\"]', '2026-05-03 21:38:04', NULL, '2026-04-30 19:25:03', '2026-05-03 21:38:04'),
(27, 'App\\Models\\User', 11, 'token_login', '5e5067ca984dfcb5c46839e42c6e4a0a0ef715621edafbeb61c891ecf94a95a5', '[\"*\"]', '2026-05-03 21:44:07', NULL, '2026-05-03 21:44:05', '2026-05-03 21:44:07'),
(28, 'App\\Models\\User', 11, 'token_login', '6ff74e91d2514d739e73bd340e41eab2470374ae93574ddc86e823560cd5b572', '[\"*\"]', '2026-05-04 12:43:27', NULL, '2026-05-04 07:59:45', '2026-05-04 12:43:27'),
(29, 'App\\Models\\User', 12, 'token_login', 'ff32c9064b908b70544315da630e8991d8619438ae62481ce2bcf350445b1b65', '[\"*\"]', '2026-05-06 13:22:00', NULL, '2026-05-04 12:46:31', '2026-05-06 13:22:00'),
(30, 'App\\Models\\User', 11, 'token_login', 'e8ef7a514a007336a48f8df40d4c969f81e27ed026c0f9074c2a9b18790d8e5e', '[\"*\"]', '2026-05-06 14:50:34', NULL, '2026-05-06 14:47:06', '2026-05-06 14:50:34'),
(31, 'App\\Models\\User', 12, 'token_login', 'eedb5c6c567353239c665322386de2586124ff504606ba6b9fb75669ee77ff2d', '[\"*\"]', '2026-05-06 15:36:29', NULL, '2026-05-06 15:31:22', '2026-05-06 15:36:29'),
(32, 'App\\Models\\User', 12, 'token_login', 'c3e78260aab587b5d395b171a0b7e7ef0ae89496d36c40bdc1f7b7f23c2ae24c', '[\"*\"]', '2026-05-08 13:16:04', NULL, '2026-05-06 15:42:22', '2026-05-08 13:16:04'),
(33, 'App\\Models\\User', 11, 'token_login', '8a2b6d10663434ff27f91ac2cf623d5ddbb5c5018869172ae24ced8e372c7702', '[\"*\"]', '2026-05-09 12:40:40', NULL, '2026-05-08 18:07:58', '2026-05-09 12:40:40'),
(34, 'App\\Models\\User', 11, 'token_login', '236c4015a86f653282b8862937711a00edb1827f921f3cedfe83ca8ce1751b65', '[\"*\"]', '2026-05-09 12:56:12', NULL, '2026-05-09 12:45:25', '2026-05-09 12:56:12'),
(35, 'App\\Models\\User', 11, 'token_login', 'a6ae58a3fa70ce6c9bff0ca8676f4eb1bc22e11ee387afe5a5060feb935a702b', '[\"*\"]', '2026-05-09 19:06:44', NULL, '2026-05-09 12:57:05', '2026-05-09 19:06:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int NOT NULL,
  `nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `id_categoria` int DEFAULT NULL,
  `color` enum('rojo','azul','verde','amarillo','negro','blanco','gris','rosa','morado','naranja','marron') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexo` enum('hombre','mujer','unisex') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `talla` enum('XS','S','M','L','XL','XXL') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `eliminado_en` datetime DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int DEFAULT '0',
  `imagen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `id_categoria`, `color`, `sexo`, `talla`, `activo`, `eliminado_en`, `precio`, `stock`, `imagen`) VALUES
(1, 'Camiseta modernas', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 1, 'azul', 'mujer', NULL, 0, '2026-05-06 19:31:51', 19.99, 52, 'camiseta_dos.jpg'),
(2, 'Camiseta bonita', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 1, 'gris', 'hombre', NULL, 1, NULL, 19.99, 50, 'camiseta_dos.jpg'),
(3, 'Camiseta oversize', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 1, 'morado', 'mujer', NULL, 1, NULL, 24.99, 50, 'camiseta_dos.jpg'),
(4, 'Camiseta ajustada', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 1, 'rosa', 'hombre', NULL, 1, NULL, 19.99, 51, 'camiseta_dos.jpg'),
(5, 'Pantalón', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 5, 'rojo', 'hombre', NULL, 1, NULL, 12.00, 12, 'pantalon.jpg'),
(6, 'Camiseta (3D)', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 1, 'rosa', 'unisex', NULL, 1, NULL, 24.99, 1, 'camiseta_3d.jpg'),
(7, 'Pantalón volantes', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 5, 'azul', 'mujer', 'L', 1, NULL, 14.00, 0, 'pantalon.jpg'),
(8, 'Pantalón lino', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 5, 'verde', 'hombre', 'S', 1, NULL, 12.00, 11, 'pantalon.jpg'),
(10, 'Pantalón vaquero', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 5, 'verde', 'hombre', 'S', 1, NULL, 12.00, 11, 'pantalon.jpg'),
(46, 'Chaqueta Clásica', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 2, 'negro', 'hombre', 'M', 1, NULL, 49.99, 30, 'chaqueta.jpg'),
(47, 'Chaqueta Slim', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 2, 'azul', 'mujer', 'S', 1, NULL, 54.99, 25, 'chaqueta.jpg'),
(48, 'Chaqueta Casual', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 2, 'gris', 'hombre', 'L', 1, NULL, 44.99, 20, 'chaqueta.jpg'),
(49, 'Chaqueta Elegante', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 2, 'blanco', 'mujer', NULL, 1, NULL, 69.99, 15, 'chaqueta.jpg'),
(50, 'Chaqueta Sport', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 2, 'rojo', 'hombre', 'XL', 1, NULL, 39.99, 40, 'chaqueta.jpg'),
(51, 'Short Playero', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 6, 'azul', 'hombre', 'M', 1, NULL, 19.99, 50, 'short.jpg'),
(52, 'Short Deportivo', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 6, 'negro', 'mujer', 'S', 1, NULL, 24.99, 45, 'short.jpg'),
(53, 'Short Casual', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 6, 'verde', 'hombre', NULL, 1, NULL, 17.99, 60, 'short.jpg'),
(54, 'Short Urbano', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 6, 'gris', 'mujer', 'L', 1, NULL, 22.99, 35, 'short.jpg'),
(55, 'Short Premium', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 6, 'naranja', 'hombre', 'XL', 1, NULL, 29.99, 20, 'short.jpg'),
(56, 'Zapatillas Urban', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 7, 'blanco', 'hombre', NULL, 1, NULL, 59.99, 30, 'botas.jpg'),
(57, 'Botas de Cuero', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 7, 'marron', 'mujer', NULL, 1, NULL, 89.99, 15, 'botas.jpg'),
(58, 'Sneakers Clásicos', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 7, 'negro', 'hombre', NULL, 1, NULL, 64.99, 25, 'botas.jpg'),
(59, 'Sandalias Verano', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 7, 'rosa', 'mujer', NULL, 1, NULL, 34.99, 40, 'botas.jpg'),
(60, 'Mocasines Elegantes', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 7, 'marron', 'hombre', NULL, 1, NULL, 74.99, 20, 'botas.jpg'),
(61, 'Jersey de Lana', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 8, 'gris', 'hombre', 'L', 1, NULL, 39.99, 30, 'jersey.jpg'),
(62, 'Jersey Fino', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 8, 'azul', 'mujer', 'S', 1, NULL, 29.99, 25, 'jersey.jpg'),
(63, 'Jersey Cuello Alto', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 8, 'negro', 'hombre', NULL, 1, NULL, 44.99, 20, 'jersey.jpg'),
(64, 'Jersey Oversize', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 8, 'morado', 'mujer', 'M', 1, NULL, 34.99, 35, 'jersey.jpg'),
(65, 'Jersey Rayado', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 8, 'blanco', 'hombre', 'XL', 1, NULL, 32.99, 40, 'jersey.jpg'),
(66, 'Camiseta Técnica', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 9, 'verde', 'hombre', 'M', 1, NULL, 24.99, 50, 'deportiva.jpg'),
(67, 'Mallas Deportivas', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 9, 'negro', 'mujer', 'S', 1, NULL, 34.99, 40, 'deportiva.jpg'),
(68, 'Sudadera Sport', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 9, 'gris', 'hombre', NULL, 1, NULL, 44.99, 30, 'deportiva.jpg'),
(69, 'Top Deportivo', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 9, 'rosa', 'mujer', 'M', 1, NULL, 19.99, 45, 'deportiva.jpg'),
(70, 'Chándal Completo', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 9, 'azul', 'hombre', 'L', 1, NULL, 59.99, 20, 'deportiva.jpg'),
(71, 'Cinturón de Cuero', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 10, 'marron', 'hombre', NULL, 1, NULL, 19.99, 60, 'cinturon.jpg'),
(72, 'Gorra Snapback', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 10, 'negro', 'hombre', NULL, 1, NULL, 14.99, 80, 'gorra.jpg'),
(73, 'Bolso Bandolera', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 10, 'rojo', 'mujer', NULL, 1, NULL, 29.99, 35, 'bolso.jpg'),
(74, 'Bufanda de Lana', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 10, 'morado', 'mujer', NULL, 1, NULL, 17.99, 50, 'bufanda.jpg'),
(75, 'Mochila Urban', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 10, 'gris', 'hombre', NULL, 1, NULL, 39.99, 25, 'mochila.jpg'),
(76, 'Abrigo de Paño', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 11, 'negro', 'mujer', 'M', 1, NULL, 99.99, 15, 'abrigo.jpg'),
(77, 'Plumífero Ligero', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 11, 'azul', 'hombre', 'L', 1, NULL, 84.99, 20, 'abrigo.jpg'),
(78, 'Trench Clásico', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 11, 'marron', 'mujer', NULL, 1, NULL, 109.99, 10, 'abrigo.jpg'),
(79, 'Anorak Outdoor', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 11, 'verde', 'hombre', 'XL', 1, NULL, 119.99, 12, 'abrigo.jpg'),
(80, 'Abrigo Oversize', 'Composición del tejido:\r\nExterior: 70% lana, 30% poliéster — proporciona calidez y resistencia al desgaste.\r\nForro: 100% poliéster — facilita la movilidad y el confort térmico.\r\nRelleno: 90% plumón, 10% plumas — ligero y aislante.', 11, 'gris', 'mujer', 'S', 1, NULL, 94.99, 18, 'abrigo.jpg');

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `trg_audit_producto_update` AFTER UPDATE ON `producto` FOR EACH ROW BEGIN
    INSERT INTO auditoria(tabla_afectada,id_registro,operacion,datos_anteriores,datos_nuevos)
    VALUES(
        'Producto',
        NEW.id_producto,
        'UPDATE',
        JSON_OBJECT('precio',OLD.precio,'stock',OLD.stock,'activo',OLD.activo),
        JSON_OBJECT('precio',NEW.precio,'stock',NEW.stock,'activo',NEW.activo)
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_producto_eliminado_en` BEFORE UPDATE ON `producto` FOR EACH ROW BEGIN
    -- Si se desactiva el producto, ponemos la fecha
    IF OLD.activo = TRUE AND NEW.activo = FALSE THEN
        SET NEW.eliminado_en = NOW();
    -- Si se reactiva el producto, borramos la fecha
    ELSEIF OLD.activo = FALSE AND NEW.activo = TRUE THEN
        SET NEW.eliminado_en = NULL;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('fXSRBOcHjiaXfJleOI4EsItZuDWXcQQgJgWnTCmW', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXFiVDh1QTRucjJpSkxkRmplU21mNXFRRDFESk1QRTJRQk9IOVdCOSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1773229880);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `email`, `contrasena`, `rol`, `telefono`, `fecha_nacimiento`, `fecha_registro`) VALUES
(3, 'Nacho Editado', 'nacho@gmail.com', '$2y$12$jBEf22KxxgscSbsUhlj7eu7AtudgUsIBVGD07hr3BpLaL4bMHvT6G', 'admin', '611111111', '2005-03-21', '2026-02-28 16:45:18'),
(4, 'Ivan', 'ivan@gmail.com', '$2y$12$GWF9PUhMxXoJiGBYRomr7ucZDdztKuPCbgaIVcGh3bHeqjXTya2Ay', 'admin', '123456789', '2005-09-11', '2026-03-04 15:26:07'),
(8, 'Ignacio Langarica', 'ignaciolangarica68@gmail.com', '$2y$12$JJAg4HttU6XScMQ4H10sKePIX1d/mHK3mi3jjA3ViKw25M1fnSgyu', 'cliente', '+34 606950429', '2000-11-11', '2026-04-07 03:33:29'),
(9, 'Ignacio Nacho', 'ignaciolangarica90@gmail.com', '$2y$12$qOb81zycpGoYE.zPEQTypufwe1gdieartfYu8c5GV0aLcpyPhzOtW', 'cliente', NULL, NULL, '2026-04-07 12:21:21'),
(11, 'Nadia Miau', 'nadia@gmail.com', '$2y$12$ph.ZzLOrpjYAbcJItfqYEuI2rYzqPtcf3wHBmv4BMxzi0zYXy8YLS', 'cliente', '+34 12345678', '2001-04-28', '2026-04-11 14:34:39'),
(12, 'nadia admin', 'nadiaadmin@gmail.com', '$2y$12$AzMXzEdEsUJYbl7Dzv2sfuk5vAI/1rCxu9QpheO8QBLaEEtR3qDEa', 'admin', NULL, '2026-04-22', '2026-04-30 23:24:35');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id_auditoria`),
  ADD KEY `idx_auditoria_tabla_fecha` (`tabla_afectada`,`fecha`);

--
-- Indices de la tabla `avatar_3d`
--
ALTER TABLE `avatar_3d`
  ADD PRIMARY KEY (`id_avatar`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id_carrito`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD UNIQUE KEY `id_usuario_2` (`id_usuario`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `detalle_carrito`
--
ALTER TABLE `detalle_carrito`
  ADD PRIMARY KEY (`id_detalle_carrito`),
  ADD KEY `id_carrito` (`id_carrito`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_detalle_pedido`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD PRIMARY KEY (`id_direccion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `favorito`
--
ALTER TABLE `favorito`
  ADD PRIMARY KEY (`id_usuario`,`id_producto`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `historial_estado_pedido`
--
ALTER TABLE `historial_estado_pedido`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_pedido` (`id_pedido`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD PRIMARY KEY (`id_metodo_pago`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_metodo_pago` (`id_metodo_pago`),
  ADD KEY `id_direccion` (`id_direccion`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `idx_producto_activo_eliminado` (`activo`,`eliminado_en`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `id_auditoria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=560;

--
-- AUTO_INCREMENT de la tabla `avatar_3d`
--
ALTER TABLE `avatar_3d`
  MODIFY `id_avatar` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id_carrito` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `detalle_carrito`
--
ALTER TABLE `detalle_carrito`
  MODIFY `id_detalle_carrito` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id_detalle_pedido` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `direccion`
--
ALTER TABLE `direccion`
  MODIFY `id_direccion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_estado_pedido`
--
ALTER TABLE `historial_estado_pedido`
  MODIFY `id_historial` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  MODIFY `id_metodo_pago` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `avatar_3d`
--
ALTER TABLE `avatar_3d`
  ADD CONSTRAINT `avatar_3d_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_carrito`
--
ALTER TABLE `detalle_carrito`
  ADD CONSTRAINT `detalle_carrito_ibfk_1` FOREIGN KEY (`id_carrito`) REFERENCES `carrito` (`id_carrito`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_carrito_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD CONSTRAINT `direccion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `favorito`
--
ALTER TABLE `favorito`
  ADD CONSTRAINT `favorito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorito_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `historial_estado_pedido`
--
ALTER TABLE `historial_estado_pedido`
  ADD CONSTRAINT `historial_estado_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`) ON DELETE CASCADE;

--
-- Filtros para la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD CONSTRAINT `metodo_pago_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_metodo_pago`) REFERENCES `metodo_pago` (`id_metodo_pago`),
  ADD CONSTRAINT `pedido_ibfk_3` FOREIGN KEY (`id_direccion`) REFERENCES `direccion` (`id_direccion`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE SET NULL;

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `borrar_productos_inactivos` ON SCHEDULE EVERY 1 DAY STARTS '2026-02-27 14:23:59' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DELETE FROM producto
    WHERE activo = 0
    AND eliminado_en IS NOT NULL
    AND eliminado_en < NOW() - INTERVAL 3 YEAR;
END$$

CREATE DEFINER=`root`@`localhost` EVENT `limpiar_auditoria` ON SCHEDULE EVERY 1 DAY STARTS '2026-02-27 14:40:20' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM Auditoria
  WHERE fecha < NOW() - INTERVAL 1 YEAR$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

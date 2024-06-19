-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2024 a las 07:30:32
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `login_registro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `ID_estado` int(11) NOT NULL,
  `Tipo_estado` varchar(45) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`ID_estado`, `Tipo_estado`, `fecha_ingreso`) VALUES
(101, 'Activo', '2024-06-02 02:47:09'),
(102, 'Inactivo', '2024-06-02 02:45:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE `registro` (
  `ID_registro` int(11) NOT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  `Estado_ID_estado` int(11) NOT NULL,
  `Usuario_ID_user` int(11) NOT NULL,
  `Tipo_ID_tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `ID_tipo` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `fecha_ingreso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`ID_tipo`, `Nombre`, `fecha_ingreso`) VALUES
(201, 'Usuario', '2024-06-02 02:56:57'),
(202, 'Administrador', '2024-06-02 02:56:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `ID_user` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Apellido` varchar(45) NOT NULL,
  `Correo` varchar(45) NOT NULL,
  `Password` varchar(45) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID_user`, `Nombre`, `Apellido`, `Correo`, `Password`, `fecha_ingreso`) VALUES
(1, 'Victor', '', 'aaaaa@aaaa.com', '$2y$10$nqVfiY4V0nXIOyaHcEr2/ulMtY0WhQzEXryouf', NULL),
(2, 'marco', '', 'aaaa', '$2y$10$EhxhUx44jfsYVl8owgNeQesGagKMGw1SmSObvV', NULL),
(3, 'fer', '', 'fadasd', '$2y$10$MdWpiS0bekisQpTV9Y6vsOAoNuWLYBJFRFnMOV', NULL),
(4, 'Botashe', '', 'victor@gmail.com', '$2y$10$asIAeo7lUAF9/VLNPjmlcOusl5ikQoUdH8dxEq', NULL),
(6, 'Francisco', '', 'fran@gmail.cl', '12345', NULL),
(7, 'Valentin', '', 'val@a', '$2y$10$Nyl5BdhXnVX3V5aXY3kTnOulf9/lSjFsBDiu7t', NULL),
(8, 'martin', '', 'mar11', '$2y$10$/I36CEGc2C4MVcmu.PsEyeWWu2Jjl1vux7tscU', NULL),
(9, 'claudia', '', 'claulatonta', '$2y$10$d3dkHmjkusm890sDOW/dh.neNp6n6PIA99Ie59', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`ID_estado`);

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`ID_registro`),
  ADD KEY `fk_Registro_Estado_idx` (`Estado_ID_estado`),
  ADD KEY `fk_Registro_Usuario1_idx` (`Usuario_ID_user`),
  ADD KEY `fk_Registro_Tipo1_idx` (`Tipo_ID_tipo`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`ID_tipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `ID_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT de la tabla `registro`
--
ALTER TABLE `registro`
  MODIFY `ID_registro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo`
--
ALTER TABLE `tipo`
  MODIFY `ID_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=203;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `fk_Registro_Estado` FOREIGN KEY (`Estado_ID_estado`) REFERENCES `estado` (`ID_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Registro_Tipo1` FOREIGN KEY (`Tipo_ID_tipo`) REFERENCES `tipo` (`ID_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Registro_Usuario1` FOREIGN KEY (`Usuario_ID_user`) REFERENCES `usuario` (`ID_user`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE DATABASE  IF NOT EXISTS `gestioncliente` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestioncliente`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: gestioncliente
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID_CLIENTE` int NOT NULL AUTO_INCREMENT,
  `CLI_NOMBRE` varchar(100) NOT NULL,
  `CLI_APELLIDO` varchar(100) NOT NULL,
  `DNI` varchar(30) NOT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `ID_ESTADO` int NOT NULL,
  `CLI_TELEFONO` varchar(20) DEFAULT NULL,
  `DIRECCION` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_CLIENTE`),
  KEY `IX_CLIENTE_DNI` (`DNI`),
  KEY `IX_CLIENTE_EMAIL` (`EMAIL`),
  KEY `IX_CLIENTE_ESTADO` (`ID_ESTADO`),
  CONSTRAINT `FK_CLIENTE_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `estado` (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contrato`
--

DROP TABLE IF EXISTS `contrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrato` (
  `ID_CONTRATO` int NOT NULL AUTO_INCREMENT,
  `ID_PRODUCTO` int NOT NULL,
  `ID_POLITICA` int NOT NULL,
  `ID_CLIENTE` int NOT NULL,
  `ID_ESTADO` int NOT NULL,
  `FCH_CONTRATO` date NOT NULL,
  `FCH_VIGENCIA` date DEFAULT NULL,
  `FCH_FIN` date DEFAULT NULL,
  PRIMARY KEY (`ID_CONTRATO`),
  KEY `FK_CONTRATO_POLITICA` (`ID_POLITICA`),
  KEY `FK_CONTRATO_CLIENTE` (`ID_CLIENTE`),
  KEY `IX_CONTRATO_ESTADO` (`ID_ESTADO`),
  KEY `IX_CONTRATO_PRODUCTO` (`ID_PRODUCTO`),
  KEY `IX_CONTRATO_VIGENCIA` (`FCH_VIGENCIA`,`FCH_FIN`),
  CONSTRAINT `FK_CONTRATO_CLIENTE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`),
  CONSTRAINT `FK_CONTRATO_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `estado` (`ID_ESTADO`),
  CONSTRAINT `FK_CONTRATO_POLITICA` FOREIGN KEY (`ID_POLITICA`) REFERENCES `politica` (`ID_POLITICA`),
  CONSTRAINT `FK_CONTRATO_PRODUCTO` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `producto` (`ID_PRODUCTO`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_CONTRATO_CONTROL_PRODPOL` BEFORE INSERT ON `contrato` FOR EACH ROW BEGIN
	DECLARE IS_EXISTE BOOLEAN DEFAULT 0;
    
    SELECT 1 FROM PRODUCTOPOL 
    WHERE ID_PRODUCTO = NEW.ID_PRODUCTO 
    AND ID_POLITICA = NEW.ID_POLITICA 
    INTO IS_EXISTE;
    
	IF IS_EXISTE = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Producto y politica no asociados';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `contratoprm`
--

DROP TABLE IF EXISTS `contratoprm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratoprm` (
  `ID_CONTRATOPRM` int NOT NULL AUTO_INCREMENT,
  `ID_CONTRATO` int NOT NULL,
  `ID_PROMOCION` int NOT NULL,
  `PRM_FCH_INI` date NOT NULL,
  `PRM_FCH_FIN` date NOT NULL,
  PRIMARY KEY (`ID_CONTRATOPRM`),
  KEY `FK_CONTRATOPRM_CONTRATO` (`ID_CONTRATO`),
  KEY `FK_CONTRATOPRM_PROMOCION` (`ID_PROMOCION`),
  CONSTRAINT `FK_CONTRATOPRM_CONTRATO` FOREIGN KEY (`ID_CONTRATO`) REFERENCES `contrato` (`ID_CONTRATO`),
  CONSTRAINT `FK_CONTRATOPRM_PROMOCION` FOREIGN KEY (`ID_PROMOCION`) REFERENCES `promocion` (`ID_PROMOCION`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_CONTRATO_CONTROL_PRODPOLPRM` BEFORE INSERT ON `contratoprm` FOR EACH ROW BEGIN
	DECLARE IS_EXISTE BOOLEAN DEFAULT 0;
    DECLARE T_PRODUCTO INT;
    DECLARE T_POLITICA INT;
    
    SELECT ID_PRODUCTO, ID_POLITICA 
    INTO T_PRODUCTO, T_POLITICA
    FROM CONTRATO
    WHERE ID_CONTRATO = NEW.ID_CONTRATO;

	SELECT 1 INTO IS_EXISTE
    FROM PRODUCTOPRM 
	WHERE ID_PRODUCTO = T_PRODUCTO 
	AND ID_POLITICA = T_POLITICA
	AND ID_PROMOCION = NEW.ID_PROMOCION;
    
	IF IS_EXISTE = 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Producto, politica y promoción no asociados';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_CONTRATOPRM_CONTROL_PRM_ACTIVA` BEFORE INSERT ON `contratoprm` FOR EACH ROW BEGIN
	DECLARE IS_TIENE BOOLEAN;
    SELECT FN_TIENE_PROMO(NEW.ID_CONTRATO) INTO IS_TIENE;
	IF IS_TIENE = 1 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Contrato ya tiene una promo activa';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado` (
  `ID_ESTADO` int NOT NULL AUTO_INCREMENT,
  `ENTIDAD` varchar(50) NOT NULL,
  `DESCRIPCION` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_ESTADO`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `ID_FACTURA` int NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int NOT NULL,
  `IS_PAGA` tinyint(1) NOT NULL DEFAULT (0),
  `FAC_FCH` date NOT NULL,
  `FAC_TOTAL` decimal(10,2) NOT NULL,
  `FAC_FCH_PAGO` date DEFAULT NULL,
  `FACTURA_ULT_LIN` int DEFAULT '0',
  PRIMARY KEY (`ID_FACTURA`),
  KEY `IX_FACTURA_CLIENTE` (`ID_CLIENTE`),
  KEY `IX_FACTURA_FECHA` (`FAC_FCH`),
  KEY `IX_FACTURA_PAGO` (`FAC_FCH_PAGO`),
  CONSTRAINT `FK_FACTURA_CLIENTE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facturalinea`
--

DROP TABLE IF EXISTS `facturalinea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturalinea` (
  `ID_FACTURA` int NOT NULL,
  `ID_FACTURALIN` int NOT NULL,
  `ID_CONTRATO` int NOT NULL,
  `FAC_LIN_IMP` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID_FACTURA`,`ID_FACTURALIN`),
  KEY `FK_FACTURALIN_CONTRATO` (`ID_CONTRATO`),
  CONSTRAINT `FK_FACTURALIN_CONTRATO` FOREIGN KEY (`ID_CONTRATO`) REFERENCES `contrato` (`ID_CONTRATO`),
  CONSTRAINT `FK_FACTURALIN_FACTURA` FOREIGN KEY (`ID_FACTURA`) REFERENCES `factura` (`ID_FACTURA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_UPD_FACTURA_ULT_LIN` AFTER INSERT ON `facturalinea` FOR EACH ROW BEGIN
	UPDATE FACTURA SET FACTURA_ULT_LIN = (SELECT MAX(ID_FACTURALIN) FROM FACTURALINEA WHERE ID_FACTURA = NEW.ID_FACTURA)
	WHERE ID_FACTURA = NEW.ID_FACTURA;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `log_politica`
--

DROP TABLE IF EXISTS `log_politica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_politica` (
  `ID_POL_LOG` int NOT NULL AUTO_INCREMENT,
  `ID_POLITICA` int NOT NULL,
  `POL_PRECIO_OLD` decimal(10,2) DEFAULT NULL,
  `POL_PRECIO_NEW` decimal(10,2) NOT NULL,
  `LOG_POL_FCH` date NOT NULL,
  PRIMARY KEY (`ID_POL_LOG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_promocion`
--

DROP TABLE IF EXISTS `log_promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_promocion` (
  `ID_PRM_LOG` int NOT NULL AUTO_INCREMENT,
  `ID_PROMOCION` int NOT NULL,
  `ID_CAMPO` enum('PRM_DTO','PRM_CNT_MESES') DEFAULT NULL,
  `VALOR_OLD` int DEFAULT NULL,
  `VALOR_NEW` int DEFAULT NULL,
  `LOG_PRM_FCH` date NOT NULL,
  PRIMARY KEY (`ID_PRM_LOG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ordenservicio`
--

DROP TABLE IF EXISTS `ordenservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenservicio` (
  `ID_ORDEN` int NOT NULL AUTO_INCREMENT,
  `ID_CONTRATO` int NOT NULL,
  `ID_ORDENTPO` varchar(1) NOT NULL,
  `ORD_FCH` date NOT NULL,
  `ORD_FCH_FIN` date DEFAULT NULL,
  `ID_ESTADO` int NOT NULL,
  PRIMARY KEY (`ID_ORDEN`),
  KEY `FK_ORDENSRV_ORDENTPO` (`ID_ORDENTPO`),
  KEY `IX_ORDENSRV_CONTRATO` (`ID_CONTRATO`),
  KEY `IX_ORDENSRV_ESTADO` (`ID_ESTADO`),
  KEY `IX_ORDENSRV_FECHA` (`ORD_FCH`),
  CONSTRAINT `FK_ORDENSRV_CONTRATO` FOREIGN KEY (`ID_CONTRATO`) REFERENCES `contrato` (`ID_CONTRATO`),
  CONSTRAINT `FK_ORDENSRV_ESTADO` FOREIGN KEY (`ID_ESTADO`) REFERENCES `estado` (`ID_ESTADO`),
  CONSTRAINT `FK_ORDENSRV_ORDENTPO` FOREIGN KEY (`ID_ORDENTPO`) REFERENCES `ordentipo` (`ID_ORDENTPO`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ordentipo`
--

DROP TABLE IF EXISTS `ordentipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordentipo` (
  `ID_ORDENTPO` varchar(1) NOT NULL,
  `DESCRIPCION` varchar(30) NOT NULL,
  PRIMARY KEY (`ID_ORDENTPO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `politica`
--

DROP TABLE IF EXISTS `politica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `politica` (
  `ID_POLITICA` int NOT NULL AUTO_INCREMENT,
  `POL_NOMBRE` varchar(100) NOT NULL,
  `POL_PRECIO` decimal(10,2) NOT NULL,
  `IS_ACTIVO` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_POLITICA`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_LOG_POLITICA` AFTER UPDATE ON `politica` FOR EACH ROW BEGIN
	INSERT INTO LOG_POLITICA (ID_POLITICA, POL_PRECIO_OLD, POL_PRECIO_NEW, LOG_POL_FCH) VALUES
    (OLD.ID_POLITICA, OLD.POL_PRECIO, NEW.POL_PRECIO, CURDATE());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `ID_PRODUCTO` int NOT NULL AUTO_INCREMENT,
  `PRD_NOMBRE` varchar(100) NOT NULL,
  `IS_ACTIVO` tinyint(1) NOT NULL DEFAULT '0',
  `ID_PRODUCTOTPO` varchar(1) NOT NULL,
  PRIMARY KEY (`ID_PRODUCTO`),
  KEY `FK_PRODUCTO_PRODUCTOTPO` (`ID_PRODUCTOTPO`),
  CONSTRAINT `FK_PRODUCTO_PRODUCTOTPO` FOREIGN KEY (`ID_PRODUCTOTPO`) REFERENCES `productotpo` (`ID_PRODUCTOTPO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productopol`
--

DROP TABLE IF EXISTS `productopol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productopol` (
  `ID_PRODUCTO` int NOT NULL,
  `ID_POLITICA` int NOT NULL,
  PRIMARY KEY (`ID_PRODUCTO`,`ID_POLITICA`),
  KEY `FK_PRODUCTOPOL_POLITICA` (`ID_POLITICA`),
  CONSTRAINT `FK_PRODUCTOPOL_POLITICA` FOREIGN KEY (`ID_POLITICA`) REFERENCES `politica` (`ID_POLITICA`),
  CONSTRAINT `FK_PRODUCTOPOL_PRODUCTO` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `producto` (`ID_PRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productoprm`
--

DROP TABLE IF EXISTS `productoprm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productoprm` (
  `ID_PRODUCTO` int NOT NULL,
  `ID_POLITICA` int NOT NULL,
  `ID_PROMOCION` int NOT NULL,
  PRIMARY KEY (`ID_PRODUCTO`,`ID_POLITICA`,`ID_PROMOCION`),
  KEY `FK_PRODUCTOPRM_POLITICA` (`ID_POLITICA`),
  KEY `FK_PRODUCTOPRM_PROMOCION` (`ID_PROMOCION`),
  CONSTRAINT `FK_PRODUCTOPRM_POLITICA` FOREIGN KEY (`ID_POLITICA`) REFERENCES `politica` (`ID_POLITICA`),
  CONSTRAINT `FK_PRODUCTOPRM_PRODUCTO` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `producto` (`ID_PRODUCTO`),
  CONSTRAINT `FK_PRODUCTOPRM_PROMOCION` FOREIGN KEY (`ID_PROMOCION`) REFERENCES `promocion` (`ID_PROMOCION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productotpo`
--

DROP TABLE IF EXISTS `productotpo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productotpo` (
  `ID_PRODUCTOTPO` varchar(1) NOT NULL,
  `PRD_TPO_NOMBRE` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_PRODUCTOTPO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `promocion`
--

DROP TABLE IF EXISTS `promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promocion` (
  `ID_PROMOCION` int NOT NULL AUTO_INCREMENT,
  `PRM_NOMBRE` varchar(100) NOT NULL,
  `PRM_DTO` int NOT NULL,
  `PRM_CNT_MESES` int NOT NULL,
  `IS_ACTIVO` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_PROMOCION`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_LOG_PROMOCION` AFTER UPDATE ON `promocion` FOR EACH ROW BEGIN
	IF OLD.PRM_DTO <> NEW.PRM_DTO THEN
		INSERT INTO LOG_PROMOCION (ID_PROMOCION, ID_CAMPO, VALOR_OLD, VALOR_NEW, LOG_PRM_FCH) VALUES
		(OLD.ID_PROMOCION, 'PRM_DTO', OLD.PRM_DTO, NEW.PRM_DTO, CURDATE());
    END IF;
    
	IF OLD.PRM_CNT_MESES <> NEW.PRM_CNT_MESES THEN
		INSERT INTO LOG_PROMOCION (ID_PROMOCION, ID_CAMPO, VALOR_OLD, VALOR_NEW, LOG_PRM_FCH) VALUES
		(OLD.ID_PROMOCION, 'PRM_CNT_MESES', OLD.PRM_CNT_MESES, NEW.PRM_CNT_MESES, CURDATE());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vw_facturas_detalles`
--

DROP TABLE IF EXISTS `vw_facturas_detalles`;
/*!50001 DROP VIEW IF EXISTS `vw_facturas_detalles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_facturas_detalles` AS SELECT 
 1 AS `ID_CLIENTE`,
 1 AS `CLIENTE`,
 1 AS `FACTURA`,
 1 AS `LINEA`,
 1 AS `PRODUCTO`,
 1 AS `POLITICA`,
 1 AS `PRECIO`,
 1 AS `PROMOCION`,
 1 AS `DESCUENTO`,
 1 AS `IMPORTE FINAL`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_most_prdtpo`
--

DROP TABLE IF EXISTS `vw_most_prdtpo`;
/*!50001 DROP VIEW IF EXISTS `vw_most_prdtpo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_most_prdtpo` AS SELECT 
 1 AS `TIPO`,
 1 AS `CANTIDAD FACTURAS`,
 1 AS `TOTAL FACTURADO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_prd_config_activos`
--

DROP TABLE IF EXISTS `vw_prd_config_activos`;
/*!50001 DROP VIEW IF EXISTS `vw_prd_config_activos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_prd_config_activos` AS SELECT 
 1 AS `ID_PRODUCTO`,
 1 AS `PRODUCTO`,
 1 AS `ID_POLITICA`,
 1 AS `POLITICA`,
 1 AS `ID_PROMOCION`,
 1 AS `PROMOCION`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_productos_contratados`
--

DROP TABLE IF EXISTS `vw_productos_contratados`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_contratados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_contratados` AS SELECT 
 1 AS `ID`,
 1 AS `PRODUCTO`,
 1 AS `CANTIDAD CONECTADOS`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_productostpo_contratados`
--

DROP TABLE IF EXISTS `vw_productostpo_contratados`;
/*!50001 DROP VIEW IF EXISTS `vw_productostpo_contratados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productostpo_contratados` AS SELECT 
 1 AS `TIPO`,
 1 AS `CANTIDAD CONTRATADOS`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_servicios_generados`
--

DROP TABLE IF EXISTS `vw_servicios_generados`;
/*!50001 DROP VIEW IF EXISTS `vw_servicios_generados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_servicios_generados` AS SELECT 
 1 AS `CLIENTE`,
 1 AS `CONTRATO`,
 1 AS `ESTADO`,
 1 AS `PRODUCTO`,
 1 AS `POLITICA`,
 1 AS `PRECIO`,
 1 AS `PROMOCION`,
 1 AS `FECHA INGRESO`,
 1 AS `FECHA VIGENCIA`,
 1 AS `FECHA DESCONEXION`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'gestioncliente'
--
/*!50003 DROP FUNCTION IF EXISTS `FN_BUSCAR_ESTADO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_BUSCAR_ESTADO`(F_ENTIDAD VARCHAR(50), F_ESTADO VARCHAR(50)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE F_ID_ESTADO INT DEFAULT 0;

    SELECT ID_ESTADO INTO F_ID_ESTADO
    FROM ESTADO
    WHERE ENTIDAD = F_ENTIDAD
    AND DESCRIPCION = F_ESTADO;

    RETURN F_ID_ESTADO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_CLIENTE_APE_NOM` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_CLIENTE_APE_NOM`(F_CLIENTE INT) RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE APENOM VARCHAR(200);

	SELECT CONCAT(TRIM(CLI_NOMBRE),' ',TRIM(CLI_APELLIDO)) INTO APENOM
    FROM CLIENTE
    WHERE ID_CLIENTE = F_CLIENTE;

    RETURN APENOM;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_NEW_FAC_LIN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_NEW_FAC_LIN`(F_FACTURA INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE NEW_ID_FACTURALIN INT;

    SELECT FACTURA_ULT_LIN + 1 INTO NEW_ID_FACTURALIN FROM FACTURA WHERE ID_FACTURA = F_FACTURA;
    RETURN NEW_ID_FACTURALIN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_OBTENER_DTO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_OBTENER_DTO`(F_CONTRATO INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE F_DTO INT DEFAULT 0;
	
	SELECT P.PRM_DTO INTO F_DTO FROM CONTRATOPRM CP
	INNER JOIN PROMOCION P
		ON CP.ID_PROMOCION = P.ID_PROMOCION
	WHERE CP.ID_CONTRATO = F_CONTRATO
	AND PRM_FCH_INI <= CURDATE()
	AND PRM_FCH_FIN >= CURDATE()
	LIMIT 1;

	RETURN F_DTO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_TIENE_PROMO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_TIENE_PROMO`(F_CONTRATO INT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE IS_TIENE INT DEFAULT 0;
	
	SELECT COUNT(*) INTO IS_TIENE FROM CONTRATOPRM 
	WHERE ID_CONTRATO = F_CONTRATO
	AND PRM_FCH_INI <= CURDATE()
	AND PRM_FCH_FIN >= CURDATE();

	RETURN IS_TIENE > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_TOTAL_FACTURA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_TOTAL_FACTURA`(F_CLIENTE INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
	DECLARE FN_TOTAL DECIMAL(10,2);
	DECLARE F_ESTADO INT;

	SELECT FN_BUSCAR_ESTADO('CONTRATO','CONECTADO') INTO F_ESTADO;

	SELECT SUM(P.POL_PRECIO * (1 - (FN_OBTENER_DTO(CO.ID_CONTRATO))/100)) INTO FN_TOTAL 
	FROM CONTRATO CO
    INNER JOIN POLITICA P
        ON P.ID_POLITICA = CO.ID_POLITICA
	WHERE CO.ID_CLIENTE = F_CLIENTE
    AND CO.ID_ESTADO = F_ESTADO;

    RETURN FN_TOTAL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_INS_CLIENTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INS_CLIENTE`(P_NOMBRE VARCHAR(100), P_APELLIDO VARCHAR(100), P_DNI VARCHAR(30), P_EMAIL VARCHAR(100), P_STS VARCHAR(50), P_TEL VARCHAR(20), P_DIR VARCHAR(100))
BEGIN
    DECLARE P_ESTADO INT;
    SELECT FN_BUSCAR_ESTADO('CLIENTE',P_STS) INTO P_ESTADO;
    INSERT INTO CLIENTE (CLI_NOMBRE,CLI_APELLIDO,DNI,EMAIL,ID_ESTADO,CLI_TELEFONO,DIRECCION) 
    VALUES (P_NOMBRE,P_APELLIDO,P_DNI,P_EMAIL,P_ESTADO,P_TEL,P_DIR);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_INS_CONTRATO` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INS_CONTRATO`(P_PRODUCTO INT, P_POLITICA INT, P_PROMOCION INT, P_CLIENTE INT, P_FCH_CONTRATO DATE, P_FCH_VIGENCIA DATE, P_STS VARCHAR(50))
BEGIN
    DECLARE P_ESTADO INT;
	DECLARE P_CNT_MESES INT;
	DECLARE P_CONTRATO INT;

    SELECT FN_BUSCAR_ESTADO('CONTRATO',P_STS) INTO P_ESTADO;

    INSERT INTO CONTRATO (ID_PRODUCTO,ID_POLITICA,ID_CLIENTE,ID_ESTADO,FCH_CONTRATO,FCH_VIGENCIA,FCH_FIN) 
    VALUES (P_PRODUCTO,P_POLITICA,P_CLIENTE,P_ESTADO,P_FCH_CONTRATO,P_FCH_VIGENCIA,NULL);

	SET P_CONTRATO = LAST_INSERT_ID();

	IF P_PROMOCION > 0 THEN 
		SELECT PRM_CNT_MESES INTO P_CNT_MESES
		FROM PROMOCION
		WHERE ID_PROMOCION = P_PROMOCION;
	
		INSERT INTO CONTRATOPRM (ID_CONTRATO,ID_PROMOCION,PRM_FCH_INI,PRM_FCH_FIN) 
		VALUES (P_CONTRATO,P_PROMOCION,P_FCH_CONTRATO,DATE_ADD(P_FCH_CONTRATO, INTERVAL P_CNT_MESES MONTH));
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_INS_FACTURA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INS_FACTURA`(P_CLIENTE INT, P_PAGA BOOLEAN, P_FCH DATE, P_FCH_PAGO DATE)
BEGIN
    DECLARE P_TOTAL DECIMAL(10,2);
    DECLARE P_ID_FACTURALIN INT;
    DECLARE P_ESTADO INT;
	DECLARE P_FACTURA INT;
	
    SELECT FN_TOTAL_FACTURA(P_CLIENTE) INTO P_TOTAL;
    
    /*CREO EL CABEZAL DE LA FACTURA*/
    INSERT INTO FACTURA (ID_CLIENTE,IS_PAGA,FAC_FCH,FAC_TOTAL,FAC_FCH_PAGO,FACTURA_ULT_LIN) 
    VALUES (P_CLIENTE,P_PAGA,P_FCH,P_TOTAL,P_FCH_PAGO,0);

	SET P_FACTURA = LAST_INSERT_ID();
    
    /*CREO LAS LINEAS DE LA FACTURA POR CONTRATO FACTURADO*/
    SELECT FN_BUSCAR_ESTADO('CONTRATO','CONECTADO') INTO P_ESTADO;
	
    INSERT INTO FACTURALINEA 
    SELECT P_FACTURA,FN_NEW_FAC_LIN(P_FACTURA),CO.ID_CONTRATO,P.POL_PRECIO * (1 - FN_OBTENER_DTO(CO.ID_CONTRATO)/100)
    FROM CONTRATO CO
    INNER JOIN POLITICA P
        ON P.ID_POLITICA = CO.ID_POLITICA
	WHERE CO.ID_CLIENTE = P_CLIENTE
    AND CO.ID_ESTADO = P_ESTADO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_ORDENES_ATRASADAS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ORDENES_ATRASADAS`(P_CNT_DIAS INT)
BEGIN
	SELECT O.*, E.DESCRIPCION AS 'ESTADO',DATEDIFF(CURDATE(),O.ORD_FCH) AS 'DIAS ATRASADOS' FROM ORDENSERVICIO O
    INNER JOIN ESTADO E
		ON E.ID_ESTADO = O.ID_ESTADO
	WHERE O.ORD_FCH_FIN IS NULL
	AND DATEDIFF(CURDATE(),O.ORD_FCH) >= P_CNT_DIAS;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_facturas_detalles`
--

/*!50001 DROP VIEW IF EXISTS `vw_facturas_detalles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_facturas_detalles` AS select `f`.`ID_CLIENTE` AS `ID_CLIENTE`,`FN_CLIENTE_APE_NOM`(`f`.`ID_CLIENTE`) AS `CLIENTE`,`f`.`ID_FACTURA` AS `FACTURA`,`fl`.`ID_FACTURALIN` AS `LINEA`,`p`.`PRD_NOMBRE` AS `PRODUCTO`,`pl`.`POL_NOMBRE` AS `POLITICA`,`pl`.`POL_PRECIO` AS `PRECIO`,`pr`.`PRM_NOMBRE` AS `PROMOCION`,`pr`.`PRM_DTO` AS `DESCUENTO`,`fl`.`FAC_LIN_IMP` AS `IMPORTE FINAL` from (((((((`factura` `f` join `cliente` `c` on((`c`.`ID_CLIENTE` = `f`.`ID_CLIENTE`))) join `facturalinea` `fl` on((`fl`.`ID_FACTURA` = `f`.`ID_FACTURA`))) join `contrato` `co` on((`co`.`ID_CONTRATO` = `fl`.`ID_CONTRATO`))) join `producto` `p` on((`p`.`ID_PRODUCTO` = `co`.`ID_PRODUCTO`))) join `politica` `pl` on((`pl`.`ID_POLITICA` = `co`.`ID_POLITICA`))) join `contratoprm` `cp` on((`cp`.`ID_CONTRATO` = `co`.`ID_CONTRATO`))) join `promocion` `pr` on((`pr`.`ID_PROMOCION` = `cp`.`ID_PROMOCION`))) order by `f`.`ID_CLIENTE`,`f`.`ID_FACTURA`,`fl`.`ID_FACTURALIN` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_most_prdtpo`
--

/*!50001 DROP VIEW IF EXISTS `vw_most_prdtpo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_most_prdtpo` AS select `pt`.`PRD_TPO_NOMBRE` AS `TIPO`,count(0) AS `CANTIDAD FACTURAS`,sum(`fl`.`FAC_LIN_IMP`) AS `TOTAL FACTURADO` from (((`facturalinea` `fl` join `contrato` `co` on((`co`.`ID_CONTRATO` = `fl`.`ID_CONTRATO`))) join `producto` `p` on((`p`.`ID_PRODUCTO` = `co`.`ID_PRODUCTO`))) join `productotpo` `pt` on((`pt`.`ID_PRODUCTOTPO` = `p`.`ID_PRODUCTOTPO`))) group by `p`.`ID_PRODUCTOTPO`,`pt`.`PRD_TPO_NOMBRE` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_prd_config_activos`
--

/*!50001 DROP VIEW IF EXISTS `vw_prd_config_activos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_prd_config_activos` AS select `p`.`ID_PRODUCTO` AS `ID_PRODUCTO`,`p`.`PRD_NOMBRE` AS `PRODUCTO`,`pl`.`ID_POLITICA` AS `ID_POLITICA`,`pl`.`POL_NOMBRE` AS `POLITICA`,`pr`.`ID_PROMOCION` AS `ID_PROMOCION`,`pr`.`PRM_NOMBRE` AS `PROMOCION` from ((((`productoprm` `prm` join `productopol` `pp` on(((`pp`.`ID_PRODUCTO` = `prm`.`ID_PRODUCTO`) and (`pp`.`ID_POLITICA` = `prm`.`ID_POLITICA`)))) join `producto` `p` on((`p`.`ID_PRODUCTO` = `prm`.`ID_PRODUCTO`))) join `politica` `pl` on((`pl`.`ID_POLITICA` = `prm`.`ID_POLITICA`))) join `promocion` `pr` on((`pr`.`ID_PROMOCION` = `prm`.`ID_PROMOCION`))) where ((`p`.`IS_ACTIVO` = 1) and (`pl`.`IS_ACTIVO` = 1)) order by `prm`.`ID_PRODUCTO`,`prm`.`ID_POLITICA`,`prm`.`ID_PROMOCION` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_productos_contratados`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_contratados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_contratados` AS select `p`.`ID_PRODUCTO` AS `ID`,`p`.`PRD_NOMBRE` AS `PRODUCTO`,count(`p`.`ID_PRODUCTO`) AS `CANTIDAD CONECTADOS` from (`contrato` `co` join `producto` `p` on((`p`.`ID_PRODUCTO` = `co`.`ID_PRODUCTO`))) where (`co`.`ID_ESTADO` = `FN_BUSCAR_ESTADO`('CONTRATO','CONECTADO')) group by `p`.`ID_PRODUCTO` order by `p`.`ID_PRODUCTO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_productostpo_contratados`
--

/*!50001 DROP VIEW IF EXISTS `vw_productostpo_contratados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productostpo_contratados` AS select `pt`.`PRD_TPO_NOMBRE` AS `TIPO`,count(0) AS `CANTIDAD CONTRATADOS` from ((`contrato` `co` join `producto` `p` on((`p`.`ID_PRODUCTO` = `co`.`ID_PRODUCTO`))) join `productotpo` `pt` on((`pt`.`ID_PRODUCTOTPO` = `p`.`ID_PRODUCTOTPO`))) where (`co`.`ID_ESTADO` in (`FN_BUSCAR_ESTADO`('CONTRATO','CONECTADO'),`FN_BUSCAR_ESTADO`('CONTRATO','INGRESADO'))) group by `pt`.`PRD_TPO_NOMBRE` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_servicios_generados`
--

/*!50001 DROP VIEW IF EXISTS `vw_servicios_generados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_servicios_generados` AS select `FN_CLIENTE_APE_NOM`(`co`.`ID_CLIENTE`) AS `CLIENTE`,`co`.`ID_CONTRATO` AS `CONTRATO`,`s`.`DESCRIPCION` AS `ESTADO`,`p`.`PRD_NOMBRE` AS `PRODUCTO`,`pl`.`POL_NOMBRE` AS `POLITICA`,`pl`.`POL_PRECIO` AS `PRECIO`,ifnull((select `pr`.`PRM_NOMBRE` from (`contratoprm` `cp` join `promocion` `pr` on((`pr`.`ID_PROMOCION` = `cp`.`ID_PROMOCION`))) where ((`cp`.`ID_CONTRATO` = `co`.`ID_CONTRATO`) and (`cp`.`PRM_FCH_INI` <= curdate()) and (`cp`.`PRM_FCH_FIN` >= curdate())) limit 1),'') AS `PROMOCION`,`co`.`FCH_CONTRATO` AS `FECHA INGRESO`,`co`.`FCH_VIGENCIA` AS `FECHA VIGENCIA`,`co`.`FCH_FIN` AS `FECHA DESCONEXION` from ((((`contrato` `co` join `cliente` `c` on((`c`.`ID_CLIENTE` = `co`.`ID_CLIENTE`))) join `producto` `p` on((`p`.`ID_PRODUCTO` = `co`.`ID_PRODUCTO`))) join `politica` `pl` on((`pl`.`ID_POLITICA` = `co`.`ID_POLITICA`))) join `estado` `s` on((`s`.`ID_ESTADO` = `co`.`ID_ESTADO`))) order by `co`.`ID_CLIENTE`,`co`.`ID_CONTRATO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-25 19:49:51

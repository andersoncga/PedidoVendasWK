CREATE DATABASE  IF NOT EXISTS `pvwk` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pvwk`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pvwk
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `produtospedidos`
--

DROP TABLE IF EXISTS `produtospedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtospedidos` (
  `codigoitem` int NOT NULL AUTO_INCREMENT,
  `numeropedido` int DEFAULT NULL,
  `codigoproduto` int DEFAULT NULL,
  `quantidade` int NOT NULL,
  `valorunitario` decimal(12,2) NOT NULL,
  `valortotal` decimal(12,2) NOT NULL,
  PRIMARY KEY (`codigoitem`),
  KEY `FKNumeroPedido1_idx` (`numeropedido`),
  KEY `FKCodigoProduto2_idx` (`codigoproduto`),
  CONSTRAINT `FKCodigoProduto2` FOREIGN KEY (`codigoproduto`) REFERENCES `produtos` (`codigo`),
  CONSTRAINT `FKNumeroPedido1` FOREIGN KEY (`numeropedido`) REFERENCES `pedidos` (`numeropedido`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtospedidos`
--

LOCK TABLES `produtospedidos` WRITE;
/*!40000 ALTER TABLE `produtospedidos` DISABLE KEYS */;
INSERT INTO `produtospedidos` VALUES (1,1,1,1,1.00,1.00),(2,2,2,1,2.00,2.00),(3,3,3,1,3.00,3.00),(4,4,4,1,4.00,4.00),(5,5,5,1,5.00,5.00),(6,6,6,1,6.00,6.00),(7,7,7,1,7.00,7.00),(8,8,8,1,8.00,8.00),(9,9,9,1,9.00,9.00),(10,10,10,1,10.00,10.00),(11,11,11,1,11.00,11.00),(12,12,12,1,12.00,12.00),(13,13,13,1,13.00,13.00),(14,14,14,1,14.00,14.00),(15,15,15,1,15.00,15.00),(16,16,16,1,16.00,16.00),(17,17,17,1,17.00,17.00),(18,18,18,1,18.00,18.00),(19,19,19,1,19.00,19.00),(20,20,20,1,20.00,20.00);
/*!40000 ALTER TABLE `produtospedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-27 14:53:20

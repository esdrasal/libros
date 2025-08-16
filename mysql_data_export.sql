-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: libros_development
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `active_storage_attachments`
--

DROP TABLE IF EXISTS `active_storage_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `active_storage_attachments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `record_type` varchar(255) NOT NULL,
  `record_id` bigint NOT NULL,
  `blob_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_attachments_uniqueness` (`record_type`,`record_id`,`name`,`blob_id`),
  KEY `index_active_storage_attachments_on_blob_id` (`blob_id`),
  CONSTRAINT `fk_rails_c3b3935057` FOREIGN KEY (`blob_id`) REFERENCES `active_storage_blobs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_attachments`
--

LOCK TABLES `active_storage_attachments` WRITE;
/*!40000 ALTER TABLE `active_storage_attachments` DISABLE KEYS */;
INSERT INTO `active_storage_attachments` VALUES (9,'pdf','Libro',9,9,'2025-08-15 00:58:35.548156'),(10,'pdf','Libro',10,10,'2025-08-15 02:20:08.739410'),(12,'pdf','Libro',12,12,'2025-08-15 02:23:45.428436'),(13,'pdf','Libro',13,13,'2025-08-15 02:34:31.304159'),(14,'pdf','Libro',14,14,'2025-08-15 03:22:56.265978');
/*!40000 ALTER TABLE `active_storage_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_storage_blobs`
--

DROP TABLE IF EXISTS `active_storage_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `active_storage_blobs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `metadata` text,
  `service_name` varchar(255) NOT NULL,
  `byte_size` bigint NOT NULL,
  `checksum` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_blobs_on_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_blobs`
--

LOCK TABLES `active_storage_blobs` WRITE;
/*!40000 ALTER TABLE `active_storage_blobs` DISABLE KEYS */;
INSERT INTO `active_storage_blobs` VALUES (9,'wos5j2kdn2jmevsnn2op2l9224iw','Como habla Dios_ - Francis S. Collins.pdf','application/pdf','{\"identified\":true,\"analyzed\":true}','local',1768504,'5zskarOyNZh9mqHKT8HSig==','2025-08-15 00:58:35.546455'),(10,'mi6tlhggfndoqql1z8s3nf128o4s','!Cuidado con esa boca! (Spanish - Tony Evans.pdf','application/pdf','{\"identified\":true}','local',1231915,'g6EgxdDCaRaRWMOhZvv5Pw==','2025-08-15 02:20:08.737130'),(12,'4sr0c8ukuj4rgukxgr6dgg4dnine','_guia-para-mamas-mentiras-que-las-ninas-creen.pdf','application/pdf','{\"identified\":true,\"analyzed\":true}','local',8132910,'JKZo3V+UBIACpENfph0zww==','2025-08-15 02:23:45.425976'),(13,'8jgvz9lf3olwifjp1n6efph64a52','1 y 2 Timoteo y Tito - Max Lucado.pdf','application/pdf','{\"identified\":true,\"analyzed\":true}','local',51530040,'2R5TnecdeGwiU0zFcHL0YA==','2025-08-15 02:34:31.302404'),(14,'tivsxdrmo2n935y7wpaa5m8r9v35','11. Como Triunfar en el amor. Nancy Van Pelt.pdf','application/pdf','{\"identified\":true,\"analyzed\":true}','local',883898,'PalWD92zlsH6jKPNYI0uXA==','2025-08-15 03:22:56.263888');
/*!40000 ALTER TABLE `active_storage_blobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_storage_variant_records`
--

DROP TABLE IF EXISTS `active_storage_variant_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `active_storage_variant_records` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blob_id` bigint NOT NULL,
  `variation_digest` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_variant_records_uniqueness` (`blob_id`,`variation_digest`),
  CONSTRAINT `fk_rails_993965df05` FOREIGN KEY (`blob_id`) REFERENCES `active_storage_blobs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_variant_records`
--

LOCK TABLES `active_storage_variant_records` WRITE;
/*!40000 ALTER TABLE `active_storage_variant_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_storage_variant_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2025-08-14 23:42:07.701298','2025-08-14 23:42:07.701301');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `paginas` int DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_libros_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (9,'Como habla Dios','Francis Collins',289,NULL,'2025-08-15 00:58:35.541025','2025-08-15 02:47:23.672955',0),(10,'Aprende a controlar tu lengua','Tony Evans',182,NULL,'2025-08-15 02:20:08.730186','2025-08-15 02:33:31.126887',0),(12,'Mentiras que las niñas creen y la verdad que las hace libres','Dannah Gresh',322,NULL,'2025-08-15 02:23:45.420193','2025-08-15 02:25:04.938798',0),(13,'1 y 2 Timoteo','Max Lucado',129,NULL,'2025-08-15 02:34:31.297755','2025-08-15 02:34:40.905489',0),(14,'Como triunfar en el amor','Nancy Van Pelt',82,NULL,'2025-08-15 03:22:56.258869','2025-08-15 03:22:56.346838',0);
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nota`
--

DROP TABLE IF EXISTS `nota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contenido` text,
  `pagina` int DEFAULT NULL,
  `libro_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_nota_on_libro_id` (`libro_id`),
  KEY `index_nota_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_9839f1f17c` FOREIGN KEY (`libro_id`) REFERENCES `libros` (`id`),
  CONSTRAINT `fk_rails_ca2298c254` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nota`
--

LOCK TABLES `nota` WRITE;
/*!40000 ALTER TABLE `nota` DISABLE KEYS */;
INSERT INTO `nota` VALUES (3,'Es interesante como la educación en casa aunque carezca de estructura, resulta mucho más provechosa en despertar el interes, genuino interes en los estudiantes.',11,9,'2025-08-15 05:02:05.619374','2025-08-15 05:02:05.619374',1),(4,'Agnosticismo: postura comoda para evitar considerar los argumentos que incomodan, tanto si hay o si no hay Dios. \n\nDecir: \"no se\" en muchos sentidos es en realidad \"no quiero saber\"',13,9,'2025-08-15 05:05:13.758418','2025-08-15 05:05:13.758418',1),(9,'¿Porqué existiría un hambre tan universal y exclusivamente humana si no estuviera conectada con alguna oportunidad de ser satisfecha?\n\nLas criaturas no nacen con deseos a menos que exista satisfacción a esos deseos... si encuentro dentro de mi  un deseo que ninguna experiencia en este mundo puede satisfacer , la explicación mas probable es que fue creado para otro mundo',28,9,'2025-08-15 14:10:21.358187','2025-08-15 14:10:21.358187',1),(10,'Entre ciencia e iglesia, la armonia de hoy puede ser la discordia del mañana',42,9,'2025-08-15 20:34:27.072549','2025-08-15 20:34:27.072549',1);
/*!40000 ALTER TABLE `nota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20250814234153'),('20250815000153'),('20250815010449'),('20250815025015'),('20250815025534'),('20250815030600'),('20250815030709'),('20250815031447'),('20250815031654');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_libros`
--

DROP TABLE IF EXISTS `user_libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_libros` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `libro_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `estado` int DEFAULT '0',
  `pagina_actual` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_user_libros_on_user_id` (`user_id`),
  KEY `index_user_libros_on_libro_id` (`libro_id`),
  CONSTRAINT `fk_rails_57ec468d20` FOREIGN KEY (`libro_id`) REFERENCES `libros` (`id`),
  CONSTRAINT `fk_rails_86d689a08c` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_libros`
--

LOCK TABLES `user_libros` WRITE;
/*!40000 ALTER TABLE `user_libros` DISABLE KEYS */;
INSERT INTO `user_libros` VALUES (1,1,9,'2025-08-15 03:04:05.460951','2025-08-15 21:21:09.411884',1,43),(2,1,10,'2025-08-15 03:09:37.430598','2025-08-15 03:09:40.050554',1,0),(4,1,12,'2025-08-15 03:17:33.924959','2025-08-15 03:17:33.924959',0,0),(5,1,14,'2025-08-15 03:22:56.407200','2025-08-15 03:22:56.407200',0,0);
/*!40000 ALTER TABLE `user_libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime(6) DEFAULT NULL,
  `remember_created_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'esdras.alvarenga89@gmail.com','$2a$12$zc77ankOjQAIgCmC36ui/.9UCCo4G5LIB5b6PoRkDPMx1/omtqwwG',NULL,NULL,'2025-08-15 13:48:56.253245','2025-08-15 03:02:36.780758','2025-08-15 13:48:56.254180');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-15 18:33:54

-- MySQL dump 10.13  Distrib 8.0.22, for osx10.15 (x86_64)
--
-- Host: localhost    Database: stylecode
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `image_url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'나이키','https://i.ibb.co/D5M91bV/fakeLogo.png'),(2,'아디다스','https://image.freepik.com/free-psd/logo-mockup-3d-modern-wall_145275-122.jpg'),(3,'스투시','https://image.freepik.com/free-psd/logo-mockup-with-silver-logo_136295-372.jpg'),(4,'그라미치','https://image.freepik.com/free-psd/dizzy-text-style-effect_136295-364.jpg'),(5,'언더아머','https://image.freepik.com/free-psd/reflecting-logo-office-wall_117023-1653.jpg'),(6,'스파오','https://image.freepik.com/free-psd/fire-logo_253059-60.jpg'),(7,'파타고니아','https://image.freepik.com/free-psd/gold-logo-mock-up-black-leather_1051-786.jpg');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `color_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int NOT NULL,
  `size_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_color_id_310b8eda_fk_colors_id` (`color_id`),
  KEY `carts_order_id_89a6b74a_fk_orders_id` (`order_id`),
  KEY `carts_product_id_02913eac_fk_products_id` (`product_id`),
  KEY `carts_size_id_1f374f6c_fk_sizes_id` (`size_id`),
  KEY `carts_user_id_3a9d1785_fk_users_id` (`user_id`),
  CONSTRAINT `carts_color_id_310b8eda_fk_colors_id` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`),
  CONSTRAINT `carts_order_id_89a6b74a_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `carts_product_id_02913eac_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `carts_size_id_1f374f6c_fk_sizes_id` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `carts_user_id_3a9d1785_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colors`
--

DROP TABLE IF EXISTS `colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colors`
--

LOCK TABLES `colors` WRITE;
/*!40000 ALTER TABLE `colors` DISABLE KEYS */;
INSERT INTO `colors` VALUES (1,'BLACK'),(2,'WHITE'),(3,'GREY'),(4,'RED'),(5,'BLUE'),(6,'GREEN'),(7,'PURPLE');
/*!40000 ALTER TABLE `colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `ootd_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_ootd_id_14373799_fk_ootds_id` (`ootd_id`),
  KEY `comments_parent_id_d317363b_fk_comments_id` (`parent_id`),
  KEY `comments_user_id_b8fd0b64_fk_users_id` (`user_id`),
  CONSTRAINT `comments_ootd_id_14373799_fk_ootds_id` FOREIGN KEY (`ootd_id`) REFERENCES `ootds` (`id`),
  CONSTRAINT `comments_parent_id_d317363b_fk_comments_id` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `comments_user_id_b8fd0b64_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'잘 어울리나요?','2020-11-26 17:07:02.089882','2020-11-26 17:07:02.089902',1,NULL,1),(2,'잘 어울리시네요','2020-11-26 17:07:02.091540','2020-11-26 17:07:02.091557',1,NULL,2),(3,'멋있습니다.','2020-11-26 17:07:02.093121','2020-11-26 17:07:02.093138',1,NULL,3),(4,'감사합니다 ㅎㅎㅎ','2020-11-26 17:07:02.094877','2020-11-26 17:07:02.094893',1,2,1),(5,'와.. 멋있다..','2020-11-26 17:07:02.096419','2020-11-26 17:07:02.096438',1,NULL,4),(6,'감사합니다 ㅋㅋㅋ','2020-11-26 17:07:02.097483','2020-11-26 17:07:02.097498',1,5,1),(7,'아름다우시네요','2020-11-26 17:07:02.098981','2020-11-26 17:07:02.098996',2,NULL,80),(8,'코디 진짜 이뻐요! ㅋㅋ','2020-11-26 17:07:02.100240','2020-11-26 17:07:02.100255',2,NULL,81),(9,'얼마에 주고 사셨나요??','2020-11-26 17:07:02.101405','2020-11-26 17:07:02.101421',2,NULL,82),(10,'꾸안꾸 정석..','2020-11-26 17:07:02.103124','2020-11-26 17:07:02.103139',2,NULL,83),(11,'대박!!!!!!','2020-11-26 17:07:02.104626','2020-11-26 17:07:02.104641',3,NULL,85),(12,'이거 보고 질렀습니다 ㅋㅋ','2020-11-26 17:07:02.105988','2020-11-26 17:07:02.106004',3,NULL,86),(13,'진짜 이뻐요!','2020-11-26 17:07:02.107509','2020-11-26 17:07:02.107525',3,NULL,87),(14,'사이즈 몇 가셨나요?','2020-11-26 17:07:02.108969','2020-11-26 17:07:02.108986',3,NULL,88),(15,'스펙이 어떻게 되시나요?','2020-11-26 17:07:02.110651','2020-11-26 17:07:02.110669',4,NULL,20),(16,'사이즈 어떤 거 하셨어요?','2020-11-26 17:07:02.112206','2020-11-26 17:07:02.112221',4,NULL,21),(17,'심플하네요','2020-11-26 17:07:02.114145','2020-11-26 17:07:02.114166',4,NULL,22),(18,'가을가을합니다','2020-11-26 17:07:02.115591','2020-11-26 17:07:02.115608',5,NULL,20),(19,'겨울겨울하지않나요?','2020-11-26 17:07:02.116817','2020-11-26 17:07:02.116840',5,18,21),(20,'이쁩니다','2020-11-26 17:07:02.118108','2020-11-26 17:07:02.118124',5,NULL,22),(21,'패완얼 ㄷㄷ','2020-11-26 17:07:02.124089','2020-11-26 17:07:02.124106',5,NULL,23),(22,'진짜 멋집니다','2020-11-26 17:07:02.125948','2020-11-26 17:07:02.125973',6,NULL,21),(23,'최고입니다','2020-11-26 17:07:02.127864','2020-11-26 17:07:02.127886',6,NULL,22),(24,'예쁩니다','2020-11-26 17:07:02.129740','2020-11-26 17:07:02.129762',6,NULL,23),(25,'나도 사고 싶다','2020-11-26 17:07:02.131537','2020-11-26 17:07:02.131559',7,NULL,21),(26,'고급스럽습니다...','2020-11-26 17:07:02.133211','2020-11-26 17:07:02.133228',7,NULL,22),(27,'능력자..!','2020-11-26 17:07:02.134878','2020-11-26 17:07:02.134896',7,NULL,23),(28,'저걸 사시다니!','2020-11-26 17:07:02.136626','2020-11-26 17:07:02.136644',7,NULL,24),(29,'사이즈 몇 가셨나요?','2020-11-26 17:07:02.138442','2020-11-26 17:07:02.138458',7,NULL,25),(30,'우연히 들렸네요 ^^ 좋아요 누르고 갑니다','2020-11-26 17:07:02.140063','2020-11-26 17:07:02.140080',8,NULL,21),(31,'맞팔 부탁드려요','2020-11-26 17:07:02.141652','2020-11-26 17:07:02.141668',8,NULL,22),(32,'저도 사고 싶어요','2020-11-26 17:07:02.142961','2020-11-26 17:07:02.142977',8,NULL,23),(33,'지름신 강림하네요','2020-11-26 17:07:02.144381','2020-11-26 17:07:02.144397',9,NULL,21),(34,'저도 샀습니다!! ㅋㅋ','2020-11-26 17:07:02.145946','2020-11-26 17:07:02.145961',9,NULL,22),(35,'스펙 172/66인데 사이즈 S 저스트입니다.','2020-11-26 17:07:02.147423','2020-11-26 17:07:02.147445',9,NULL,23),(36,'안녕하세요!!','2020-11-26 17:07:02.149116','2020-11-26 17:07:02.149139',10,NULL,21),(37,'댓글 남기고 갑니다','2020-11-26 17:07:02.150819','2020-11-26 17:07:02.150840',10,NULL,22);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `discount_cost` decimal(10,2) DEFAULT NULL,
  `discount_rate` decimal(3,2) DEFAULT NULL,
  `limit_price` decimal(10,2) DEFAULT NULL,
  `limit_period` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'회원가입 할인',NULL,0.25,NULL,NULL),(2,'20%할인',NULL,0.20,50000.00,NULL),(3,'수험생 할인',7000.00,NULL,30000.00,'2020-12-31 00:00:00.000000'),(4,'위코드 할인',NULL,0.80,NULL,NULL);
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (30,'cart','cart'),(31,'cart','coupon'),(32,'cart','usercoupon'),(1,'contenttypes','contenttype'),(17,'ootd','comment'),(18,'ootd','follow'),(19,'ootd','like'),(20,'ootd','ootd'),(23,'ootd','ootdimageurl'),(22,'ootd','ootdtag'),(21,'ootd','tag'),(24,'order','order'),(29,'order','ordererinformation'),(25,'order','orderrequest'),(26,'order','orderstatus'),(27,'order','shippingcompany'),(28,'order','shippingnumber'),(5,'product','brand'),(6,'product','color'),(7,'product','firstcategory'),(8,'product','product'),(16,'product','productcolor'),(15,'product','productimageurl'),(14,'product','productootd'),(13,'product','productsize'),(9,'product','secondcategory'),(10,'product','size'),(12,'product','stock'),(11,'product','thirdcategory'),(2,'sessions','session'),(3,'user','gender'),(4,'user','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'ootd','0001_initial','2020-11-26 17:06:23.340914'),(2,'product','0001_initial','2020-11-26 17:06:23.809589'),(3,'cart','0001_initial','2020-11-26 17:06:24.222103'),(4,'user','0001_initial','2020-11-26 17:06:24.296347'),(5,'order','0001_initial','2020-11-26 17:06:24.599882'),(6,'cart','0002_auto_20201126_1706','2020-11-26 17:06:24.976513'),(7,'contenttypes','0001_initial','2020-11-26 17:06:25.004902'),(8,'contenttypes','0002_remove_content_type_name','2020-11-26 17:06:25.061719'),(9,'ootd','0002_auto_20201126_1706','2020-11-26 17:06:25.431337'),(10,'sessions','0001_initial','2020-11-26 17:06:25.447754');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `first_categories`
--

DROP TABLE IF EXISTS `first_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `first_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `first_categories`
--

LOCK TABLES `first_categories` WRITE;
/*!40000 ALTER TABLE `first_categories` DISABLE KEYS */;
INSERT INTO `first_categories` VALUES (1,'홈'),(2,'브랜드'),(3,'랭킹'),(4,'유니섹스'),(5,'여성'),(6,'뷰티'),(7,'가방잡화'),(8,'슈즈'),(9,'라이프'),(10,'테크');
/*!40000 ALTER TABLE `first_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `followee_id` int NOT NULL,
  `follower_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `follows_followee_id_6accedd4_fk_users_id` (`followee_id`),
  KEY `follows_follower_id_63fa6a23_fk_users_id` (`follower_id`),
  CONSTRAINT `follows_followee_id_6accedd4_fk_users_id` FOREIGN KEY (`followee_id`) REFERENCES `users` (`id`),
  CONSTRAINT `follows_follower_id_63fa6a23_fk_users_id` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
INSERT INTO `follows` VALUES (1,2,1),(2,3,1),(3,4,1),(4,5,1),(5,6,1),(6,7,1),(7,8,1),(8,9,1),(9,10,1),(10,11,1),(11,12,1),(12,13,1),(13,14,1),(14,15,1),(15,16,1),(16,17,1),(17,18,1),(18,19,1),(19,20,1),(20,21,1),(21,22,1),(22,2,3),(23,2,4),(24,2,5),(25,2,6),(26,2,7),(27,2,8),(28,2,9),(29,2,10),(30,2,11),(31,2,12),(32,2,13),(33,2,14),(34,2,15),(35,2,16),(36,2,17),(37,2,18),(38,2,19),(39,2,20),(40,2,21),(41,2,22),(42,2,23),(43,2,24),(44,2,25),(45,2,26),(46,2,27),(47,2,28),(48,2,29),(49,2,30),(50,2,31);
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genders`
--

DROP TABLE IF EXISTS `genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genders`
--

LOCK TABLES `genders` WRITE;
/*!40000 ALTER TABLE `genders` DISABLE KEYS */;
INSERT INTO `genders` VALUES (1,'남자'),(2,'여자');
/*!40000 ALTER TABLE `genders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ootd_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `likes_ootd_id_abcbc51a_fk_ootds_id` (`ootd_id`),
  KEY `likes_user_id_0899754c_fk_users_id` (`user_id`),
  CONSTRAINT `likes_ootd_id_abcbc51a_fk_ootds_id` FOREIGN KEY (`ootd_id`) REFERENCES `ootds` (`id`),
  CONSTRAINT `likes_user_id_0899754c_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,1,55),(56,1,56),(57,1,57),(58,1,58),(59,1,59),(60,1,60),(61,1,61),(62,1,62),(63,1,63),(64,1,64),(65,1,65),(66,1,66),(67,1,67),(68,1,68),(69,1,69),(70,1,70),(71,1,71),(72,1,72),(73,1,73),(74,1,74),(75,1,75),(76,1,76),(77,1,77),(78,1,78),(79,1,79),(80,1,80),(81,1,81),(82,1,82),(83,1,83),(84,1,84),(85,1,85),(86,1,86),(87,1,87),(88,1,88),(89,1,89),(90,2,10),(91,2,11),(92,2,12),(93,2,13),(94,2,14),(95,2,15),(96,2,16),(97,2,17),(98,2,18),(99,2,19),(100,2,20),(101,2,21),(102,2,22),(103,2,23),(104,2,24),(105,2,25),(106,2,26),(107,2,27),(108,2,28),(109,2,29),(110,2,30),(111,2,31),(112,2,32),(113,2,33),(114,2,34),(115,2,35),(116,2,36),(117,2,37),(118,3,5),(119,3,6),(120,3,7),(121,3,8),(122,3,9),(123,3,10),(124,3,11),(125,3,12),(126,3,13),(127,3,14),(128,3,15),(129,3,16),(130,3,17),(131,3,18),(132,3,19),(133,3,20),(134,3,21),(135,3,22),(136,3,23),(137,3,24),(138,3,25),(139,3,26),(140,3,27),(141,3,28),(142,3,29),(143,3,30),(144,3,31),(145,3,32),(146,3,33),(147,3,34),(148,3,35),(149,3,36),(150,3,37),(151,3,38),(152,3,39),(153,3,40),(154,3,41),(155,3,42),(156,3,43),(157,3,44),(158,3,45),(159,3,46),(160,3,47),(161,3,48),(162,3,49),(163,3,50),(164,3,51),(165,3,52),(166,3,53),(167,3,54),(168,3,55),(169,3,56),(170,3,57),(171,3,58),(172,3,59),(173,3,60),(174,3,61),(175,3,62),(176,3,63),(177,3,64),(178,3,65),(179,3,66),(180,3,67),(181,3,68),(182,3,69),(183,3,70),(184,3,71),(185,3,72),(186,3,73),(187,3,74),(188,3,75),(189,3,76),(190,3,77),(191,3,78),(192,3,79),(193,3,80),(194,3,81),(195,3,82),(196,4,1),(197,4,2),(198,4,3),(199,4,4),(200,4,5),(201,4,6),(202,4,7),(203,4,8),(204,4,9),(205,4,10),(206,4,11),(207,4,12),(208,4,13),(209,4,14),(210,4,15),(211,5,30),(212,5,31),(213,5,32),(214,5,33),(215,5,34),(216,5,35),(217,5,36),(218,5,37),(219,5,38),(220,5,39),(221,5,40),(222,5,41),(223,5,42),(224,5,43),(225,6,1),(226,6,2),(227,6,3),(228,6,4),(229,6,5),(230,6,6),(231,6,7),(232,6,8),(233,6,9),(234,6,50),(235,7,1),(236,7,2),(237,7,3),(238,7,4),(239,7,5),(240,7,6),(241,7,7),(242,7,8),(243,7,9),(244,8,1),(245,8,2),(246,8,3),(247,8,4),(248,8,5),(249,8,6),(250,8,7),(251,8,8),(252,8,9),(253,9,1),(254,9,2),(255,9,3),(256,9,4),(257,9,5),(258,9,6),(259,9,7),(260,9,8),(261,10,1),(262,10,2),(263,10,3),(264,10,4),(265,10,5),(266,10,6),(267,10,7),(268,10,8);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ootd_image_urls`
--

DROP TABLE IF EXISTS `ootd_image_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ootd_image_urls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(200) NOT NULL,
  `ootd_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ootd_image_urls_ootd_id_8fe21515_fk_ootds_id` (`ootd_id`),
  CONSTRAINT `ootd_image_urls_ootd_id_8fe21515_fk_ootds_id` FOREIGN KEY (`ootd_id`) REFERENCES `ootds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ootd_image_urls`
--

LOCK TABLES `ootd_image_urls` WRITE;
/*!40000 ALTER TABLE `ootd_image_urls` DISABLE KEYS */;
INSERT INTO `ootd_image_urls` VALUES (1,'https://images.unsplash.com/photo-1504284674659-1216fb2866c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1305&q=80',1),(2,'https://images.unsplash.com/photo-1518417823698-91652324a3f3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',1),(3,'https://images.unsplash.com/photo-1534260748473-e1c629d04bb0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',2),(4,'https://images.unsplash.com/photo-1518740028517-36c686a4a001?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',2),(5,'https://images.unsplash.com/photo-1571755497619-a0ee0e54764e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=802&q=80',3),(6,'https://images.unsplash.com/photo-1571755497609-8b3b0cedde29?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80',3),(7,'https://images.unsplash.com/photo-1556232145-b11640abf9b3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2468&q=80',4),(8,'https://images.unsplash.com/photo-1558599884-996ab09ac98b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',5),(9,'https://images.unsplash.com/photo-1598211686290-a8ef209d87c5?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTUxfHxuaWtlfGVufDB8fDB8&auto=format&fit=crop&w=800&q=60',6),(10,'https://images.unsplash.com/photo-1560856503-a959432ceeff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2550&q=80',7),(11,'https://images.unsplash.com/photo-1527718926451-9120bb1d21a3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80',8),(12,'https://images.unsplash.com/photo-1515555230216-82228b88ea98?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1226&q=80',9),(13,'https://images.unsplash.com/photo-1580408745615-1f0592484c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',10),(14,'https://images.unsplash.com/photo-1592647825664-d5e440d32692?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',11),(15,'https://images.unsplash.com/photo-1548203784-fed54afd472d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',12),(16,'https://images.unsplash.com/photo-1518727670167-a89841d547dc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',13),(17,'https://images.unsplash.com/photo-1556793522-27d2c018d721?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',14),(18,'https://images.unsplash.com/photo-1599265866618-44bf5b03def6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',15),(19,'https://images.unsplash.com/photo-1535323700481-068e9c9f4c1f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',16),(20,'https://images.unsplash.com/photo-1511167966586-4942d18c6f40?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',17),(21,'https://images.unsplash.com/photo-1511196044526-5cb3bcb7071b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',18),(22,'https://images.unsplash.com/photo-1462430638866-7ad892655344?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',19),(23,'https://images.unsplash.com/photo-1598441322332-16310ec9b738?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',20),(24,'https://images.unsplash.com/photo-1595899961631-e9a6d6c4e4ce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',21),(25,'https://images.unsplash.com/photo-1582124448694-88b2445077b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',22),(26,'https://images.unsplash.com/photo-1534557668063-45fd39faa851?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',23),(27,'https://images.unsplash.com/photo-1563440473806-a2abe721077c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',24),(28,'https://images.unsplash.com/photo-1603401740347-dc340113440f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',25),(29,'https://images.unsplash.com/photo-1558608846-7295ca9d0348?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',26),(30,'https://images.unsplash.com/photo-1588992970837-27e122b58cef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',27),(31,'https://images.unsplash.com/photo-1601632609961-90b86ffad7b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',28),(32,'https://images.unsplash.com/photo-1522872641108-bcb51e2aff69?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',29),(33,'https://images.unsplash.com/photo-1533858455121-cad255c592dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',30),(34,'https://images.unsplash.com/photo-1518417823698-91652324a3f3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',31),(35,'https://images.unsplash.com/photo-1495994132590-5c7b6c4fffec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',32),(36,'https://images.unsplash.com/photo-1594035795072-3fcd236b7d83?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',33),(37,'https://images.unsplash.com/photo-1576501375626-25f1ac1e0ae8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',34),(38,'https://images.unsplash.com/photo-1525903080273-b24878294850?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',35),(39,'https://images.unsplash.com/photo-1539783184059-9f740f54a3c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',36),(40,'https://images.unsplash.com/photo-1603233842167-ff91cab9e6ae?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',37),(41,'https://images.unsplash.com/photo-1603389400023-a89abdcd92fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',38),(42,'https://images.unsplash.com/photo-1604341841227-6dd5c2255842?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',38),(43,'https://images.unsplash.com/photo-1502940113860-9d7391613fa7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',39),(44,'https://images.unsplash.com/photo-1524601885886-1bdd86a02f5a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',40),(45,'https://images.unsplash.com/photo-1520484205608-f65d27ad0765?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',41),(46,'https://images.unsplash.com/photo-1511105043137-7e66f28270e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',42),(47,'https://images.unsplash.com/photo-1527888134035-745830ac26fd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',43),(48,'https://images.unsplash.com/photo-1601632564328-58c2a78e46b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',44),(49,'https://images.unsplash.com/photo-1529470839332-78ad660a6a82?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',45),(50,'https://images.unsplash.com/photo-1517939031243-43d1006b5c23?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',46),(51,'https://images.unsplash.com/photo-1519862170344-6cd5e49cb996?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',47),(52,'https://images.unsplash.com/photo-1515955690568-59512d0bd487?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',48),(53,'https://images.unsplash.com/photo-1598401488442-813164f38b19?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',49),(54,'https://images.unsplash.com/photo-1524704088085-cfbde9454330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',50),(55,'https://images.unsplash.com/photo-1563900027-8c7f0573cf52?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',51),(56,'https://images.unsplash.com/photo-1533898301026-0a2546b285e7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',52),(57,'https://images.unsplash.com/photo-1520013135029-3c324dc527a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',53),(58,'https://images.unsplash.com/photo-1534260748473-e1c629d04bb0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',54),(59,'https://images.unsplash.com/photo-1518740028517-36c686a4a001?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',55),(60,'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',56),(61,'https://images.unsplash.com/flagged/photo-1562053690-62f7812fd0de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',57),(62,'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',58),(63,'https://images.unsplash.com/photo-1552168212-9ceb61083ba0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1296&q=60',59),(64,'https://images.unsplash.com/photo-1593202873672-79aeb34143d8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',60),(65,'https://images.unsplash.com/photo-1532073150508-0c1df022bdd1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',61),(66,'https://images.unsplash.com/photo-1531734510209-2da4a139a53a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',62),(67,'https://images.unsplash.com/photo-1520483984082-37caa3093d0f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',63),(68,'https://images.unsplash.com/photo-1603233791515-24a3429645b8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',64),(69,'https://images.unsplash.com/photo-1574427797991-b086946fa9e7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',65),(70,'https://images.unsplash.com/photo-1511105612320-2e62a04dd044?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',66),(71,'https://images.unsplash.com/photo-1531455522153-b9887b5a5696?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',67),(72,'https://images.unsplash.com/photo-1601295347735-bdc097e86049?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',68),(73,'https://images.unsplash.com/photo-1529399447871-731cff7f696b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',69),(74,'https://images.unsplash.com/photo-1535323700481-068e9c9f4c1f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',70),(75,'https://images.unsplash.com/photo-1511167966586-4942d18c6f40?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',71),(76,'https://images.unsplash.com/photo-1511196044526-5cb3bcb7071b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',72),(77,'https://images.unsplash.com/photo-1462430638866-7ad892655344?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',73),(78,'https://images.unsplash.com/photo-1598441322332-16310ec9b738?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',74),(79,'https://images.unsplash.com/photo-1595899961631-e9a6d6c4e4ce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',75),(80,'https://images.unsplash.com/photo-1582124448694-88b2445077b7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',76),(81,'https://images.unsplash.com/photo-1534557668063-45fd39faa851?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',77),(82,'https://images.unsplash.com/photo-1563440473806-a2abe721077c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',78),(83,'https://images.unsplash.com/photo-1603401740347-dc340113440f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',79),(84,'https://images.unsplash.com/photo-1558608846-7295ca9d0348?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',80),(85,'https://images.unsplash.com/photo-1588992970837-27e122b58cef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',81),(86,'https://images.unsplash.com/photo-1601632609961-90b86ffad7b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',82),(87,'https://images.unsplash.com/photo-1522872641108-bcb51e2aff69?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',83),(88,'https://images.unsplash.com/photo-1533858455121-cad255c592dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',84),(89,'https://images.unsplash.com/photo-1518417823698-91652324a3f3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',85),(90,'https://images.unsplash.com/photo-1495994132590-5c7b6c4fffec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',86),(91,'https://images.unsplash.com/photo-1594035795072-3fcd236b7d83?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',87),(92,'https://images.unsplash.com/photo-1576501375626-25f1ac1e0ae8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',88),(93,'https://images.unsplash.com/photo-1525903080273-b24878294850?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',89),(94,'https://images.unsplash.com/photo-1539783184059-9f740f54a3c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',90),(95,'https://images.unsplash.com/photo-1603233842167-ff91cab9e6ae?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',91),(96,'https://images.unsplash.com/photo-1603389400023-a89abdcd92fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',92),(97,'https://images.unsplash.com/photo-1604341841227-6dd5c2255842?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',93),(98,'https://images.unsplash.com/photo-1502940113860-9d7391613fa7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',94),(99,'https://images.unsplash.com/photo-1524601885886-1bdd86a02f5a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',95),(100,'https://images.unsplash.com/photo-1520484205608-f65d27ad0765?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',96),(101,'https://images.unsplash.com/photo-1511105043137-7e66f28270e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',97),(102,'https://images.unsplash.com/photo-1527888134035-745830ac26fd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',98),(103,'https://images.unsplash.com/photo-1601632564328-58c2a78e46b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60',99);
/*!40000 ALTER TABLE `ootd_image_urls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ootds`
--

DROP TABLE IF EXISTS `ootds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ootds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ootds_user_id_86eb4934_fk_users_id` (`user_id`),
  CONSTRAINT `ootds_user_id_86eb4934_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ootds`
--

LOCK TABLES `ootds` WRITE;
/*!40000 ALTER TABLE `ootds` DISABLE KEYS */;
INSERT INTO `ootds` VALUES (1,'인스타에 안 올린 #데일리룩 B컷 방출 \n#나이키 반팔티 사고 처음 입어 봤는데 걍 나 오늘 힙하다~ 이런느낌ㅋㅋ#반팔티 #오늘뭐입지?','2020-11-26 17:07:01.275210','2020-11-26 17:07:01.275234',1),(2,'#나이키 #스우시 의 vivid한 color와 oversize의 boxy한 fit이 favorite하네요 #해외브랜드 #우먼스','2020-11-26 17:07:01.277250','2020-11-26 17:07:01.277302',4),(3,'#나이키 후드티로 데일리 코디 #반팔티 #로고 #블랙 #메쉬','2020-11-26 17:07:01.279413','2020-11-26 17:07:01.279433',3),(4,'#오토바이 탈 때는 요렇게 입지요- 29CM와 함께하는 세이의 ‘매일’ 룩!\n_\n29CM의 ‘매일의 가이드’ 캠페인에 참여했어요! 브랜드를 시작하면서 개인 콘텐츠 작업 기회가 많지 않았는데 인터뷰도 하고 좋아하는 브랜드와 아이템들을 소개할 수 있는 기회가 많아져 즐거운 요즘입니당 히히히\n\n세이가 추천하는 브랜드&아이템과 자세한 ‘매일의 가이드’ 인터뷰 콘텐츠는 29CM 앱 +제 인스타 스토리 링크를 통해 보실 수 있어요! #꾸안꾸','2020-11-26 17:07:01.281589','2020-11-26 17:07:01.281606',3),(5,'스포티함이 포인트인 #아메카지 나이키룩이죠 #겨울 #가을 #13번','2020-11-26 17:07:01.283314','2020-11-26 17:07:01.283336',5),(6,'#레오파드 애니멀 패턴 부클 자켓과 나이키! 첫 도전 음머 #스투시','2020-11-26 17:07:01.284916','2020-11-26 17:07:01.284933',5),(7,'비오는날 너무 싫네요ㅠㅠ #파타고니아 #아디다스','2020-11-26 17:07:01.286040','2020-11-26 17:07:01.286062',6),(8,'귀엽고 따뜻한 #스파오 리버시블 양털 자켓코디에오\n한가지 아우터로 두가지 느낌을 연출할 수 있답미다! #그라미치','2020-11-26 17:07:01.287416','2020-11-26 17:07:01.287432',7),(9,'겨울에 양털은 필수죠 #나이키 #파타고니아 #아디다스','2020-11-26 17:07:01.288540','2020-11-26 17:07:01.288556',8),(10,'자켓 코디~ #반팔티 #오늘뭐입지? #데일리룩 #해외브랜드','2020-11-26 17:07:01.290313','2020-11-26 17:07:01.290330',9),(11,'니트에 가죽치마 코디!','2020-11-26 17:07:01.291626','2020-11-26 17:07:01.291642',10),(12,'공원 나들이 하구 왔어요','2020-11-26 17:07:01.292855','2020-11-26 17:07:01.292872',1),(13,'오늘 입은 의상입니다.','2020-11-26 17:07:01.294473','2020-11-26 17:07:01.294490',1),(14,'민트민트 코디 !!!','2020-11-26 17:07:01.295565','2020-11-26 17:07:01.295581',1),(15,'가을 데일리룩','2020-11-26 17:07:01.297427','2020-11-26 17:07:01.297450',1),(16,'하늘색 니트는.. 지금 날씨에 딱 맞는 코디','2020-11-26 17:07:01.299418','2020-11-26 17:07:01.299464',2),(17,'New one','2020-11-26 17:07:01.301426','2020-11-26 17:07:01.301450',3),(18,'블레이저 코디 포기 못훼 ','2020-11-26 17:07:01.302734','2020-11-26 17:07:01.302750',4),(19,'계속 오늘같은 날씨였으면 좋겠네요','2020-11-26 17:07:01.304738','2020-11-26 17:07:01.304759',5),(20,'가디건 코디','2020-11-26 17:07:01.306547','2020-11-26 17:07:01.306569',6),(21,'수납공간 넉넉하고 스트링 디테일이 너무 예쁜 백팩','2020-11-26 17:07:01.308225','2020-11-26 17:07:01.308241',5),(22,'좋아하는 느낌','2020-11-26 17:07:01.309953','2020-11-26 17:07:01.309975',4),(23,'후드티에 레오파드 스커트는 사랑','2020-11-26 17:07:01.311551','2020-11-26 17:07:01.311567',3),(24,'아메카지 코디','2020-11-26 17:07:01.313204','2020-11-26 17:07:01.313223',4),(25,'마지막사진 먼 일이람','2020-11-26 17:07:01.315141','2020-11-26 17:07:01.315164',4),(26,'인스타에 안올린 B컷들!','2020-11-26 17:07:01.316649','2020-11-26 17:07:01.316665',4),(27,'티라미수가 생각나는 오늘의 코디','2020-11-26 17:07:01.317813','2020-11-26 17:07:01.317828',4),(28,'크리스마스가 코앞에..겨울에는 롱부츠로 따뜻한 코디를','2020-11-26 17:07:01.324964','2020-11-26 17:07:01.324987',5),(29,'비야 오지마 ×.× ','2020-11-26 17:07:01.326873','2020-11-26 17:07:01.326893',6),(30,'이 아우터 입으면 세상을 다 가진 기분','2020-11-26 17:07:01.328749','2020-11-26 17:07:01.328776',7),(31,'셔츠 포인트','2020-11-26 17:07:01.330455','2020-11-26 17:07:01.330478',8),(32,'귀여운 양털 뽀글이 크로스백 코디하기','2020-11-26 17:07:01.332382','2020-11-26 17:07:01.332406',9),(33,'제 옷 귀엽죠','2020-11-26 17:07:01.333916','2020-11-26 17:07:01.333936',8),(34,'올블랙 패션.','2020-11-26 17:07:01.335811','2020-11-26 17:07:01.335826',9),(35,'\"13번, 13번 ! 13번 없나?!\" \n\"제가 13번인데요\" \n\"13번 일어나서 이거 읽어봐\"  \"모르겠는데요\"  \"뭐야!? 머리에 뭐가 들었길래 단어 하나를 못 읽냐? 엉?! \"  \" 내 여.자. 하나만 들어서 다른건 생각할 겨를이 없습니다\"','2020-11-26 17:07:01.337624','2020-11-26 17:07:01.337645',2),(36,'\"나 좋아하지마.\"  \"그게 뭔데.\"  \"나 좋아하지 말라고.\"  \"그거 어떻게 하는건데.\"','2020-11-26 17:07:01.339406','2020-11-26 17:07:01.339428',3),(37,'ㄴ ㅏ는 가끔 눈물을 흘린ㄷ ㅏ...ㅠ ㅁ ㅓ리가 ㅇ ㅏ닌 맘으로 우는 ㄴ ㅐ가 좋ㄷ ㅏ...','2020-11-26 17:07:01.341111','2020-11-26 17:07:01.341130',1),(38,'애정하는 차분한 베이지 톤온톤 코디!','2020-11-26 17:07:01.343399','2020-11-26 17:07:01.343435',10),(39,'완전 편하고 따땃하영','2020-11-26 17:07:01.345235','2020-11-26 17:07:01.345257',10),(40,'겨울 니트 코디','2020-11-26 17:07:01.347091','2020-11-26 17:07:01.347125',10),(41,'겨울아우터, 후리스, 뽀글이 추천','2020-11-26 17:07:01.349264','2020-11-26 17:07:01.349280',10),(42,'감 너무 예쁜 트레이닝셋뚜','2020-11-26 17:07:01.350885','2020-11-26 17:07:01.350902',10),(43,'오토바이 타면 완성\'!!','2020-11-26 17:07:01.357094','2020-11-26 17:07:01.357111',10),(44,'안에 크롭탑입고 입으면 꾸안꾸 그자체','2020-11-26 17:07:01.358462','2020-11-26 17:07:01.358478',10),(45,'블랙 말고 화사한 아이보리 코디 어때?~','2020-11-26 17:07:01.359566','2020-11-26 17:07:01.359582',10),(46,'미니멀룩에 과하지 않은 포인트 주기 좋은 가방','2020-11-26 17:07:01.367376','2020-11-26 17:07:01.367393',10),(47,'바이크 룩 Ver.2! 겹쳐 입기 좋아하는 사람은 이렇게도 입지요','2020-11-26 17:07:01.368645','2020-11-26 17:07:01.368661',10),(48,'커피 중독자','2020-11-26 17:07:01.370317','2020-11-26 17:07:01.370342',10),(49,'반팔 긴팔 레이어드','2020-11-26 17:07:01.372242','2020-11-26 17:07:01.372277',10),(50,'무채색 데일리룩','2020-11-26 17:07:01.374107','2020-11-26 17:07:01.374155',9),(51,'ㄴ ㅏ는 가끔 눈물을 흘린ㄷ ㅏ...ㅠ ㅁ ㅓ리가 ㅇ ㅏ닌 맘으로 우는 ㄴ ㅐ가 좋ㄷ ㅏ...','2020-11-26 17:07:01.375687','2020-11-26 17:07:01.375702',1),(52,'인스타에 안 올린 B컷 대방출\n버킷햇 첨 써보는데 걍 나 오늘 힙하다~ 이런느낌ㅋㅋ','2020-11-26 17:07:01.377214','2020-11-26 17:07:01.377232',1),(53,'\"13번, 13번 ! 13번 없나?!\" \n\"제가 13번인데요\" \n\"13번 일어나서 이거 읽어봐\"  \"모르겠는데요\"  \"뭐야!? 머리에 뭐가 들었길래 단어 하나를 못 읽냐? 엉?! \"  \" 내 여.자. 하나만 들어서 다른건 생각할 겨를이 없습니다\"','2020-11-26 17:07:01.378696','2020-11-26 17:07:01.378712',2),(54,'구매한 의상을 입어봤습니다. ','2020-11-26 17:07:01.380725','2020-11-26 17:07:01.380746',3),(55,'vivid한 color와 oversize의 boxy한 fit이 favorite하네요','2020-11-26 17:07:01.382208','2020-11-26 17:07:01.382226',4),(56,'후드티로 데일리 코디','2020-11-26 17:07:01.383523','2020-11-26 17:07:01.383539',3),(57,'바이크 탈 때는 요렇게 입지요- 29CM와 함께하는 세이의 ‘매일’ 룩!\n_\n29CM의 ‘매일의 가이드’ 캠페인에 참여했어요! 브랜드를 시작하면서 개인 콘텐츠 작업 기회가 많지 않았는데 인터뷰도 하고 좋아하는 브랜드와 아이템들을 소개할 수 있는 기회가 많아져 즐거운 요즘입니당 히히히\n\n세이가 추천하는 브랜드&아이템과 자세한 ‘매일의 가이드’ 인터뷰 콘텐츠는 29CM 앱 +제 인스타 스토리 링크를 통해 보실 수 있어요!','2020-11-26 17:07:01.384893','2020-11-26 17:07:01.384910',3),(58,'치마가 포인트인 할미룩이쥬','2020-11-26 17:07:01.386627','2020-11-26 17:07:01.386649',5),(59,'애니멀 패턴 부클 자켓 첫 도전 음머','2020-11-26 17:07:01.388132','2020-11-26 17:07:01.388159',5),(60,'비오는날 너무 싫네요ㅠㅠ','2020-11-26 17:07:01.396157','2020-11-26 17:07:01.396174',6),(61,'귀엽고 따뜻한 리버시블 양털 자켓코디에오\n한가지 아우터로 두가지 느낌을 연출할 수 있답미다!','2020-11-26 17:07:01.397899','2020-11-26 17:07:01.397921',7),(62,'겨울에 양털은 필수죠','2020-11-26 17:07:01.399486','2020-11-26 17:07:01.399513',8),(63,'자켓 코디~','2020-11-26 17:07:01.401510','2020-11-26 17:07:01.401533',9),(64,'니트에 가죽치마 코디!','2020-11-26 17:07:01.402910','2020-11-26 17:07:01.402926',10),(65,'공원 나들이 하구 왔어요','2020-11-26 17:07:01.404969','2020-11-26 17:07:01.404989',1),(66,'\"나 좋아하지마.\"  \"그게 뭔데.\"  \"나 좋아하지 말라고.\"  \"그거 어떻게 하는건데.\"','2020-11-26 17:07:01.407052','2020-11-26 17:07:01.407073',1),(67,'민트민트 코디 !!!','2020-11-26 17:07:01.408651','2020-11-26 17:07:01.408673',1),(68,'가을 데일리룩','2020-11-26 17:07:01.409878','2020-11-26 17:07:01.409894',1),(69,'하늘색 니트는.. 지금 날씨에 딱 맞는 코디','2020-11-26 17:07:01.411638','2020-11-26 17:07:01.411659',2),(70,'New one','2020-11-26 17:07:01.413468','2020-11-26 17:07:01.413514',3),(71,'블레이저 코디 포기 못훼 ','2020-11-26 17:07:01.415131','2020-11-26 17:07:01.415148',4),(72,'계속 오늘같은 날씨였으면 좋겠네요','2020-11-26 17:07:01.422256','2020-11-26 17:07:01.422272',5),(73,'가디건 코디','2020-11-26 17:07:01.423916','2020-11-26 17:07:01.423938',6),(74,'수납공간 넉넉하고 스트링 디테일이 너무 예쁜 백팩','2020-11-26 17:07:01.425655','2020-11-26 17:07:01.425677',5),(75,'좋아하는 느낌','2020-11-26 17:07:01.427326','2020-11-26 17:07:01.427347',4),(76,'후드티에 레오파드 스커트는 사랑','2020-11-26 17:07:01.429072','2020-11-26 17:07:01.429093',3),(77,'아메카지 코디','2020-11-26 17:07:01.430835','2020-11-26 17:07:01.430851',4),(78,'마지막사진 먼 일이람','2020-11-26 17:07:01.432536','2020-11-26 17:07:01.432553',4),(79,'인스타에 안올린 B컷들!','2020-11-26 17:07:01.434100','2020-11-26 17:07:01.434118',4),(80,'티라미수가 생각나는 오늘의 코디','2020-11-26 17:07:01.435807','2020-11-26 17:07:01.435824',4),(81,'크리스마스가 코앞에..겨울에는 롱부츠로 따뜻한 코디를','2020-11-26 17:07:01.437572','2020-11-26 17:07:01.437587',5),(82,'비야 오지마 ×.× ','2020-11-26 17:07:01.438987','2020-11-26 17:07:01.439001',6),(83,'이 아우터 입으면 세상을 다 가진 기분','2020-11-26 17:07:01.440439','2020-11-26 17:07:01.440453',7),(84,'셔츠 포인트','2020-11-26 17:07:01.442207','2020-11-26 17:07:01.442222',8),(85,'귀여운 양털 뽀글이 크로스백 코디하기','2020-11-26 17:07:01.443647','2020-11-26 17:07:01.443662',9),(86,'제 옷 귀엽죠','2020-11-26 17:07:01.445369','2020-11-26 17:07:01.445383',8),(87,'올블랙 패션.','2020-11-26 17:07:01.447242','2020-11-26 17:07:01.447263',9),(88,'애정하는 차분한 베이지 톤온톤 코디!','2020-11-26 17:07:01.448674','2020-11-26 17:07:01.448690',10),(89,'완전 편하고 따땃하영','2020-11-26 17:07:01.449999','2020-11-26 17:07:01.450015',10),(90,'겨울 니트 코디','2020-11-26 17:07:01.451175','2020-11-26 17:07:01.451191',10),(91,'겨울아우터, 후리스, 뽀글이 추천','2020-11-26 17:07:01.452333','2020-11-26 17:07:01.452350',10),(92,'감 너무 예쁜 트레이닝셋뚜','2020-11-26 17:07:01.453614','2020-11-26 17:07:01.453635',10),(93,'오토바이 타면 완성\'!!','2020-11-26 17:07:01.454834','2020-11-26 17:07:01.454852',10),(94,'안에 크롭탑입고 입으면 꾸안꾸 그자체','2020-11-26 17:07:01.456405','2020-11-26 17:07:01.456426',10),(95,'블랙 말고 화사한 아이보리 코디 어때?~','2020-11-26 17:07:01.458132','2020-11-26 17:07:01.458153',10),(96,'미니멀룩에 과하지 않은 포인트 주기 좋은 가방','2020-11-26 17:07:01.459968','2020-11-26 17:07:01.460011',10),(97,'바이크 룩 Ver.2! 겹쳐 입기 좋아하는 사람은 이렇게도 입지요','2020-11-26 17:07:01.461698','2020-11-26 17:07:01.461724',10),(98,'커피 중독자','2020-11-26 17:07:01.463460','2020-11-26 17:07:01.463483',10),(99,'반팔 긴팔 레이어드','2020-11-26 17:07:01.465302','2020-11-26 17:07:01.465324',10);
/*!40000 ALTER TABLE `ootds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ootds_tags`
--

DROP TABLE IF EXISTS `ootds_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ootds_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ootd_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ootds_tags_ootd_id_2af0cf35_fk_ootds_id` (`ootd_id`),
  KEY `ootds_tags_tag_id_89bbf323_fk_tags_id` (`tag_id`),
  CONSTRAINT `ootds_tags_ootd_id_2af0cf35_fk_ootds_id` FOREIGN KEY (`ootd_id`) REFERENCES `ootds` (`id`),
  CONSTRAINT `ootds_tags_tag_id_89bbf323_fk_tags_id` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ootds_tags`
--

LOCK TABLES `ootds_tags` WRITE;
/*!40000 ALTER TABLE `ootds_tags` DISABLE KEYS */;
INSERT INTO `ootds_tags` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,2,1),(6,2,6),(7,2,7),(8,2,8),(9,3,1),(10,3,2),(11,3,9),(12,3,10),(13,3,11),(14,4,12),(15,4,13),(16,5,14),(17,5,15),(18,5,16),(19,5,17),(20,6,18),(21,6,19),(22,7,20),(23,7,21),(24,8,22),(25,8,23),(26,9,1),(27,9,20),(28,9,21),(29,10,2),(30,10,3),(31,10,4),(32,10,6);
/*!40000 ALTER TABLE `ootds_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_informations`
--

DROP TABLE IF EXISTS `order_informations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_informations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderer_name` varchar(10) NOT NULL,
  `orderer_email` varchar(254) NOT NULL,
  `orderer_phone_number` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `order_informations_user_id_705e2217_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_informations`
--

LOCK TABLES `order_informations` WRITE;
/*!40000 ALTER TABLE `order_informations` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_informations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_requests`
--

DROP TABLE IF EXISTS `order_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `request` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_requests`
--

LOCK TABLES `order_requests` WRITE;
/*!40000 ALTER TABLE `order_requests` DISABLE KEYS */;
INSERT INTO `order_requests` VALUES (1,'빠른 배송 부탁드립니다.'),(2,'배송 전, 연락주세요.'),(3,'부재 시, 휴대폰으로 연락주세요'),(4,'부재 시, 경비실에 맡겨주세요'),(5,'문 앞에다 놓아주세요');
/*!40000 ALTER TABLE `order_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_statuses`
--

DROP TABLE IF EXISTS `order_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_status` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_statuses`
--

LOCK TABLES `order_statuses` WRITE;
/*!40000 ALTER TABLE `order_statuses` DISABLE KEYS */;
INSERT INTO `order_statuses` VALUES (1,'입금 전'),(2,'주문완료'),(3,'배송 준비중'),(4,'발송 완료'),(5,'거래 완료'),(6,'주문 취소');
/*!40000 ALTER TABLE `order_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `order_number` varchar(20) NOT NULL,
  `orderer_name` varchar(10) NOT NULL,
  `orderer_phone_number` varchar(20) NOT NULL,
  `orderer_email` varchar(254) NOT NULL,
  `recipient_name` varchar(10) NOT NULL,
  `recipient_phone_number` varchar(20) NOT NULL,
  `self_request` varchar(50) DEFAULT NULL,
  `coupon_id` int DEFAULT NULL,
  `order_request_id` int DEFAULT NULL,
  `order_status_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_order_request_id_eedda92b_fk_order_requests_id` (`order_request_id`),
  KEY `orders_order_status_id_05e726df_fk_order_statuses_id` (`order_status_id`),
  KEY `orders_user_id_7e2523fb_fk_users_id` (`user_id`),
  KEY `orders_coupon_id_a782d700_fk_coupons_id` (`coupon_id`),
  CONSTRAINT `orders_coupon_id_a782d700_fk_coupons_id` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
  CONSTRAINT `orders_order_request_id_eedda92b_fk_order_requests_id` FOREIGN KEY (`order_request_id`) REFERENCES `order_requests` (`id`),
  CONSTRAINT `orders_order_status_id_05e726df_fk_order_statuses_id` FOREIGN KEY (`order_status_id`) REFERENCES `order_statuses` (`id`),
  CONSTRAINT `orders_user_id_7e2523fb_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_image_urls`
--

DROP TABLE IF EXISTS `product_image_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_image_urls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(300) NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_image_urls_product_id_05509d02_fk_products_id` (`product_id`),
  CONSTRAINT `product_image_urls_product_id_05509d02_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_image_urls`
--

LOCK TABLES `product_image_urls` WRITE;
/*!40000 ALTER TABLE `product_image_urls` DISABLE KEYS */;
INSERT INTO `product_image_urls` VALUES (1,'https://images.unsplash.com/photo-1586116104126-7b8e839d5b8c?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',1),(2,'https://images.unsplash.com/photo-1586116120874-40400db66053?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',1),(3,'https://images.unsplash.com/photo-1586116134477-4f25636a68de?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',1),(4,'https://image.freepik.com/free-psd/girl-t-shirt-mock-up_89887-83.jpg',2),(5,'https://image.freepik.com/free-psd/girl-t-shirt-mock-up_89887-100.jpg',2),(6,'https://image.freepik.com/free-psd/african-man-t-shirt-mock-up_89887-96.jpg',2),(7,'https://image.freepik.com/free-psd/woman-t-shirt-mock-up_89887-135.jpg',2),(8,'https://image.freepik.com/free-psd/teen-girl-wearing-t-shirt-mockup_206643-58.jpg',3),(9,'https://image.freepik.com/free-psd/teen-girl-wearing-black-t-shirt-mockup-denim-outfit_206643-56.jpg',3),(10,'https://image.freepik.com/free-psd/boy-wearing-white-shirt-with-mockup_181945-915.jpg',3),(11,'https://image.freepik.com/free-psd/man-showing-mock-up-shirt-peace-sign_23-2148685096.jpg',4),(12,'https://image.freepik.com/free-psd/man-showing-mock-up-shirt-from_23-2148685099.jpg',4),(13,'https://image.freepik.com/free-psd/listening-music-dancing-mock-up_23-2148685102.jpg',4),(14,'https://image.freepik.com/free-psd/chromatees-tshirt-mockup_126278-24.jpg',5),(15,'https://image.freepik.com/free-psd/chromatees-tshirt-mockup_126278-33.jpg',5),(16,'https://image.freepik.com/free-psd/chromatees-tshirt-mockup_126278-22.jpg',5),(17,'https://image.freepik.com/free-psd/mens-short-sleeve-t-shirt-mockups-04_126278-125.jpg',6),(18,'https://image.freepik.com/free-psd/mens-short-sleeve-t-shirt-mockups-03_126278-124.jpg',6),(19,'https://image.freepik.com/free-psd/mens-tri-blend-crew-tee-mockup_126278-134.jpg',6),(20,'https://image.freepik.com/free-psd/sports-shirt-mockup-with-brand-logo_23-2148126808.jpg',7),(21,'https://image.freepik.com/free-psd/sports-shirt-mockup-with-brand-logo_23-2148126774.jpg',7),(22,'https://image.freepik.com/free-psd/sports-shirt-mockup-with-brand-logo_23-2148126766.jpg',7),(23,'https://image.freepik.com/free-psd/front-view-man-posing-while-wearing-t-shirt_23-2148457384.jpg',8),(24,'https://image.freepik.com/free-psd/front-view-couple-posing-t-shirts_23-2148457379.jpg',8),(25,'https://image.freepik.com/free-psd/front-view-man-woman-posing-t-shirts_23-2148457381.jpg',8),(26,'https://image.freepik.com/free-psd/smiley-female-pointing-her-t-shirt_23-2148731668.jpg',9),(27,'https://image.freepik.com/free-psd/smiley-volunteers-holding-their-t-shirts-while-preparing-food-donation_23-2148731610.jpg',9),(28,'https://image.freepik.com/free-psd/smiley-volunteers-pointing-their-t-shirts-while-preparing-food-donation_23-2148731611.jpg',9),(29,'https://image.freepik.com/free-psd/close-up-beautiful-shirt-logo-mockup_213086-101.jpg',10),(30,'https://image.freepik.com/free-psd/close-up-beautiful-shirt-logo-mockup_213086-102.jpg',10),(31,'https://image.freepik.com/free-psd/logo-mockup-t-shirt-neck-label_185216-220.jpg',10);
/*!40000 ALTER TABLE `product_image_urls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `model_name` varchar(45) NOT NULL,
  `description` longtext NOT NULL,
  `discount_rate` decimal(3,2) DEFAULT NULL,
  `sales_product` int NOT NULL,
  `main_image_url` varchar(200) DEFAULT NULL,
  `like` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `brand_id` int NOT NULL,
  `first_category_id` int NOT NULL,
  `second_category_id` int NOT NULL,
  `third_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_first_category_id_bedb7e75_fk_first_categories_id` (`first_category_id`),
  KEY `products_second_category_id_bbd1a202_fk_second_categories_id` (`second_category_id`),
  KEY `products_third_category_id_cde8e35e_fk_third_categories_id` (`third_category_id`),
  KEY `products_brand_id_7e90a5c4_fk_brands_id` (`brand_id`),
  CONSTRAINT `products_brand_id_7e90a5c4_fk_brands_id` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  CONSTRAINT `products_first_category_id_bedb7e75_fk_first_categories_id` FOREIGN KEY (`first_category_id`) REFERENCES `first_categories` (`id`),
  CONSTRAINT `products_second_category_id_bbd1a202_fk_second_categories_id` FOREIGN KEY (`second_category_id`) REFERENCES `second_categories` (`id`),
  CONSTRAINT `products_third_category_id_cde8e35e_fk_third_categories_id` FOREIGN KEY (`third_category_id`) REFERENCES `third_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'나이키 스우시 반팔티',39900.00,'CK2350-001','나를 지켜주는 클래식한 편안함  나이키 스포츠웨어 클럽은 이미 시도하여 진정한 것에 부드러운 편안함을 더했습니다. 매일 입고 싶어할 티셔츠이며 편안하고 내구성이 우수하므로 매일 입을 수 있습니다.\n [공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.31,0,'https://images.unsplash.com/photo-1586116126912-6ce9141a3535?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',3452,'2020-11-26 17:07:00.470231',1,4,1,1),(2,'나이키 반팔 NSW 숏슬리브 티',55000.00,'CK2252-010','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.00,30,'https://images.unsplash.com/photo-1573084615714-fd555dcc785e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',20,'2020-11-26 17:07:00.473093',1,4,1,1),(3,'나이키 반팔티셔츠 더블스우시 화이트',90000.00,'CK2253-100','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.55,3,'https://images.unsplash.com/photo-1585036156261-1e2ac055414d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',2000,'2020-11-26 17:07:00.474557',1,4,1,1),(4,'나이키 남성용 JUST DO IT 스우시 반팔티',49000.00,'AR5006-011','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.00,2,'https://images.pexels.com/photos/733500/pexels-photo-733500.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',1122,'2020-11-26 17:07:00.475994',1,4,1,1),(5,'나이키 우먼스 파크 7 저지 S/S',26400.00,'BV6728-010','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.02,14,'https://images.unsplash.com/photo-1600525990321-9b74f0b86cdc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',302,'2020-11-26 17:07:00.478917',1,4,1,1),(6,'나이키 아쿠아 포토 티셔츠 블랙',60100.00,'45ht-45','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.42,10,'https://images.unsplash.com/flagged/photo-1580236922810-921cb4267a66?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',10,'2020-11-26 17:07:00.481201',1,4,1,1),(7,'나이키 NSW 에어 일러스트레이션 반팔티셔츠 ',37340.00,'CV0068-100','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.07,0,'https://images.unsplash.com/photo-1559634761-b542379908a9?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjgwfHxuaWtlJTIwc3dvb3NofGVufDB8fDB8&auto=format&fit=crop&w=800&q=60',0,'2020-11-26 17:07:00.483670',1,4,1,1),(8,'나이키 솔리드 스우시 반팔티',37000.00,'AR6029-100','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.31,3,'https://images.unsplash.com/photo-1558521432-23ac0222f962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',2,'2020-11-26 17:07:00.485348',1,4,1,1),(9,'나이키 로고 반팔티',49500.00,'696707-104','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.41,30,'https://images.unsplash.com/photo-1570470817527-8d23fb787632?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80',101,'2020-11-26 17:07:00.492399',1,4,1,1),(10,'나이키 TD NSW 스우시 반팔 티셔츠 ',30000.00,'thmtir-45949','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.34,100,'https://images.unsplash.com/photo-1578924608828-79a71150f711?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1508&q=80',2,'2020-11-26 17:07:00.493833',1,4,1,1),(11,'나이키 NSW 헤리티지 플러스 HBR 로고 반팔 티셔츠',49000.00,'BV7678-010','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.24,100,'https://images.unsplash.com/photo-1588117305388-c2631a279f82?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2468&q=80',1,'2020-11-26 17:07:00.495152',1,4,1,1),(12,'나이키 우먼 프로 메쉬 반팔티',59000.00,'AO9952-010','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.32,1,'https://images.unsplash.com/photo-1505915909330-c082888680af?ixlib=rb-1.2.1&auto=format&fit=crop&w=564&q=80',3,'2020-11-26 17:07:00.496833',1,4,1,1),(13,'나이키 스우시 폴로 매치업 카라 티셔츠 ',59000.00,'909746-100','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.33,10,'https://image.freepik.com/free-psd/green-t-shirt-mockup-isolated_278586-103.jpg',2,'2020-11-26 17:07:00.498986',1,4,1,1),(14,'리버풀 FC 스타디움 홈 숏슬리브 저지 ',117600.00,'CZ2636-687','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.21,9,'https://image.freepik.com/free-psd/hanging-t-shirt-mockup_37789-82.jpg',40,'2020-11-26 17:07:00.501676',1,4,1,1),(15,'나이키 풋웨어 캠프 티셔츠 ',66800.00,'dfkg-453453','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.41,10,'https://image.freepik.com/free-psd/soccer-jersey-front-back-mock-up-isolated_110893-2064.jpg',10,'2020-11-26 17:07:00.503677',1,4,1,1),(16,'나이키 반팔티셔츠 멀티로고',49000.00,'CU4510-902','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.07,1000,'https://image.freepik.com/free-psd/womens-slim-fit-t-shirt-mockup_315241-15.jpg',20,'2020-11-26 17:07:00.506121',1,4,1,1),(17,'나이키 루거시스 티셔츠',78200.00,'dfsg-345345345','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.39,1,'https://image.freepik.com/free-psd/t-shirt-mock-up_267205-3.jpg',30,'2020-11-26 17:07:00.508572',1,4,1,1),(18,'나이키 AOP 풋웨어 티셔츠',69300.00,'ertert-345345345','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.30,112,'https://image.freepik.com/free-psd/sportswear-cloth-mockup_1562-417.jpg',50,'2020-11-26 17:07:00.510752',1,4,1,1),(19,'나이키 맨 NSW 헤리티지 플러스 반팔 티셔츠',49000.00,'BV7882-010','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.17,114,'https://image.freepik.com/free-psd/t-shirt-mock-up_267205-25.jpg',80,'2020-11-26 17:07:00.512508',1,4,1,1),(20,'나이키 비치 베스켓볼 반팔 티셔츠 화이트',63270.00,'CD1294-100','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,12,'https://image.freepik.com/free-psd/woman-chair-holding-cushion_23-2147642304.jpg',0,'2020-11-26 17:07:00.515148',1,4,1,1),(21,'나이키 리버풀 FC 에버그린 티',44400.00,'CZ8183-010','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.21,333,'https://image.freepik.com/free-psd/blank-white-t-shirts-mockup-hanging_34168-2168.jpg',0,'2020-11-26 17:07:00.516681',1,4,1,1),(22,'나이키 레트로 그래픽 티셔츠',83900.00,'wertert-345345','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.\n\n구매에 참고 부탁드립니다.\n\n감사합니다.\n\n< 주문 공지 >\n\n해당 상품은 해외배송상품입니다. 실수령하시는 고객님의 개인통관고유부호를 주문서 배송메세지란에 직접입력 해주세요\n\n(미입력 주문시 세관통관 불가 및 이후 입력 시 지연 및 세금이 발생될 수 있습니다.\n\n미통관에 대한 책임은 주문자에 있습니다.)',0.38,1233,'https://image.freepik.com/free-psd/pocket-t-shirt-mockup-isolated_185216-356.jpg',0,'2020-11-26 17:07:00.518284',1,4,1,1),(23,'아디다스  스트라이프 반팔티셔츠 ',40000.00,'hgf5-565','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.31,0,'https://image.freepik.com/free-psd/blank-black-t-shirts-mockup-hanging-white-wall_34168-2148.jpg',0,'2020-11-26 17:07:00.520625',2,4,1,1),(24,'[아디다스 반팔티] CROP TOP-WHITE/BLACK',45100.00,'FM2556','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.\n\n[아디다스 반팔티] (FM2556) CROP TOP-WHITE/BLACK',0.00,11,'https://image.freepik.com/free-psd/t-shirts-mockups-men_300849-184.jpg',0,'2020-11-26 17:07:00.522803',2,4,1,1),(25,'아디다스 크롭 티셔츠 ',33600.00,'FM2517','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.17,6,'https://image.freepik.com/free-psd/woman-wearing-mockup-design-space-white-tee_53876-28122.jpg',0,'2020-11-26 17:07:00.524868',2,4,1,1),(26,'아디다스 여름 인기 반팔티셔츠',19500.00,'trh-345345','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.34,1111,'https://image.freepik.com/free-psd/brown-t-shirt-mockup-with-realistic-model_181945-962.jpg',1,'2020-11-26 17:07:00.526849',2,4,1,1),(27,'아디다스 유스보이 에센셜 3S 반팔티 그레이',11800.00,'DV1803','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.00,1,'https://image.freepik.com/free-psd/t-shirt-hanger-mockup_1562-441.jpg',2,'2020-11-26 17:07:00.528881',2,4,1,1),(28,'아디다스 기능성 스포츠 반팔티',37300.00,'A377','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.18,2,'https://image.freepik.com/free-psd/folded-tshirt-mockups-isolated_338606-6.jpg',3,'2020-11-26 17:07:00.530838',2,4,1,1),(29,'아디다스 M 로고 박스 포일 티 ',33000.00,'GD5930','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.17,0,'https://image.freepik.com/free-psd/t-shirt-mock-up_267205-36.jpg',2,'2020-11-26 17:07:00.532594',2,4,1,1),(30,'아디다스 엔트라다 18 저지 유소년티 반팔티',12800.00,'thrth-345345','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.19,2,'https://image.freepik.com/free-psd/realistic-tshirt-mockup-isolated_274703-18.jpg',2,'2020-11-26 17:07:00.534959',2,4,1,1),(31,'아디다스 어드벤쳐 티',37200.00,'GD5988','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.17,0,'https://image.freepik.com/free-psd/black-t-shirt-mockup_278586-33.jpg',3,'2020-11-26 17:07:00.536574',2,4,1,1),(32,'아디다스 MH 박스 반팔티셔츠 ',40000.00,'FR6608','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.07,11,'https://image.freepik.com/free-psd/t-shirt-mock-up_267205-10.jpg',4,'2020-11-26 17:07:00.537954',2,4,1,1),(33,'아디다스 R.Y.V. 미러 티',37200.00,'GD9291','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.00,1230,'https://image.freepik.com/free-psd/baby-t-shirt-mockup-design-business_278586-76.jpg',5,'2020-11-26 17:07:00.540312',2,4,1,1),(34,'아디다스 숄더 드레스',66000.00,'ED7521','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.23,20,'https://image.freepik.com/free-psd/woman-t-shirt-mockup-isolated_78895-1878.jpg',3,'2020-11-26 17:07:00.542751',2,4,1,1),(35,'아디다스 오버사이즈드 티 ',49200.00,'FM3795','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.19,333,'https://image.freepik.com/free-psd/tshirt-mockup_68185-66.jpg',3,'2020-11-26 17:07:00.544490',2,4,1,1),(36,'아디다스 MH BOS 티',30000.00,'FK3505','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.30,11,'https://image.freepik.com/free-psd/t-shirt-mockup-design_278586-65.jpg',1,'2020-11-26 17:07:00.546261',2,4,1,1),(37,'아디다스 B UR 시어서커 티',33600.00,'FM2922','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.26,1,'https://image.freepik.com/free-psd/realistic-t-shirt-mockup_88130-116.jpg',2,'2020-11-26 17:07:00.548553',2,4,1,1),(38,'아디다스 M MH 박스 BOS 티',44400.00,'FR6608','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.27,0,'https://image.freepik.com/free-psd/front-back-t-shirt-mockup-isolated_225210-227.jpg',50,'2020-11-26 17:07:00.550477',2,4,1,1),(39,'아디다스 오리지널 숏슬리브 G 슈무 반팔티',39000.00,'GK2905','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.06,33,'https://image.freepik.com/free-psd/t-shirt-with-notebook-mockup_37789-277.jpg',0,'2020-11-26 17:07:00.552633',2,4,1,1),(40,'아디다스 W 라지 로고 티',46800.00,'GD2358','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.32,12,'https://image.freepik.com/free-psd/t-shirt-mockup-girl-model_206643-91.jpg',3,'2020-11-26 17:07:00.555461',2,4,1,1),(41,'아디다스 트리플 로고 F 티 여름티셔츠 반팔티 ',24600.00,'nhnhm-65r','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.17,11,'https://image.freepik.com/free-psd/tank-top-psd-mockup_77323-87.jpg',3,'2020-11-26 17:07:00.558178',2,4,1,1),(42,'아디다스 반팔 빅 트레포일',59000.00,'FM9904','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.28,1,'https://image.freepik.com/free-psd/t-shirt-logo-mockup-isolated_57262-101.jpg',3,'2020-11-26 17:07:00.560021',2,4,1,1),(43,'아디다스 제노 티',46800.00,'FS7328','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.37,123,'https://image.freepik.com/free-psd/mockup-logo-backside-t-shirt-editable-color_178149-19.jpg',3,'2020-11-26 17:07:00.561995',2,4,1,1),(44,'스투시 랜드 아트 티셔츠',94100.00,'456rty','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,1,'https://image.freepik.com/free-psd/close-up-man-wearing-t-shirt-mockup_281023-63.jpg',3,'2020-11-26 17:07:00.563968',3,4,1,1),(45,'스투시 메쉬 크루넥 네이비',169000.00,'rty456','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.31,1,'https://image.freepik.com/free-psd/realistic-3d-polo-t-shirt-mockup-isolated_167120-93.jpg',3,'2020-11-26 17:07:00.565747',3,4,1,1),(46,'스투시 포켓 크루넥티 블랙',135100.00,'rladdd3-4','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.33,10,'https://image.freepik.com/free-psd/black-t-shirt-mockup-design_328332-23.jpg',3,'2020-11-26 17:07:00.568333',3,4,1,1),(47,'스투시 다이아몬드 티셔츠 레드',135000.00,'3t40t-t','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.33,111,'https://image.freepik.com/free-psd/specification-baseball-t-shirt-mockup-isolated_33916-631.jpg',3,'2020-11-26 17:07:00.570046',3,4,1,1),(48,'스투시 월드와이드 티셔츠',96600.00,'t5t-3e','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,31,'https://image.freepik.com/free-psd/close-up-woman-wearing-t-shirt-mockup_281023-55.jpg',3,'2020-11-26 17:07:00.572348',3,4,1,1),(49,'스투시 S 스포츠 티',94700.00,'234ert-t','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,111,'https://image.freepik.com/free-psd/female-t-shirt-ghost-mannequin-mockup_170704-32.jpg',2,'2020-11-26 17:07:00.574264',3,4,1,1),(50,'스투시 GAMBIT 티셔츠',60900.00,'h-56uy','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,66,'https://image.freepik.com/free-psd/mockup-isolated-t-shirt-front-view_196070-312.jpg',2,'2020-11-26 17:07:00.576655',3,4,1,1),(51,'스투시 KING 티셔츠',60990.00,'6y-5t4r34','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,22,'https://image.freepik.com/free-psd/yellow-t-shirts-mockup-front-back_34168-1035.jpg',1,'2020-11-26 17:07:00.580108',3,4,1,1),(52,'스투시 다이아몬드 티셔츠',135100.00,'ujyh-tgtr','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.33,0,'https://image.freepik.com/free-psd/white-oversize-t-shirts-mockup-front-back-mockup-template-your-design_34168-2014.jpg',2,'2020-11-26 17:07:00.582215',3,4,1,1),(53,'스투시 스트라이프 폴로 티 네츄럴',155300.00,'0o9i8u-7y','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.31,23,'https://image.freepik.com/free-psd/t-shirt-mock-up-wall_25226-44.jpg',3,'2020-11-26 17:07:00.584094',3,4,1,1),(54,'20SS 스투시 래가먼 체크 티셔츠',96600.00,'1q2-w3e4r','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,666,'https://image.freepik.com/free-psd/close-up-pocket-t-shirt-mockup_185216-258.jpg',4,'2020-11-26 17:07:00.586141',3,4,1,1),(55,'스투시 FUNKY S 티셔츠',94700.00,'sedf-345','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,132,'https://image.freepik.com/free-psd/t-shirt-mock-up_115431-72.jpg',5,'2020-11-26 17:07:00.588628',3,4,1,1),(56,'스투시 코스모스 반팔티셔츠',76800.00,'ju-56','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.05,21,'https://image.freepik.com/free-psd/unisex-t-shirt-mockup_120995-46.jpg',6,'2020-11-26 17:07:00.590538',3,4,1,1),(57,'스투시 립 패턴 셔츠',256500.00,'fy-456','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.27,66,'https://image.freepik.com/free-psd/polo-shirt-mockup_281023-42.jpg',7,'2020-11-26 17:07:00.592430',3,4,1,1),(58,'스투시 SPIRAL STRIPE CREW 반팔티 ',125000.00,'sgh-345','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.40,77,'https://image.freepik.com/free-psd/polo-shirt-mockup_281023-42.jpg',8,'2020-11-26 17:07:00.594933',3,4,1,1),(59,'스투시 크라운 스페이드 티셔츠',96600.00,'ghg-565','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,45,'https://image.freepik.com/free-psd/t-shirt-mockup-business-isolated_354609-18.jpg',9,'2020-11-26 17:07:00.596659',3,4,1,1),(60,'스투시 윙스 티셔츠 아쿠아',93000.00,'456h-mj','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.26,11,'https://image.freepik.com/free-psd/back-side-t-shirt-mockup_185216-332.jpg',8,'2020-11-26 17:07:00.598653',3,4,1,1),(61,'스투시 월드 티셔츠 ',94700.00,'345-rty','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,55,'https://image.freepik.com/free-psd/t-shirt-mock-up_267205-8.jpg',7,'2020-11-26 17:07:00.600292',3,4,1,1),(62,'스투시 멋있는 반팔티셔츠',63000.00,'1903306','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.05,23,'https://image.freepik.com/free-psd/t-shirt-mock-up_267205-5.jpg',6,'2020-11-26 17:07:00.603802',3,4,1,1),(63,'20SS 스투시 래가먼 체크 티셔츠',96600.00,'as2-rt4','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.37,46,'https://image.freepik.com/free-psd/green-t-shirt-mockup-light-gray-background-sunglight-shadows_193948-148.jpg',5,'2020-11-26 17:07:00.605953',3,4,1,1),(64,'스투시 GAMBIT 티셔츠 ',94700.00,'jj-888','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,44,'https://image.freepik.com/free-psd/top-view-mock-up-yellow-blue-t-shirt-with-mock-up-price-tags-wooden-table_67155-11048.jpg',7,'2020-11-26 17:07:00.607925',3,4,1,1),(65,'스투시 오렌지 슬라이스 티 ',93000.00,'yj-078','100% Cotton',0.77,32,'https://image.freepik.com/free-psd/woman-t-shirt-mock-up_1563-14.jpg',8,'2020-11-26 17:07:00.609841',3,4,1,1),(66,'스투시 웨이터 티',125000.00,'rt-45','100% Cotton',0.54,553,'https://image.freepik.com/free-psd/t-shirt-mockup-3d-rendering-design_185119-70.jpg',78,'2020-11-26 17:07:00.612119',3,4,1,1),(67,'스투시 레비테이트 티',91000.00,'er-45045','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.44,56,'https://image.freepik.com/free-psd/hanging-t-shirt-mockup_77323-97.jpg',9,'2020-11-26 17:07:00.614826',3,4,1,1),(68,'스투시 스모킹 스컬 티 ',91000.00,'qrhm-56565','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.66,34,'https://image.freepik.com/free-psd/man-pink-t-shirt-holding-disposable-coffee-cup_107420-16793.jpg',120,'2020-11-26 17:07:00.616425',3,4,1,1),(69,'스투시 X CDG 서퍼맨 티셔츠 화이트',99200.00,'qwe-3434','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.36,10,'https://image.freepik.com/free-psd/black-t-shirt-front-side-mockup-design_328332-21.jpg',20,'2020-11-26 17:07:00.618007',3,4,1,1),(70,'그라미치 x F/CE 오버 반팔 티셔츠 Black',189000.00,'sasd-1231','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.33,15,'https://image.freepik.com/free-psd/t-shirt-mockup-3d-rendering-design_185119-58.jpg',1110,'2020-11-26 17:07:00.620476',4,4,1,1),(71,'그라미치 빅러닝맨 반팔 티셔츠',123000.00,'qwer-1231','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.26,345,'https://image.freepik.com/free-psd/basic-unisex-t-shirt-mockup-ghost-mannequin-effect_68185-407.jpg',3505,'2020-11-26 17:07:00.622891',4,4,1,1),(72,'그라미치 원 포인트 반팔 티셔츠',66000.00,'1020-10203','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.16,5,'https://image.freepik.com/free-psd/tank-top-psd-mockup_1562-279.jpg',20,'2020-11-26 17:07:00.624786',4,4,1,1),(73,'그라미치 테일컷 반팔 티셔츠',100000.00,'1020-20394','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.55,33,'https://image.freepik.com/free-psd/tank-top-mockup_77323-197.jpg',10,'2020-11-26 17:07:00.626750',4,4,1,1),(74,'그라미치 테일컷 스웨트 반팔 티셔츠',120000.00,'202-20304','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.30,45,'https://image.freepik.com/free-psd/men-t-shirt-mockup_120995-50.jpg',203,'2020-11-26 17:07:00.628488',4,4,1,1),(75,'그라미치 로고 반팔 티셔츠',74000.00,'123w03f','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.00,3,'https://image.freepik.com/free-psd/tank-top-psd-mockup_1562-278.jpg',0,'2020-11-26 17:07:00.630226',4,4,1,1),(76,'언더아머 락커 2.0 반팔티',42000.00,'1305775-001','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.56,20,'https://image.freepik.com/free-psd/woman-t-shirt-mockup-3d-rendering-design_185119-211.jpg',203,'2020-11-26 17:07:00.632171',5,4,1,1),(77,'스파오 5부소매 라운드넥 티셔츠',19900.00,'SPRAA37W01','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.00,55,'https://image.freepik.com/free-psd/men-s-cotton-short-sleeve-t-shirt-mockup_1332-786.jpg',20,'2020-11-26 17:07:00.634172',6,4,1,1),(78,'파타고니아 2020년 FW P6로고 리스폰서빌리티 반팔티',54300.00,'38504','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.05,1770,'https://image.freepik.com/free-psd/top-view-black-t-shirt-mockup_354010-17.jpg',20,'2020-11-26 17:07:00.635930',7,4,1,1),(79,'파타고니아 라벨 패치 포켓 티셔츠 ',59090.00,'owoie3403','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.00,234,'https://image.freepik.com/free-psd/top-view-white-t-shirt-mockup_354010-16.jpg',10,'2020-11-26 17:07:00.637931',7,4,1,1),(80,'파타고니아 피츠로이 물고기 로고 반팔 티셔츠 ',58900.00,'azsxdc1q','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.05,205,'https://image.freepik.com/free-psd/top-view-black-white-t-shirt-mockup_354010-18.jpg',20,'2020-11-26 17:07:00.639882',7,4,1,1),(81,'파타고니아 스웨이드 티셔츠',1235000.00,'1q2w3e4r','[공지사항]\n본 상품은 해외 브랜드 5% 할인쿠폰 및 스타일쉐어 스토어 등급별 멤버쉽 할인 쿠폰 이 외\n다른 쿠폰 적용이 제한된 상품 입니다.\n\n구매시 참고 부탁드립니다.\n감사합니다.',0.12,55,'https://image.freepik.com/free-psd/gray-t-shirt-mockup-design_278586-62.jpg',2,'2020-11-26 17:07:00.641720',7,4,1,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_colors`
--

DROP TABLE IF EXISTS `products_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `color_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_colors_color_id_6f4711fc_fk_colors_id` (`color_id`),
  KEY `products_colors_product_id_6c9653b3_fk_products_id` (`product_id`),
  CONSTRAINT `products_colors_color_id_6f4711fc_fk_colors_id` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`),
  CONSTRAINT `products_colors_product_id_6c9653b3_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_colors`
--

LOCK TABLES `products_colors` WRITE;
/*!40000 ALTER TABLE `products_colors` DISABLE KEYS */;
INSERT INTO `products_colors` VALUES (1,1,1),(2,2,1),(3,3,1),(4,1,2),(5,2,2),(6,3,2),(7,1,3),(8,2,3),(9,3,3),(10,1,4),(11,2,4),(12,3,4),(13,1,5),(14,2,5),(15,3,5),(16,1,6),(17,2,6),(18,3,6),(19,1,7),(20,2,7),(21,3,7),(22,1,8),(23,2,8),(24,3,8),(25,1,9),(26,2,9),(27,3,9),(28,1,10),(29,2,10),(30,3,10),(31,1,11),(32,1,12),(33,1,13),(34,1,14),(35,1,15),(36,1,16),(37,1,17),(38,1,18),(39,1,19),(40,1,20),(41,1,21),(42,1,22),(43,1,23),(44,1,24),(45,1,25),(46,1,26),(47,1,27),(48,1,28),(49,1,29),(50,1,30),(51,1,31),(52,1,32),(53,1,33),(54,1,34),(55,1,35),(56,1,36),(57,1,37),(58,1,38),(59,1,39),(60,1,40),(61,1,41),(62,1,42),(63,1,43),(64,1,44),(65,1,45),(66,1,46),(67,1,47),(68,1,48),(69,1,49),(70,1,50),(71,1,51),(72,1,52),(73,1,53),(74,1,54),(75,1,55),(76,1,56),(77,1,57),(78,1,58),(79,1,59),(80,1,60),(81,1,61),(82,1,62),(83,1,63),(84,1,64),(85,1,65),(86,1,66),(87,1,67),(88,1,68),(89,1,69),(90,1,70),(91,1,71),(92,1,72),(93,1,73),(94,1,74),(95,1,75),(96,1,76),(97,1,77),(98,1,78),(99,1,79),(100,1,80),(101,1,81);
/*!40000 ALTER TABLE `products_colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_ootds`
--

DROP TABLE IF EXISTS `products_ootds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_ootds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ootd_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_ootds_ootd_id_e7a242fe_fk_ootds_id` (`ootd_id`),
  KEY `products_ootds_product_id_59b60003_fk_products_id` (`product_id`),
  CONSTRAINT `products_ootds_ootd_id_e7a242fe_fk_ootds_id` FOREIGN KEY (`ootd_id`) REFERENCES `ootds` (`id`),
  CONSTRAINT `products_ootds_product_id_59b60003_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_ootds`
--

LOCK TABLES `products_ootds` WRITE;
/*!40000 ALTER TABLE `products_ootds` DISABLE KEYS */;
INSERT INTO `products_ootds` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,1),(7,7,2),(8,8,3),(9,9,8),(10,10,1),(11,11,2),(12,12,1),(13,13,3),(14,14,9),(15,15,10),(16,16,2),(17,17,3),(18,18,5),(19,19,6),(20,20,2),(21,21,3),(22,22,2),(23,23,3),(24,24,3),(25,25,2),(26,26,1),(27,27,1),(28,28,1),(29,29,1),(30,30,2),(31,31,3),(32,32,4),(33,33,1),(34,34,1),(35,35,1),(36,36,1),(37,37,2),(38,38,4),(39,39,4),(40,40,4),(41,41,4),(42,42,1),(43,43,1),(44,44,1),(45,45,1),(46,46,1),(47,47,5),(48,48,5),(49,49,1),(50,50,1),(51,51,1),(52,52,1),(53,53,1),(54,54,5),(55,55,5),(56,56,1),(57,57,1),(58,58,1),(59,59,1),(60,60,1),(61,61,6),(62,62,1),(63,63,1),(64,64,1),(65,65,1),(66,66,1),(67,67,1),(68,68,6),(69,69,6),(70,70,6),(71,71,6),(72,72,6),(73,73,11),(74,74,1),(75,75,1),(76,76,1),(77,77,1),(78,78,6),(79,79,6),(80,80,6),(81,81,6),(82,82,6),(83,83,6),(84,84,7),(85,85,7),(86,86,7),(87,87,7),(88,88,8),(89,89,8),(90,90,8),(91,91,8),(92,92,9),(93,93,9),(94,94,9),(95,95,9),(96,96,10),(97,97,10),(98,98,10),(99,99,10);
/*!40000 ALTER TABLE `products_ootds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_sizes`
--

DROP TABLE IF EXISTS `products_sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `size_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_sizes_product_id_2e2d0557_fk_products_id` (`product_id`),
  KEY `products_sizes_size_id_d19716a2_fk_sizes_id` (`size_id`),
  CONSTRAINT `products_sizes_product_id_2e2d0557_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `products_sizes_size_id_d19716a2_fk_sizes_id` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_sizes`
--

LOCK TABLES `products_sizes` WRITE;
/*!40000 ALTER TABLE `products_sizes` DISABLE KEYS */;
INSERT INTO `products_sizes` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,2,1),(6,2,2),(7,2,3),(8,2,4),(9,3,1),(10,3,2),(11,3,3),(12,3,4),(13,4,1),(14,4,2),(15,4,3),(16,4,4),(17,5,1),(18,5,2),(19,5,3),(20,5,4),(21,6,1),(22,6,2),(23,6,3),(24,6,4),(25,7,1),(26,7,2),(27,7,3),(28,7,4),(29,8,1),(30,8,2),(31,8,3),(32,8,4),(33,9,1),(34,9,2),(35,9,3),(36,9,4),(37,10,1),(38,10,2),(39,10,3),(40,10,4),(41,11,5),(42,12,5),(43,13,5),(44,14,5),(45,15,5),(46,16,5),(47,17,5),(48,18,5),(49,19,5),(50,20,5),(51,21,5),(52,22,5),(53,23,5),(54,24,5),(55,25,5),(56,26,5),(57,27,5),(58,28,5),(59,29,5),(60,30,5),(61,31,5),(62,32,5),(63,33,5),(64,34,5),(65,35,5),(66,36,5),(67,37,5),(68,38,5),(69,39,5),(70,40,5),(71,41,5),(72,42,5),(73,43,5),(74,44,5),(75,45,5),(76,46,5),(77,47,5),(78,48,5),(79,49,5),(80,50,5),(81,51,5),(82,52,5),(83,53,5),(84,54,5),(85,55,5),(86,56,5),(87,57,5),(88,58,5),(89,59,5),(90,60,5),(91,61,5),(92,62,5),(93,63,5),(94,64,5),(95,65,5),(96,66,5),(97,67,5),(98,68,5),(99,69,5),(100,70,5),(101,71,5),(102,72,5),(103,73,5),(104,74,5),(105,75,5),(106,76,5),(107,77,5),(108,78,5),(109,79,5),(110,80,5),(111,81,5);
/*!40000 ALTER TABLE `products_sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `second_categories`
--

DROP TABLE IF EXISTS `second_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `second_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `first_category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `second_categories_first_category_id_33822916_fk_first_cat` (`first_category_id`),
  CONSTRAINT `second_categories_first_category_id_33822916_fk_first_cat` FOREIGN KEY (`first_category_id`) REFERENCES `first_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `second_categories`
--

LOCK TABLES `second_categories` WRITE;
/*!40000 ALTER TABLE `second_categories` DISABLE KEYS */;
INSERT INTO `second_categories` VALUES (1,'티셔츠',4),(2,'후드/집업/맨투맨',4),(3,'셔츠',4),(4,'니트/가디건',4),(5,'아우터',4),(6,'팬츠',4),(7,'스포츠',4),(8,'언더웨어',4),(9,'프리미엄 브랜드',4),(10,'티셔츠',5),(11,'후드/집업/맨투맨',5),(12,'셔츠/블라우스',5),(13,'니트/가디건',5),(14,'아우터',5),(15,'팬츠',5),(16,'스커트',5),(17,'원피스',5),(18,'스포츠',5),(19,'언더웨어',5),(20,'프리미엄 브랜드',5),(21,'스킨케어',6),(22,'메이크업',6),(23,'클렌징',6),(24,'바디케어',6),(25,'헤어케어',6),(26,'남성화장품',6),(27,'향수/디퓨저/캔들',6),(28,'뷰티소품',6),(29,'여성용품',6),(30,'헤어/바디/미용기기',6),(31,'글로벌 브랜드',6),(32,'다이어트 식품',6),(33,'홈트레이닝',6),(34,'집콕홈케어',6),(35,'가방',7),(36,'지갑/파우치',7),(37,'시계',7),(38,'모자',7),(39,'안경/선글라스',7),(40,'장갑/목도리/귀도리',7),(41,'쥬얼리',7),(42,'기타소품',7),(43,'양말/스타킹',7),(44,'프리미엄 브랜드',7),(45,'스니커즈',8),(46,'구두',8),(47,'샌들',8),(48,'부츠',8),(49,'슈케어 & 액세서리',8),(50,'남성슈즈',8),(51,'프리미엄 브랜드',8),(52,'인테리어',9),(53,'가구/수납',9),(54,'생활용품',9),(55,'패브릭',9),(56,'키친',9),(57,'시즌/이벤트',9),(58,'디자인문구',9),(59,'푸드',9),(60,'집콕생활',9),(61,'휴대폰 악세서리',10),(62,'계절가전',10),(63,'생활가전',10),(64,'건강가전',10),(65,'음향기기',10),(66,'카메라',10),(67,'pc 주변기기',10),(68,'집콕학습',10),(69,'스마트기기 악세서리',10);
/*!40000 ALTER TABLE `second_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_companies`
--

DROP TABLE IF EXISTS `shipping_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_companies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_companies`
--

LOCK TABLES `shipping_companies` WRITE;
/*!40000 ALTER TABLE `shipping_companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_numbers`
--

DROP TABLE IF EXISTS `shipping_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_numbers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipping_number` varchar(50) NOT NULL,
  `order_id` int NOT NULL,
  `shipping_company_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_numbers_order_id_3e66e460_fk_orders_id` (`order_id`),
  KEY `shipping_numbers_shipping_company_id_df0f2dad_fk_shipping_` (`shipping_company_id`),
  CONSTRAINT `shipping_numbers_order_id_3e66e460_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `shipping_numbers_shipping_company_id_df0f2dad_fk_shipping_` FOREIGN KEY (`shipping_company_id`) REFERENCES `shipping_companies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_numbers`
--

LOCK TABLES `shipping_numbers` WRITE;
/*!40000 ALTER TABLE `shipping_numbers` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipping_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (1,'S'),(2,'M'),(3,'L'),(4,'XL'),(5,'FREE');
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocks`
--

DROP TABLE IF EXISTS `stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stocks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock_count` int NOT NULL,
  `color_id` int NOT NULL,
  `product_id` int NOT NULL,
  `size_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stocks_color_id_6ef9212c_fk_colors_id` (`color_id`),
  KEY `stocks_product_id_f5a06e7d_fk_products_id` (`product_id`),
  KEY `stocks_size_id_89eafc27_fk_sizes_id` (`size_id`),
  CONSTRAINT `stocks_color_id_6ef9212c_fk_colors_id` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`),
  CONSTRAINT `stocks_product_id_f5a06e7d_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `stocks_size_id_89eafc27_fk_sizes_id` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocks`
--

LOCK TABLES `stocks` WRITE;
/*!40000 ALTER TABLE `stocks` DISABLE KEYS */;
INSERT INTO `stocks` VALUES (1,100,1,1,1),(2,100,2,1,1),(3,100,3,1,1),(4,100,1,1,2),(5,100,2,1,2),(6,100,3,1,2),(7,100,1,1,3),(8,100,2,1,3),(9,100,3,1,3),(10,100,1,1,4),(11,0,2,1,4),(12,0,3,1,4),(13,10,1,2,1),(14,2,2,2,1),(15,5,3,2,1),(16,1,1,2,2),(17,2,2,2,2),(18,5,3,2,2),(19,0,1,2,3),(20,0,2,2,3),(21,2,3,2,3),(22,30,1,2,4),(23,30,2,2,4),(24,1,3,2,4),(25,10,1,3,1),(26,10,2,3,1),(27,1,3,3,1),(28,11,1,3,2),(29,0,2,3,2),(30,1,3,3,2),(31,0,1,3,3),(32,2,2,3,3),(33,0,3,3,3),(34,0,1,3,4),(35,0,2,3,4),(36,0,3,3,4),(37,33,1,4,1),(38,33,2,4,1),(39,33,3,4,1),(40,33,1,4,2),(41,33,2,4,2),(42,33,3,4,2),(43,33,1,4,3),(44,33,2,4,3),(45,33,3,4,3),(46,33,1,4,4),(47,33,2,4,4),(48,33,3,4,4),(49,33,1,5,1),(50,33,2,5,1),(51,33,3,5,1),(52,33,1,5,2),(53,33,2,5,2),(54,33,3,5,2),(55,33,1,5,3),(56,33,2,5,3),(57,33,3,5,3),(58,33,1,5,4),(59,33,2,5,4),(60,34,3,5,4),(61,34,1,6,1),(62,34,2,6,1),(63,34,3,6,1),(64,0,1,6,2),(65,0,2,6,2),(66,0,3,6,2),(67,0,1,6,3),(68,0,2,6,3),(69,0,3,6,3),(70,0,1,6,4),(71,0,2,6,4),(72,0,3,6,4),(73,1,1,7,1),(74,2,2,7,1),(75,3,3,7,1),(76,1,1,7,2),(77,2,2,7,2),(78,1,3,7,2),(79,2,1,7,3),(80,1,2,7,3),(81,0,3,7,3),(82,0,1,7,4),(83,0,2,7,4),(84,10,3,7,4),(85,110,1,8,1),(86,10,2,8,1),(87,100,3,8,1),(88,100,1,8,2),(89,100,2,8,2),(90,100,3,8,2),(91,100,1,8,3),(92,100,2,8,3),(93,100,3,8,3),(94,100,1,8,4),(95,100,2,8,4),(96,10,3,8,4),(97,20,1,9,1),(98,30,2,9,1),(99,1,3,9,1),(100,4,1,9,2),(101,0,2,9,2),(102,10,3,9,2),(103,0,1,9,3),(104,20,2,9,3),(105,30,3,9,3),(106,0,1,9,4),(107,0,2,9,4),(108,10,3,9,4),(109,20,1,10,1),(110,30,2,10,1),(111,10,3,10,1),(112,10,1,10,2),(113,10,2,10,2),(114,20,3,10,2),(115,0,1,10,3),(116,2,2,10,3),(117,20,3,10,3),(118,30,1,10,4),(119,10,2,10,4),(120,20,3,10,4),(121,10,1,11,5),(122,5,1,12,5),(123,0,1,13,5),(124,0,1,14,5),(125,0,1,15,5),(126,0,1,16,5),(127,0,1,17,5),(128,0,1,18,5),(129,10,1,19,5),(130,20,1,20,5),(131,30,1,21,5),(132,0,1,22,5),(133,0,1,23,5),(134,0,1,24,5),(135,10,1,25,5),(136,10,1,26,5),(137,100,1,27,5),(138,100,1,28,5),(139,100,1,29,5),(140,100,1,30,5),(141,100,1,31,5),(142,100,1,32,5),(143,100,1,33,5),(144,100,1,34,5),(145,100,1,35,5),(146,100,1,36,5),(147,100,1,37,5),(148,100,1,38,5),(149,100,1,39,5),(150,100,1,40,5),(151,100,1,41,5),(152,100,1,42,5),(153,100,1,43,5),(154,100,1,44,5),(155,100,1,45,5),(156,100,1,46,5),(157,100,1,47,5),(158,100,1,48,5),(159,100,1,49,5),(160,100,1,50,5),(161,100,1,51,5),(162,100,1,52,5),(163,100,1,53,5),(164,100,1,54,5),(165,100,1,55,5),(166,100,1,56,5),(167,100,1,57,5),(168,100,1,58,5),(169,100,1,59,5),(170,100,1,60,5),(171,100,1,61,5),(172,100,1,62,5),(173,100,1,63,5),(174,100,1,64,5),(175,100,1,65,5),(176,100,1,66,5),(177,100,1,67,5),(178,100,1,68,5),(179,100,1,69,5),(180,100,1,70,5),(181,100,1,71,5),(182,100,1,72,5),(183,100,1,73,5),(184,100,1,74,5),(185,100,1,75,5),(186,100,1,76,5),(187,100,1,77,5),(188,100,1,78,5),(189,100,1,79,5),(190,100,1,80,5),(191,100,1,81,5);
/*!40000 ALTER TABLE `stocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'#나이키'),(2,'#반팔티'),(3,'#오늘뭐입지?'),(4,'#데일리룩'),(5,'#프린트'),(6,'#해외브랜드'),(7,'#스우시'),(8,'#우먼스'),(9,'#로고'),(10,'#블랙'),(11,'#메쉬'),(12,'#꾸안꾸'),(13,'#오토바이'),(14,'#겨울'),(15,'#가을'),(16,'#아메카지'),(17,'#13번'),(18,'#레오파드'),(19,'#스투시'),(20,'#파타고니아'),(21,'#아디다스'),(22,'#그라미치'),(23,'#스파오'),(24,'#언더아머');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_categories`
--

DROP TABLE IF EXISTS `third_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `third_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `second_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `third_categories_second_category_id_1010744b_fk_second_ca` (`second_category_id`),
  CONSTRAINT `third_categories_second_category_id_1010744b_fk_second_ca` FOREIGN KEY (`second_category_id`) REFERENCES `second_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_categories`
--

LOCK TABLES `third_categories` WRITE;
/*!40000 ALTER TABLE `third_categories` DISABLE KEYS */;
INSERT INTO `third_categories` VALUES (1,'반팔 티셔츠',1),(2,'긴팔 티셔츠',1),(3,'슬리브리스',1),(4,'피케 티셔츠',1),(5,'터틀넥 티셔츠',1),(6,'후드',2),(7,'후드집업',2),(8,'맨투맨',2),(9,'캐주얼 셔츠',3),(10,'체크/패턴셔츠',3),(11,'데님 셔츠',3),(12,'라운드넥 니트',4),(13,'브이넥 니트',4),(14,'터틀넥 니트',4),(15,'베스트',4),(16,'가디건',4),(17,'코트',5),(18,'점퍼',5),(19,'자켓',5),(20,'야상',5),(21,'롱패딩',5),(22,'가죽자켓',5),(23,'패딩 베스트',5),(24,'숏패딩',5),(25,'베스트',5),(26,'바람막이/트랙자켓',5),(27,'플리스',5),(28,'코튼팬츠',6),(29,'데님팬츠',6),(30,'슬랙스',6),(31,'숏/하프팬츠',6),(32,'트레이닝',6),(33,'티셔츠',7),(34,'팬츠',7),(35,'트레이닝',7),(36,'자켓/점퍼',7),(37,'조끼/베스트',7),(38,'수영복/래쉬가드',7),(39,'스노우 웨어',7),(40,'스윔웨어',7),(41,'러닝',8),(42,'팬티',8),(43,'잠옷',8),(44,'내의',8),(45,'무스너클',9),(46,'노비스',9),(47,'바버',9),(48,'꼼데가르송',9),(49,'생로랑',9),(50,'톰브라운',9),(51,'몽클레어',9),(52,'마르셀로블론',9),(53,'스톤아일랜드',9),(54,'에르노',9),(55,'겐조',9),(56,'디스퀘어드2',9),(57,'CP컴퍼니',9),(58,'아미',9),(59,'캐나다구스',9),(60,'반팔 티셔츠',10),(61,'긴팔 티셔츠',10),(62,'크롭/슬리브리스',10),(63,'피케 티셔츠',10),(64,'터틀넥 티셔츠',10),(65,'후드',11),(66,'후드집업',11),(67,'맨투맨',11),(68,'카라 블라우스',12),(69,'노카라 블라우스',12),(70,'민소매 브라우스/셔츠',12),(71,'데님셔츠',12),(72,'화이트셔츠',12),(73,'컬러셔츠',12),(74,'체크/패턴셔츠',12),(75,'라운드넥 니트',13),(76,'브이넥 니트',13),(77,'롱/터틀넥 니트',13),(78,'베스트/ 뷔스티에',13),(79,'가디건',13),(80,'롱/루즈핏 가디건',13),(81,'코트',14),(82,'점퍼',14),(83,'자켓',14),(84,'야상',14),(85,'롱패딩',14),(86,'가죽자켓',14),(87,'패딩 베스트',14),(88,'숏패딩',14),(89,'베스트',14),(90,'바람막이/트랙자켓',14),(91,'플리스',14),(92,'트렌치코트',14),(93,'데님 팬츠',15),(94,'숏/하프팬츠',15),(95,'코튼 팬츠',15),(96,'와이드 팬츠',15),(97,'슬랙스',15),(98,'점프수트/오버롤',15),(99,'기모팬츠',15),(100,'레깅스',15),(101,'트레이닝',15),(102,'미니 스커트',16),(103,'미들/롱 스커트',16),(104,'니트 스커트',16),(105,'데님 스커트',16),(106,'롱/미디 원피스',17),(107,'미니 원피스',17),(108,'민소매 원피스',17),(109,'니트 원피스',17),(110,'티셔츠',18),(111,'팬츠',18),(112,'트레이닝',18),(113,'자켓/점퍼',18),(114,'조끼/베스트',18),(115,'요가복',18),(116,'수영복/래쉬가드',18),(117,'스노우 웨어',18),(118,'스윔웨어',18),(119,'캐미솔/러닝톱',19),(120,'브라',19),(121,'팬티',19),(122,'잠옷',19),(123,'세트',19),(124,'내의',19),(125,'무스너클',20),(126,'노비스',20),(127,'바버',20),(128,'생로랑',20),(129,'버버리',20),(130,'프라다',20),(131,'몽클레어',20),(132,'꼼데가르송',20),(133,'토리버치',20),(134,'스킨/토너',21),(135,'로션/에멀전',21),(136,'에센스/앰플/세럼',21),(137,'크림',21),(138,'아이케어/링클케어',21),(139,'화이트닝케어',21),(140,'트러블/진정/민감성케어',21),(141,'피지/모공케어',21),(142,'필오프/워시오프/리모델링팩',21),(143,'스킨케어세트',21),(144,'미스트/부스터',21),(145,'오일',21),(146,'썬케어',21),(147,'스페셜케어',21),(148,'시트마스크',21),(149,'슬리핑팩',21),(150,'수분케어',21),(151,'핌플패드/스킨패드',21),(152,'메이크업베이스/프라이머',22),(153,'비비크림/씨씨크림',22),(154,'파운데이션',22),(155,'컨실러/스킨커버',22),(156,'쿠션/파우더/팩트',22),(157,'아이브로우',22),(158,'아이라이너',22),(159,'아이섀도우',22),(160,'마스카라',22),(161,'립스틱/립크레용/립라이너',22),(162,'립글로스/립밤/립탑코트',22),(163,'립라커/틴트/립마카',22),(164,'메이크업세트',22),(165,'블러셔/치크',22),(166,'쉐딩/하이라이터',22),(167,'클렌징폼',23),(168,'립앤아이리무버',23),(169,'클렌징오일/클렌징젤/밤/티슈',23),(170,'클렌징크림/로션/워터',23),(171,'스크럽/필링/마사지',23),(172,'미용비누/천연비누/수제비누',23),(173,'클렌징세트',23),(174,'클렌징도구',23),(175,'바디워시',24),(176,'바디로션/오일/파우더',24),(177,'바디스크럽/바디필링',24),(178,'바디미스트/샤워코롱',24),(179,'바디세트',24),(180,'입욕제',24),(181,'풋/핸드케어',24),(182,'데오드란트',24),(183,'제모용품',24),(184,'바디패치/바디스페션케어',24),(185,'여성청결제',24),(186,'립케어/립밤/립오일',24),(187,'구강케어',24),(188,'샴푸/린스',25),(189,'염색/헤어컬러링',25),(190,'트리트먼트/팩',25),(191,'헤어오일/에센스',25),(192,'헤어스타일링',25),(193,'헤어세트',25),(194,'헤어소품',25),(195,'헤어가발',25),(196,'남성세트',26),(197,'스킨/애프터쉐이브',26),(198,'로션/에센스/미스트/크림',26),(199,'올인원',26),(200,'선크림/비비크림',26),(201,'클렌징',26),(202,'기능성케어/마스크팩',26),(203,'왁스/스프레이/염색제',26),(204,'헤어소품',26),(205,'남성메이크업',26),(206,'남성뷰티소품',26),(207,'여성향수',27),(208,'남성향수',27),(209,'섬유향수',27),(210,'디퓨저/방향제',27),(211,'캔들',27),(212,'퍼퓸샤셰',27),(213,'브러시',28),(214,'퍼프',28),(215,'거울',28),(216,'헤어소품',28),(217,'생활미용소품',28),(218,'메이크업 소품',28),(219,'바디소품',28),(220,'속눈썹',28),(221,'화장솜',28),(222,'메이크업 파우치',28),(223,'뷰러',28),(224,'네일아트/네일소품',28),(225,'기타',28),(226,'생리대',29),(227,'드라이기',30),(228,'고데기',30),(229,'피부관리기기',30),(230,'제모기',30),(231,'클렌징 기기',30),(232,'바디케어 기기',30),(233,'네일케어 기기',30),(234,'면도기',30),(235,'이미용기기',30),(236,'기초',31),(237,'색조',31),(238,'헤어/바디',31),(239,'향수/캔들/디퓨저',31),(240,'식사대용/간식',32),(241,'다이어트 보조식품',32),(242,'다이어트 쉐이크',32),(243,'건강식품',32),(244,'스트레칭/마사지/교정',33),(245,'유산소',33),(246,'근력',33),(247,'보호대',33),(248,'체중계',33),(249,'스포츠/레저',33),(250,'스킨케어기기',34),(251,'헤어케어기기',34),(252,'바디케어기기',34),(253,'네일케어',34),(254,'마스크팩',34),(255,'헤어팩',34),(256,'미용소품',34),(257,'에코백',35),(258,'토트백',35),(259,'숄더백',35),(260,'크로스백/메신저백',35),(261,'백팩',35),(262,'힙색',35),(263,'클러치백',35),(264,'노트북 가방',35),(265,'보스턴백/여행가방',35),(266,'반지갑',36),(267,'장지갑',36),(268,'카드지갑',36),(269,'파우치',36),(270,'머니클립',36),(271,'동전지갑',36),(272,'여권지갑',36),(273,'중지갑',36),(274,'지갑 악세사리',36),(275,'스트랩',37),(276,'디지털시계',37),(277,'아닐로그시계',37),(278,'야구모자',38),(279,'베레모',38),(280,'비니',38),(281,'사파리',38),(282,'페도라',38),(283,'안경',39),(284,'선글라스',39),(285,'안경 악세사리',39),(286,'장갑',40),(287,'머플러',40),(288,'스카프',40),(289,'귀도리',40),(290,'귀걸이',41),(291,'목걸이',41),(292,'반지',41),(293,'팔찌/발찌',41),(294,'기타',41),(295,'피어싱',41),(296,'귀찌',41),(297,'쥬얼리세트',41),(298,'커플링',41),(299,'벨트',42),(300,'키링',42),(301,'헤어 악세사리',42),(302,'기타',42),(303,'뱃지',42),(304,'우산',42),(305,'마스크',42),(306,'헤어밴드',42),(307,'마스크 스트랩',42),(308,'페이크삭스',43),(309,'니삭스',43),(310,'발목 양말',43),(311,'세트 양말',43),(312,'스타킹',43),(313,'수면양말',43),(314,'구찌',44),(315,'프라다',44),(316,'지방시',44),(317,'몽블랑',44),(318,'비비안웨스트우드',44),(319,'티파니앤코',44),(320,'페라가모',44),(321,'생로랑',44),(322,'발렌티노',44),(323,'버버리',44),(324,'발렌시아가',44),(325,'마이클코어스',44),(326,'마크제이콥스',44),(327,'마르지엘라',44),(328,'토리버치',44),(329,'끌로에',44),(330,'셀린느',44),(331,'보테가베네타',44),(332,'멀버리',44),(333,'아크네',44),(334,'코치',44),(335,'마르니',44),(336,'슬립온',45),(337,'하이탑',45),(338,'로우탑',45),(339,'캔버스',45),(340,'운동화',45),(341,'농구화',45),(342,'테니스화',45),(343,'스케이트보드화',45),(344,'런닝화',45),(345,'벨크로',45),(346,'어글리슈즈',45),(347,'플랫',46),(348,'로퍼',46),(349,'옥스퍼드',46),(350,'힐',46),(351,'웨지힐',46),(352,'슬링백',46),(353,'블로퍼',46),(354,'플립플랍',47),(355,'힐 샌들',47),(356,'슬로퍼',47),(357,'플랫샌들',47),(358,'롱부츠(플랫)',48),(359,'롱부츠(힐)',48),(360,'앵클/부티워커',48),(361,'레인부츠',48),(362,'퍼부츠',48),(363,'패딩부츠',48),(364,'캐주얼 부츠',48),(365,'슈케어&악세사리',49),(366,'로퍼',50),(367,'레이스업',50),(368,'부츠',50),(369,'스트랩',50),(370,'골든구스',51),(371,'꼼데가르송',51),(372,'어그',51),(373,'페레가모',51),(374,'생로랑',51),(375,'발렌티노',51),(376,'프라다',51),(377,'알렉산더 맥퀸',51),(378,'토리버치',51),(379,'조명/스탠드',52),(380,'월데코/액자',52),(381,'시계',52),(382,'디퓨저/방향제',52),(383,'캔들',52),(384,'장식소품',52),(385,'행거',53),(386,'수납장',53),(387,'책상',53),(388,'의자',53),(389,'정리용품',54),(390,'욕실용품',54),(391,'기타 생활잡화',54),(392,'세제',54),(393,'담요',55),(394,'쿠션',55),(395,'러그',55),(396,'커튼',55),(397,'패브릭 소품',55),(398,'텀블러',56),(399,'컵',56),(400,'와인/차 용품',56),(401,'식기',56),(402,'조리기구',56),(403,'에이프런/장갑',56),(404,'기타소품',56),(405,'파티',57),(406,'트래블',57),(407,'다이어리',58),(408,'노트',58),(409,'데코레이션',58),(410,'엽서',58),(411,'파일링',58),(412,'앨범',58),(413,'필기구',58),(414,'데스크용품',58),(415,'취미',58),(416,'기타',58),(417,'과자',59),(418,'커피',59),(419,'견과',59),(420,'생수',59),(421,'두유',59),(422,'냉동/냉장',59),(423,'조미료',59),(424,'방꾸미기',60),(425,'다꾸',60),(426,'홈카페',60),(427,'보호필름',61),(428,'충전기',61),(429,'보조배터리',61),(430,'스마트링',61),(431,'거치대',61),(432,'아이폰 케이스',61),(433,'안드로이드 케이스',61),(434,'휴대/탁상형 선풍기',62),(435,'스탠드 선풍기',62),(436,'공기순환기',62),(437,'가습기',62),(438,'히터',62),(439,'휴대용 난방기기',62),(440,'진공청소기',63),(441,'공기청정기',63),(442,'다리미',63),(443,'보풀제거기',63),(444,'찜질기',64),(445,'안마용품',64),(446,'전동칫솔',64),(447,'음향 액세서리',65),(448,'이어폰',65),(449,'헤드폰',65),(450,'스피커',65),(451,'무선마이크',65),(452,'카메라',66),(453,'마우스',67),(454,'키보드',67),(455,'주변용품',67),(456,'모니터 받침대',67),(457,'USB',67),(458,'원격수업',68),(459,'주변기기',68),(460,'청소기',68),(461,'태블릿 액세서리',69),(462,'스마트 워치 액세서리',69);
/*!40000 ALTER TABLE `third_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login_id` varchar(20) NOT NULL,
  `password` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `birth_date` date NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `profile_image_url` varchar(200) DEFAULT NULL,
  `description` longtext,
  `country` varchar(20) DEFAULT NULL,
  `website_url` varchar(200) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `point` int NOT NULL,
  `gender_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_gender_id_5b939083` (`gender_id`),
  CONSTRAINT `users_gender_id_5b939083_fk_genders_id` FOREIGN KEY (`gender_id`) REFERENCES `genders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'messi','1q2w','messi@naver.com','1975-05-05','메시','https://images.unsplash.com/photo-1598121876853-82437626c783?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','맨체스터시티에서 선수 생활을 하고 있는 메시라고 합니다.','대한민국','https://www.instagram.com/leomessi/',NULL,0,2),(2,'ronaldo','1q2w','ronaldo@naver.com','1990-06-06','호날두','https://images.unsplash.com/photo-1567371278008-4d771286fb85?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','유벤투스에서 선수생활을 하고 있는 호날두라고 합니다.','대한민국','https://www.instagram.com/cristiano/',NULL,0,2),(3,'dooly','1q2w','dooly@naver.com','2002-02-02','둘리','https://images.unsplash.com/photo-1525877442103-5ddb2089b2bb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1296&q=60','고길동네 거주하는 둘리입니다.','대한민국','https://www.instagram.com/doolymuseum/?hl=ko',NULL,0,2),(4,'douner','1q2w','douner@naver.com','1960-05-03','도우너','https://images.unsplash.com/photo-1503533464228-bd3c36ddd3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','고길동네 거주하는 도우너입니다.','대한민국','https://www.instagram.com/go_gil_dong/',NULL,0,2),(5,'minkoo','1q2w','minkoo@naver.com','2007-02-03','김민구','https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','위코드에서 공부하고 있는 김민구입니다.','대한민국','',NULL,0,1),(6,'hocheol','1q2w','hocheol@naver.com','1990-05-05','장호철','https://images.unsplash.com/photo-1548946526-f69e2424cf45?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','위코드에서 공부하고 있는 장호철입니다.','대한민국','',NULL,0,1),(7,'hyunjae','1q2w','hyunjae@naver.com','1997-07-07','박현재','https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','위코드에서 공부하고 있는 박현재입니다.','대한민국','',NULL,0,1),(8,'munju','1q2w','munju@naver.com','1990-06-06','엄문주','https://images.unsplash.com/photo-1567186937675-a5131c8a89ea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','위코드에서 공부하고 있는 엄문주입니다.','대한민국','',NULL,0,1),(9,'seungchan','1q2w','seungchan@naver.com','1995-06-06','백승찬','https://images.unsplash.com/photo-1597357664116-6510db2a06b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','위코드에서 공부하고 있는 백승찬입니다.','대한민국','',NULL,0,1),(10,'hyeonseok','q1q2','hyeonseok@naver.com','1999-06-06','정현석','https://images.unsplash.com/photo-1585675100414-add2e465a136?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60','위코드에서 공부하고 있는 정현석입니다.','대한민국','',NULL,0,1),(11,'dummy1','1234','dummy1@naver.com','2020-02-02','나이키사랑','https://images.unsplash.com/photo-1545912452-8aea7e25a3d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80','안녕하세요 저는 나이키를 사랑하는 사람입니다.','대한민국','',NULL,0,1),(12,'dummy2','1234','dummy2@naver.com','2020-02-03','나이키나이키나이키','https://images.unsplash.com/photo-1524638431109-93d95c968f03?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80','더미2입니다 잘 부탁드립니다.','대한민국','',NULL,0,1),(13,'dummy3','1234','dummy3@naver.com','2020-02-04','나이키키키키','https://images.unsplash.com/photo-1524502397800-2eeaad7c3fe5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80','취준생 더미3이에요 ㅋㅋㅋ 소통 많이 해요','대한민국','',NULL,0,1),(14,'dummy4','1234','dummy4@naver.com','2020-02-05','키이나이키','https://images.unsplash.com/photo-1503104834685-7205e8607eb9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80','식사들 맛있게 하셨나요?','대한민국','',NULL,0,1),(15,'dummy5','1234','dummy5@naver.com','2020-02-06','나이스한나이키','https://images.unsplash.com/photo-1560535733-540e0b0068b9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80','개발자를 준비하고 있는 사람입니다.','대한민국','',NULL,0,1),(16,'dummy6','1234','dummy6@naver.com','2020-02-07','나이키너무좋습니다','https://images.unsplash.com/photo-1532170579297-281918c8ae72?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1362&q=80','스타일쉐어를 클론 프로젝트하고 있습니다.','대한민국','',NULL,0,1),(17,'dummy7','1234','dummy7@naver.com','2020-02-08','나이키괜찮습니다','https://images.unsplash.com/photo-1481824429379-07aa5e5b0739?ixlib=rb-1.2.1&auto=format&fit=crop&w=684&q=80','깔끔한 파이썬 탄탄한 백엔드 많이 사랑해주세요','대한민국','',NULL,0,2),(18,'dummy8','1234','dummy8@naver.com','2020-02-09','S2나이키S2','https://images.unsplash.com/photo-1464863979621-258859e62245?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80','장고로 개발을 하고 있습니다.','대한민국','',NULL,0,2),(19,'dummy9','1234','dummy9@naver.com','2020-02-10','T없E맑은나이키 ™','https://images.unsplash.com/photo-1578616070222-50c4de9d5ade?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=712&q=80','리액트로 개발을 하고 있습니다.','대한민국','',NULL,0,2),(20,'dummy10','1234','dummy10@naver.com','2020-02-11','@@나이키구함@@','https://images.unsplash.com/flagged/photo-1576212152884-614580e3d5ac?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80','코로나가 잠잠해졌으면 좋겠습니다.','대한민국','',NULL,0,2),(21,'dummy11','1234','dummy11@naver.com','2020-02-12','나이키는사랑입니다','https://images.unsplash.com/photo-1503342394128-c104d54dba01?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80','스타일 코드팀 짱!!!','대한민국','',NULL,0,2),(22,'dummy12','1234','dummy12@naver.com','2020-02-13','스우시나이키인정','https://images.unsplash.com/photo-1562003389-902303a38425?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1429&q=80','프론트앤드 담당 장호철 엄문주 박현재','대한민국','',NULL,0,2),(23,'dummy13','1234','dummy13@naver.com','2020-02-14','나이키는못참지','https://images.unsplash.com/photo-1591845466147-c6c601063c3a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80','백엔드 담당 정현석 김민구 백승찬','대한민국','',NULL,0,1),(24,'dummy14','1234','dummy14@naver.com','2020-02-15','dummyname14','','','','',NULL,0,1),(25,'dummy15','1234','dummy15@naver.com','2020-02-16','dummyname15','','','','',NULL,0,1),(26,'dummy16','1234','dummy16@naver.com','2020-02-17','dummyname16','','','','',NULL,0,1),(27,'dummy17','1234','dummy17@naver.com','2020-02-18','dummyname17','','','','',NULL,0,1),(28,'dummy18','1234','dummy18@naver.com','2020-02-19','dummyname18','','','','',NULL,0,1),(29,'dummy19','1234','dummy19@naver.com','2020-02-20','dummyname19','','','','',NULL,0,2),(30,'dummy20','1234','dummy20@naver.com','2020-02-21','dummyname20','','','','',NULL,0,2),(31,'dummy21','1234','dummy21@naver.com','2020-02-22','dummyname21','','','','',NULL,0,2),(32,'dummy22','1234','dummy22@naver.com','2020-02-23','dummyname22','','','','',NULL,0,2),(33,'dummy23','1234','dummy23@naver.com','2020-02-24','dummyname23','','','','',NULL,0,2),(34,'dummy24','1234','dummy24@naver.com','2020-02-25','dummyname24','','','','',NULL,0,2),(35,'dummy25','1234','dummy25@naver.com','2020-02-26','dummyname25','','','','',NULL,0,1),(36,'dummy26','1234','dummy26@naver.com','2020-02-27','dummyname26','','','','',NULL,0,1),(37,'dummy27','1234','dummy27@naver.com','2020-02-28','dummyname27','','','','',NULL,0,1),(38,'dummy28','1234','dummy28@naver.com','2020-02-29','dummyname28','','','','',NULL,0,1),(39,'dummy29','1234','dummy29@naver.com','2020-03-01','dummyname29','','','','',NULL,0,1),(40,'dummy30','1234','dummy30@naver.com','2020-03-02','dummyname30','','','','',NULL,0,1),(41,'dummy31','1234','dummy31@naver.com','2020-03-03','dummyname31','','','','',NULL,0,2),(42,'dummy32','1234','dummy32@naver.com','2020-03-04','dummyname32','','','','',NULL,0,2),(43,'dummy33','1234','dummy33@naver.com','2020-03-05','dummyname33','','','','',NULL,0,2),(44,'dummy34','1234','dummy34@naver.com','2020-03-06','dummyname34','','','','',NULL,0,2),(45,'dummy35','1234','dummy35@naver.com','2020-03-07','dummyname35','','','','',NULL,0,2),(46,'dummy36','1234','dummy36@naver.com','2020-03-08','dummyname36','','','','',NULL,0,2),(47,'dummy37','1234','dummy37@naver.com','2020-03-09','dummyname37','','','','',NULL,0,1),(48,'dummy38','1234','dummy38@naver.com','2020-03-10','dummyname38','','','','',NULL,0,1),(49,'dummy39','1234','dummy39@naver.com','2020-03-11','dummyname39','','','','',NULL,0,1),(50,'dummy40','1234','dummy40@naver.com','2020-03-12','dummyname40','','','','',NULL,0,1),(51,'dummy41','1234','dummy41@naver.com','2020-03-13','dummyname41','','','','',NULL,0,1),(52,'dummy42','1234','dummy42@naver.com','2020-03-14','dummyname42','','','','',NULL,0,1),(53,'dummy43','1234','dummy43@naver.com','2020-03-15','dummyname43','','','','',NULL,0,2),(54,'dummy44','1234','dummy44@naver.com','2020-03-16','dummyname44','','','','',NULL,0,2),(55,'dummy45','1234','dummy45@naver.com','2020-03-17','dummyname45','','','','',NULL,0,2),(56,'dummy46','1234','dummy46@naver.com','2020-03-18','dummyname46','','','','',NULL,0,2),(57,'dummy47','1234','dummy47@naver.com','2020-03-19','dummyname47','','','','',NULL,0,2),(58,'dummy48','1234','dummy48@naver.com','2020-03-20','dummyname48','','','','',NULL,0,2),(59,'dummy49','1234','dummy49@naver.com','2020-03-21','dummyname49','','','','',NULL,0,1),(60,'dummy50','1234','dummy50@naver.com','2020-03-22','dummyname50','','','','',NULL,0,1),(61,'dummy51','1234','dummy51@naver.com','2020-03-23','dummyname51','','','','',NULL,0,1),(62,'dummy52','1234','dummy52@naver.com','2020-03-24','dummyname52','','','','',NULL,0,1),(63,'dummy53','1234','dummy53@naver.com','2020-03-25','dummyname53','','','','',NULL,0,1),(64,'dummy54','1234','dummy54@naver.com','2020-03-26','dummyname54','','','','',NULL,0,1),(65,'dummy55','1234','dummy55@naver.com','2020-03-27','dummyname55','','','','',NULL,0,2),(66,'dummy56','1234','dummy56@naver.com','2020-03-28','dummyname56','','','','',NULL,0,2),(67,'dummy57','1234','dummy57@naver.com','2020-03-29','dummyname57','','','','',NULL,0,2),(68,'dummy58','1234','dummy58@naver.com','2020-03-30','dummyname58','','','','',NULL,0,2),(69,'dummy59','1234','dummy59@naver.com','2020-03-31','dummyname59','','','','',NULL,0,2),(70,'dummy60','1234','dummy60@naver.com','2020-04-01','dummyname60','','','','',NULL,0,2),(71,'dummy61','1234','dummy61@naver.com','2020-04-02','dummyname61','','','','',NULL,0,1),(72,'dummy62','1234','dummy62@naver.com','2020-04-03','dummyname62','','','','',NULL,0,1),(73,'dummy63','1234','dummy63@naver.com','2020-04-04','dummyname63','','','','',NULL,0,1),(74,'dummy64','1234','dummy64@naver.com','2020-04-05','dummyname64','','','','',NULL,0,1),(75,'dummy65','1234','dummy65@naver.com','2020-04-06','dummyname65','','','','',NULL,0,1),(76,'dummy66','1234','dummy66@naver.com','2020-04-07','dummyname66','','','','',NULL,0,1),(77,'dummy67','1234','dummy67@naver.com','2020-04-08','dummyname67','','','','',NULL,0,2),(78,'dummy68','1234','dummy68@naver.com','2020-04-09','dummyname68','','','','',NULL,0,2),(79,'dummy69','1234','dummy69@naver.com','2020-04-10','dummyname69','','','','',NULL,0,2),(80,'dummy70','1234','dummy70@naver.com','2020-04-11','dummyname70','','','','',NULL,0,2),(81,'dummy71','1234','dummy71@naver.com','2020-04-12','dummyname71','','','','',NULL,0,2),(82,'dummy72','1234','dummy72@naver.com','2020-04-13','dummyname72','','','','',NULL,0,2),(83,'dummy73','1234','dummy73@naver.com','2020-04-14','dummyname73','','','','',NULL,0,1),(84,'dummy74','1234','dummy74@naver.com','2020-04-15','dummyname74','','','','',NULL,0,1),(85,'dummy75','1234','dummy75@naver.com','2020-04-16','dummyname75','','','','',NULL,0,1),(86,'dummy76','1234','dummy76@naver.com','2020-04-17','dummyname76','','','','',NULL,0,1),(87,'dummy77','1234','dummy77@naver.com','2020-04-18','dummyname77','','','','',NULL,0,1),(88,'dummy78','1234','dummy78@naver.com','2020-04-19','dummyname78','','','','',NULL,0,1),(89,'dummy79','1234','dummy79@naver.com','2020-04-20','dummyname79','','','','',NULL,0,2),(90,'dummy80','1234','dummy80@naver.com','2020-04-21','dummyname80','','','','',NULL,0,2),(91,'dummy81','1234','dummy81@naver.com','2020-04-22','dummyname81','','','','',NULL,0,2),(92,'dummy82','1234','dummy82@naver.com','2020-04-23','dummyname82','','','','',NULL,0,2),(93,'dummy83','1234','dummy83@naver.com','2020-04-24','dummyname83','','','','',NULL,0,2),(94,'dummy84','1234','dummy84@naver.com','2020-04-25','dummyname84','','','','',NULL,0,2),(95,'dummy85','1234','dummy85@naver.com','2020-04-26','dummyname85','','','','',NULL,0,1),(96,'dummy86','1234','dummy86@naver.com','2020-04-27','dummyname86','','','','',NULL,0,1),(97,'dummy87','1234','dummy87@naver.com','2020-04-28','dummyname87','','','','',NULL,0,1),(98,'dummy88','1234','dummy88@naver.com','2020-04-29','dummyname88','','','','',NULL,0,1),(99,'dummy89','1234','dummy89@naver.com','2020-04-30','dummyname89','','','','',NULL,0,1),(100,'dummy90','1234','dummy90@naver.com','2020-05-01','dummyname90','','','','',NULL,0,1),(101,'dummy91','1234','dummy91@naver.com','2020-05-02','dummyname91','','','','',NULL,0,2),(102,'dummy92','1234','dummy92@naver.com','2020-05-03','dummyname92','','','','',NULL,0,2),(103,'dummy93','1234','dummy93@naver.com','2020-05-04','dummyname93','','','','',NULL,0,2),(104,'dummy94','1234','dummy94@naver.com','2020-05-05','dummyname94','','','','',NULL,0,2),(105,'dummy95','1234','dummy95@naver.com','2020-05-06','dummyname95','','','','',NULL,0,2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_coupons`
--

DROP TABLE IF EXISTS `users_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupon_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_coupons_coupon_id_9a384134_fk_coupons_id` (`coupon_id`),
  KEY `users_coupons_user_id_aa80d15d_fk_users_id` (`user_id`),
  CONSTRAINT `users_coupons_coupon_id_9a384134_fk_coupons_id` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
  CONSTRAINT `users_coupons_user_id_aa80d15d_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_coupons`
--

LOCK TABLES `users_coupons` WRITE;
/*!40000 ALTER TABLE `users_coupons` DISABLE KEYS */;
INSERT INTO `users_coupons` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,1,2),(6,1,3),(7,1,4),(8,1,5),(9,1,6);
/*!40000 ALTER TABLE `users_coupons` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-27 11:37:29

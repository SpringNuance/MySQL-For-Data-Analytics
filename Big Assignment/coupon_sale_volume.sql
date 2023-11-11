-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.16 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5629
-- ---------------------------------------information_schemacoupon_sale_volume-----------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table teaching.coupon_sale_volume
CREATE TABLE IF NOT EXISTS `coupon_sale_volume` (
  `Coupon_ID` char(50) DEFAULT NULL,
  `Sale_date` date DEFAULT NULL,
  `Total_sale_volume` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table teaching.coupon_sale_volume: ~0 rows (approximately)
/*!40000 ALTER TABLE `coupon_sale_volume` DISABLE KEYS */;
INSERT INTO `coupon_sale_volume` (`Coupon_ID`, `Sale_date`, `Total_sale_volume`) VALUES
	('CouponA', '2021-09-03', 0),
	('CouponA', '2021-09-04', 12),
	('CouponA', '2021-09-05', 37),
	('CouponA', '2021-09-06', 40),
	('CouponB', '2021-08-14', 43),
	('CouponB', '2021-08-15', 75),
	('CouponB', '2021-08-13', 20),
	('CouponC', '2021-09-04', 16),
	('CouponC', '2021-09-05', 38),
	('CouponC', '2021-09-06', 77),
	('CouponC', '2021-09-07', 97),
	('CouponC', '2021-09-03', 2);
/*!40000 ALTER TABLE `coupon_sale_volume` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 26, 2025 at 01:45 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wellnessbridge_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `birth_properties`
--

CREATE TABLE `birth_properties` (
  `bID` bigint(20) UNSIGNED NOT NULL,
  `childID` bigint(20) UNSIGNED NOT NULL,
  `motherAge` int(11) NOT NULL,
  `fatherAge` int(11) NOT NULL,
  `numberOfChildren` int(11) NOT NULL,
  `birthType` varchar(255) NOT NULL,
  `birthWeight` double NOT NULL,
  `childCondition` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `birth_properties`
--

INSERT INTO `birth_properties` (`bID`, `childID`, `motherAge`, `fatherAge`, `numberOfChildren`, `birthType`, `birthWeight`, `childCondition`, `created_at`, `updated_at`) VALUES
(1, 51, 29, 52, 1, 'C-Section', 4.28, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(2, 52, 32, 28, 9, 'Natural', 3.87, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(3, 53, 21, 50, 2, 'Natural', 3.88, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(4, 54, 33, 28, 7, 'Natural', 2.98, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(5, 55, 33, 48, 1, 'Natural', 2.92, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(6, 56, 28, 28, 3, 'Natural', 3.69, 'Premature', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(7, 57, 38, 54, 3, 'Natural', 3.78, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(8, 58, 28, 54, 2, 'C-Section', 3.65, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(9, 59, 21, 53, 3, 'Natural', 2.86, 'Premature', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(10, 60, 29, 52, 9, 'Natural', 3.7, 'Premature', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(11, 61, 40, 31, 10, 'Natural', 3.3, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(12, 62, 28, 25, 2, 'Natural', 3.79, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(13, 63, 31, 44, 4, 'Natural', 3.57, 'Premature', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(14, 64, 41, 41, 9, 'Natural', 3.93, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(15, 65, 45, 47, 4, 'Natural', 3.13, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(16, 66, 29, 27, 5, 'C-Section', 3.81, 'Premature', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(17, 67, 21, 43, 3, 'Natural', 4.08, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(18, 68, 23, 40, 3, 'C-Section', 3.92, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(19, 69, 35, 59, 8, 'C-Section', 2.75, 'Premature', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(20, 70, 34, 23, 10, 'C-Section', 2.9, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(21, 71, 27, 40, 2, 'Natural', 4.46, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(22, 72, 20, 35, 8, 'Natural', 3.3, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(23, 73, 26, 18, 1, 'C-Section', 2.59, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(24, 74, 35, 51, 7, 'C-Section', 3.87, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(25, 75, 36, 39, 10, 'Natural', 4.43, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(26, 76, 20, 35, 5, 'C-Section', 4.15, 'Healthy', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(27, 77, 36, 35, 10, 'C-Section', 3.97, 'Premature', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(28, 78, 21, 28, 3, 'C-Section', 2.64, 'Underweight', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(30, 80, 24, 33, 7, 'Natural', 3.54, 'Premature', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(31, 5, 32, 34, 3, 'C-section', 3.5, 'Premature', '2025-05-04 10:34:16', '2025-05-04 10:35:34');

-- --------------------------------------------------------

--
-- Table structure for table `cadres`
--

CREATE TABLE `cadres` (
  `cadID` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `qualification` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cadres`
--

INSERT INTO `cadres` (`cadID`, `name`, `description`, `qualification`, `created_at`, `updated_at`) VALUES
(1, 'Malaria', 'This is the rooom for malaraia', 'A3', '2025-05-02 13:48:41', '2025-05-03 10:49:23'),
(2, 'voluptatum', 'Commodi sit ipsum necessitatibus consequuntur quia. Minus assumenda id architecto aut necessitatibus. Suscipit natus laboriosam eum ullam nihil rem.', 'facere', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(3, 'iure', 'Quo voluptates explicabo harum. Possimus voluptatem repellat nihil odit dolorem dolorem dolorem. Adipisci repudiandae voluptatibus deleniti beatae dolorem optio. Voluptatem fugiat iure quia omnis.', 'iure', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(4, 'dicta', 'Aperiam eveniet quia ab blanditiis. Rerum ab quam eos sit labore. Excepturi assumenda illum itaque eum adipisci.', 'soluta', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(5, 'rerum', 'Eligendi maiores vel dolor sit ullam sunt veritatis. Quidem esse ut ad fugiat sapiente eum eaque. Sapiente nesciunt nemo et aliquam recusandae accusamus nesciunt.', 'modi', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(6, 'corporis', 'Ducimus quibusdam ipsam officiis voluptates mollitia officiis officia facere. Rerum maiores reiciendis sunt enim aliquid quisquam. Quidem ab aut id dolorum aperiam et modi.', 'dolor', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(7, 'eum', 'Itaque eligendi minima voluptatem assumenda quas tenetur sunt. Tempore ut autem est autem rerum id ullam consequatur. Magnam consectetur debitis nam vitae sed laudantium accusantium placeat. Perferendis est sed aut unde quo ut.', 'libero', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(8, 'dicta', 'Perspiciatis velit aut sit magni aut voluptatibus. Consectetur dolorum itaque tenetur sequi in et deleniti est. Id iure rem quo voluptatem. Rem ut officia rem veniam fuga veniam.', 'dolores', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(9, 'itaque', 'Iusto sint et architecto ex. Repudiandae nostrum dolorem facilis ullam quasi a ut. Laudantium quam a a alias mollitia.', 'officiis', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(10, 'et', 'Possimus veniam delectus explicabo dolor. Accusantium et distinctio qui ab dolores necessitatibus nesciunt magnam.', 'ratione', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(11, 'nisi', 'Quisquam alias qui impedit ab illo enim. Dolor quam quae dolore qui minima est velit. Et ea sequi enim aut.', 'itaque', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(12, 'ut', 'Soluta id et voluptas ducimus ut rerum sunt. Ut ut deleniti aut repellat totam. Magnam sequi et illum voluptatum asperiores.', 'aspernatur', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(13, 'enim', 'Alias distinctio nam vel est sunt sed accusamus. Fugiat quos et velit laborum molestiae commodi voluptatem voluptatem. Ipsa harum architecto numquam sit sint fugit aliquam possimus. Id ipsum repudiandae qui.', 'et', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(14, 'fuga', 'Dolor ut sit beatae beatae fugit numquam fugit. Occaecati nam aut non et. Nam placeat libero corrupti. Sunt saepe beatae qui officia quasi quod dolor.', 'vel', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(15, 'sed', 'Tempore consequatur amet deserunt vero accusamus incidunt. Est sint est odit. Debitis voluptates iure illo. Ea dignissimos et aut necessitatibus. Rerum repellendus omnis sunt et similique inventore nihil.', 'ut', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(16, 'facere', 'Fuga dolores facilis qui eaque optio sit nam. Voluptatum sapiente quasi ipsam necessitatibus. Suscipit qui aut asperiores enim. Placeat et dolores eum. Ratione architecto dolorum aut et.', 'quis', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(17, 'asperiores', 'Aut qui iure nesciunt deleniti inventore ullam. Enim natus dolor voluptate quibusdam ut explicabo tenetur. Sit ea molestiae atque ipsam architecto. Ut quam non perferendis eveniet placeat et aperiam itaque.', 'incidunt', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(18, 'dolor', 'Consequuntur illo veritatis dolores non atque eius rerum nobis. Et qui dicta in pariatur nemo dolor. Rerum voluptatum autem dolores voluptas omnis.', 'nam', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(19, 'quisquam', 'Recusandae sit dignissimos ea cumque reprehenderit. Rerum pariatur ut sunt numquam eos magni. Distinctio adipisci non omnis nostrum. Quis itaque est placeat omnis et consequuntur.', 'autem', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(20, 'nihil', 'Sint vel voluptas nisi voluptas ipsam tenetur. Repudiandae minus cum repellendus delectus omnis ea animi voluptatem. Eaque similique molestiae molestias consequatur a. Odio consequuntur fugiat laudantium fuga excepturi.', 'voluptatem', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(21, 'nobis', 'Ab cumque accusantium harum architecto assumenda incidunt. Est doloremque quod ut et quos non fuga. Magnam inventore architecto ipsam laudantium dicta qui pariatur.', 'accusantium', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(22, 'ullam', 'Laborum eum expedita repellendus minus enim. Repellendus quaerat iure odit. Sed ea vero itaque rem. A rem libero dolorem.', 'itaque', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(23, 'ullam', 'Dicta sint iste reiciendis non soluta expedita. Eum ut est ad perferendis eveniet dolore.', 'ab', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(24, 'non', 'Facilis perspiciatis vero omnis sint ad. Ea sint fugiat alias qui. Qui ut consequatur excepturi. Quia repellat et fugiat ut reiciendis.', 'non', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(25, 'dolorem', 'In molestias voluptatum omnis excepturi fugiat unde modi. Repellendus dolor maiores velit ipsam magni. Blanditiis doloribus ex nostrum suscipit.', 'esse', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(26, 'natus', 'Repudiandae sequi atque aut. Aut vitae illo et minima. Voluptas sed magnam rerum est vel. Ea odit aspernatur aut explicabo quo.', 'inventore', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(27, 'autem', 'Qui unde aut impedit libero. Vel autem commodi et id mollitia atque deleniti in. Sit dolores totam mollitia odit non voluptatem voluptatibus. Sunt architecto molestiae at.', 'inventore', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(28, 'voluptatem', 'Et laborum blanditiis in enim possimus. Saepe voluptatum officiis quae alias eius illo. Unde asperiores ducimus ipsum. Eos quia aut cumque.', 'et', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(29, 'voluptatum', 'Voluptates error magnam consequatur sint eos rem. Ab omnis id culpa aut qui iste. Fugit et nihil sit voluptas.', 'unde', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(30, 'velit', 'Sequi assumenda consequatur non harum quibusdam esse corrupti. Explicabo reprehenderit dolorem omnis iste possimus cupiditate inventore iure. Sint enim nemo ab natus neque corrupti hic. Ipsum ipsum voluptas aut nesciunt est.', 'voluptates', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(31, 'excepturi', 'Dignissimos veritatis et quam culpa pariatur quia. Sit quisquam eius perferendis fugiat adipisci. Provident nulla voluptas ipsam unde consequatur facere soluta dolores.', 'voluptatibus', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(32, 'consequatur', 'Officiis enim fugit et corporis nihil omnis qui. Labore ut voluptates sed in eligendi ut aut et. Doloremque quis velit eum esse tempora tempore.', 'consequatur', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(33, 'consequatur', 'Et commodi eveniet asperiores ut non ut accusantium. Molestiae ab saepe et. Minima similique et est et et consequatur. A nihil officiis cupiditate dolor provident maiores accusamus.', 'tempora', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(34, 'saepe', 'Repellat iusto ipsam totam numquam ut nam ut. Non sit illo omnis tempore voluptas exercitationem sed qui. Illo asperiores hic nobis.', 'in', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(35, 'nisi', 'Ut enim nihil doloremque expedita. Sed aut sint officiis vitae nesciunt. Inventore aspernatur culpa non totam nihil beatae debitis.', 'architecto', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(36, 'animi', 'Et ullam fugit ab quia quo sint animi nihil. Debitis saepe porro illum. Assumenda accusantium illum voluptas sit libero voluptate accusamus qui. Nulla debitis quis aut rem. Perferendis veniam debitis explicabo quo reprehenderit aut deleniti.', 'enim', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(37, 'deleniti', 'Corrupti animi architecto exercitationem rerum. Eum adipisci id ea libero fugit possimus enim quidem. Dolorem nisi sed mollitia harum corporis sit. Magni eaque assumenda ut dicta magni accusantium. Et deserunt expedita est corrupti omnis.', 'inventore', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(38, 'nostrum', 'Alias sint qui autem repellat enim et. Blanditiis impedit sed mollitia similique.', 'possimus', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(39, 'aut', 'Nostrum eum aut velit eius quam. Qui nulla porro occaecati saepe consectetur. Reprehenderit quia ea aut neque placeat. Ab quibusdam ex qui earum. Quae asperiores quidem ea ut aut aut sint.', 'mollitia', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(40, 'voluptas', 'Quos reprehenderit cum voluptas doloribus nobis ut. Rerum ipsa quod est beatae in. Reiciendis sed distinctio repellendus voluptatem ut consequatur. Aliquid voluptatem rerum deserunt quis.', 'et', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(41, 'reiciendis', 'Quis eum expedita nam quidem similique. Doloribus veniam sint dolor ut sint quibusdam. At architecto omnis sit sunt. Laudantium tenetur et non molestias similique asperiores qui.', 'id', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(42, 'harum', 'Doloremque vitae et dolor fuga qui quisquam. Et animi sunt sunt quibusdam dolorem esse ab. Sit nisi aut nisi quia hic modi in. A repellat perspiciatis et aspernatur error omnis nostrum.', 'voluptate', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(43, 'dolores', 'Autem ex dolor aut. Doloremque quia quis soluta quis non et vitae voluptas. Maxime officiis asperiores sapiente quae soluta explicabo. Reprehenderit facere fugit fuga reiciendis eveniet.', 'rem', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(44, 'repudiandae', 'Repellendus ullam corrupti itaque quia ab dolorem esse. Perspiciatis et non libero esse.', 'nesciunt', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(45, 'excepturi', 'Accusantium optio quia velit expedita nostrum harum porro. Eligendi provident est maxime nobis aliquid aut. Est error quisquam omnis dolor quia et placeat quis.', 'quis', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(46, 'id', 'Ab dolorem quibusdam dolor. Autem et esse voluptatum aut deleniti ut temporibus fugit. Odit quaerat qui qui molestiae incidunt id architecto.', 'dolorem', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(47, 'eum', 'Corrupti eos est voluptatum doloribus et qui laudantium. Est officiis dignissimos cumque et praesentium qui beatae. Aut ab molestiae voluptate quas ea qui. Accusamus omnis eum ea.', 'laudantium', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(48, 'molestiae', 'Est consectetur inventore eos ex assumenda. Et autem voluptas atque enim nemo debitis. Deleniti sint sapiente eos qui expedita. Commodi et aut alias consequatur illo hic voluptas porro.', 'perferendis', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(49, 'saepe', 'Fugiat ut cumque voluptatem sunt sit vel blanditiis ut. Inventore dolores error numquam facere. In vel quo ducimus et nam.', 'exercitationem', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(50, 'vero', 'Autem magnam sed deleniti quia. Aut doloribus quia consequatur incidunt molestiae. Magni ab optio omnis velit est ipsa aspernatur. Dolores commodi eum id. Est ea ea veniam quisquam alias ea.', 'illum', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(51, 'doloribus', 'Nam et eum aut et ut saepe at omnis. Aliquid sed laboriosam numquam vel corporis quaerat hic. Consequatur voluptatem vel accusamus sunt a et. Animi aut est nam omnis repellendus nesciunt.', 'blanditiis', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(52, 'praesentium', 'Quas a temporibus delectus consequatur. Qui nostrum cumque voluptatum sit dolorem. Ea sed ut et ratione ipsa minus quo. Esse sed vel et aut rerum corrupti et.', 'sint', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(53, 'dolores', 'Ut dicta non quidem eveniet. Optio consequatur iure amet ut et velit consectetur. Ut ex saepe rerum nesciunt. Perspiciatis numquam modi tempore amet illo.', 'ut', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(54, 'et', 'Suscipit dolorum magnam porro inventore. Quis autem deserunt reiciendis possimus consequatur dolor. Mollitia porro recusandae similique voluptatibus sed odio.', 'excepturi', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(55, 'eos', 'Et est consequuntur repellat qui alias. Eos quia voluptas recusandae sit similique magnam velit. Distinctio maiores repudiandae officia omnis voluptas aut.', 'sunt', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(56, 'commodi', 'Quia quae necessitatibus omnis aut nihil. Est non est quo impedit. In voluptatem ea eos repellendus sit est voluptas.', 'itaque', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(57, 'veritatis', 'Libero nulla aperiam architecto ullam illum. Rerum ea eius voluptates ea sit nulla. Laborum officia iusto tempora quos.', 'veritatis', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(58, 'et', 'Vel et ut sit quasi accusantium sunt. Illum molestiae nulla aut architecto. Odio ut molestiae cupiditate animi aut quod. Ex optio numquam quibusdam.', 'dolores', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(59, 'nulla', 'Esse corrupti aut rem amet veniam rem molestiae voluptate. Amet quos perferendis quidem laboriosam est. Molestiae minima et porro quia nesciunt.', 'ad', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(60, 'itaque', 'Numquam in autem nulla sequi est eos. Nulla laudantium adipisci est explicabo suscipit suscipit. Incidunt recusandae ipsam rem sit. Temporibus cum ut culpa et voluptatem.', 'ab', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(61, 'veritatis', 'Ipsum magni omnis tempore praesentium. Qui ea consequuntur aperiam aspernatur consequatur. Rem deleniti placeat blanditiis error. Quis sed sequi ut ipsam quos eum consequatur.', 'quisquam', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(62, 'ab', 'Ratione labore et esse et est. Unde quis rerum ut in voluptate et. Qui vel saepe nobis minima quia accusantium voluptas. Possimus quo dolor quaerat itaque at labore debitis.', 'voluptatem', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(63, 'voluptatem', 'Nostrum voluptatem molestias sit id eveniet velit delectus. Adipisci dolores fugit vero alias animi. Natus ullam quae doloribus quaerat natus molestiae et dolorum.', 'omnis', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(64, 'saepe', 'Aut eligendi suscipit quidem cupiditate. Quia consequatur cupiditate provident ut et ut qui. Ipsa eligendi in pariatur et accusamus et. Et aliquam aut incidunt facere ut modi.', 'error', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(65, 'ut', 'Temporibus incidunt quis natus exercitationem labore voluptatem ad. Soluta aspernatur vel ut fugit ut voluptatem esse molestiae. Labore sunt quia est et officia. Cumque at ducimus reiciendis aperiam magnam dolores rerum.', 'veritatis', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(66, 'quis', 'Veritatis nostrum deleniti sunt at suscipit. Sequi et qui velit aliquam. Ut voluptas alias ratione deleniti molestiae.', 'reprehenderit', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(67, 'aut', 'Sed quia dolor dolorem error. Dicta sunt illum sed. Quidem odit qui eos consectetur.', 'expedita', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(68, 'id', 'Facere aut et nemo cumque fuga. Sit quo maiores veniam dolore ad quia possimus. Enim dignissimos ratione pariatur esse.', 'non', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(69, 'cum', 'Consequuntur eum soluta dignissimos rem autem ut. Error vero autem unde at odit assumenda.', 'voluptatem', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(70, 'tempora', 'Eos nesciunt sit neque minima perspiciatis aspernatur. Natus est enim corrupti necessitatibus. Quasi dolores molestiae dolores ad accusamus. Odit velit enim vero consectetur.', 'doloribus', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(71, 'aut', 'Non officia soluta ipsum nesciunt. Illo voluptate qui voluptatem dolores. Quia fugit beatae sed debitis. Voluptatem molestiae tempore architecto veniam voluptatibus.', 'ullam', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(72, 'et', 'Soluta hic quia atque quis et. Debitis ut enim beatae officiis quis. Voluptate minima eius earum quo facere vitae mollitia odio. Mollitia deleniti autem distinctio voluptatem id est consequatur.', 'fugit', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(73, 'nemo', 'Suscipit nemo tempore cum voluptate. Expedita excepturi reprehenderit perspiciatis deserunt tempora iure. Et dolorem non natus blanditiis explicabo. In ut accusamus voluptatem incidunt temporibus.', 'ut', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(74, 'blanditiis', 'Ipsa et quia voluptatibus quas vel non. Molestiae hic ullam asperiores ut animi explicabo qui enim. Et ratione vitae id neque sint. Dolores libero ea et itaque voluptatem. Illum ipsa dolor laboriosam.', 'maiores', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(75, 'consectetur', 'Ab ea aut vitae. Quibusdam ut eum qui nam.', 'id', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(76, 'est', 'Placeat eveniet nemo eveniet ut aperiam. Sed excepturi et ea quisquam minima veniam. Assumenda rerum cumque sint rerum earum. Inventore fugiat nisi quas amet.', 'nemo', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(77, 'ratione', 'Minus eius aut libero. Labore fuga neque temporibus rem est. Perspiciatis pariatur animi ipsa dolorem.', 'et', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(78, 'debitis', 'Totam iusto possimus voluptas. Similique et quam voluptas vitae fuga ipsa optio. Voluptas ut ea ullam fugiat aut rerum.', 'asperiores', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(79, 'aut', 'Facilis labore architecto debitis assumenda reiciendis architecto. Quia beatae expedita provident corporis. Consequuntur placeat ea velit praesentium. Ipsa fuga soluta eum eligendi.', 'et', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(80, 'qui', 'Aut minima non illum delectus pariatur aspernatur inventore. Aut veniam voluptatem dolorum rerum et. Omnis in culpa et non impedit. Iusto sint beatae impedit quia aliquid.', 'aut', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(81, 'occaecati', 'Consequatur molestiae consequatur sunt et aliquam est ut. Sapiente numquam nostrum iusto consequatur quae voluptatem ut.', 'tempora', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(82, 'ducimus', 'Harum est sed corrupti voluptas dolores. Ad quod accusamus fugiat hic provident facere fuga. Earum sed ullam voluptatem quo similique sed.', 'ducimus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(83, 'qui', 'Nobis saepe quasi doloremque eaque. Sed rem unde officia debitis itaque sint. Natus natus voluptates repellat quia. Fuga tempora voluptas exercitationem in. Voluptatem explicabo voluptatum blanditiis quos.', 'ex', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(84, 'aut', 'Quis placeat maiores doloremque dolorem voluptas. Molestiae eligendi error voluptas itaque. Occaecati odio facilis voluptate quod et tempore.', 'delectus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(85, 'dolorum', 'Laboriosam quasi est totam est qui laborum. Dolores temporibus id alias ipsa. Aut incidunt veritatis dolor dolores officia.', 'animi', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(86, 'tempore', 'Itaque rerum odio architecto alias. Enim nostrum vel ut esse assumenda dicta quia. Nobis consequatur impedit sed vero.', 'est', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(87, 'perferendis', 'Quas est aperiam autem illo iure. Molestiae consequatur dolor culpa soluta. Nemo incidunt molestiae amet esse laborum soluta quia.', 'occaecati', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(88, 'et', 'Aut iure fuga unde aut dolore cum dolorem expedita. In rerum quae minima adipisci. Hic qui magnam qui numquam et quos. Eius voluptas quia occaecati debitis magni.', 'ea', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(89, 'in', 'Porro nisi non esse. Numquam occaecati qui ut necessitatibus. Esse quae eos saepe facilis vel esse autem. Iste consequatur error impedit iste.', 'voluptatem', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(90, 'cupiditate', 'Illo voluptas et iure quae occaecati quam. Hic dicta soluta animi alias illum ipsum. Iusto autem assumenda recusandae aut dignissimos quia maiores. Blanditiis voluptatem enim dignissimos minima ullam suscipit ex. Sed sint quis et dolorum hic assumenda.', 'repellendus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(91, 'et', 'Debitis aliquid unde minima ea enim nostrum officiis. Atque dolor autem cumque molestias molestiae quo. Fuga odio quibusdam incidunt ipsa occaecati. Quo odit aut et fugit.', 'soluta', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(92, 'ut', 'Et vel ratione numquam quia tempora culpa qui. Odio dolores quo et voluptatum vero dolores. Deserunt consequatur qui vel consequuntur sunt ut. Aut sint inventore tempore omnis dolores quia dicta et.', 'expedita', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(93, 'itaque', 'Asperiores quam provident blanditiis totam temporibus. Accusantium amet qui doloremque debitis suscipit et non. Ullam voluptatibus quod veniam non rerum temporibus. Fuga est quisquam non nihil saepe dignissimos explicabo.', 'libero', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(94, 'odit', 'Consequatur qui sint excepturi. Vel et dolores ullam optio cumque nemo voluptatem nesciunt. Nulla ab labore hic.', 'dolorum', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(95, 'aut', 'Minima aut rem sequi in non quos. Quia hic qui nostrum temporibus repudiandae sapiente quo. Exercitationem dicta culpa vero odit.', 'odit', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(96, 'vitae', 'Ipsum similique maiores cum accusamus nobis. Esse et cumque ratione quia. Odio sapiente quod adipisci.', 'voluptas', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(97, 'praesentium', 'Libero consequuntur facere nesciunt odio omnis quia eum. Assumenda doloremque facilis facilis eum et omnis. Id id dolores delectus rerum aut dolor.', 'necessitatibus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(98, 'neque', 'A voluptatem nihil veniam eos sapiente porro. Vero et dolor omnis assumenda et nisi esse. Maiores libero assumenda non eius. Non modi ipsam ipsa ducimus. Culpa dolorem aspernatur exercitationem porro autem saepe.', 'perspiciatis', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(99, 'consequuntur', 'Minus omnis exercitationem sit magni exercitationem sit amet. Ullam quidem est et eius veniam. Dolor qui adipisci eveniet temporibus.', 'ducimus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(100, 'nesciunt', 'In cupiditate reprehenderit consequatur eveniet id fuga nisi est. Maiores eum quidem incidunt. Et voluptatum aut molestias vel qui ullam numquam. Omnis nesciunt repellat aperiam mollitia tempore quibusdam sunt iste.', 'sit', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(101, 'nisi', 'Vel omnis rerum soluta quo. Consequatur dolores autem voluptatem incidunt harum aliquid.', 'rerum', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(102, 'voluptatem', 'Ad velit dolorem autem at excepturi rerum quo. Dolore nesciunt expedita aliquam cum quo tenetur cumque delectus. Sequi nihil ut ut nihil nihil et. Aperiam necessitatibus mollitia delectus iste modi.', 'aut', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(103, 'facere', 'Perferendis fuga est expedita omnis nemo inventore. Dignissimos necessitatibus consequatur cum rem consequuntur possimus. Corporis aut laborum eius et.', 'iste', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(104, 'doloribus', 'Quibusdam asperiores commodi dolor animi facilis. Quibusdam ex nostrum eum eius et. Hic animi impedit in voluptatem assumenda nisi modi commodi.', 'consequatur', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(105, 'commodi', 'Sequi incidunt perferendis aut. Excepturi nihil quia possimus optio sit assumenda. Atque autem officiis nihil eveniet quia. Sed qui alias at asperiores velit. Animi delectus possimus est hic consequatur temporibus enim.', 'maxime', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(106, 'esse', 'Illum vel perspiciatis esse praesentium commodi rerum. Ratione adipisci et sequi et vel maxime. Ut molestiae voluptatem beatae occaecati. Ad dicta itaque quaerat perferendis animi.', 'qui', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(107, 'sapiente', 'Aut voluptas et minus facilis. Assumenda aut doloremque qui placeat. Neque itaque neque nostrum aperiam iste non.', 'ad', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(108, 'eum', 'Porro ut et numquam corrupti a adipisci sunt. Ex quo voluptatibus voluptas fugit et voluptatem voluptatem qui. Numquam non iure error facere illo.', 'delectus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(109, 'qui', 'Sapiente qui qui rerum qui occaecati earum. Qui est ut et qui amet porro. Aut adipisci ut est repellendus et. Animi in rerum quia voluptatum dolor porro.', 'amet', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(110, 'enim', 'Veniam sunt consectetur quos quidem et accusamus dolores quidem. Doloremque consequatur qui perferendis ipsum. Omnis tenetur vero dolor officiis sapiente nisi exercitationem.', 'error', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(111, 'delectus', 'Aut praesentium ut quisquam quisquam dolores. Sed doloremque rerum ut et. Iure rerum fugiat sunt non quo eos et.', 'qui', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(112, 'qui', 'Nihil ducimus quibusdam qui. Tempore ut autem occaecati doloremque. Fugit nemo praesentium perspiciatis autem. Dolores eos quam repudiandae et. Ducimus aut fugiat et odio qui inventore.', 'delectus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(113, 'reprehenderit', 'Sequi et ut fuga. Et quos a nisi modi cupiditate et quibusdam. Minima aliquam ipsum odit.', 'porro', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(114, 'at', 'Aut est dignissimos unde molestiae adipisci. Quaerat distinctio exercitationem aut quis praesentium est. Inventore sit id iste et natus soluta iure.', 'veniam', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(115, 'possimus', 'Enim quia et dolorem nam eaque amet. Dolore veniam labore maiores esse accusantium ab. Laudantium et ratione laboriosam.', 'corporis', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(116, 'sit', 'Voluptatem voluptatem officiis incidunt architecto adipisci. Mollitia voluptates et sequi minima. Quia tenetur sequi rem et. Natus fuga commodi impedit vel dolorem. Provident numquam amet ratione delectus.', 'repudiandae', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(117, 'aliquid', 'Doloremque at quidem et. Qui et neque voluptate tempore. Minima quia culpa est error.', 'voluptas', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(118, 'voluptas', 'Neque necessitatibus autem ut eum ea unde at assumenda. Et et vitae illo accusantium qui qui. Deleniti maiores quisquam ut corporis.', 'error', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(119, 'fugiat', 'Velit et qui delectus. Repudiandae dicta fugiat animi mollitia. Sunt optio ut a amet voluptatem. Magnam tempora quasi unde velit eum doloremque est.', 'est', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(120, 'ad', 'Autem at totam sint molestiae nulla doloribus libero. Voluptas rerum cumque animi in id.', 'dolor', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(121, 'ullam', 'Doloremque vel esse cumque quidem at et. Quasi aperiam nemo consequatur qui iusto beatae eum. Rem debitis enim quasi sapiente impedit aliquid consequatur. Fuga quasi cum laudantium perspiciatis doloribus.', 'est', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(122, 'omnis', 'Minima delectus repellendus et similique dolore ea fugiat. Distinctio molestiae dolorem pariatur. Ut id omnis facere sunt maiores deserunt esse numquam. Voluptatem qui excepturi omnis et. Velit minima non sint eius eaque voluptate.', 'ratione', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(123, 'earum', 'Modi voluptates cupiditate quia ullam fugiat consequatur. Laudantium impedit dolorem optio voluptas. Optio eos repudiandae aliquam libero nihil et. Nobis ut incidunt architecto similique ea maxime. Aut enim hic fugiat dignissimos.', 'quos', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(124, 'ipsa', 'Optio et dolores veritatis possimus eveniet. Aut suscipit id quo. Natus nemo alias sed magni excepturi rerum.', 'rerum', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(125, 'et', 'Ab reiciendis officiis tempora fugiat eius pariatur soluta. Cumque fuga voluptate ratione velit ducimus et totam. Delectus fuga quis occaecati iure natus nobis eos.', 'temporibus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(126, 'sunt', 'Et aut quis aliquam quos. Quisquam quis molestiae dolor libero. Cumque dolores dolorem et ut voluptatem ex rerum. Maiores velit voluptas iure ea veritatis voluptatum quis eos.', 'molestias', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(127, 'dolor', 'Esse rerum eius assumenda quia. Perferendis laboriosam incidunt tenetur ea iure. Ex dolorum magni ut fugit voluptatum. Praesentium blanditiis molestiae eius eum quo. Necessitatibus nihil a tempora qui facere.', 'laborum', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(128, 'fugiat', 'Rerum saepe sed ut magnam similique. Nam animi reiciendis et ducimus aliquid quos est. Accusamus voluptatum dolor impedit est voluptate labore qui.', 'totam', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(129, 'impedit', 'Non cum modi aut mollitia. Suscipit eum quo vel repellat aut quo fugiat. Earum similique voluptatem deserunt ut dolores autem nisi voluptatibus.', 'eveniet', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(130, 'deserunt', 'Sit eligendi aut iure temporibus sed qui. Maiores occaecati aut voluptatem. Maiores inventore et qui ea fugit id.', 'possimus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(131, 'voluptatibus', 'Vel iure fugiat dignissimos neque sunt error voluptas. Distinctio magni expedita rerum et. Qui distinctio aut soluta eum facere.', 'repellendus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(132, 'id', 'Dolorem voluptates consequatur tempora. Et voluptatum iusto omnis eos. Quo ratione voluptatem quia molestiae eos nisi atque.', 'corporis', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(133, 'quaerat', 'Expedita laboriosam accusantium saepe neque. Numquam est et eos est voluptates excepturi dolorem.', 'dolores', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(134, 'perspiciatis', 'Sed aspernatur ratione laudantium. A hic perferendis iusto voluptates et. Rem est rerum voluptate est autem. Amet ipsam et asperiores ipsa.', 'autem', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(135, 'tempora', 'Eos autem architecto pariatur et. Iste ipsum tenetur in sed sed suscipit expedita dolores. Rerum est voluptatem voluptatum doloremque qui alias.', 'magnam', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(136, 'saepe', 'Architecto minus sint aut explicabo magni asperiores impedit. Autem iusto officiis est tempore sapiente error neque. Ut natus ducimus non. At rerum atque possimus culpa voluptatibus cum et.', 'tempore', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(137, 'est', 'Dolor nisi totam ipsum accusamus. Quae officiis nihil provident cum. Ipsa sunt enim repudiandae quis repudiandae atque.', 'delectus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(138, 'doloribus', 'Et voluptatibus id sunt consequatur. Aut perferendis in molestiae et suscipit ipsam ab. Reiciendis consequatur quia omnis consequuntur consectetur quae porro perferendis. Est consequatur deserunt dolores ut at. Minima fugit dolorem sunt accusamus adipisci quis tenetur.', 'est', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(139, 'in', 'Eos dolor quia qui eaque. Asperiores laborum ratione quia temporibus nihil. Neque impedit quis porro beatae consequatur enim.', 'voluptatem', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(140, 'voluptatem', 'Explicabo corporis facilis ut. Mollitia fugit suscipit voluptas velit aut corporis et vel. Atque inventore qui est praesentium. Voluptatibus tempora beatae non neque ipsa ut et.', 'eligendi', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(141, 'et', 'Voluptas earum quod nihil error totam dolores. Est aut dignissimos quis illo velit omnis. Minima beatae minima est qui illum.', 'est', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(142, 'dolor', 'Impedit et rerum quisquam voluptatem. Cum consequatur dolorem animi vel ut esse sunt nihil. Sapiente aut dolor perferendis rerum aperiam.', 'blanditiis', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(143, 'et', 'Voluptatem sed asperiores et laudantium at. Voluptatem perferendis consequatur doloribus voluptatem et quas earum. Consequatur ea sed enim amet quia qui.', 'ab', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(144, 'consequatur', 'Voluptatem atque delectus qui voluptas. Voluptas porro et ipsam beatae et omnis quia.', 'praesentium', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(145, 'voluptatem', 'Illo sed illum natus. Voluptatem minus doloremque velit dolor soluta alias. Nulla quas recusandae voluptates quae accusantium corrupti. Facere soluta a ipsam impedit molestias.', 'libero', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(146, 'sit', 'Molestiae incidunt molestias odio et iste. Ut et a natus dicta minus ut officiis assumenda. Ex reprehenderit sit voluptas ab possimus accusantium.', 'qui', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(147, 'corrupti', 'Doloribus qui illum inventore dolore. Eveniet dolor vitae consequatur mollitia possimus deleniti. Ut maxime maxime quod dolores libero voluptas consequuntur. Vero et officiis sit consequuntur. Non possimus non et libero.', 'animi', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(148, 'ut', 'Consequatur enim fugit nemo asperiores ut debitis nesciunt et. Id nihil ad quod voluptas. Occaecati in quo quod sed corrupti voluptatem.', 'sunt', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(149, 'laboriosam', 'Hic nesciunt at exercitationem consequuntur fuga. Doloribus dolorum quaerat autem nam. Aliquid deleniti eum laborum qui molestias voluptas reiciendis aut. Dolorem laboriosam et ducimus.', 'cumque', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(150, 'doloribus', 'Commodi officia sapiente distinctio saepe fugit magnam quam. Quidem quia natus ea aut debitis. Eligendi facere ut quae est est.', 'iusto', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(151, 'id', 'Quasi tempore velit et optio. Non quia omnis ut enim molestias. Aliquid quidem quisquam fuga praesentium nam assumenda ratione. Dolor et necessitatibus quibusdam aut tenetur.', 'sunt', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(152, 'deleniti', 'Blanditiis eligendi eum asperiores et velit tempore fuga atque. Totam voluptatibus cumque libero consectetur non ut dolor. Quia eligendi numquam vero unde vel.', 'amet', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(153, 'voluptatem', 'Explicabo repellat repudiandae ut vero. Tempore debitis iusto sint aut. Hic atque repellendus laboriosam omnis nobis. Molestiae quidem illum quo consequatur inventore ullam eveniet.', 'iure', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(154, 'nobis', 'Tenetur cumque repellendus quaerat ad consectetur sed. Porro libero animi adipisci voluptatem. Expedita atque et ullam dolor eaque totam.', 'sit', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(155, 'perferendis', 'Ipsa non et est sunt quia perspiciatis debitis. Reprehenderit et eveniet suscipit sit et praesentium corrupti. Eos earum repellendus architecto impedit aperiam et.', 'aliquam', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(156, 'recusandae', 'Molestiae ea quis distinctio ut beatae. Odio saepe quia nam natus id. Dolores quia animi voluptatem pariatur eum odio.', 'ea', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(157, 'et', 'Dignissimos qui ab aspernatur fuga omnis illo reprehenderit. Magni voluptatem doloribus praesentium et aspernatur consequuntur. Expedita distinctio ut in commodi libero nemo repellat.', 'quam', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(158, 'nemo', 'Iure accusamus minima dicta eum error voluptate. Asperiores porro natus fugit doloremque sit facere.', 'qui', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(159, 'fugiat', 'Laudantium maiores omnis reiciendis consectetur unde est aperiam. Fugit est cupiditate facilis sint ab sit temporibus.', 'suscipit', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(160, 'molestiae', 'Rerum sunt a dolores autem sunt qui. Hic facilis exercitationem non ea quibusdam aperiam. Et illum non et et. Voluptatibus et doloribus id illum placeat.', 'repellat', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(161, 'magnam', 'Officiis dolorem aut nesciunt voluptatem et nihil quo. Nisi placeat quasi error. Et iure sit est ipsum ipsam consequatur suscipit. Eligendi quidem facere ratione est asperiores.', 'voluptatem', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(162, 'est', 'Rerum nihil ut excepturi dolores pariatur qui suscipit. Pariatur autem iusto debitis. Qui laudantium soluta ea qui qui. Vel dicta aliquid molestiae nostrum. Placeat et non in quas.', 'iste', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(163, 'eum', 'Saepe in quia facere aliquam. Similique inventore tenetur deserunt in nulla. Praesentium doloribus similique dolores assumenda magni amet.', 'quia', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(164, 'ea', 'Asperiores neque voluptate et aut. Ipsa suscipit numquam sunt error.', 'magni', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(165, 'delectus', 'Perspiciatis quam rerum a. Perferendis autem voluptatum pariatur. Et doloremque eius dolor dolores eaque velit autem.', 'quasi', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(166, 'magni', 'Dignissimos qui aut fugiat asperiores amet fugit et eaque. Earum aut vitae voluptas consequatur fuga. Ab eos ullam dolorum id expedita dolores omnis dolor.', 'maxime', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(167, 'et', 'Eum nihil in aut qui. Vero ratione ipsa tenetur quam debitis occaecati. Aut laudantium omnis autem inventore odio tenetur et.', 'ut', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(168, 'optio', 'Temporibus illum omnis numquam. Dolore expedita in sint tempore sit provident suscipit qui. Autem qui enim accusantium vel vel est omnis rem.', 'possimus', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(169, 'rem', 'Non iure qui necessitatibus eum. Quia rerum eum eum sed temporibus deleniti. Qui non animi velit voluptatibus suscipit.', 'repudiandae', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(170, 'aut', 'Illo distinctio sequi dolorem placeat illum eligendi ut labore. Harum natus eos debitis est facere. Illo id et quidem. Tenetur repudiandae hic dolores error est nihil et. Et nulla ad amet dolorem iste itaque.', 'dolor', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(171, 'nisi', 'Tempore perferendis eaque recusandae illum doloribus veritatis cumque. Illo nisi quia sed quis aperiam eos eos. Minus laudantium ex odio laboriosam eum. Sed quae qui aut in. Ut minima vitae voluptatem est eum assumenda.', 'amet', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(172, 'perspiciatis', 'Expedita reprehenderit dolor velit. Tenetur illo vero dolores repellendus perspiciatis possimus. Qui ullam odio sequi aspernatur nihil. Ut ad maxime voluptatibus qui voluptatibus asperiores animi.', 'quas', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(173, 'sed', 'Fugit alias qui velit nam aut optio. Non deleniti ducimus ut velit. Voluptatem quae voluptatem et. Sequi modi cum omnis in esse at aut.', 'inventore', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(174, 'ea', 'Et quidem aliquam deleniti quia odio ducimus ipsum voluptas. Ducimus possimus incidunt dolor maxime. Ea cupiditate ex dolores aliquid voluptas laudantium.', 'ab', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(175, 'esse', 'Mollitia itaque soluta voluptatem et. Asperiores officiis odio quos doloremque. Optio ab corporis voluptatibus.', 'et', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(176, 'doloribus', 'Voluptate non aperiam ut doloremque aut corporis. Dolorem incidunt eius qui aut nemo est esse. Officia omnis sequi non. Atque et autem autem qui quos ut iste.', 'similique', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(177, 'accusantium', 'Aut non et incidunt temporibus laboriosam. Eaque sequi ut est omnis earum rem enim tempore. Tempora aut nulla ut sunt. Rem at qui sequi et.', 'sit', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(178, 'assumenda', 'Ipsum eos id ut tenetur iste ut enim. Dolores voluptates aut esse dicta vero praesentium placeat. Perferendis sed omnis aut dignissimos eum et est. Placeat adipisci doloribus qui exercitationem et autem.', 'et', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(179, 'officia', 'Et enim molestiae ut quas inventore facilis. Omnis voluptatem et cum. Sit at commodi culpa omnis sunt molestiae.', 'quod', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(180, 'fuga', 'Odit blanditiis repellendus dolores explicabo quia consequatur officia ut. Aut veniam rerum in vitae molestiae. Id qui quia architecto ad. Ducimus ut aperiam veritatis cumque.', 'qui', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(181, 'nulla', 'Quis illo non eveniet excepturi quidem qui qui. Ab facilis odit sit est cupiditate. Qui corrupti odit magni ab consectetur possimus. Dolore qui et dolorem.', 'itaque', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(182, 'omnis', 'Voluptatum perferendis aut unde. Aliquid perspiciatis sed vel qui esse tenetur magnam. Quia et aut rem veniam laudantium. Commodi sit dolorem non debitis quaerat aliquid.', 'molestias', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(183, 'esse', 'Debitis quisquam et repudiandae qui aut facilis. Error et tempora qui sunt quo voluptatem non. Porro tempora est animi repudiandae sed. Iste sapiente veniam tenetur fuga velit ipsa.', 'iusto', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(184, 'quo', 'Laboriosam molestiae sapiente ipsa sunt dolores. Incidunt ducimus et sunt beatae. Aperiam voluptas quia ut praesentium adipisci illum.', 'dolorum', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(185, 'ullam', 'Cum et error quo. Eligendi ut nihil veniam doloremque. Dolorem et omnis ab.', 'aliquam', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(186, 'porro', 'Cum modi ea autem aut temporibus consequatur cupiditate. Odit doloremque accusamus sit asperiores quibusdam facilis. Et deserunt officiis molestias impedit. Molestias corporis nihil et voluptatem est assumenda fuga eum.', 'voluptas', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(187, 'eum', 'Porro non sed quod velit eos. Ab sit id ipsa nostrum hic voluptatem. Ratione nihil maxime at. Et labore iusto aliquam dolorem.', 'et', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(188, 'quia', 'Repellat quidem natus sed laudantium. Ratione quia nemo accusantium. Voluptas labore atque animi iure.', 'sit', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(189, 'ut', 'Magni ab qui veniam quibusdam perferendis enim illum. Pariatur odit quo est quidem perspiciatis. Labore quae eaque architecto magni.', 'laboriosam', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(190, 'eligendi', 'Nam sed in explicabo enim quibusdam iusto nobis. Quo dolore dolorem aut. Eos inventore et dolorum recusandae dolorem odit.', 'qui', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(191, 'sunt', 'Tempora magni vel optio hic ab rerum sunt. Qui dolor sed quia ut molestiae tempore qui.', 'nihil', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(192, 'autem', 'Eligendi architecto rerum nobis sint molestias sed ipsum dicta. Placeat qui voluptatem eum iure soluta. Consequuntur doloremque at eos et enim quia est. Labore consequatur impedit numquam fugiat nihil expedita perferendis.', 'possimus', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(193, 'tempore', 'Quis et in iste. Ut omnis aliquam cumque facere recusandae ea. Laboriosam voluptas voluptatem a sed exercitationem deserunt ratione. Qui explicabo ut ipsam velit reiciendis dolor.', 'quae', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(194, 'ea', 'Saepe quis ex ut. Quisquam atque ab quis facere. Consequatur voluptatem quasi praesentium fugit quam rerum officiis.', 'saepe', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(195, 'labore', 'Qui sed sit repudiandae quae aut tenetur. Sit natus recusandae et aut. Consequuntur assumenda aperiam et beatae.', 'sunt', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(196, 'adipisci', 'Animi eveniet voluptatem sit nesciunt aut. Nam nulla autem unde sunt nesciunt enim. Voluptates enim sed quibusdam sequi atque occaecati cumque.', 'nostrum', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(197, 'laudantium', 'Veritatis voluptates adipisci voluptatum accusamus architecto et similique. Quia maxime quaerat illum earum. Dolor velit aut iure consequatur. Praesentium inventore illo corrupti explicabo ea assumenda repellendus impedit.', 'quia', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(198, 'ut', 'Voluptatem eaque neque eveniet ullam rerum. Eius inventore inventore et enim. Est magnam atque asperiores cupiditate adipisci aut itaque. Minus omnis sunt sed officia aliquam qui ipsum.', 'facilis', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(199, 'voluptates', 'Suscipit et rerum numquam a enim ut error praesentium. Vel debitis sint aspernatur et sed doloremque nam. Provident sit maxime deserunt reprehenderit rerum repudiandae ea non. Placeat harum ut minus possimus nisi voluptatem.', 'perspiciatis', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(200, 'exercitationem', 'Sit quia voluptatibus possimus incidunt eius. Illum necessitatibus voluptates rem praesentium doloribus consequuntur qui ad. Cumque dicta a vel doloribus atque quaerat.', 'et', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(201, 'ut', 'Omnis ea est nostrum non aut. Distinctio facilis veritatis nulla soluta et et. Aut est dolorem dolorem quasi sit occaecati non. Dolorum recusandae sint et dolore voluptas rerum blanditiis ullam. Dolorem unde aut aut sed esse.', 'sunt', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(202, 'quas', 'Qui inventore velit ipsum nulla. Pariatur ut et quod qui ullam asperiores modi. Eveniet veritatis consequatur facilis deserunt veritatis. Dolor qui officia in eum voluptas dolor enim.', 'autem', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(203, 'voluptate', 'Magni odit reiciendis laborum qui. Voluptas ab perferendis doloribus corrupti quos omnis aut. Quas deleniti delectus quod recusandae ea quam perferendis rerum. Aperiam eligendi nisi et qui a.', 'magnam', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(204, 'illum', 'Voluptas non accusantium rem deleniti aut. Impedit soluta distinctio reprehenderit eveniet. Qui sint excepturi dolor animi.', 'deleniti', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(205, 'eum', 'Sit minima eos aspernatur quam ratione. Deserunt sint ut quos quia ipsa magnam eligendi. Molestias nemo non dolore pariatur nostrum esse facere.', 'veritatis', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(206, 'pediatrics', 'Diseases related to childrens', 'Ao', '2025-05-02 18:28:50', '2025-05-02 18:28:50');

-- --------------------------------------------------------

--
-- Table structure for table `cadre_health_worker`
--

CREATE TABLE `cadre_health_worker` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cadID` bigint(20) UNSIGNED NOT NULL,
  `hwID` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `children`
--

CREATE TABLE `children` (
  `childID` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `parentName` varchar(255) NOT NULL,
  `parentContact` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `children`
--

INSERT INTO `children` (`childID`, `name`, `gender`, `dob`, `image`, `address`, `parentName`, `parentContact`, `created_at`, `updated_at`) VALUES
(1, 'Keagan Steuber', 'Female', '1982-02-03', 'https://via.placeholder.com/640x480.png/008855?text=cumque', '4930 Haag Club Apt. 503\nWest Adeleland, AL 00840', 'Maybelle Daugherty', '1-214-298-1646', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(2, 'Jena Champlin', 'Male', '2017-07-30', NULL, '2593 Shaniya Haven Suite 974\nHoegerside, CO 93027', 'Marcella Hansen', '1-423-699-5171', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(3, 'Althea Kuhn', 'Male', '1995-10-04', 'https://via.placeholder.com/640x480.png/001122?text=facilis', '408 Adam Fall\nWildermanland, AL 23776-6833', 'Alexie Schaefer', '971-896-8157', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(4, 'Austyn Price', 'Female', '1993-09-22', 'https://via.placeholder.com/640x480.png/00ddbb?text=quia', '123 Elinore Gateway\nLake Laury, NM 02574-1774', 'Sasha Fisher', '+1.838.887.4947', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(5, 'Dr. Adolfo Beier', 'Male', '2019-10-16', NULL, '65346 Robert Court\nLottiehaven, AK 26208', 'Katlynn Harvey', '+1-959-353-9250', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(6, 'Alaina Schneider', 'Male', '1994-09-27', 'https://via.placeholder.com/640x480.png/00cc55?text=laboriosam', '8380 Malika Squares Apt. 285\nEast Billie, GA 74332-5650', 'Miss Virginia Kuhn I', '(870) 951-2985', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(7, 'Dr. Forrest Jaskolski V', 'Male', '1971-11-22', 'https://via.placeholder.com/640x480.png/00cc00?text=laboriosam', '525 Mallie Lane\nDickinsonland, MA 98553', 'Kody Kihn Jr.', '+1 (662) 644-5010', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(8, 'Miss Georgette Flatley PhD', 'Female', '2006-08-12', NULL, '861 Jaskolski Rapids Suite 742\nNorth Kendra, SD 73109', 'Arnoldo Cummerata II', '+1.586.526.2207', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(9, 'Titus DuBuque', 'Male', '2011-06-27', 'https://via.placeholder.com/640x480.png/0000ff?text=maxime', '91089 Schiller Parkways Suite 589\nSwaniawskiport, IL 73804', 'Dr. Sid Reynolds', '341-985-0795', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(10, 'Marcellus Treutel', 'Female', '1982-09-21', NULL, '433 Tanya Lakes\nWest Bert, WV 99344-7954', 'Ms. Bettie Nolan III', '(224) 438-5353', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(11, 'Pamela Daniel', 'Female', '2004-05-23', NULL, '64014 Earlene Drive\nLake Daija, WY 03199', 'Stephanie Cole', '+1-442-300-8259', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(12, 'Madelynn Mertz II', 'Male', '1979-05-31', NULL, '1418 Nathan Extension\nCarmelafort, OK 66401-5217', 'Trudie Hills', '(470) 922-6913', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(13, 'Dr. Emory McClure', 'Female', '2022-09-24', NULL, '4004 Breitenberg Villages Apt. 956\nPort Lazarostad, NH 35084-6380', 'Miss Theodora Larkin', '651.225.7459', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(14, 'Myrna Hoppe', 'Male', '1972-07-16', 'https://via.placeholder.com/640x480.png/00eeee?text=quod', '9042 Alysa Grove\nLake Blakebury, KS 54522-8542', 'Dr. Fleta Harvey', '1-760-290-1128', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(15, 'Twila Boyle', 'Female', '2005-11-08', NULL, '908 Helena Fall\nKeelingville, WA 01922-0417', 'Myles Ernser', '1-906-869-9405', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(16, 'Kris Kuhn', 'Male', '1974-01-21', NULL, '883 Nicolas Rue Suite 047\nJenkinsfort, AZ 87670-7770', 'Candelario Jerde', '1-330-236-7798', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(17, 'Prof. Grover Kautzer', 'Male', '1976-07-19', 'https://via.placeholder.com/640x480.png/009999?text=aut', '4680 Eva Meadow Suite 702\nPort Westonmouth, CT 91856-2782', 'Arjun Mayer III', '+17345360189', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(18, 'Norma Ward', 'Male', '1989-02-02', NULL, '45302 Dennis Fort\nEast Tamara, MA 45006', 'Alec Hilpert', '+12698749044', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(19, 'Johnpaul Douglas', 'Male', '1981-11-09', 'https://via.placeholder.com/640x480.png/00dd22?text=voluptatem', '605 Moore Turnpike Apt. 909\nBechtelarfort, WV 57123-1162', 'Lyla Murphy', '680-440-8120', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(20, 'Beatrice Harber', 'Female', '2015-07-15', NULL, '26980 Torey Harbors\nPort Garthberg, MO 96673-6845', 'Robert Frami', '+1.475.634.3489', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(21, 'Harley Collins', 'Male', '1998-09-12', NULL, '750 Collins Island\nHamillburgh, HI 31177-6326', 'Savannah Runolfsdottir', '(531) 410-3544', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(22, 'Mr. Willis Pagac', 'Male', '2021-02-07', 'https://via.placeholder.com/640x480.png/009933?text=ipsum', '6225 Beahan Parkway\nSouth Danial, TN 41142-6774', 'Mike Gerlach', '+1-737-360-2704', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(23, 'Royal Bergstrom DDS', 'Female', '1988-12-23', 'https://via.placeholder.com/640x480.png/001122?text=laborum', '40300 Ezekiel Center Suite 612\nPort Giles, TX 14336-9750', 'Prof. Hunter Swaniawski MD', '551.483.2858', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(24, 'Prof. Will Volkman', 'Female', '2015-09-17', 'https://via.placeholder.com/640x480.png/00ccaa?text=quaerat', '4181 Rigoberto Ports Suite 782\nEast Joanyfurt, WY 17851-6365', 'Gordon Abbott', '+1 (689) 264-5829', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(25, 'Lucinda Thompson MD', 'Female', '1999-03-26', NULL, '3700 Opal Valleys\nKautzerhaven, PA 24182-4396', 'Elvera Kertzmann', '470-398-9963', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(26, 'Claire Murray PhD', 'Female', '2016-01-21', NULL, '920 Bechtelar Plaza\nHoegerport, SD 67193-2515', 'Prof. Felipa Casper II', '(585) 201-6581', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(27, 'Annabell Green', 'Female', '2010-07-31', 'https://via.placeholder.com/640x480.png/00ff44?text=voluptatem', '3677 Ullrich Vista Suite 846\nWest Mckenzie, WV 94547', 'Regan Beer V', '+19724076757', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(28, 'Vladimir Renner IV', 'Female', '2001-08-15', NULL, '861 Lebsack Road\nConnellymouth, MT 89991-6490', 'Piper Grimes', '+1 (818) 997-3846', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(29, 'Kobe Lind II', 'Female', '1993-10-06', NULL, '20367 Runolfsdottir Centers Suite 109\nPort Karlee, WI 44578', 'Adelbert Ledner', '+1.509.517.1602', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(30, 'Camren Hahn III', 'Female', '2019-09-01', 'https://via.placeholder.com/640x480.png/0077ff?text=ab', '394 Jorge Mission Suite 433\nLake Jasonberg, MS 66973', 'Holden Ankunding', '779-674-1398', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(31, 'Rowan DuBuque', 'Male', '1984-07-23', NULL, '6214 Ruecker Light\nBartonside, AK 32800-8551', 'Ms. Shanna Fritsch I', '870-233-2005', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(32, 'Miss Susanna Little', 'Male', '2009-06-18', 'https://via.placeholder.com/640x480.png/004499?text=pariatur', '13564 Clementine Islands\nMacejkovicchester, KS 48595-4682', 'Kelsie Crooks', '+1-480-602-0736', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(33, 'Roscoe Kuhic DVM', 'Male', '2018-09-04', NULL, '8291 Herman Trafficway\nStrosinbury, MN 43214-1808', 'Lorena Haag', '+1.959.439.7759', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(34, 'Charlene Senger', 'Male', '2011-04-02', NULL, '35079 Wiza Mountain Apt. 607\nSouth Regan, NM 35999', 'Cornell Douglas', '+1 (412) 620-5144', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(35, 'Magdalena Waters I', 'Female', '2005-08-04', NULL, '96171 Metz Common\nPort Malcolm, AZ 28578', 'Kim Fahey DDS', '1-541-319-5011', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(36, 'Amani Stroman', 'Male', '2006-03-31', 'https://via.placeholder.com/640x480.png/00ffcc?text=est', '513 Beau Field Suite 960\nNorth Raegan, NM 22066', 'Laila Stiedemann', '+1.561.585.6260', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(37, 'Antonette Gaylord MD', 'Male', '1994-11-18', NULL, '392 Goldner Fork Suite 618\nJaskolskifort, MS 22898', 'Gabe Abshire', '+12695869854', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(38, 'Ara Greenholt', 'Female', '1976-07-02', 'https://via.placeholder.com/640x480.png/00ee33?text=ad', '520 Jerde Station\nDickihaven, VT 62044', 'Gussie Kozey', '847-592-8769', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(39, 'Mr. Selmer Hoppe I', 'Female', '1970-12-14', 'https://via.placeholder.com/640x480.png/00eecc?text=in', '29281 Stark Mills\nLake Edwinmouth, NV 31326-1237', 'Katrine Treutel', '606-574-5189', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(40, 'Jesus Cronin', 'Female', '2008-05-29', 'https://via.placeholder.com/640x480.png/006699?text=qui', '53162 Quinn Glens\nKunzebury, WA 63081', 'Judd Farrell', '319-464-2776', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(41, 'Gussie Greenfelder DVM', 'Female', '1979-10-27', NULL, '6447 Crystel Street\nRomagueraview, UT 54645', 'Octavia Gerlach', '+1-423-207-9126', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(42, 'Eli Bahringer', 'Female', '1993-11-09', NULL, '675 Harber Radial\nLelaville, SD 95220', 'Koby Medhurst', '872.891.9829', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(43, 'Carley Schultz', 'Female', '1972-03-02', NULL, '372 Lavon Corner Apt. 346\nImeldaview, CO 48737', 'Tamia Rice III', '+1 (339) 816-1066', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(44, 'Lisandro Kunde', 'Male', '2021-10-04', NULL, '1189 Charles Greens\nPort Raymundoborough, VT 43346-4498', 'Dashawn McCullough', '+1-838-506-5410', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(45, 'Miss Eloisa Kuphal', 'Female', '1980-08-26', NULL, '12834 Rae Station Suite 881\nAdityaport, NJ 25328', 'Dr. Max Kerluke', '1-906-676-9266', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(46, 'Adele Langworth', 'Female', '1980-08-14', NULL, '262 Greenholt Rapids\nNew Kalebview, WI 16804', 'Xavier Torphy', '(707) 510-3562', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(47, 'Arjun Collier', 'Female', '2009-12-25', NULL, '88614 Romaguera Square Suite 156\nLake Charlieborough, PA 96214-5563', 'Katelynn Wehner', '(640) 647-3955', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(48, 'Prof. Merle Bayer', 'Male', '2009-04-12', NULL, '15166 Joyce Station Suite 312\nAuerchester, NV 36231-4057', 'Verla Thompson Jr.', '(754) 528-3045', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(49, 'Mrs. Katelin Borer', 'Male', '2016-09-17', 'https://via.placeholder.com/640x480.png/00dddd?text=et', '7983 Weber Divide Apt. 303\nPort Maria, UT 90251', 'Vivianne DuBuque', '337.414.1185', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(50, 'Devin Prohaska', 'Male', '1995-09-06', NULL, '239 Altenwerth Groves\nSpencertown, OH 38336', 'Thalia Parker', '220-450-4179', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(51, 'Frida Heller', 'Female', '2013-03-16', 'https://via.placeholder.com/640x480.png/008833?text=iusto', '18093 Clarabelle Extensions\nNorth Benport, SC 03973-3459', 'Krystel Gusikowski', '973-595-2104', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(52, 'Mrs. Rosemary Donnelly DVM', 'Male', '1995-09-15', 'https://via.placeholder.com/640x480.png/00ee66?text=repellat', '487 Berge Drives Suite 132\nCarrieborough, WI 27572-3354', 'Deja Wehner', '+1.360.337.1288', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(53, 'Rey Murazik', 'Female', '2002-12-28', NULL, '54216 Borer Point Apt. 091\nHuelstad, PA 96047-0810', 'Mrs. Simone Cartwright III', '743-664-5997', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(54, 'Mr. Gaylord Heller', 'Male', '1984-12-05', 'https://via.placeholder.com/640x480.png/0033dd?text=placeat', '399 Farrell Falls Suite 156\nPort Joy, OR 53982', 'Dr. Earnest Boehm Jr.', '640-957-2352', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(55, 'Jaquan McCullough II', 'Female', '1974-12-30', 'https://via.placeholder.com/640x480.png/004499?text=quibusdam', '6433 Lucinda Flat Suite 019\nLake Collin, NV 81600-6514', 'Wyman Runolfsson', '903-662-8205', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(56, 'Mozelle Wilkinson', 'Male', '1989-01-25', 'https://via.placeholder.com/640x480.png/00dd22?text=et', '69446 Ziemann Passage\nBenedictchester, OR 87385', 'Dr. Lina Graham II', '+1.551.292.0294', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(57, 'Dr. Katheryn Bins', 'Female', '1993-10-01', NULL, '703 Bernie Light\nWest Patience, WI 05017', 'Alexandra Rosenbaum', '763-713-9658', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(58, 'Coleman Bins', 'Female', '2008-10-01', NULL, '1920 Neha Lodge\nMurazikland, NE 92236', 'Leo Johns', '1-872-213-1101', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(59, 'Scarlett Bernier', 'Female', '1970-07-12', NULL, '897 Runolfsson Manors Suite 856\nJasenfort, OR 78987-1573', 'Bridget Shields Jr.', '(862) 535-3881', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(60, 'Nya Welch Jr.', 'Male', '2012-08-09', 'https://via.placeholder.com/640x480.png/00ccdd?text=odio', '69126 Colin Neck Suite 814\nNew Hannah, NH 39647-5058', 'Prof. Keanu Koelpin Sr.', '606-638-5633', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(61, 'Lexie Batz', 'Male', '1983-08-25', NULL, '678 Gage Glens\nBernierborough, RI 72505-8254', 'Mylene Ryan', '1-380-284-2033', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(62, 'Vivien Schaden', 'Male', '1979-11-06', NULL, '9949 Schneider Underpass Suite 194\nLake Emie, SC 14544-1957', 'Anabelle Jaskolski V', '+19082713052', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(63, 'Patrick Schroeder', 'Female', '1982-01-31', 'https://via.placeholder.com/640x480.png/00aadd?text=aut', '8173 Hermiston Trail Suite 848\nBeattymouth, AR 93071-1689', 'Miss Jeanie Simonis', '+1-332-390-1392', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(64, 'Madelynn Zemlak', 'Female', '2024-05-02', NULL, '905 Alec Station\nSouth Bethanyland, VA 91970', 'Cletus Douglas', '+1-551-209-9541', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(65, 'Therese McCullough', 'Female', '2020-01-14', 'https://via.placeholder.com/640x480.png/00eecc?text=veniam', '8953 Hartmann Forest Suite 428\nRichmondberg, AR 72379', 'Rowena Homenick', '605.279.3556', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(66, 'Aileen Hane', 'Female', '1989-05-28', 'https://via.placeholder.com/640x480.png/00dd11?text=aut', '1076 Beahan Knoll\nDanniehaven, AK 02840-7685', 'Lola Harris', '+1.412.375.7563', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(67, 'Vicente Graham', 'Male', '2007-04-18', 'https://via.placeholder.com/640x480.png/0099cc?text=eius', '68525 Ursula Keys\nPort Angelitaberg, MN 72169-2920', 'Katelyn Bernier', '1-239-981-1133', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(68, 'Turner Marks I', 'Male', '2003-07-10', 'https://via.placeholder.com/640x480.png/007799?text=cum', '29563 Ernesto Brooks Suite 365\nNorth Barryshire, AZ 70132-9983', 'Yasmine Kreiger', '+1-951-247-5602', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(69, 'Providenci O\'Reilly', 'Female', '1999-12-18', NULL, '916 Arlo Fork Apt. 017\nSouth Virgil, MO 18512-8050', 'Amparo Halvorson', '+1.352.682.9895', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(70, 'Emma Pollich', 'Male', '1988-12-05', NULL, '93887 Bulah Street Suite 921\nEast Llewellyn, WV 89829', 'Miss Yasmeen Boyle DDS', '(678) 388-0662', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(71, 'Esperanza Gusikowski', 'Female', '1982-07-13', 'https://via.placeholder.com/640x480.png/001155?text=tempora', '507 Blick Viaduct\nPort Adanview, KS 18398-8781', 'Catharine Satterfield', '704.670.9953', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(72, 'Esperanza Grimes V', 'Female', '2006-07-03', NULL, '95751 Zora Turnpike\nTierrafurt, IL 24407-6159', 'Ima Rowe', '+19382965421', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(73, 'Gunnar Johns', 'Male', '2006-06-25', NULL, '573 Okuneva Gardens\nGoodwinburgh, WI 63730-7115', 'Ms. Yesenia Mosciski', '+13413717660', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(74, 'Carlee Keeling', 'Female', '2014-05-04', NULL, '1759 Buckridge Circles Apt. 440\nDenesikside, KY 49335', 'Mrs. Marianna Morissette', '1-845-553-2100', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(75, 'Gretchen Macejkovic', 'Female', '1999-01-25', NULL, '27593 Eugene Terrace Suite 169\nPort Dante, RI 93567-6131', 'Dr. Cameron Rohan', '480-506-3529', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(76, 'Mr. Freddy Watsica PhD', 'Female', '1980-09-13', 'https://via.placeholder.com/640x480.png/000099?text=distinctio', '4617 Carlo Ramp\nNew Arnaldo, NM 81345-0004', 'Mr. Noble Gutmann', '309-901-6848', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(77, 'Timmy Lehner MD', 'Male', '2013-10-26', NULL, '4803 Connelly Points Suite 904\nRauborough, OK 54339', 'Jeromy Koss', '+1-989-743-8952', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(78, 'Hyman Legros', 'Female', '2011-09-13', NULL, '711 Janelle Forges\nGislasonport, CT 51068-1870', 'Trudie Bahringer', '1-458-651-6634', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(79, 'Lucile Beier', 'Male', '2014-08-16', NULL, '99638 Eichmann Burgs\nPort Fae, NY 19727', 'Prof. Nickolas Walker DDS', '+15348330096', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(80, 'Misty King MD', 'Male', '2021-05-14', 'https://via.placeholder.com/640x480.png/008855?text=consectetur', '213 Jaqueline Bypass\nJulianside, WA 53239-2719', 'Fern Powlowski IV', '667.818.4613', '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(81, 'Dr. Maya Rutherford IV', 'Female', '2009-03-09', NULL, '40351 Hassan Bridge\nSouth Anahi, LA 95947-4699', 'Mr. Myron Kunde', '(570) 345-6952', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(82, 'Frederik Auer', 'Female', '1993-10-07', NULL, '9066 Rosendo Centers\nWymanfort, CO 72585', 'Prof. Clovis Friesen DVM', '(341) 343-6167', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(83, 'Alvis Hegmann', 'Male', '2006-05-28', NULL, '21982 Constance Spurs Suite 557\nEast Ludwig, AK 92819', 'Madyson Hessel', '+17574512262', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(84, 'Jasen Crooks', 'Male', '2014-09-11', NULL, '558 Omer Ridges\nNorth Isobel, NE 73249-0866', 'Alana Gleichner', '469.498.2746', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(85, 'Devonte Kutch', 'Male', '2003-09-19', 'https://via.placeholder.com/640x480.png/006655?text=voluptas', '20987 Khalid Inlet\nSouth Edwardfurt, NV 95095', 'Kenya Shields', '1-717-987-9633', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(86, 'Alicia Lockman', 'Male', '2001-04-15', NULL, '406 Abbott Branch Suite 432\nEwaldburgh, NH 98824', 'Austin Batz', '(534) 402-8040', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(87, 'Lexus Jacobi', 'Female', '1970-11-07', NULL, '67907 Jalyn Loaf Apt. 623\nWest Gunnar, MD 51056', 'Branson Jacobs', '1-843-581-1137', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(88, 'Mr. Leopoldo Reichert', 'Male', '2012-03-01', 'https://via.placeholder.com/640x480.png/004499?text=nisi', '22010 Padberg Walk Apt. 186\nLibbiechester, MO 50493-4617', 'Dell Deckow II', '203-307-5782', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(89, 'Bret Cole', 'Female', '1986-11-01', NULL, '868 Frederik Fall Apt. 150\nSouth Yvettebury, NC 12076', 'Ms. Giovanna Bahringer V', '1-352-334-1523', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(90, 'Lawson Bartoletti I', 'Male', '2017-04-08', NULL, '32728 Marques Loop\nNew Kacihaven, ME 50870-0748', 'Fay Hauck', '+1 (843) 836-3915', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(91, 'Cara Abbott', 'Male', '2024-12-25', 'https://via.placeholder.com/640x480.png/003388?text=natus', '5692 Ivah Parkway Suite 431\nMohrburgh, ME 46378', 'Lennie Greenholt', '+1.848.399.4910', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(92, 'Nyah Huels', 'Female', '1990-09-03', 'https://via.placeholder.com/640x480.png/008855?text=ducimus', '799 Ava Track\nNorth Sophia, DE 72052-6611', 'Kayden Keebler', '618-993-6143', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(93, 'Mrs. Audie Willms I', 'Female', '2016-12-29', 'https://via.placeholder.com/640x480.png/0011cc?text=exercitationem', '9627 Jon Brooks\nEast Kade, VT 95431', 'Chauncey Adams', '(520) 207-5251', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(94, 'Prof. Kayla Gaylord IV', 'Male', '2022-07-20', 'https://via.placeholder.com/640x480.png/002299?text=est', '93150 Johnston Street\nNew Adolphusview, ID 55819', 'Wiley Hermann', '254-418-0839', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(95, 'Cristian Ullrich MD', 'Male', '2014-02-24', 'https://via.placeholder.com/640x480.png/009922?text=suscipit', '433 Art Unions Suite 769\nNew Robynchester, WY 66349-2769', 'Miss Mabel Williamson DDS', '(701) 420-5724', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(96, 'Mr. Dion Pagac I', 'Female', '1997-05-29', 'https://via.placeholder.com/640x480.png/000033?text=exercitationem', '745 Krajcik Courts\nEast Shannyborough, ID 19524-7697', 'Rubie Donnelly', '+1-734-592-1443', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(97, 'Mr. Gus Hermiston', 'Male', '1999-10-13', NULL, '65278 Bins Causeway Apt. 604\nWest Cristobal, MI 22523-7879', 'Kaitlin Lang', '+1-585-863-2751', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(98, 'Arvilla Cruickshank', 'Male', '2009-07-03', 'https://via.placeholder.com/640x480.png/007777?text=deleniti', '79363 Bradtke Pass\nEast Nathanial, NV 69356-8930', 'Cleveland Fisher', '+1.603.551.5988', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(99, 'Ona Keeling', 'Female', '1996-02-16', NULL, '118 Estevan Shores\nGrahamchester, MS 18452', 'Mr. Kade Rolfson Sr.', '+1-979-870-6386', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(100, 'Justine Beier', 'Male', '2001-01-03', 'https://via.placeholder.com/640x480.png/001177?text=id', '2701 Gibson Rest Suite 419\nQuitzonton, IL 03993', 'Ruthe Rippin II', '1-813-446-2223', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(101, 'Adell Gibson', 'Female', '2000-12-06', NULL, '70438 Thaddeus Common\nWest Tinaland, VA 47528-7996', 'Itzel Pfannerstill DVM', '925-622-4594', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(102, 'Jeanne Hills V', 'Female', '2010-11-23', 'https://via.placeholder.com/640x480.png/001144?text=necessitatibus', '4378 Bartoletti Route Apt. 048\nMelvinaport, MO 95429', 'Adelbert Nicolas', '830.568.1235', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(103, 'Troy Stokes', 'Female', '1987-10-19', 'https://via.placeholder.com/640x480.png/002200?text=iure', '994 Lisandro Valley Apt. 724\nBrantfort, CT 80914', 'Mrs. Zetta Thiel', '1-810-387-4360', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(104, 'Destinee O\'Kon MD', 'Female', '2009-12-19', NULL, '4106 Emilio Drive\nMacyland, AZ 85365-6109', 'Ms. Winifred Hodkiewicz III', '+1 (341) 801-7970', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(105, 'Ms. Evelyn Lesch', 'Male', '2021-11-04', 'https://via.placeholder.com/640x480.png/007711?text=consequatur', '1007 Reichert Oval Suite 333\nKoepptown, GA 59330', 'Sonya Bogisich', '(949) 248-9644', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(106, 'Amalia Lesch', 'Female', '2017-01-19', NULL, '921 Christy Heights Suite 859\nEast Gwentown, HI 78707-7172', 'Kadin Murray', '415-966-0045', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(107, 'Dr. Jordan Zulauf IV', 'Female', '1974-12-05', 'https://via.placeholder.com/640x480.png/001100?text=sed', '9242 Quitzon Pines Suite 836\nNew Destiney, MA 57831', 'Mr. Jordyn Boyle PhD', '+1-801-943-6051', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(108, 'Isabell Kuhic MD', 'Female', '1994-10-05', NULL, '1719 Brad Forges Apt. 601\nVincenzoberg, AZ 87431', 'Mr. Myron Funk I', '205-592-8659', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(109, 'Tiana Rutherford', 'Male', '1975-02-11', 'https://via.placeholder.com/640x480.png/00ff00?text=exercitationem', '667 Zena Stream\nWest Giannifurt, RI 37712', 'Dr. Camilla Kunze MD', '+1-502-387-9511', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(110, 'Noe Bechtelar', 'Male', '2023-06-06', NULL, '9417 Feest Isle Suite 563\nPort Brielleshire, VT 18674-4427', 'Larry Wehner', '1-240-619-9614', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(111, 'Garrison Cassin', 'Female', '1975-05-09', NULL, '256 Cassin Alley Suite 361\nDarenborough, ND 44977', 'Jasen Gusikowski', '503.719.5706', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(112, 'Mrs. Maida Bernier', 'Male', '2007-10-17', 'https://via.placeholder.com/640x480.png/00aacc?text=suscipit', '6845 Tomasa Alley\nKonopelskihaven, OH 91580-7965', 'Wilma Abbott MD', '(567) 932-6209', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(113, 'Leonora Gaylord', 'Male', '2023-02-01', 'https://via.placeholder.com/640x480.png/0099ee?text=quae', '40114 Brandt Camp Apt. 752\nEmoryborough, TX 07141', 'Cordia Renner', '763.431.2344', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(114, 'Unique Bruen', 'Male', '2008-11-26', 'https://via.placeholder.com/640x480.png/003377?text=minima', '776 Adella Glen\nNew Grantfurt, UT 76268-0436', 'Prof. Jamel Dietrich V', '+1.872.514.7233', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(115, 'Stephen Cummings', 'Male', '1987-05-15', 'https://via.placeholder.com/640x480.png/003377?text=non', '250 Janessa Island\nConsidinefurt, HI 24963-5956', 'Prof. Ron Marquardt IV', '(662) 885-4255', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(116, 'Mr. Bradly Lesch II', 'Female', '1977-11-26', NULL, '15839 Raven Throughway\nDuBuqueton, RI 74059-4172', 'Olen Bode', '(209) 673-3107', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(117, 'Fletcher Hammes DVM', 'Female', '2012-10-02', 'https://via.placeholder.com/640x480.png/00aa55?text=laboriosam', '4728 Herman Centers Suite 797\nToyberg, KS 76892', 'Jayde Breitenberg DVM', '+13019931982', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(118, 'Domenico Mueller', 'Female', '1985-09-13', 'https://via.placeholder.com/640x480.png/003366?text=facilis', '5188 Mya Motorway Apt. 741\nSwaniawskiport, WY 77433', 'Mr. Keven Ferry', '+1 (941) 936-2470', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(119, 'Forrest Russel', 'Female', '1988-01-31', 'https://via.placeholder.com/640x480.png/0099ee?text=repellendus', '8458 Johns Shoals Suite 774\nNew Caleighchester, WA 38224', 'Dane Ruecker', '+1-351-417-2985', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(120, 'Vella Schuppe', 'Female', '2005-07-16', NULL, '436 Powlowski Tunnel\nLake Teaganburgh, NY 79986', 'Toney Goodwin II', '(657) 644-4036', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(121, 'Tatum McDermott', 'Female', '1991-08-19', NULL, '10788 Alda Crescent\nPort Rosiechester, HI 18123', 'Fredrick Tremblay', '(678) 448-6752', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(122, 'Nigel Greenholt', 'Female', '1982-02-28', NULL, '76390 Ashlee Lane\nJenifermouth, NM 29909-1500', 'Garfield Gorczany', '1-434-914-6185', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(123, 'Alaina O\'Keefe', 'Female', '2008-03-29', NULL, '25257 Blick Station Apt. 076\nSchultzmouth, IN 94092', 'Jayda Sanford', '(541) 792-8434', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(124, 'Webster Koelpin DDS', 'Male', '1972-08-04', NULL, '706 Jermain Parkway Apt. 642\nAmayashire, UT 71394', 'Faye Pfannerstill', '(860) 345-5463', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(125, 'Prof. Rashawn Labadie', 'Male', '2014-06-04', 'https://via.placeholder.com/640x480.png/005599?text=veniam', '49778 Yadira Via\nWest Vallieborough, IL 75486-3272', 'Elyssa Wuckert', '725.513.8784', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(126, 'Amya Glover', 'Male', '1989-06-23', NULL, '58678 Barton Plains Suite 886\nSouth Lorine, WV 52567-2555', 'Alejandra Purdy', '+1-385-397-8780', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(127, 'Wilber Cartwright Jr.', 'Female', '1983-01-11', 'https://via.placeholder.com/640x480.png/008833?text=quos', '4130 Krajcik River\nWalshhaven, WA 98741', 'Dr. Kathlyn Wintheiser', '+1 (202) 371-9591', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(128, 'Prof. Ludie O\'Hara V', 'Female', '1970-09-10', NULL, '80912 Marguerite Square\nYundtport, OK 27480', 'Rashawn Hauck', '(520) 349-6353', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(129, 'Dr. Bartholome Bahringer III', 'Male', '1982-07-12', NULL, '964 Kaela Walk Apt. 333\nKingfurt, GA 91030-8548', 'Lyla Heller', '1-678-243-9846', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(130, 'Marilie Wiza', 'Male', '1997-11-30', 'https://via.placeholder.com/640x480.png/00cc33?text=quam', '14991 Rosalyn Lodge\nNorth Rosarioberg, WI 78673', 'Randi Tromp', '1-929-831-4715', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(131, 'Salvador O\'Conner', 'Female', '2023-11-04', 'https://via.placeholder.com/640x480.png/000011?text=ex', '4955 Braun Walk\nEast Lydashire, TN 58882-9118', 'Beau Considine', '+16782154389', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(132, 'Devin Gislason', 'Male', '2013-07-04', NULL, '379 Mante Lock Apt. 720\nEast Keenan, AL 47364', 'Prof. Armando Prosacco', '+12395924194', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(133, 'Hettie Fadel', 'Female', '2019-09-11', 'https://via.placeholder.com/640x480.png/003311?text=sit', '7619 Sporer Views Apt. 249\nNew Josiechester, MT 66755-7149', 'Reilly Russel', '+1-937-869-2625', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(134, 'Mrs. Lacey Bashirian', 'Female', '1991-09-17', NULL, '2877 Lowe Motorway Apt. 765\nJeanville, VT 15812', 'Guadalupe Cummerata MD', '352-931-3940', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(135, 'Malcolm Mitchell', 'Male', '1985-11-28', NULL, '16128 Fabiola Tunnel Suite 124\nOrtizberg, WI 12365', 'Chelsey Von Sr.', '+1.973.373.9756', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(136, 'Miss Elisha Bergstrom', 'Female', '2023-07-01', 'https://via.placeholder.com/640x480.png/005577?text=ex', '672 Loma Manors\nEast Jeanneburgh, AZ 54536-9486', 'Prof. Roscoe Bergstrom', '952-759-7187', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(137, 'Josefina Frami', 'Male', '1970-07-19', 'https://via.placeholder.com/640x480.png/006699?text=praesentium', '791 Dickinson Fields Suite 273\nNew Norbertmouth, OR 14575-9760', 'Miss Lavada Mraz V', '+1.947.647.6887', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(138, 'Terrence Cummerata DDS', 'Female', '1982-12-31', 'https://via.placeholder.com/640x480.png/00dd88?text=non', '6979 Graham Loaf Suite 289\nNorth Evalynchester, MI 06877', 'Dixie Cartwright', '+1-423-950-1422', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(139, 'Mckenna Konopelski', 'Female', '2007-12-05', NULL, '4893 Toy Hill\nPort Kayli, DE 63127', 'Edison Dooley', '1-440-446-9159', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(140, 'Cassidy Frami', 'Female', '2002-12-05', NULL, '876 Kilback Centers Suite 564\nRettashire, WA 38320', 'Ms. Emmie Jerde Jr.', '+1 (408) 557-7389', '2025-05-02 13:48:42', '2025-05-02 13:48:42');

-- --------------------------------------------------------

--
-- Table structure for table `child_health_records`
--

CREATE TABLE `child_health_records` (
  `recordID` bigint(20) UNSIGNED NOT NULL,
  `childID` bigint(20) UNSIGNED NOT NULL,
  `healthWorkerID` bigint(20) UNSIGNED NOT NULL,
  `checkupDate` date NOT NULL,
  `height` double NOT NULL,
  `weight` double NOT NULL,
  `vaccination` varchar(255) NOT NULL,
  `diagnosis` text NOT NULL,
  `treatment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `child_health_records`
--

INSERT INTO `child_health_records` (`recordID`, `childID`, `healthWorkerID`, `checkupDate`, `height`, `weight`, `vaccination`, `diagnosis`, `treatment`, `created_at`, `updated_at`) VALUES
(1, 81, 51, '2023-03-30', 74.59, 32.71, 'eum', 'Quisquam minus cum at ut deleniti dicta in.', 'Cumque quis natus impedit similique exercitationem. Inventore voluptatem aut eos velit. Minima eos voluptas consectetur. Tenetur repudiandae suscipit corrupti officiis repellendus.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(2, 82, 52, '1992-09-23', 82.36, 2.71, 'repellat', 'Sunt amet repellendus deserunt consequatur consequatur.', 'Explicabo harum quo voluptatibus tenetur quia voluptatem. Non totam ut iste rem. Dolorum deleniti voluptas magnam ex soluta autem deleniti.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(3, 83, 53, '2005-11-27', 82.32, 10.28, 'a', 'Magnam libero doloremque ex ut rerum totam.', 'Culpa ut odit harum doloremque. Facere dolor fuga itaque minus eveniet quis. Eos id sed nihil maxime. Maxime ad aliquid dolorem numquam modi quo animi.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(4, 84, 54, '1973-02-14', 121.41, 18.76, 'quo', 'Voluptate quas voluptate nisi.', 'Molestiae accusamus nihil voluptates perspiciatis fuga consequatur. Et et dolorum nulla quod modi eligendi. Vel omnis voluptates id consequatur et rerum.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(5, 85, 55, '1973-06-01', 96.93, 37.63, 'esse', 'Hic consectetur nihil rem adipisci.', 'Animi inventore quis nihil qui. Qui qui autem eaque autem. Eum et cumque fuga omnis distinctio tempore. Asperiores iusto odio assumenda iure iusto.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(6, 86, 56, '2011-08-08', 143.71, 34.23, 'quia', 'Aut eligendi suscipit est adipisci.', 'Aut sint porro beatae odio. Aperiam aut esse cupiditate eveniet laboriosam. Rem molestiae ullam ut vitae tempore in. Accusamus dolore aut nobis quis cumque dolorum.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(7, 87, 57, '1975-10-12', 126.38, 16.19, 'adipisci', 'Deserunt quia est iste accusantium nostrum minus commodi natus.', 'Perspiciatis itaque nisi id. Nobis est minus veniam repudiandae sed culpa. Molestiae quibusdam voluptatem unde distinctio non non ea. Commodi et quo esse libero assumenda libero.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(8, 88, 58, '1970-06-02', 94.52, 24.54, 'corporis', 'Cupiditate accusamus corrupti et velit velit in qui.', 'Velit illo deleniti libero eaque. Dolorum atque incidunt sit aut neque ad.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(9, 89, 59, '2003-09-20', 96.83, 35.95, 'vitae', 'Dolor tenetur itaque sunt dolores iste.', 'Odit et eum itaque laborum id expedita. Et illum ut quae eaque unde et unde nihil. Eum quam excepturi vel autem voluptatum blanditiis.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(10, 90, 60, '1995-05-27', 133.65, 33.93, 'et', 'Ut sequi nulla iusto qui ut numquam laboriosam nihil.', 'Cumque et dolores at veniam. Voluptatem modi facere optio ut necessitatibus laborum. Nostrum reiciendis quia et enim totam. Ut assumenda est repudiandae eum tempore vero.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(11, 91, 61, '2020-07-18', 134.34, 24.34, 'sint', 'Quos rerum officia ipsa aut ab.', 'Quisquam molestiae voluptatibus nostrum quia. Voluptate voluptatibus aut hic omnis. Temporibus officia delectus inventore recusandae commodi.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(12, 92, 62, '1982-12-17', 131.53, 26.92, 'quam', 'Et aut eius laudantium optio aut id enim.', 'Fugiat eos facere totam consequatur similique velit est. Enim sed aut dolor in natus consequuntur. Autem dolores vel illo ut aut.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(13, 93, 63, '1973-08-02', 114.19, 33.74, 'minima', 'Maxime odit sit doloribus expedita quo.', 'Illum ut ut sequi labore fugit. Nihil ut vero necessitatibus error nisi. Ab eaque a incidunt quidem et dolore dolorum ipsa. Rerum eveniet rerum sed aut neque qui.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(14, 94, 64, '2012-05-29', 77.57, 45.65, 'ut', 'Sed qui et autem sed.', 'Impedit quis dignissimos est nulla sunt. Qui non est est quasi blanditiis eum quos alias.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(15, 95, 65, '1974-09-11', 101.28, 21.65, 'asperiores', 'Non ipsum ullam cum ipsa aliquam illo consectetur nesciunt.', 'Reprehenderit deleniti dolores odio quibusdam. Eaque porro repellendus omnis minima nostrum rem. Dolores adipisci assumenda eligendi voluptas enim sint amet.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(16, 96, 66, '2019-06-30', 92.49, 17.78, 'velit', 'Cupiditate dignissimos id architecto maxime sunt.', 'Placeat architecto voluptatibus ut delectus repellat iusto. Voluptas nihil exercitationem voluptatum. Deserunt natus mollitia possimus non est quam.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(17, 97, 67, '1977-05-03', 115.44, 5.82, 'et', 'Aut qui ad autem odio et ad quae.', 'Sunt molestias nostrum vel molestiae est deserunt. Ut expedita omnis officia commodi. Aliquam perferendis minus qui.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(18, 98, 68, '1984-05-18', 107.26, 33.92, 'velit', 'Aut sint est voluptas voluptas illo.', 'Voluptas necessitatibus veritatis et reprehenderit explicabo mollitia dolor. Voluptas facilis nesciunt incidunt molestiae voluptatum. Odit laborum nemo consequuntur architecto libero distinctio non. Sit omnis sit qui quidem itaque adipisci sit quas.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(19, 99, 69, '2021-12-12', 93.59, 39.51, 'eveniet', 'Est impedit fugiat eligendi rem facilis.', 'Ratione sit et corrupti aut eligendi culpa in totam. Voluptas ut tempore autem est dolores. Et ab ut sapiente quam laboriosam voluptates excepturi. Est nemo omnis deleniti consequatur.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(20, 100, 70, '1970-05-08', 61.26, 49.45, 'amet', 'Libero recusandae qui quos necessitatibus suscipit voluptatem.', 'Ipsam dicta et voluptatem. Non consequatur officiis ratione sit. Similique nisi animi rerum dolorem sint natus architecto asperiores.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(21, 101, 71, '2004-11-02', 100.09, 14.31, 'laboriosam', 'Omnis eum voluptatum a dolorum doloremque reiciendis.', 'Tempore similique porro odio explicabo voluptatem. Quia in quibusdam molestias deserunt. Voluptatem id non doloribus assumenda.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(22, 102, 72, '1977-03-26', 98.37, 23.24, 'eaque', 'Deserunt accusantium corrupti alias unde modi ab.', 'Reprehenderit perferendis voluptatem ab praesentium nostrum tempora at sapiente. Tenetur autem sunt sed sit autem. Ut aut dolor animi ut nemo qui. Earum optio quo qui libero aut hic neque. Vitae voluptatum dolorem sed repellat.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(23, 103, 73, '1981-05-19', 119.6, 20.56, 'ratione', 'Non autem aut et recusandae facere praesentium.', 'Fugiat quia ullam qui molestiae architecto deserunt distinctio. Quia harum perferendis exercitationem numquam omnis. Quo rerum ipsum dicta possimus rerum perspiciatis.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(24, 104, 74, '2021-12-18', 104.77, 21.82, 'ipsam', 'Consequatur commodi rem aliquid.', 'Ratione dolores officiis quia. Deleniti exercitationem dolorum eius animi. Est fugiat itaque accusantium voluptas aliquid. Soluta animi dolores sed excepturi incidunt ut. Assumenda omnis impedit culpa ut reiciendis.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(25, 105, 75, '1997-04-12', 115.5, 37.86, 'voluptatem', 'Labore quasi et commodi dignissimos.', 'Nulla ab recusandae voluptatum architecto aut maiores. Commodi commodi accusamus aut enim dicta eius sint. Rem sunt ab dolores ut ducimus quo quis.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(26, 106, 76, '1987-01-10', 124.67, 30.95, 'non', 'Repudiandae et aliquid sit atque dolores consequatur expedita.', 'Est magni totam soluta harum numquam. Quaerat dignissimos sed modi ratione totam consequatur at. Possimus eum nam cum voluptatibus. Libero est ea reprehenderit voluptatibus quia rerum pariatur.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(27, 107, 77, '1979-05-29', 67.25, 45.89, 'pariatur', 'Molestiae et minus earum eveniet sed est.', 'Rem doloremque delectus aut placeat autem. Deleniti odio est sequi aperiam omnis quisquam provident. Nam eius modi dicta tempore architecto. Autem aut doloribus cupiditate quam et voluptatem.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(28, 108, 78, '1971-06-23', 76.75, 44.03, 'repudiandae', 'Facere voluptatem est amet itaque voluptas.', 'Placeat accusamus molestiae culpa. Est itaque nulla autem. Doloremque ullam iure veritatis possimus. Omnis qui fugiat expedita quo cum.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(29, 109, 79, '1982-04-10', 136.95, 5.67, 'temporibus', 'Voluptatem tempora et possimus non nesciunt iste.', 'Quis doloremque adipisci in et nam eum. Repellendus vitae porro quasi quas incidunt sed et est. Rem dolores dolorem occaecati rerum quia. Sunt non culpa aspernatur nobis culpa voluptates qui.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(30, 110, 80, '2002-10-13', 88.88, 12.75, 'unde', 'Blanditiis rerum assumenda reprehenderit perferendis.', 'Incidunt ut labore iure ut est veniam. Ut expedita libero nam quasi excepturi corporis vitae. Ea facilis dolorem quia error officia cumque consectetur illum. Ut officiis corrupti labore sunt dolores hic magnam rerum. Nobis cumque repellendus velit ratione officiis sed voluptas.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(31, 111, 81, '1973-12-08', 58.5, 3.67, 'dolores', 'Illo eum dignissimos molestiae.', 'Voluptas tenetur nihil ut nihil sunt hic. Sit architecto ut blanditiis molestiae earum. Vitae et temporibus eius magni dolorum et. Repudiandae quo ipsum velit.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(32, 112, 82, '1993-06-18', 147.46, 7.54, 'aliquam', 'Non iusto quia quo voluptatibus ea culpa consectetur.', 'Est ullam explicabo quis quas dolorem aut enim est. Voluptas unde blanditiis sint debitis ut.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(33, 113, 83, '2017-05-03', 52.92, 44.16, 'aut', 'Quod voluptatum beatae praesentium.', 'Tenetur molestiae veritatis quia ipsum amet dolore velit quo. Quae consequatur voluptatibus sint officia consequatur mollitia.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(34, 114, 84, '1997-03-24', 89.4, 26.71, 'deleniti', 'Eos qui ea reiciendis vel consequuntur.', 'Odit illo expedita nihil delectus officia provident mollitia. Sunt consequuntur qui est molestias. Dolorem odit et quia dolorem iusto et et. Rem nisi debitis enim nesciunt.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(35, 115, 85, '2000-05-04', 130.01, 34.91, 'pariatur', 'Harum doloremque consectetur in sequi.', 'Et harum quisquam sint nemo quia qui. Impedit asperiores doloribus quia dolor eius dolor quam. Quasi rerum ut officiis sunt et nihil alias. Consequatur tempora qui et accusamus.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(36, 116, 86, '1980-04-22', 108.16, 31.53, 'aut', 'Velit voluptate commodi molestiae dolores.', 'Unde doloribus velit provident vitae doloremque facere. Consequatur similique natus qui nulla voluptatem exercitationem ad. Fuga sit repellendus sed fuga consequuntur. Quia dolorum repellat nostrum.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(37, 117, 87, '2009-10-14', 119.55, 39.55, 'rerum', 'Quam et distinctio et.', 'Est odit voluptas soluta cumque sit natus odio cupiditate. Eligendi sit repellat totam itaque quia ipsum. Deleniti in qui omnis id maxime neque sequi.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(38, 118, 88, '1987-01-04', 68.63, 36.42, 'nostrum', 'Ex sint deleniti maxime doloremque officia.', 'Blanditiis rerum culpa illo temporibus quasi ut libero. Sequi eaque deleniti culpa id commodi earum facere. Corporis ab rerum et quidem. Ducimus perspiciatis cumque eaque assumenda voluptate cum nemo.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(39, 119, 89, '2009-06-04', 90.2, 35.4, 'cumque', 'Facere aperiam possimus eum modi quia et et dolorum.', 'Facilis nihil dicta ut veniam ex iste. Nulla ut voluptate illum rerum similique quidem adipisci optio. Eaque id est praesentium et eaque dolor natus ut.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(40, 120, 90, '1992-03-05', 99.78, 40.17, 'aliquam', 'Voluptatem quas illo ipsa fugiat aut voluptas.', 'Corporis in esse nihil aut. Voluptatum similique est nemo. Iusto illo iure eum reprehenderit et aut.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(41, 121, 91, '1971-10-04', 148.9, 25.05, 'dolor', 'Aut deleniti exercitationem et dolores quaerat.', 'Reprehenderit omnis similique est cupiditate pariatur. Autem nulla dolorem corrupti cum ea accusantium itaque neque. Reprehenderit sed et consectetur quia eaque. Debitis enim laborum cum magnam voluptatum deleniti.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(42, 122, 92, '1988-06-02', 142.25, 8.82, 'eum', 'Sunt beatae optio ullam culpa odit libero placeat.', 'Nostrum porro similique possimus non qui. Enim dolor mollitia optio consequuntur quos nihil explicabo. Minus fuga ipsam iste libero autem aliquam.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(43, 123, 93, '2020-02-05', 56.24, 11.61, 'voluptatum', 'Sed accusantium minus voluptas ipsam.', 'Aliquid rerum sunt minus esse consequatur nisi. Eos in et non sunt repellendus est. Commodi et eum eaque laborum repellat.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(44, 124, 94, '2003-05-11', 69.1, 44.94, 'ad', 'Tempore aut ducimus reprehenderit quia sequi qui unde a.', 'Nisi consequatur consequatur quo sit placeat placeat nesciunt blanditiis. Atque ut rerum iste commodi illo quo optio. Quis deleniti sed sequi voluptates. Optio nihil eligendi minus non aspernatur totam est.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(45, 125, 95, '1981-01-06', 148.27, 19.89, 'et', 'Quo voluptates fugit asperiores possimus commodi minus sit quos.', 'Atque officiis harum fugiat veritatis ea et explicabo vitae. Quia inventore beatae adipisci. Dolorem laudantium ullam consequatur aliquid.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(46, 126, 96, '2003-11-12', 70.08, 26.91, 'deleniti', 'Tempora explicabo corrupti quo ut.', 'Molestiae voluptas porro corporis sit aut. Officia iusto quam facere dolorem quidem dolore qui. Error vero est repellat amet quos. Nihil quasi iure dolorem sed nobis.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(47, 127, 97, '1998-05-06', 71.05, 3.44, 'totam', 'Ullam ex ut repudiandae nam molestiae placeat et.', 'Velit consequatur a ab tenetur in quos a. Ut debitis illo velit. Et sed ex recusandae quisquam eius delectus corporis. Optio excepturi quos adipisci voluptatum vitae similique.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(48, 128, 98, '1977-07-27', 87.69, 7.43, 'maiores', 'Optio ipsa quaerat atque tenetur quia dignissimos dolores.', 'Perferendis quis accusantium neque ut et nobis. Repellendus dolores laboriosam provident. Laboriosam et maxime optio qui amet eius hic.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(50, 130, 100, '2010-05-21', 62.36, 31.48, 'mollitia', 'Pariatur hic accusantium qui voluptatem.', 'Deserunt sed dignissimos molestias repellendus illum. Soluta doloremque nisi ut nam dicta ut et voluptatem. Dolorum nostrum laborum beatae eum soluta facilis.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(51, 131, 101, '2007-12-23', 103.03, 4.75, 'ab', 'Eum itaque libero consequatur quia nam.', 'Quo in earum accusantium fuga velit ratione. Nihil molestiae a earum ratione. Cupiditate similique velit soluta amet perferendis tempora.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(52, 132, 102, '1974-08-01', 51.08, 8.49, 'nostrum', 'Repellendus ex dignissimos voluptate eum.', 'Eum magni dolorem ut voluptates quos. Dolores eum consequatur eveniet ut quos ullam. Commodi tempore voluptates eaque dolore maxime perspiciatis quaerat.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(53, 133, 103, '2001-08-01', 99.92, 16.37, 'ut', 'Unde enim aut est est nihil dolores sint.', 'Ipsum ratione est consequatur vitae ullam quia natus vel. Dicta molestiae tempora voluptatem voluptate. Et non provident dolorum magni labore.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(54, 134, 104, '1974-05-05', 73.4, 47.18, 'rerum', 'Rerum in amet culpa.', 'Et et similique fugit quisquam est delectus in. Dignissimos iste cumque labore earum ipsam et. Sed accusamus facere ut adipisci adipisci hic.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(55, 135, 105, '2021-04-22', 94.3, 21.1, 'dolores', 'Dolore occaecati in animi consequatur consequatur non cumque delectus.', 'Soluta eos itaque ut. In omnis occaecati dolores eaque incidunt. Non aperiam exercitationem pariatur voluptatum doloribus voluptatem et.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(56, 136, 106, '2008-11-29', 74.58, 32.99, 'ut', 'Reprehenderit mollitia ut est maiores non aut.', 'Ut molestiae ullam tempore est soluta id. Perferendis dolore iure rem dolorem nostrum. Non dolores non sit explicabo et ullam est. Ut nostrum ea perferendis et hic dignissimos omnis.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(57, 137, 107, '1994-12-13', 72.42, 38.11, 'aut', 'Inventore est tenetur nesciunt officiis dicta.', 'Aut dicta cumque nisi ut. Maiores earum est vel tempora nemo perspiciatis. Aut sequi voluptates aut eum quas. Illum porro amet ullam velit nihil facilis dolores impedit.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(58, 138, 108, '2008-06-04', 78.04, 30.8, 'quia', 'Quia nostrum eveniet unde.', 'Sed consequatur voluptas quo maiores totam et. Odio qui corporis voluptatem eum. Eligendi dolor eveniet odit quod perspiciatis optio.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(60, 140, 110, '1972-08-18', 128.94, 16.19, 'omnis', 'Quisquam qui molestiae et beatae non.', 'Qui sint excepturi magnam iure iste totam. Voluptatem maxime expedita dolor unde atque ut facere. Et vel alias harum velit ratione libero consequuntur et.', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(61, 1, 10, '2025-05-04', 120.5, 30.2, 'Polio', 'Healthy', 'None', '2025-05-04 10:57:57', '2025-05-04 10:57:57'),
(62, 60, 10, '2025-05-04', 120.5, 30.2, 'Polio', 'Healthy', 'None', '2025-05-04 11:02:35', '2025-05-04 11:02:35'),
(63, 60, 10, '2025-05-04', 120.5, 30.2, 'Polio', 'Healthy', 'None', '2025-05-04 11:03:20', '2025-05-04 11:03:20'),
(64, 1, 10, '2025-05-04', 120.5, 30.2, 'Polio', 'Healthy', 'None', '2025-05-04 11:14:10', '2025-05-04 11:14:10');

-- --------------------------------------------------------

--
-- Table structure for table `health_restrictions`
--

CREATE TABLE `health_restrictions` (
  `hrID` bigint(20) UNSIGNED NOT NULL,
  `recordID` bigint(20) UNSIGNED NOT NULL,
  `description` text NOT NULL,
  `severity` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `health_restrictions`
--

INSERT INTO `health_restrictions` (`hrID`, `recordID`, `description`, `severity`, `created_at`, `updated_at`) VALUES
(1, 31, 'Omnis eos labore velit ducimus.', 'Severe', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(2, 32, 'Quo molestiae repudiandae quibusdam nihil hic id.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(3, 33, 'Vel nostrum odio et enim voluptates hic ab.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(4, 34, 'Eveniet sunt itaque sit quis optio alias.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(5, 35, 'Fuga non pariatur at dolor.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(6, 36, 'In et quo voluptatum recusandae.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(7, 37, 'Quibusdam quidem hic reiciendis minus libero molestiae.', 'Moderate', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(8, 38, 'Quos sint earum quas quod.', 'Severe', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(9, 39, 'Ut quae consequatur a qui amet magni.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(10, 40, 'Autem culpa in ex est facere placeat aliquid.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(11, 41, 'Et qui adipisci odit autem voluptatem.', 'Moderate', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(12, 42, 'Distinctio rerum culpa et velit ipsum soluta maiores.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(13, 43, 'Quo iste esse non quia cupiditate.', 'Severe', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(14, 44, 'Est et est id.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(15, 45, 'Error nemo iste tenetur non fugit incidunt vitae.', 'Severe', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(16, 46, 'Hic porro quia repellendus molestiae ipsam suscipit.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(17, 47, 'Et dignissimos voluptatem magni aperiam.', 'Severe', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(18, 48, 'Dignissimos ea impedit dolorum et sint pariatur.', 'Severe', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(20, 50, 'Qui illum est ea ipsum.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(21, 51, 'Recusandae reprehenderit aut excepturi ut quo accusantium.', 'Severe', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(22, 52, 'Praesentium modi qui quisquam.', 'Moderate', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(23, 53, 'Tempora maiores quam dolore tempore tempore error.', 'Moderate', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(24, 54, 'Ullam iste voluptas aut aut excepturi voluptas.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(25, 55, 'Iure animi nihil assumenda pariatur neque.', 'Moderate', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(26, 56, 'Explicabo et ut dolores alias.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(27, 57, 'Et porro quod voluptatem suscipit.', 'Mild', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(28, 58, 'Et quis iure vero tempora qui ea qui.', 'Severe', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(30, 60, 'Odit veniam quo dolor.', 'Moderate', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(31, 1, 'No strenuous activity', 'Moderate', '2025-05-04 18:19:31', '2025-05-04 18:19:31'),
(32, 1, 'No strenuous activity', 'Moderate', '2025-05-04 18:19:48', '2025-05-04 18:19:48'),
(33, 1, 'No strenuous activity', 'Moderate', '2025-05-04 18:20:25', '2025-05-04 18:20:25'),
(34, 1, 'No strenuous activity', 'Moderate', '2025-05-04 18:20:41', '2025-05-04 18:20:41'),
(35, 1, 'No strenuous activity', 'Moderate', '2025-05-04 18:21:12', '2025-05-04 18:21:12'),
(36, 1, 'No strenuous activity', 'Moderate', '2025-05-04 18:22:18', '2025-05-04 18:22:18'),
(37, 1, 'No strenuous activity', 'Moderate', '2025-05-15 13:56:59', '2025-05-15 13:56:59'),
(38, 1, 'No strenuous activity', 'Moderate', '2025-05-15 14:01:00', '2025-05-15 14:01:00'),
(39, 1, 'No strenuous activity', 'Moderate', '2025-05-15 14:01:10', '2025-05-15 14:01:10');

-- --------------------------------------------------------

--
-- Table structure for table `health_workers`
--

CREATE TABLE `health_workers` (
  `hwID` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `role` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `cadID` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `health_workers`
--

INSERT INTO `health_workers` (`hwID`, `name`, `gender`, `dob`, `role`, `telephone`, `email`, `image`, `address`, `cadID`, `created_at`, `updated_at`) VALUES
(2, 'Jado Fils Salim', 'Male', '1999-03-25', 'Admin', '+250727210121', 'salim@gmail.net', 'images/SlYhGqSGjpQq98sZzPuhFmbbBGzKIE0eRSRK86f9.jpg', 'Kn  Kigali Landing Suite 622 gasabo, OR 44257', 78, '2025-05-02 13:48:41', '2025-05-26 09:32:36'),
(3, 'Etha Millers', 'Male', '1986-09-13', 'Director Of Social Media Marketing', '1-770-250-8546', 'asia36@example.net', 'https://via.placeholder.com/640x480.png/009977?text=dolores', '5776 Quigley Knoll\nBartonside, AR 17843-3060', 23, '2025-05-02 13:48:41', '2025-05-19 13:47:35'),
(4, 'Mr. Frank Donnelly II', 'Female', '1973-12-09', 'Spraying Machine Operator', '+1 (640) 275-1426', 'kvon@example.org', 'https://via.placeholder.com/640x480.png/003399?text=nesciunt', '523 Napoleon Route Apt. 171\nLake Sharon, NJ 44298', 24, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(5, 'Mrs. Beth Treutel', 'Male', '2008-03-22', 'Patrol Officer', '720-222-5061', 'rippin.deborah@example.com', 'https://via.placeholder.com/640x480.png/0044aa?text=tempora', '39505 Cummings Ridge Apt. 802\nViolettechester, MT 04463', 2, '2025-05-02 13:48:41', '2025-05-19 11:26:27'),
(6, 'Ms. Tanya Jenkins I', 'Female', '1987-02-03', 'Gauger', '1-601-493-8152', 'iquigley@example.org', 'https://via.placeholder.com/640x480.png/000099?text=incidunt', '86711 Osinski Springs\nLake Modesto, IN 35272', 26, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(7, 'Stephany Wolf', 'Male', '1991-09-29', 'Police and Sheriffs Patrol Officer', '+1.256.419.1158', 'vlowe@example.org', 'https://via.placeholder.com/640x480.png/002244?text=et', '79003 Howe Pines\nMadisenfurt, MA 34065', 27, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(8, 'Mireille Strosin DDS', 'Male', '2022-06-18', 'Personnel Recruiter', '754-534-0460', 'tillman.tate@example.net', 'https://via.placeholder.com/640x480.png/00cc55?text=et', '7371 Harris Path\nNew Joshport, SC 31777', 28, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(9, 'Mr. Lexus Boyle', 'Female', '2024-08-30', 'Broadcast Technician', '+1-941-506-1632', 'swaniawski.roberta@example.net', 'https://via.placeholder.com/640x480.png/003355?text=error', '12196 Efren Brooks Apt. 771\nEast Willow, RI 24287', 29, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(10, 'Mrs. Alexandria Sipes', 'Female', '1974-09-27', 'Solderer', '443.241.1023', 'duncan.pfannerstill@example.com', 'https://via.placeholder.com/640x480.png/00bb88?text=qui', '176 Simonis Brooks Apt. 080\nSouth Nathenville, KY 62918-3968', 30, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(11, 'Mrs. Antonina Feeney', 'Male', '1989-07-14', 'Social Sciences Teacher', '+1 (606) 570-4279', 'pouros.karine@example.net', 'https://via.placeholder.com/640x480.png/00eecc?text=voluptatem', '74589 Name Ville Suite 324\nHellerburgh, OK 83185-3488', 31, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(12, 'Parker Kemmer', 'Male', '2022-11-17', 'Command Control Center Officer', '+1-804-700-7868', 'beryl99@example.net', 'https://via.placeholder.com/640x480.png/0066bb?text=quae', '11045 Celestine Hollow Apt. 026\nAnitatown, TN 84203-9537', 32, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(13, 'Alysa Lynch', 'Male', '1987-09-02', 'Financial Specialist', '+1-617-645-4745', 'bblock@example.net', 'https://via.placeholder.com/640x480.png/00aaee?text=qui', '72662 Zane Roads\nMitchellstad, NM 04241-6870', 33, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(14, 'Joey Hettinger', 'Male', '1983-11-15', 'Steel Worker', '+1-662-781-6359', 'keeley32@example.org', 'https://via.placeholder.com/640x480.png/006611?text=architecto', '7748 Grady Crossroad Suite 363\nLake Vernerside, IN 49113', 34, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(15, 'Prof. Kody Pacocha Jr.', 'Female', '2018-08-31', 'Substation Maintenance', '+1-564-837-6073', 'maurine09@example.com', 'https://via.placeholder.com/640x480.png/0011ff?text=ut', '69960 Rogers Road Suite 888\nNew Keven, CT 19015-4962', 35, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(16, 'Josh Champlin', 'Male', '2006-01-31', 'Obstetrician', '323.827.4838', 'xbrekke@example.com', 'https://via.placeholder.com/640x480.png/007777?text=soluta', '540 Armstrong Neck Suite 862\nEast Amari, LA 58431-6147', 36, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(17, 'Erika Cruickshank', 'Female', '2009-08-18', 'Brickmason', '+1 (279) 937-3428', 'elouise12@example.com', 'https://via.placeholder.com/640x480.png/00ffcc?text=asperiores', '33652 Genoveva Road\nVonRuedenhaven, WV 67489', 37, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(18, 'Polly Schaefer MD', 'Female', '1989-03-09', 'Postmasters', '1-813-684-8394', 'jennifer.lueilwitz@example.org', 'https://via.placeholder.com/640x480.png/008844?text=esse', '2180 Lakin Roads\nLake Elza, OR 43106-2117', 38, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(19, 'Prof. Lamont Wilderman', 'Female', '2016-06-30', 'Paving Equipment Operator', '1-747-213-8252', 'lavonne.heaney@example.com', 'https://via.placeholder.com/640x480.png/0088ff?text=officiis', '72855 Heidenreich Place Suite 382\nStanleymouth, OR 92070', 39, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(20, 'Mr. Frederick Crooks PhD', 'Female', '2018-05-20', 'Chef', '507-967-6928', 'zetta72@example.com', 'https://via.placeholder.com/640x480.png/00aadd?text=et', '3822 Lawrence Lakes\nSouth Alexandria, VA 20150', 40, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(21, 'Erica Kling', 'Female', '1989-07-12', 'Transit Police OR Railroad Police', '775-731-5796', 'leffler.candelario@example.com', 'https://via.placeholder.com/640x480.png/00ff99?text=fuga', '85233 Percival Track\nEast Schuylerchester, IN 12011-9225', 41, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(22, 'Aryanna Howe', 'Female', '2021-02-21', 'Electro-Mechanical Technician', '986-987-3792', 'buckridge.alysa@example.org', 'https://via.placeholder.com/640x480.png/001155?text=nam', '15801 Howell Rapid Apt. 540\nDennisside, NE 91604', 42, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(23, 'Ludie Weimann', 'Male', '2001-01-07', 'Maintenance Worker', '224-953-5353', 'eusebio.schultz@example.com', 'https://via.placeholder.com/640x480.png/0099ff?text=aut', '3048 Gislason Wall Suite 149\nNorth Arnaldoside, TN 99509', 43, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(24, 'Dr. Elian Russel', 'Male', '1979-12-19', 'Dishwasher', '+17544056432', 'leone.kreiger@example.net', 'https://via.placeholder.com/640x480.png/004499?text=nemo', '99527 Alfonzo Causeway Suite 532\nSouth Marcelo, NM 57193', 44, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(25, 'Augustine Schaden', 'Female', '2019-01-07', 'Space Sciences Teacher', '984.944.8794', 'micheal82@example.net', 'https://via.placeholder.com/640x480.png/002200?text=dolores', '10406 Lonnie Pass Apt. 799\nKristinfort, VA 77151', 45, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(26, 'Betty Pouros', 'Female', '1973-03-16', 'Insulation Worker', '307.557.2536', 'delmer75@example.net', 'https://via.placeholder.com/640x480.png/000022?text=blanditiis', '6906 Camren Run Suite 442\nWest Isabellestad, WY 88838', 46, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(27, 'Kenny Dibbert Sr.', 'Male', '1994-05-06', 'Stone Sawyer', '419-746-4217', 'ismith@example.com', 'https://via.placeholder.com/640x480.png/0033dd?text=eveniet', '5844 Delmer Ferry Apt. 006\nLeifmouth, WI 94012', 47, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(28, 'Delphine Daugherty', 'Female', '1973-11-10', 'Precision Etcher and Engraver', '(901) 770-6110', 'nico70@example.net', 'https://via.placeholder.com/640x480.png/00ddbb?text=eius', '7552 Santino Alley Suite 961\nEast Audrey, IL 18689-6974', 48, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(29, 'Monserrate Streich', 'Male', '2003-01-23', 'Aircraft Engine Specialist', '+1-385-418-4584', 'bauch.margaretta@example.org', 'https://via.placeholder.com/640x480.png/00ff88?text=ipsam', '132 Jennyfer Pass\nWeberfurt, NH 85281', 49, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(30, 'Gabriel Hermann', 'Male', '1990-10-24', 'Nuclear Equipment Operation Technician', '214-546-9281', 'laurence.will@example.org', 'https://via.placeholder.com/640x480.png/0099cc?text=quas', '25594 Della Lake Suite 956\nSouth Milton, VA 15690-2394', 50, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(31, 'May Kemmer', 'Female', '2021-09-18', 'Tour Guide', '(262) 849-2583', 'ebony47@example.net', 'https://via.placeholder.com/640x480.png/00ff11?text=eos', '519 Rutherford Track Apt. 045\nNorth Lavon, NY 87966-0617', 51, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(32, 'Eugenia Tromp Jr.', 'Male', '1982-11-19', 'Steel Worker', '817.844.4870', 'reggie64@example.net', 'https://via.placeholder.com/640x480.png/0044ee?text=dolor', '52440 Mertz Valley Suite 331\nPacochamouth, NH 47367-0888', 52, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(33, 'Bernita Mayert', 'Female', '1981-11-30', 'Account Manager', '+1 (765) 850-3990', 'keven.predovic@example.net', 'https://via.placeholder.com/640x480.png/0044ee?text=cum', '2570 Ondricka Mount\nLake Ashly, IN 55461-5020', 53, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(34, 'Carolyne Beier IV', 'Male', '1990-11-28', 'Musician OR Singer', '+1-770-999-3294', 'keon20@example.com', 'https://via.placeholder.com/640x480.png/0088aa?text=qui', '34663 Reinhold Trail Suite 871\nNew Baileemouth, OK 97181', 54, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(35, 'Effie Zieme', 'Female', '2019-06-30', 'Plant and System Operator', '+1.785.842.4843', 'mlynch@example.net', 'https://via.placeholder.com/640x480.png/0044ff?text=consequatur', '650 Carlee Bridge\nNew Ernesto, NV 90682-2147', 55, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(36, 'Sonia Conroy', 'Female', '2020-12-26', 'Locomotive Firer', '(351) 475-6923', 'simone71@example.com', 'https://via.placeholder.com/640x480.png/007777?text=necessitatibus', '533 Alfonzo Bridge Apt. 152\nWalkertown, CT 61482', 56, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(37, 'Mrs. Pascale Borer', 'Female', '1977-06-02', 'Secondary School Teacher', '+14587438368', 'liza73@example.org', 'https://via.placeholder.com/640x480.png/008877?text=laudantium', '3076 Torp Streets Suite 520\nNew Alexandre, CO 01697-4825', 57, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(38, 'Mrs. Danielle Franecki III', 'Female', '2017-01-30', 'Postsecondary Education Administrators', '+17065982683', 'thuels@example.org', 'https://via.placeholder.com/640x480.png/00ccee?text=aperiam', '357 Ledner Square\nSouth Justinamouth, SC 20682-5236', 58, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(39, 'Ms. Nedra King', 'Male', '1979-11-18', 'Composer', '(615) 667-8983', 'christy97@example.net', 'https://via.placeholder.com/640x480.png/009988?text=porro', '587 Nakia Mall\nPort Bridgette, NE 27193', 59, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(40, 'Mr. Keshawn Pfannerstill III', 'Female', '2015-11-21', 'Precision Aircraft Systems Assemblers', '+1-479-844-0660', 'heaney.mack@example.com', 'https://via.placeholder.com/640x480.png/007766?text=sed', '588 Santina Plaza\nCurtton, KS 00437', 60, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(41, 'Prof. Bernardo Wintheiser III', 'Male', '2010-08-08', 'Farmer', '1-747-273-8279', 'yoshiko87@example.com', 'https://via.placeholder.com/640x480.png/009988?text=accusantium', '4076 Abernathy Row Suite 954\nNorth Janaside, NC 05206', 61, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(42, 'Alejandra Jakubowski', 'Female', '2017-11-08', 'Glass Cutting Machine Operator', '609.268.9044', 'wehner.dan@example.net', 'https://via.placeholder.com/640x480.png/003377?text=quo', '9980 Jazmyne Trail Suite 072\nNorth Fernando, DC 44375', 62, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(43, 'Dr. Lionel Wehner', 'Male', '2013-07-10', 'Choreographer', '(520) 330-3115', 'feil.reginald@example.net', 'https://via.placeholder.com/640x480.png/0044ff?text=fugit', '42021 Leonardo Club\nAngieside, MS 56089', 63, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(44, 'Gaylord Leuschke', 'Female', '1992-12-15', 'Detective', '+13084418039', 'legros.gladyce@example.org', 'https://via.placeholder.com/640x480.png/00ccbb?text=reprehenderit', '3443 Lowell Wells\nNicklausstad, SD 07961', 64, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(45, 'Elisabeth Schoen', 'Male', '1984-05-05', 'Psychologist', '1-660-655-2616', 'oceane.greenfelder@example.org', 'https://via.placeholder.com/640x480.png/000022?text=et', '25920 Granville Course\nHyattfort, MS 17066', 65, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(46, 'Mr. Coby Connelly II', 'Male', '1977-05-29', 'Receptionist and Information Clerk', '341.703.8767', 'bernard.gaylord@example.org', 'https://via.placeholder.com/640x480.png/005577?text=assumenda', '97077 Destinee Loaf\nNatmouth, RI 74263-5217', 66, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(47, 'Camryn Hartmann', 'Male', '1991-12-31', 'Webmaster', '972.927.7017', 'jackeline00@example.org', 'https://via.placeholder.com/640x480.png/00ff22?text=fugit', '216 Alphonso Corners Apt. 253\nEast Ricofort, MA 32426', 67, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(48, 'Prof. Jack Mayert', 'Female', '2017-04-03', 'Central Office and PBX Installers', '(228) 495-6233', 'agleason@example.net', 'https://via.placeholder.com/640x480.png/000000?text=voluptates', '7119 Allen Ridge Suite 669\nMadieland, UT 91561-7032', 68, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(49, 'Dr. Kathryne Kuhn', 'Male', '2003-10-29', 'Letterpress Setters Operator', '+1.719.509.9773', 'delta59@example.net', 'https://via.placeholder.com/640x480.png/0088ff?text=rerum', '16091 Yost Trail Suite 347\nNew Raphael, TX 89702', 69, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(50, 'Laila Jakubowski', 'Male', '1973-08-31', 'Career Counselor', '+1.608.300.3711', 'karlee27@example.com', 'https://via.placeholder.com/640x480.png/004411?text=exercitationem', '32286 Beahan Trail\nGregoriahaven, UT 90983', 70, '2025-05-02 13:48:41', '2025-05-02 13:48:41'),
(51, 'Zack Tillman', 'Male', '1987-05-06', 'Landscaping', '(775) 657-1396', 'lee48@example.net', 'https://via.placeholder.com/640x480.png/008899?text=rem', '255 Herzog Path Suite 189\nPort Rickiechester, SD 13328-8921', 71, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(52, 'Jo McGlynn I', 'Male', '1970-12-13', 'Creative Writer', '+1.541.819.3343', 'cummings.edd@example.org', 'https://via.placeholder.com/640x480.png/00cc11?text=rem', '83981 Ali Shores\nSouth Hesterstad, FL 13116-1423', 72, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(53, 'Mr. Rodrigo Prosacco', 'Male', '2007-12-03', 'Security Systems Installer OR Fire Alarm Systems Installer', '+15745819605', 'harber.hector@example.net', 'https://via.placeholder.com/640x480.png/0033aa?text=rem', '323 Reagan Crossing\nNew Susie, WV 09801', 73, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(54, 'Prof. Franco Halvorson IV', 'Female', '2000-12-01', 'Personal Financial Advisor', '(870) 943-0656', 'abdullah.mitchell@example.org', 'https://via.placeholder.com/640x480.png/0088aa?text=ratione', '95213 Jett Crossroad Apt. 655\nPort Mireyaborough, AK 46116-4893', 74, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(55, 'Dr. Tyree Langosh II', 'Male', '2005-04-15', 'Set and Exhibit Designer', '1-307-906-3924', 'adriana.fay@example.net', 'https://via.placeholder.com/640x480.png/006633?text=fugit', '22100 O\'Reilly Roads\nSouth Michelle, MN 58887-3648', 75, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(56, 'Mrs. Hanna Hoeger Jr.', 'Female', '1984-11-02', 'Host and Hostess', '+1-810-340-5154', 'pmann@example.org', 'https://via.placeholder.com/640x480.png/002233?text=mollitia', '842 Arvid Bridge\nHubertside, MN 73083', 76, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(57, 'Dr. Deangelo Doyle I', 'Male', '1987-11-17', 'Human Resources Assistant', '743-920-6375', 'sheila43@example.com', 'https://via.placeholder.com/640x480.png/0077aa?text=magnam', '6970 Kuhic Terrace Apt. 964\nPort Paulburgh, ND 38504', 77, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(58, 'Miss Susanna Schultz', 'Female', '1972-10-24', 'Reporters OR Correspondent', '+1 (743) 363-4049', 'wfarrell@example.com', 'https://via.placeholder.com/640x480.png/00ee88?text=et', '309 Gutmann Mountain Suite 069\nBrandybury, WY 70257', 78, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(59, 'Jaylon Schroeder III', 'Female', '1991-12-05', 'Lathe Operator', '1-386-998-7022', 'ramona49@example.net', 'https://via.placeholder.com/640x480.png/00ffcc?text=veritatis', '3434 Williamson Neck Apt. 706\nLake Gayleburgh, WV 78024', 79, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(60, 'Mrs. Laney Miller', 'Male', '1998-11-19', 'Lodging Manager', '+1.662.886.0752', 'vbashirian@example.net', 'https://via.placeholder.com/640x480.png/00aa88?text=quia', '9265 Lura Fields\nBatzchester, MI 54099', 80, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(61, 'Herminia Abshire', 'Female', '1978-10-19', 'Medical Transcriptionist', '1-385-856-7819', 'wyman.gaylord@example.com', 'https://via.placeholder.com/640x480.png/001100?text=sed', '13697 Ansel Wells Suite 791\nWest Cheyanne, AL 57519', 81, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(62, 'Ulises Stoltenberg', 'Female', '1993-03-11', 'Licensed Practical Nurse', '(325) 780-3615', 'nova84@example.net', 'https://via.placeholder.com/640x480.png/00aa55?text=eveniet', '9692 Predovic Cliff\nWest Raleigh, SC 66116', 82, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(63, 'Cary Conroy', 'Male', '1984-10-25', 'Annealing Machine Operator', '(253) 550-1147', 'vmertz@example.com', 'https://via.placeholder.com/640x480.png/00aaee?text=reiciendis', '6967 Aylin Harbor Suite 729\nTimothyton, NV 72935', 83, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(64, 'Ms. Retha Nikolaus', 'Female', '1999-02-22', 'Writer OR Author', '1-716-536-4650', 'mcclure.maegan@example.net', 'https://via.placeholder.com/640x480.png/0022ff?text=vero', '27265 Erich Land\nPort Elvisfurt, TN 94522-9327', 84, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(65, 'Prof. Marilie Gulgowski', 'Male', '1981-07-05', 'Prosthodontist', '+16167284009', 'ternser@example.org', 'https://via.placeholder.com/640x480.png/0077ff?text=placeat', '8385 Conn Lock\nEast Corineburgh, MI 34944', 85, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(66, 'Prof. Jenifer Hauck', 'Male', '2008-03-08', 'Visual Designer', '1-325-754-9799', 'corkery.edmond@example.net', 'https://via.placeholder.com/640x480.png/00ff22?text=hic', '5492 Cleta Prairie\nNew Rylan, NY 30650', 86, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(67, 'Gage Reynolds', 'Female', '1980-07-21', 'Fraud Investigator', '412-210-8330', 'torey66@example.net', 'https://via.placeholder.com/640x480.png/00bb33?text=libero', '1490 Ernser Mission Apt. 003\nLake Jayda, GA 12511', 87, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(68, 'Osvaldo Hane', 'Male', '2000-02-19', 'Retail Salesperson', '331.576.3693', 'kpollich@example.net', 'https://via.placeholder.com/640x480.png/0088aa?text=vel', '98955 Rudy Route Suite 529\nMitchellmouth, WA 27182-0504', 88, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(69, 'Jett Borer', 'Male', '1978-11-27', 'Forest Fire Inspector', '947.983.5367', 'gvonrueden@example.com', 'https://via.placeholder.com/640x480.png/0022cc?text=illo', '51206 Morissette Mission Suite 702\nNorth Giovannyfort, IL 37669-3700', 89, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(70, 'Coleman Braun', 'Male', '1973-02-28', 'Legal Secretary', '1-770-977-6263', 'vergie.orn@example.net', 'https://via.placeholder.com/640x480.png/009999?text=quibusdam', '333 Streich Street\nEast Kelvin, KS 97305', 90, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(71, 'Germaine Weber DDS', 'Male', '1980-02-13', 'Lifeguard', '1-347-707-8523', 'awiza@example.org', 'https://via.placeholder.com/640x480.png/00aa55?text=vitae', '11303 Moshe Roads\nLebsackmouth, TN 98209-8856', 91, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(72, 'Shyanne Strosin', 'Female', '1997-09-17', 'Electrical Engineering Technician', '+1.972.820.1649', 'hilpert.vickie@example.org', 'https://via.placeholder.com/640x480.png/009900?text=possimus', '53860 Schumm Viaduct Apt. 073\nKulasfurt, VA 33995', 92, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(73, 'Evan Russel', 'Male', '1981-08-19', 'Auditor', '+14703797333', 'halvorson.evangeline@example.org', 'https://via.placeholder.com/640x480.png/0066ff?text=impedit', '36630 Renee Trail\nJohnpaulbury, UT 00367-8699', 93, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(74, 'Mrs. Candida Sauer', 'Female', '1991-04-02', 'Child Care Worker', '925.709.0383', 'cary.mayer@example.net', 'https://via.placeholder.com/640x480.png/00aa99?text=sint', '68961 Ruecker Pike Suite 409\nPenelopemouth, DE 28247', 94, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(75, 'Mylene McGlynn', 'Male', '2005-03-14', 'Product Management Leader', '(903) 556-0292', 'nichole73@example.org', 'https://via.placeholder.com/640x480.png/004466?text=omnis', '99277 Araceli Wall\nMichaelport, WA 52009-7869', 95, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(76, 'Rosella Nikolaus', 'Male', '1980-01-31', 'Military Officer', '+1-424-936-0060', 'lkris@example.com', 'https://via.placeholder.com/640x480.png/00ee66?text=asperiores', '984 Goyette Coves\nSpinkaville, TN 46272-4485', 96, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(77, 'Prof. Nedra Emard', 'Female', '1971-07-26', 'Geologist', '+1 (470) 961-0045', 'odell82@example.com', 'https://via.placeholder.com/640x480.png/00eeaa?text=in', '4461 Madelynn Alley\nSchmitttown, KS 74860-1295', 97, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(78, 'Greyson Bailey', 'Male', '1978-01-17', 'Staff Psychologist', '+18203754891', 'nader.taylor@example.com', 'https://via.placeholder.com/640x480.png/006677?text=nesciunt', '756 Ratke Streets Suite 943\nWest Toy, MA 59729', 98, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(79, 'Dorcas Stark', 'Male', '2013-09-30', 'Soil Scientist', '(360) 220-1479', 'idella.romaguera@example.net', 'https://via.placeholder.com/640x480.png/0088ee?text=illo', '4845 Braun View Apt. 408\nMitchellland, GA 54162-9093', 99, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(80, 'Gunner Doyle PhD', 'Female', '1989-07-08', 'Nuclear Engineer', '+1.505.533.1657', 'vschuppe@example.org', 'https://via.placeholder.com/640x480.png/00aadd?text=eum', '9168 Gutkowski Crossing\nKeeblerview, KY 54319-8384', 100, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(81, 'Leonora Abshire', 'Female', '1990-12-10', 'Nuclear Monitoring Technician', '(716) 224-7269', 'lelah.ratke@example.com', 'https://via.placeholder.com/640x480.png/0033dd?text=tenetur', '89566 Kathleen Course\nSouth Owen, OR 98085', 101, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(82, 'Elijah Moen MD', 'Female', '2018-12-14', 'Human Resource Manager', '346-684-8136', 'irwin.koepp@example.com', 'https://via.placeholder.com/640x480.png/00cc77?text=molestias', '64608 Claude Prairie\nHerzogside, WV 48474-0947', 102, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(83, 'Diego Collier DVM', 'Female', '1992-03-21', 'Mechanical Door Repairer', '440.210.1012', 'wbarton@example.com', 'https://via.placeholder.com/640x480.png/00aa66?text=similique', '2166 Runolfsdottir Fall Apt. 158\nLake Emmaberg, KY 74460-0024', 103, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(84, 'Emmanuel Ward', 'Female', '1998-04-06', 'Broadcast Technician', '+1-515-659-7201', 'missouri73@example.net', 'https://via.placeholder.com/640x480.png/0066cc?text=optio', '493 Rogahn Meadows\nTrompborough, UT 13945-2423', 104, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(85, 'Dr. Willa Gutkowski', 'Female', '1986-02-25', 'Anthropologist', '+1 (915) 545-9934', 'pedro.mckenzie@example.net', 'https://via.placeholder.com/640x480.png/00aa00?text=aut', '51154 Conn Spurs\nSouth Blairport, DE 97426', 105, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(86, 'Treva Kilback', 'Male', '2015-05-18', 'Sociologist', '(239) 425-4930', 'darren.kreiger@example.org', 'https://via.placeholder.com/640x480.png/00aaee?text=et', '2054 Schaden Lodge\nRobelfort, MD 32898-5106', 106, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(87, 'Hudson Abernathy', 'Female', '2018-03-03', 'Compensation and Benefits Manager', '254-718-3779', 'dana.weber@example.com', 'https://via.placeholder.com/640x480.png/00bb11?text=perspiciatis', '482 Buckridge Drive Apt. 047\nNorth Alfredo, NV 75704', 107, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(88, 'Nella Barton', 'Female', '1991-12-11', 'Registered Nurse', '+18484913252', 'bernard23@example.org', 'https://via.placeholder.com/640x480.png/004499?text=totam', '525 Freeman Forges Apt. 125\nKuhicbury, DC 73245', 108, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(89, 'Prudence Grimes V', 'Female', '1997-01-24', 'Welding Machine Tender', '+1-937-562-4911', 'crona.dixie@example.net', 'https://via.placeholder.com/640x480.png/00ccbb?text=velit', '6772 Ruecker Fall\nEstevanchester, AR 63243-0617', 109, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(90, 'Patience Hahn', 'Female', '1977-02-10', 'Music Director', '858.229.4471', 'ookuneva@example.org', 'https://via.placeholder.com/640x480.png/004422?text=rerum', '5848 Morar Street Suite 201\nMrazport, NJ 23238', 110, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(91, 'Alaina Corkery', 'Male', '1982-01-04', 'Rigger', '937.522.5370', 'warren.olson@example.com', 'https://via.placeholder.com/640x480.png/002288?text=hic', '13716 Frank Stravenue Suite 712\nGoyettestad, AK 32391-5525', 111, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(92, 'Otha Ondricka', 'Female', '1984-10-09', 'Roof Bolters Mining', '308-700-3907', 'fay.medhurst@example.net', 'https://via.placeholder.com/640x480.png/0066dd?text=rerum', '86415 Erich Rapid Suite 537\nNigeltown, MS 80337-4128', 112, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(93, 'Prof. Zakary Grady', 'Male', '1986-10-27', 'Adjustment Clerk', '252-763-4814', 'cole.parker@example.com', 'https://via.placeholder.com/640x480.png/009955?text=qui', '2767 Goldner Trail Suite 123\nCourtneyside, LA 66575-3749', 113, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(94, 'Mrs. Elfrieda Harris V', 'Male', '1971-06-02', 'Motorboat Mechanic', '1-669-996-0488', 'bayer.burdette@example.net', 'https://via.placeholder.com/640x480.png/002233?text=et', '12542 Mueller Stream Apt. 857\nWest Erickamouth, LA 10149', 114, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(95, 'Eduardo Smith', 'Female', '2018-04-21', 'Host and Hostess', '+19595878357', 'reichel.brandt@example.com', 'https://via.placeholder.com/640x480.png/0033aa?text=nihil', '1623 Hudson Via\nKobyhaven, MO 86858-6111', 115, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(96, 'Alan Effertz', 'Female', '2011-12-23', 'Protective Service Worker', '+1-725-394-1476', 'catherine48@example.net', 'https://via.placeholder.com/640x480.png/005500?text=quisquam', '683 Dejah Park Suite 025\nPabloville, OH 72396-2499', 116, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(97, 'Alexia', 'Male', '1978-06-21', 'Physician', '987-654-3210', 'alexia@gmail.com', 'https://via.placeholder.com/640x480.png/00aacc?text=error', '9592 Koss Spurs\nMarianebury, MI 48513-0398', 117, '2025-05-02 13:48:42', '2025-05-02 17:47:53'),
(98, 'Adam Hane', 'Male', '1975-01-10', 'Real Estate Sales Agent', '+1 (657) 699-4324', 'pbraun@example.net', 'https://via.placeholder.com/640x480.png/007755?text=optio', '7410 Reynolds Spur\nNew Emelyland, TN 67622-5109', 118, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(100, 'Katrina Gottlieb', 'Male', '2000-12-24', 'Physician', '+1.757.870.9844', 'vfay@example.org', 'https://via.placeholder.com/640x480.png/0022bb?text=voluptatibus', '924 Herzog Island\nBeierland, MN 68753', 120, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(101, 'Ralph Kerluke', 'Female', '2012-08-14', 'Millwright', '1-952-400-9473', 'cfriesen@example.net', 'https://via.placeholder.com/640x480.png/00ee77?text=quia', '3191 Coty Cliff Suite 674\nEast Kayli, MS 66699-7917', 121, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(102, 'Adeline Kerluke', 'Male', '2004-03-18', 'Skin Care Specialist', '+16316511264', 'janick70@example.net', 'https://via.placeholder.com/640x480.png/005555?text=fuga', '9322 Gulgowski Stravenue Apt. 296\nWest Laylafort, MN 92012-9940', 122, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(103, 'Chris O\'Hara', 'Male', '2006-03-03', 'Recreation and Fitness Studies Teacher', '1-954-421-7816', 'lydia77@example.net', 'https://via.placeholder.com/640x480.png/00ee66?text=illo', '649 O\'Keefe Tunnel Suite 788\nRaushire, NE 65131-3707', 123, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(104, 'Kenyon Turcotte II', 'Male', '2002-10-18', 'Glass Cutting Machine Operator', '+1 (505) 280-2090', 'white.amos@example.org', 'https://via.placeholder.com/640x480.png/008800?text=quasi', '2097 Oberbrunner Harbors Apt. 449\nNorth Ahmed, NH 17527-7688', 124, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(105, 'Jordan Olson', 'Female', '1973-12-10', 'Transit Police OR Railroad Police', '(657) 837-7003', 'chadd76@example.org', 'https://via.placeholder.com/640x480.png/001100?text=sed', '26886 O\'Connell Trail Apt. 902\nPort Estella, ID 40957', 125, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(106, 'Tad Prosacco', 'Male', '2002-02-14', 'Electrician', '231-968-2204', 'flo.schulist@example.net', 'https://via.placeholder.com/640x480.png/0044bb?text=et', '8606 Armando Trace Apt. 300\nWest Cassidyside, NM 22003', 126, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(107, 'Mr. Coty O\'Keefe DDS', 'Female', '2019-01-24', 'Ambulance Driver', '213.672.0471', 'domenico25@example.net', 'https://via.placeholder.com/640x480.png/0033aa?text=quis', '613 Marks Union\nForrestchester, NH 25547-4609', 127, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(108, 'Mr. Brody Goldner I', 'Male', '1984-05-09', 'Teller', '+1.234.547.0381', 'josefina.metz@example.org', 'https://via.placeholder.com/640x480.png/0066dd?text=iusto', '92669 Philip Crossing Suite 237\nSimonischester, NH 61532-1549', 128, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(109, 'Dr. Leonel Kemmer DVM', 'Male', '1994-11-19', 'Materials Scientist', '+1-505-750-2975', 'laurel49@example.org', 'https://via.placeholder.com/640x480.png/00bb88?text=ipsa', '28307 Eden Village Apt. 063\nReillystad, RI 55817', 129, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(110, 'Dr. Emmanuel Zieme II', 'Female', '2002-12-28', 'Industrial Production Manager', '(254) 584-6426', 'durward.pacocha@example.net', 'https://via.placeholder.com/640x480.png/002200?text=aut', '61737 Mike Lodge\nLake Shanna, VA 38726-8832', 130, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(111, 'Zaria Langosh', 'Female', '2002-09-13', 'Slot Key Person', '+1.580.648.2513', 'yrohan@example.com', 'https://via.placeholder.com/640x480.png/000011?text=pariatur', '3765 Danika Freeway Suite 323\nPort Noah, MI 00872', 156, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(112, 'Amos Konopelski', 'Male', '2001-10-26', 'Aircraft Engine Specialist', '+1-828-410-8612', 'gusikowski.green@example.com', 'https://via.placeholder.com/640x480.png/009988?text=pariatur', '434 Koelpin Prairie\nNew Stewart, SC 89769-2998', 158, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(113, 'Prof. Arlo Kunze', 'Female', '2003-10-20', 'Home Appliance Repairer', '(847) 481-8107', 'carroll.geo@example.net', 'https://via.placeholder.com/640x480.png/008866?text=laboriosam', '49183 Ernesto Springs Apt. 522\nNew Cayla, NH 87527-4031', 160, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(114, 'Cassidy Gulgowski', 'Male', '2001-10-29', 'Casting Machine Operator', '+1 (325) 316-3334', 'ngoodwin@example.org', 'https://via.placeholder.com/640x480.png/0000cc?text=sit', '7535 Abernathy Inlet Apt. 333\nKovacekborough, NV 50686', 162, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(115, 'Dr. Macie Zulauf', 'Male', '1990-08-22', 'Compensation and Benefits Manager', '1-562-340-9860', 'kdavis@example.org', 'https://via.placeholder.com/640x480.png/0099dd?text=est', '84530 Lois Islands Suite 412\nJohathantown, MI 70983', 164, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(116, 'Linwood Klein III', 'Male', '2018-11-15', 'Photographic Developer', '+1-805-703-4828', 'ceasar09@example.net', 'https://via.placeholder.com/640x480.png/009977?text=commodi', '7525 Lilly Fork Apt. 284\nPort Lucioland, WA 60211', 166, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(117, 'Roscoe Dooley Sr.', 'Male', '2005-06-27', 'Real Estate Association Manager', '+19285136262', 'myundt@example.org', 'https://via.placeholder.com/640x480.png/00aa77?text=et', '8061 Weimann Pine Apt. 757\nMyahstad, WV 31736-1796', 168, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(118, 'Dr. Anastasia Roberts', 'Female', '1990-10-06', 'Textile Machine Operator', '+1.234.790.0697', 'norma.langworth@example.net', 'https://via.placeholder.com/640x480.png/003388?text=consequatur', '7952 Marcelo Vista Suite 999\nFraneckistad, GA 29927', 170, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(119, 'Mr. Franz Block I', 'Female', '1983-03-29', 'Gaming Service Worker', '+17855289519', 'becker.enos@example.org', 'https://via.placeholder.com/640x480.png/00dd55?text=deserunt', '24531 Martina Station Apt. 898\nKristoferhaven, WA 56687-3485', 172, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(120, 'Jewell Cronin', 'Female', '1983-11-07', 'Chemical Engineer', '1-757-831-7530', 'veum.king@example.com', 'https://via.placeholder.com/640x480.png/00aa88?text=ut', '8950 Schroeder Unions\nLake Milanshire, PA 54423', 174, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(121, 'Arthur Cassin', 'Male', '2009-11-14', 'Communications Teacher', '+1-318-531-9224', 'kmayer@example.org', 'https://via.placeholder.com/640x480.png/000099?text=cumque', '53415 Hermann Point Suite 102\nSchusterville, ME 97871-7612', 176, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(122, 'Van Ebert', 'Female', '2001-12-16', 'Metal Molding Operator', '838.986.2631', 'schmitt.emery@example.com', 'https://via.placeholder.com/640x480.png/001144?text=perspiciatis', '55561 McClure Common\nBorisberg, UT 54978', 178, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(123, 'Betsy Wuckert', 'Female', '1993-09-26', 'Philosophy and Religion Teacher', '870-534-7494', 'christiansen.javier@example.com', 'https://via.placeholder.com/640x480.png/002211?text=facilis', '7610 Marc Turnpike Apt. 446\nPort David, AK 75092', 180, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(124, 'Aglae Kuhn', 'Female', '1999-03-26', 'Farmworker', '262-295-5415', 'wkautzer@example.net', 'https://via.placeholder.com/640x480.png/00dddd?text=necessitatibus', '3018 Ernestina Ville Suite 534\nLake Damian, NC 46864', 182, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(125, 'Gregory Stanton MD', 'Female', '1980-03-04', 'Coremaking Machine Operator', '1-609-455-2337', 'jess38@example.org', 'https://via.placeholder.com/640x480.png/00ff55?text=et', '624 Haven Way Suite 321\nSouth Malachi, VT 65399-8331', 184, '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(126, 'Zelma Haley', 'Male', '2019-10-25', 'Business Development Manager', '941.999.9431', 'ernestine.crooks@example.org', 'https://via.placeholder.com/640x480.png/001122?text=doloremque', '401 Cecilia Station Suite 517\nSelinastad, FL 16261', 186, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(127, 'Ms. Kylee Stiedemann V', 'Female', '1993-10-22', 'Gaming Service Worker', '+19892509677', 'nadia00@example.com', 'https://via.placeholder.com/640x480.png/008822?text=sunt', '6013 Grady Crossroad\nNew Edison, PA 04403', 188, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(128, 'Elza Schimmel', 'Male', '2009-06-20', 'Aircraft Body Repairer', '+1.341.961.6182', 'rempel.earnestine@example.org', 'https://via.placeholder.com/640x480.png/00bbdd?text=sint', '96874 Keebler Viaduct\nZemlakville, KS 19198', 190, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(129, 'Mariana Wilkinson Sr.', 'Female', '2007-05-30', 'Legislator', '+1-847-400-0298', 'fbode@example.com', 'https://via.placeholder.com/640x480.png/0099ee?text=animi', '3101 Thurman Plaza\nWest Elizabethport, IA 47161-9381', 192, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(130, 'Karley Crona', 'Female', '2016-04-02', 'Physical Therapist', '+1 (717) 283-8728', 'joshuah78@example.org', 'https://via.placeholder.com/640x480.png/009999?text=aut', '6129 Williamson Neck\nLake Marty, DC 38396', 194, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(131, 'Prof. Lynn Schmidt', 'Male', '2000-01-20', 'Brake Machine Setter', '1-364-684-8344', 'kory59@example.org', 'https://via.placeholder.com/640x480.png/004466?text=consequatur', '92594 Gleason Oval Apt. 565\nWatersmouth, MS 11448', 196, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(132, 'Tomasa Bergstrom', 'Male', '1970-11-03', 'Electronic Masking System Operator', '346.896.2330', 'loraine54@example.com', 'https://via.placeholder.com/640x480.png/00bbbb?text=ipsum', '24249 Aliza Port Apt. 677\nWest Angelo, AR 97358-8978', 198, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(133, 'Dr. Neal Labadie', 'Male', '2001-07-28', 'Inspector', '1-539-446-2811', 'joshua55@example.com', 'https://via.placeholder.com/640x480.png/0044ff?text=officiis', '3392 Theodora Camp\nEast Lottie, WI 75721', 200, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(134, 'Mr. Trey Hauck V', 'Female', '1976-09-03', 'Engineer', '830-837-3114', 'bashirian.claud@example.net', 'https://via.placeholder.com/640x480.png/003399?text=omnis', '69134 Henriette River Apt. 576\nBauchview, AK 41897-8779', 202, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(135, 'Dr. Nils Terry V', 'Female', '2008-10-13', 'Explosives Expert', '+12769807105', 'tupton@example.org', 'https://via.placeholder.com/640x480.png/002244?text=at', '5950 Bartoletti Haven\nLilianland, NC 18083-1814', 204, '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(136, 'John Doe', 'Male', '1990-05-20', 'Nurse', '+250781234567', 'johndoe@example.com', 'https://example.com/images/johndoe.jpg', '123 Kigali Street, Rwanda', 1, '2025-05-02 15:55:58', '2025-05-02 15:55:58'),
(137, 'Frank ISHIMWE', 'Male', '1990-05-20', 'Nurse', '+76397829738', 'frank@ishimwe.com', 'https://example.com/images/johndoe.jpg', '123 Kigali Street, Rwanda', 10, '2025-05-02 16:06:33', '2025-05-02 16:06:33'),
(138, 'Musonera', 'Male', '1990-05-20', 'Nurse', '+7639829738', 'Musonera@ishimwe.com', 'https://example.com/images/johndoe.jpg', '123 Kigali Street, Rwanda', 10, '2025-05-02 16:07:01', '2025-05-02 16:07:01'),
(139, 'John Doe', 'Male', '1990-01-01', 'Nurse', '123-456-7890', 'john@example.com', NULL, '123 Main St, City, Country', 21, '2025-05-15 13:36:31', '2025-05-15 13:36:31'),
(140, 'UWIHANGANYE Marcel', 'Male', '1990-01-01', 'Nurse', '123-456-7898', 'marcel@gmail.com', NULL, '234 Main St, Kigali, Rwanda', 23, '2025-05-15 13:37:52', '2025-05-15 13:37:52'),
(141, 'UWIHANGANYE Edson', 'Male', '1990-01-01', 'Nurse', '123-456-7398', 'edson@gmail.com', NULL, '234 Main St, Kigali, Rwanda', 23, '2025-05-15 13:38:33', '2025-05-15 13:38:33'),
(142, 'JEdson', 'Male', '1990-01-01', 'Nurse', '343-456-7398', 'edson01@gmail.com', NULL, '234 Main St, Kigali, Rwanda', 1, '2025-05-15 13:39:15', '2025-05-15 13:39:15'),
(143, 'Jd Fils', 'Male', '2000-01-01', 'Doctor', '255-456-7398', 'jdfils@gmail.com', NULL, '890 Main St, Kigali, Rwanda', 1, '2025-05-15 13:39:52', '2025-05-15 13:39:52'),
(144, 'Jado Fils SEZIKEYE', 'Male', '1999-01-01', 'Admin', '1234-456-7398', 'jadofilsgeeksforcoding@gmail.com', NULL, '890 Main St, Kigali, Rwanda', 1, '2025-05-15 13:40:59', '2025-05-15 13:40:59'),
(145, 'Umugwaneza Sandrine', 'Female', '2002-03-23', 'Nurse', '2345-7632-7890', 'umugwaneza@sando.com', NULL, '123 KigaliSt, City, Country', 22, '2025-05-22 10:31:45', '2025-05-22 10:31:45');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_05_02_142843_create_cadres_table', 1),
(2, '2025_05_02_140559_create_health_workers_table', 2),
(3, '2025_05_02_143159_create_children_table', 3),
(4, '2025_05_02_142638_create_birth_properties_table', 4),
(5, '2025_05_02_142530_create_child_health_records_table', 5),
(6, '2025_05_02_142936_create_projects_table', 6),
(7, '2025_05_02_143039_create_project_assignments_table', 7),
(8, '2025_05_02_142741_create_health_restrictions_table', 8),
(9, '2025_05_02_174119_create_personal_access_tokens_table', 9),
(10, '2025_05_19_134113_create_cadre_health_worker_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `prjID` bigint(20) UNSIGNED NOT NULL,
  `cadID` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`prjID`, `cadID`, `name`, `description`, `startDate`, `endDate`, `status`, `created_at`, `updated_at`) VALUES
(1, 131, 'Quibusdam et a.', 'Harum facilis qui aut rem. Illo consequatur ad molestiae. Aut occaecati dolor facere. Ut cupiditate rerum fugit nihil tempora aut beatae.', '2011-02-11', '2019-08-05', 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(2, 132, 'Provident illo illum quod.', 'Maxime incidunt cum et nostrum suscipit. Qui voluptatem at nisi perspiciatis eveniet repellat magni. Deserunt odio perferendis vitae suscipit temporibus et.', '2012-08-13', '1974-04-30', 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(4, 134, 'Placeat eum dolore.', 'Aut rerum maxime et nemo assumenda. Ipsum fugit numquam id recusandae eligendi. Quod qui fugiat ut nihil in. Ex accusantium porro quisquam beatae sed facere.', '2006-08-02', NULL, 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(5, 135, 'Qui sunt distinctio.', 'Qui enim officia sed. Voluptatum quis provident qui qui. Sint aliquam libero beatae voluptatum. Ullam unde deleniti porro earum quibusdam aperiam. Nobis rerum sint cumque omnis sunt.', '2013-09-03', '1993-09-07', 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(6, 136, 'Dicta iusto est.', 'Alias autem nemo sapiente eius et. Veritatis aut illo nisi sit iure modi tenetur. Voluptas impedit iste et fugit cumque animi. Iure sapiente illum quos ea impedit officiis.', '1998-10-26', '2004-08-04', 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(7, 137, 'Quae illum quas ut.', 'Quia sed odio dolor minima non. Numquam similique sunt atque consequuntur. Corrupti expedita pariatur non facilis est voluptatum ratione.', '1977-05-06', '1989-11-15', 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(8, 138, 'Temporibus ab ullam.', 'Ipsa nihil maxime quisquam consequatur unde. Quas officia et consequatur aut modi. Labore ipsam dicta aspernatur ipsum odit. Quia voluptatem et sed commodi.', '1997-05-02', '1985-12-21', 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(9, 139, 'Atque numquam dolorem.', 'Debitis iste dolore nihil illum et recusandae nam modi. Natus atque odio quae ipsum voluptas provident. Nesciunt veritatis atque quia. Excepturi nihil dolores accusantium ex recusandae.', '1994-10-11', NULL, 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(10, 140, 'Quaerat soluta iusto.', 'Qui natus quia sed. Qui corrupti laborum sed. Officiis commodi officia tempore.', '1995-01-18', NULL, 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(11, 141, 'Possimus natus voluptatem nisi.', 'Ducimus sed sed et. Aut vitae soluta veniam et neque. Reprehenderit voluptatem ipsam similique corrupti perferendis exercitationem.', '1977-05-07', '2003-11-09', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(12, 142, 'Fuga dolores vero.', 'Corrupti et maxime ipsa in corporis. Dolor voluptatem provident maxime. Est libero ab placeat repudiandae enim excepturi. Quo id blanditiis quod qui laborum ut quam. Aliquid in sunt vitae architecto pariatur.', '1997-11-12', NULL, 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(13, 143, 'Pariatur sint molestias.', 'Reprehenderit corrupti sint dolore beatae est velit iure. Porro officia aut non dolore ut nulla repudiandae similique. Consequatur provident minus deserunt pariatur eos corrupti fugit.', '1972-04-01', NULL, 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(14, 144, 'Eius animi voluptatum.', 'Sit sit soluta similique ipsa quisquam. Odio consequatur optio tempore sapiente vel. Quas porro harum et ipsum possimus dolor.', '1975-05-27', NULL, 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(15, 145, 'Quisquam ad eos.', 'Natus sequi laborum expedita esse quaerat qui. Enim ratione aut omnis qui quod dolores. Sed neque qui impedit autem asperiores odit.', '1990-04-06', NULL, 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(16, 146, 'Quod labore cumque rerum.', 'Aut cupiditate placeat dolor voluptas repudiandae quos culpa. Provident rerum nisi sed eius dolor. Et quos non eos perferendis quod voluptates. Voluptatum assumenda explicabo totam qui assumenda.', '2015-05-15', '2020-10-02', 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(17, 147, 'Eveniet velit et.', 'Nesciunt neque aspernatur repellendus rem corporis. Earum non voluptatem aut unde cumque dolorum asperiores. Quidem sunt ipsam nihil adipisci aut. Vel quos animi iusto voluptate consequatur.', '1994-08-03', '2018-08-21', 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(18, 148, 'Veniam natus.', 'Optio ut dolorem non eaque eius. Rerum similique est itaque eos cum voluptates. Illum animi consequatur vel nulla. Aspernatur facilis qui repellendus et nemo.', '2014-05-05', '2003-03-01', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(19, 149, 'Provident laboriosam et.', 'Quis qui a quaerat cupiditate possimus recusandae excepturi. Tenetur ut tempore nam nobis possimus. Sed vel nostrum aut dignissimos ea facere assumenda. Autem aliquid quia tempore illum veritatis ut voluptatem nobis.', '1986-01-05', NULL, 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(20, 150, 'Ea mollitia autem.', 'Dolores veritatis ab repellat eaque ducimus. Et inventore consequuntur reiciendis quam libero sunt. Debitis culpa voluptas qui adipisci.', '1977-06-07', '2020-01-10', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(21, 151, 'In atque ut voluptates.', 'Laborum fugiat corporis fugiat libero cum. Ut iste aut voluptate et eos. Aliquam dolore aut et facere.', '2024-03-10', '2008-05-10', 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(22, 152, 'Ut eaque.', 'Nam et voluptates aperiam. Quia tempore inventore natus odio. Ratione id maxime ab beatae.', '2002-05-23', '2018-10-06', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(23, 153, 'Quis et magnam voluptatem corrupti.', 'Porro sed iusto neque harum laboriosam eum asperiores sint. Explicabo qui enim laboriosam exercitationem ut. Ipsum delectus necessitatibus totam fuga laboriosam quis impedit. Harum est in nostrum.', '1971-12-17', NULL, 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(24, 154, 'Iusto qui dolore.', 'Voluptatem eligendi labore facilis laborum. Id expedita molestiae ad consequatur officiis. Qui ea praesentium corporis sunt quidem aliquid suscipit. Rerum sit ipsam illum ducimus.', '2001-10-02', '2003-01-03', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(25, 155, 'Modi itaque et.', 'Corporis est molestiae et consequatur quo quos sit. Vel sint temporibus perferendis quasi animi. Et quam magnam consequatur qui dolores. Consequuntur similique nulla deserunt fugit.', '1990-08-28', '2020-12-13', 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(26, 157, 'Ipsam consequatur non.', 'Qui quia corrupti molestiae ipsam. In rerum autem voluptas nihil deleniti. Amet atque labore dolor vitae.', '1991-08-13', NULL, 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(27, 159, 'Et aliquid voluptatum veritatis.', 'Molestiae vel repudiandae distinctio cupiditate. Cumque quia eum dignissimos qui ab suscipit. Laboriosam libero rerum occaecati vero quia optio.', '1988-07-23', NULL, 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(28, 161, 'Rerum deserunt voluptas minima adipisci.', 'Aut numquam id a eos pariatur. Labore ut eius ea est tempora. Atque perspiciatis quis reprehenderit. Aut et quo aut vitae.', '2010-05-03', NULL, 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(29, 163, 'Et aut tenetur.', 'Autem est ducimus deserunt magni inventore autem error sit. Amet in nihil beatae vel delectus. Autem dolorem ut rem doloremque.', '2016-01-20', '2021-02-18', 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(30, 165, 'Sequi atque alias.', 'Quia illum labore error. Nam dolore ipsa expedita voluptatibus. Natus nihil esse minus quidem voluptatum non quas.', '2011-05-20', '1985-02-21', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(31, 167, 'Ducimus animi dolorum.', 'Quae ut sit et labore sapiente ipsum aut. Vel fugiat beatae et sequi. Magnam et non velit vel omnis suscipit.', '1998-12-29', NULL, 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(32, 169, 'Porro corrupti et ratione.', 'Inventore provident numquam fugiat placeat. Qui culpa reiciendis adipisci ut ea aut et occaecati. Vitae et nesciunt veniam non velit. In placeat aliquid ipsa veritatis sunt occaecati non.', '2003-10-08', '2005-06-02', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(33, 171, 'Et amet voluptatum.', 'Itaque incidunt aspernatur aliquid qui et inventore laudantium. Hic vel laborum aut. Necessitatibus reprehenderit rem aut nulla qui impedit.', '1999-12-06', '1992-01-19', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(34, 173, 'Atque non consequatur.', 'Magnam ea possimus sunt minus ut consequatur nobis. Ut cum necessitatibus magnam nulla eos exercitationem quia et. Ipsam reiciendis blanditiis rerum optio qui doloremque.', '2012-08-19', '1997-08-09', 'Ongoing', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(35, 175, 'Voluptates molestiae blanditiis velit quidem.', 'Explicabo amet ducimus aperiam omnis. Vel at minus fuga aut. Deserunt deleniti ipsam sed sunt voluptate ipsa dicta. Impedit odio necessitatibus harum quibusdam ipsa.', '2010-01-19', NULL, 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(36, 177, 'Cupiditate nihil sed consequatur.', 'Dolorem veritatis ea enim est. A maxime sit labore est sit eos. Quam omnis maiores dolorem voluptatibus sit vel beatae. Voluptas enim maxime aut sed in ut repellendus placeat.', '2010-11-12', NULL, 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(37, 179, 'Cupiditate et id.', 'Ut asperiores quia voluptas enim sapiente. Rerum vero ut ab molestias. Et et tempora quibusdam tenetur dolorem dolorem est.', '1994-12-24', NULL, 'Completed', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(38, 181, 'Deleniti consequatur ex laborum.', 'Autem itaque dolores voluptatem ea. Repellat facere quo quidem vero quis alias rerum. Repellendus sunt nihil ipsum exercitationem et tempora. Quia aperiam non saepe et qui placeat totam.', '1998-04-26', '1982-11-08', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(39, 183, 'Fugiat vitae cum repellat.', 'Eius qui atque ut. Incidunt neque quaerat autem similique adipisci quos. Quibusdam sed nihil debitis consequatur sequi.', '2011-12-10', '1992-06-21', 'Pending', '2025-05-02 13:48:42', '2025-05-02 13:48:42'),
(40, 185, 'Perferendis porro qui unde et.', 'Ea sed facere cum alias laboriosam error architecto. Quidem natus facere adipisci eum nihil sunt.', '1984-04-14', '1985-08-09', 'Ongoing', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(41, 187, 'Quam possimus quo assumenda.', 'Reprehenderit quod consequatur blanditiis laboriosam magnam quo cupiditate. Omnis possimus nobis et ducimus tempore. Laborum doloribus placeat qui nesciunt sit veniam.', '1979-01-06', NULL, 'Pending', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(42, 189, 'Rerum voluptates nisi.', 'Rerum adipisci dolorem eaque sint. Hic facere unde quis voluptatem quidem consequatur. Suscipit deserunt dolorum et minima dolor eius et.', '2012-05-20', NULL, 'Completed', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(43, 191, 'Quo corporis molestiae nesciunt.', 'Eum voluptate rerum quos. Dolor sit provident quo culpa ducimus. Magni ut saepe quos aliquid quam exercitationem in praesentium.', '2017-06-19', '1997-12-22', 'Completed', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(44, 193, 'Ea ipsam deserunt.', 'Vel est a excepturi exercitationem tempora veniam. Voluptatibus voluptas sit distinctio debitis et et deleniti. Non et et modi ut aut et. Totam excepturi enim earum iure voluptatum.', '1997-11-29', '1978-09-06', 'Completed', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(45, 195, 'Et odit blanditiis.', 'Ullam mollitia qui ab quae blanditiis delectus minima maxime. Eos maiores sit error omnis ut. Sit odio quaerat esse enim beatae. Asperiores voluptate delectus laudantium ut quam officiis natus ut. Molestias corrupti consequatur ea est sequi.', '1985-01-31', '1983-05-12', 'Completed', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(46, 197, 'Laboriosam id voluptas quia.', 'Aut id iure et recusandae quia pariatur ut. Ut quos velit ut aut ad fugiat id. Maxime necessitatibus molestiae perspiciatis et omnis. Dolores esse eos quo quidem vel.', '1984-01-01', '1975-08-15', 'Pending', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(47, 199, 'Delectus eaque voluptas.', 'Eveniet occaecati ut pariatur expedita dolorem ullam ea. Quasi praesentium harum autem qui facere et. Eum harum molestiae esse excepturi id quia deleniti.', '2018-12-05', NULL, 'Completed', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(48, 201, 'Aut enim rerum.', 'Officiis odio quos quibusdam aperiam id. Ea nihil autem nesciunt ut non. Eaque sequi voluptatem accusantium est tempore distinctio earum. Sapiente non adipisci assumenda nihil iure ea tempore odit.', '2002-03-20', '2012-03-18', 'Completed', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(49, 203, 'Soluta eligendi nihil voluptates.', 'Sapiente qui iure delectus incidunt est. Pariatur laboriosam quae rerum repellat distinctio. Expedita minus numquam odit voluptas excepturi rem explicabo. Voluptates voluptas quibusdam ea laudantium voluptatem dolorem iste rerum.', '1970-12-16', NULL, 'Ongoing', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(50, 205, 'Consequatur harum qui.', 'Voluptates voluptatum delectus aliquid adipisci voluptatem est. Velit dolores consequatur cum hic animi impedit. Molestiae cum unde facere iure nam. Modi molestiae consequatur quisquam non omnis.', '1985-05-12', '1973-04-30', 'Pending', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(51, 1, 'Project Alpha', 'This is a sample project.', '2025-05-01', '2025-06-01', 'ongoing', '2025-05-18 08:55:47', '2025-05-18 08:55:47'),
(52, 1, 'Updated Project Name', 'Updated description', '2025-06-01', '2025-07-01', 'completed', '2025-05-18 08:56:19', '2025-05-18 09:04:14');

-- --------------------------------------------------------

--
-- Table structure for table `project_assignments`
--

CREATE TABLE `project_assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hwID` bigint(20) UNSIGNED NOT NULL,
  `prjID` bigint(20) UNSIGNED NOT NULL,
  `assignedDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `role` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_assignments`
--

INSERT INTO `project_assignments` (`id`, `hwID`, `prjID`, `assignedDate`, `endDate`, `role`, `created_at`, `updated_at`) VALUES
(1, 5, 2, '2025-05-18', '2025-05-18', 'Admin', '2025-05-02 13:48:43', '2025-05-18 09:28:59'),
(2, 112, 27, '1996-06-12', NULL, 'Volunteer', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(3, 113, 28, '2001-04-27', NULL, 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(4, 114, 29, '1995-04-10', '2022-07-09', 'Volunteer', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(5, 115, 30, '1982-10-06', '2001-12-22', 'Volunteer', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(6, 116, 31, '2017-09-08', NULL, 'Coordinator', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(7, 117, 32, '2010-09-28', NULL, 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(8, 118, 33, '2019-06-18', '1973-05-14', 'Volunteer', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(9, 119, 34, '2010-09-21', '1982-08-15', 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(10, 120, 35, '2007-09-22', '1975-08-19', 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(11, 121, 36, '2011-10-03', '1979-12-17', 'Volunteer', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(12, 122, 37, '1983-08-26', '1973-01-08', 'Volunteer', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(13, 123, 38, '1970-10-26', NULL, 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(14, 124, 39, '2002-06-08', '1998-03-27', 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(15, 125, 40, '1992-09-06', '2002-01-19', 'Coordinator', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(16, 126, 41, '2004-10-26', '1981-09-17', 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(17, 127, 42, '1996-01-20', '2004-10-13', 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(18, 128, 43, '2019-04-11', NULL, 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(19, 129, 44, '2003-03-11', '2003-01-23', 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(20, 130, 45, '2006-12-21', '2021-10-22', 'Volunteer', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(21, 131, 46, '1973-10-08', NULL, 'Coordinator', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(22, 132, 47, '2024-01-02', NULL, 'Coordinator', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(23, 133, 48, '1977-06-22', NULL, 'Volunteer', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(24, 134, 49, '1974-12-31', NULL, 'Supervisor', '2025-05-02 13:48:43', '2025-05-02 13:48:43'),
(25, 135, 50, '1975-09-05', '2023-11-21', 'Coordinator', '2025-05-02 13:48:43', '2025-05-02 13:48:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `birth_properties`
--
ALTER TABLE `birth_properties`
  ADD PRIMARY KEY (`bID`),
  ADD UNIQUE KEY `birth_properties_childid_unique` (`childID`);

--
-- Indexes for table `cadres`
--
ALTER TABLE `cadres`
  ADD PRIMARY KEY (`cadID`);

--
-- Indexes for table `cadre_health_worker`
--
ALTER TABLE `cadre_health_worker`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cadre_health_worker_cadid_foreign` (`cadID`),
  ADD KEY `cadre_health_worker_hwid_foreign` (`hwID`);

--
-- Indexes for table `children`
--
ALTER TABLE `children`
  ADD PRIMARY KEY (`childID`);

--
-- Indexes for table `child_health_records`
--
ALTER TABLE `child_health_records`
  ADD PRIMARY KEY (`recordID`),
  ADD KEY `child_health_records_childid_foreign` (`childID`),
  ADD KEY `child_health_records_healthworkerid_foreign` (`healthWorkerID`);

--
-- Indexes for table `health_restrictions`
--
ALTER TABLE `health_restrictions`
  ADD PRIMARY KEY (`hrID`),
  ADD KEY `health_restrictions_recordid_foreign` (`recordID`);

--
-- Indexes for table `health_workers`
--
ALTER TABLE `health_workers`
  ADD PRIMARY KEY (`hwID`),
  ADD UNIQUE KEY `health_workers_telephone_unique` (`telephone`),
  ADD UNIQUE KEY `health_workers_email_unique` (`email`),
  ADD KEY `health_workers_cadreid_foreign` (`cadID`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`prjID`),
  ADD KEY `projects_cadid_foreign` (`cadID`);

--
-- Indexes for table `project_assignments`
--
ALTER TABLE `project_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_assignments_hwid_foreign` (`hwID`),
  ADD KEY `project_assignments_prjid_foreign` (`prjID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `birth_properties`
--
ALTER TABLE `birth_properties`
  MODIFY `bID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `cadres`
--
ALTER TABLE `cadres`
  MODIFY `cadID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;

--
-- AUTO_INCREMENT for table `cadre_health_worker`
--
ALTER TABLE `cadre_health_worker`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `children`
--
ALTER TABLE `children`
  MODIFY `childID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `child_health_records`
--
ALTER TABLE `child_health_records`
  MODIFY `recordID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `health_restrictions`
--
ALTER TABLE `health_restrictions`
  MODIFY `hrID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `health_workers`
--
ALTER TABLE `health_workers`
  MODIFY `hwID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `prjID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `project_assignments`
--
ALTER TABLE `project_assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `birth_properties`
--
ALTER TABLE `birth_properties`
  ADD CONSTRAINT `birth_properties_childid_foreign` FOREIGN KEY (`childID`) REFERENCES `children` (`childID`) ON DELETE CASCADE;

--
-- Constraints for table `cadre_health_worker`
--
ALTER TABLE `cadre_health_worker`
  ADD CONSTRAINT `cadre_health_worker_cadid_foreign` FOREIGN KEY (`cadID`) REFERENCES `cadres` (`cadID`) ON DELETE CASCADE,
  ADD CONSTRAINT `cadre_health_worker_hwid_foreign` FOREIGN KEY (`hwID`) REFERENCES `health_workers` (`hwID`) ON DELETE CASCADE;

--
-- Constraints for table `child_health_records`
--
ALTER TABLE `child_health_records`
  ADD CONSTRAINT `child_health_records_childid_foreign` FOREIGN KEY (`childID`) REFERENCES `children` (`childID`) ON DELETE CASCADE,
  ADD CONSTRAINT `child_health_records_healthworkerid_foreign` FOREIGN KEY (`healthWorkerID`) REFERENCES `health_workers` (`hwID`) ON DELETE CASCADE;

--
-- Constraints for table `health_restrictions`
--
ALTER TABLE `health_restrictions`
  ADD CONSTRAINT `health_restrictions_recordid_foreign` FOREIGN KEY (`recordID`) REFERENCES `child_health_records` (`recordID`) ON DELETE CASCADE;

--
-- Constraints for table `health_workers`
--
ALTER TABLE `health_workers`
  ADD CONSTRAINT `health_workers_cadreid_foreign` FOREIGN KEY (`cadID`) REFERENCES `cadres` (`cadID`) ON DELETE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_cadid_foreign` FOREIGN KEY (`cadID`) REFERENCES `cadres` (`cadID`) ON DELETE CASCADE;

--
-- Constraints for table `project_assignments`
--
ALTER TABLE `project_assignments`
  ADD CONSTRAINT `project_assignments_hwid_foreign` FOREIGN KEY (`hwID`) REFERENCES `health_workers` (`hwID`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_assignments_prjid_foreign` FOREIGN KEY (`prjID`) REFERENCES `projects` (`prjID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

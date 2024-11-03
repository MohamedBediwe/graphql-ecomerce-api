-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2024 at 07:54 PM
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
-- Database: `graphql`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ordered_products` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ordered_products`)),
  `total` float NOT NULL,
  `status` enum('pending','shipped','delivered','cancelled') NOT NULL,
  `address` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `numItemsInCart` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `ordered_products`, `total`, `status`, `address`, `name`, `numItemsInCart`, `created_at`) VALUES
(6, 23, '[{\"productID\":1,\"amount\":1,\"cartID\":\"1#FFF\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/stuhl.webp\",\"price\":99.99,\"productColor\":\"#FFF\",\"title\":\"Stuhl\"}]', 120, 'pending', 'Alexandria, Egypt', 'Mohamed', 1, '2024-10-26 21:48:28'),
(7, 23, '[{\"productID\":8,\"amount\":1,\"cartID\":\"8#FF5733\",\"company\":\"Luxora\",\"image\":\"https:\\/\\/images.pexels.com\\/photos\\/4916510\\/pexels-photo-4916510.jpeg?auto=compress&cs=tinysrgb&w=1600\",\"price\":289.99,\"productColor\":\"#FF5733\",\"title\":\"velvet sofa\"}]', 130, 'pending', 'Alexandria', 'Mohamed', 1, '2024-10-26 21:48:28'),
(8, 23, '[{\"productID\":2,\"amount\":1,\"cartID\":\"2#FFF\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/sofa.jpeg\",\"price\":99.99,\"productColor\":\"#FFF\",\"title\":\"Sofa\"}]', 114.989, 'pending', 'Alexandria', 'Mohamed', 1, '2024-10-26 21:48:28'),
(9, 23, '[{\"productID\":3,\"amount\":1,\"cartID\":\"3#F0F\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/sofa-tilt.webp\",\"price\":119.99,\"productColor\":\"#F0F\",\"title\":\"Sofa Tilt\"},{\"productID\":3,\"amount\":1,\"cartID\":\"3#0FF\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/sofa-tilt.webp\",\"price\":119.99,\"productColor\":\"#0FF\",\"title\":\"Sofa Tilt\"},{\"productID\":3,\"amount\":3,\"cartID\":\"3#FF0\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/sofa-tilt.webp\",\"price\":119.99,\"productColor\":\"#FF0\",\"title\":\"Sofa Tilt\"},{\"productID\":6,\"amount\":1,\"cartID\":\"6#f00\",\"company\":\"Homestead\",\"image\":\"http:\\/\\/localhost\\/images\\/stylish-bed.jpeg\",\"price\":179.99,\"productColor\":\"#f00\",\"title\":\"Stylish bed\"},{\"productID\":6,\"amount\":2,\"cartID\":\"6#0f0\",\"company\":\"Homestead\",\"image\":\"http:\\/\\/localhost\\/images\\/stylish-bed.jpeg\",\"price\":179.99,\"productColor\":\"#0f0\",\"title\":\"Stylish bed\"}]', 1258.91, 'pending', 'Alexandria, Egypt', 'Mohamed', 8, '2024-10-26 21:48:28'),
(10, 23, '[{\"productID\":2,\"amount\":1,\"cartID\":\"2#FFF\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/sofa.jpeg\",\"price\":99.99,\"productColor\":\"#FFF\",\"title\":\"Sofa\"}]', 114.989, 'pending', 'Alexandria', 'Mohamed', 1, '2024-10-26 21:48:28'),
(11, 23, '[{\"productID\":1,\"amount\":1,\"cartID\":\"1#FFF\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/stuhl.webp\",\"price\":99.99,\"productColor\":\"#FFF\",\"title\":\"Stuhl\"}]', 114.989, 'pending', 'Alexandria', 'Mohamed', 1, '2024-10-26 21:48:48'),
(12, 23, '[{\"productID\":1,\"amount\":1,\"cartID\":\"1#FFF\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/stuhl.webp\",\"price\":99.99,\"productColor\":\"#FFF\",\"title\":\"Stuhl\"}]', 114.989, 'pending', 'Alexandria, Egypt', 'Mohamed Bediwe', 1, '2024-10-26 21:49:33'),
(13, 23, '[{\"productID\":2,\"amount\":1,\"cartID\":\"2#FFF\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/sofa.jpeg\",\"price\":99.99,\"productColor\":\"#FFF\",\"title\":\"Sofa\"},{\"productID\":2,\"amount\":3,\"cartID\":\"2#000\",\"company\":\"IKEA\",\"image\":\"http:\\/\\/localhost\\/images\\/sofa.jpeg\",\"price\":99.99,\"productColor\":\"#000\",\"title\":\"Sofa\"}]', 444.956, 'pending', 'اسكندرية', 'Robot', 4, '2024-10-26 21:59:37'),
(14, 23, '[{\"productID\":4,\"amount\":1,\"cartID\":\"4#f00\",\"company\":\"Modenza\",\"image\":\"http:\\/\\/localhost\\/images\\/avant-garde-lamp.webp\",\"price\":169.99,\"productColor\":\"#f00\",\"title\":\"Avant-Garde Lamp\"}]', 191.989, 'pending', 'adsdqw', 'Robot', 1, '2024-10-26 22:00:39'),
(15, 23, '[{\"productID\":9,\"amount\":1,\"cartID\":\"9#33FF57\",\"company\":\"Artifex\",\"image\":\"https:\\/\\/images.pexels.com\\/photos\\/3932930\\/pexels-photo-3932930.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2\",\"price\":119.99,\"productColor\":\"#33FF57\",\"title\":\"wooden shelves\"}]', 136.989, 'pending', 'Alexandria', 'Mohamed', 1, '2024-10-26 22:01:01'),
(16, 23, '[{\"productID\":10,\"amount\":1,\"cartID\":\"10#FF5733\",\"company\":\"Artifex\",\"image\":\"https:\\/\\/images.pexels.com\\/photos\\/439227\\/pexels-photo-439227.jpeg?auto=compress&cs=tinysrgb&w=1600\",\"price\":439.99,\"productColor\":\"#FF5733\",\"title\":\"Minimalist Shelves\"}]', 488.989, 'pending', 'Alex, Egypt', 'Mohamed', 1, '2024-10-26 22:01:21');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `company` varchar(255) NOT NULL,
  `colors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`colors`)),
  `category` varchar(255) NOT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `shipping` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `price`, `quantity`, `image`, `description`, `company`, `colors`, `category`, `featured`, `shipping`) VALUES
(1, 'Stuhl', 99.99, 9, 'http://localhost/images/stuhl.webp', 'Das ist ein Stuhl', 'IKEA', '[\"#FFF\", \"#000\"]', 'Chairs', 0, 1),
(2, 'Sofa', 99.99, 10, 'http://localhost/images/sofa.jpeg', 'Das ist ein Sofa', 'IKEA', '[\"#FFF\", \"#000\"]', 'Sofas', 0, 1),
(3, 'Sofa Tilt', 119.99, 5, 'http://localhost/images/sofa-tilt.webp', 'Das ist ein Sofa, This is a sofa but this time in English.', 'IKEA', '[\"#FF0\", \"#0FF\", \"#F0F\"]', 'Sofas', 1, 1),
(4, 'Avant-Garde Lamp', 169.99, 5, 'http://localhost/images/avant-garde-lamp.webp', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Modenza', '[\"#f00\", \"#0f0\"]', 'Kids', 1, 0),
(5, 'Coffee Table', 169.99, 5, 'http://localhost/images/coffee-table.jpeg', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Modenza', '[\"#f00\", \"#0f0\"]', 'Tables', 1, 0),
(6, 'Stylish bed', 179.99, 5, 'http://localhost/images/stylish-bed.jpeg', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Homestead', '[\"#f00\", \"#0f0\"]', 'Beds', 0, 1),
(7, 'Chic chair', 339.99, 5, 'https://images.pexels.com/photos/5705090/pexels-photo-5705090.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Luxora', '[\"#FF5733\", \"#33FF57\", \"#3366FF\"]', 'Chairs', 0, 0),
(8, 'velvet sofa', 289.99, 5, 'https://images.pexels.com/photos/4916510/pexels-photo-4916510.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Luxora', '[\"#FF5733\", \"#33FF57\", \"#FFFF00\"]', 'Chairs', 0, 0),
(9, 'wooden shelves', 119.99, 5, 'https://images.pexels.com/photos/3932930/pexels-photo-3932930.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Artifex', '[\"#33FF57\", \"#3366FF\"]', 'Kids', 0, 0),
(10, 'Minimalist Shelves', 439.99, 5, 'https://images.pexels.com/photos/439227/pexels-photo-439227.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Artifex', '[\"#FF5733\", \"#FFFF00\"]', 'Kids', 0, 0),
(11, 'modern sofa', 299.99, 5, 'https://images.pexels.com/photos/6480707/pexels-photo-6480707.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Comfora', '[\"#FF5733\", \"#33FF57\", \"#FFFF00\"]', 'Sofas', 0, 0),
(12, 'modern table', 389.99, 5, 'https://images.pexels.com/photos/447592/pexels-photo-447592.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Modenza', '[\"#33FF57\", \"#3366FF\"]', 'Tables', 0, 0),
(13, 'reclining sofa', 329.99, 2, 'https://images.pexels.com/photos/4316737/pexels-photo-4316737.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Comfora', '[\"#FF5733\", \"#33FF57\", \"#3366FF\", \"#FFFF00\"]', 'Sofas', 0, 0),
(14, 'Sectional Sofa', 359.99, 5, 'https://images.pexels.com/photos/4857775/pexels-photo-4857775.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Comfora', '[\"#FF5733\", \"#33FF57\", \"#3366FF\", \"#FFFF00\"]', 'Sofas', 0, 0),
(15, 'sleek bed', 539.99, 3, 'https://images.pexels.com/photos/16869701/pexels-photo-16869701/free-photo-of-modern-luxury-real-estate-property-interior-bedroom.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Homestead', '[\"#FFFF00\", \"#3366FF\"]', 'Beds', 0, 0),
(16, 'sleek chair', 199.99, 5, 'https://images.pexels.com/photos/116910/pexels-photo-116910.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Luxora', '[\"#FF5733\", \"#33FF57\", \"#3366FF\", \"#FFFF00\"]', 'Chairs', 0, 1),
(17, 'streamlined table', 209.99, 5, 'https://images.pexels.com/photos/890669/pexels-photo-890669.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Modenza', '[\"#FF5733\", \"#3366FF\"]', 'Tables', 0, 0),
(19, 'Toy Shelf', 79.99, 5, 'https://images.pexels.com/photos/3932929/pexels-photo-3932929.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 'Luxora', '[\"#33FF57\", \"#FFFF00\"]', 'Kids', 0, 0),
(24, 'Emperor Bed', 239.99, 5, 'https://images.pexels.com/photos/271618/pexels-photo-271618.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Kickstarter humblebrag keytar cliche waistcoat slow-carb seitan echo park.', 'Ikea', '[\"#000\", \"#0000ff\"]', 'beds', 0, 0),
(26, 'Leather Sofa', 999.99, 5, 'https://images.pexels.com/photos/1866149/pexels-photo-1866149.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Marfa hammock twee retro sriracha vegan cray distillery kinfolk yuccie banjo migas farm-to-table. Kombucha slow-carb affogato dreamcatcher 3 wolf moon kitsch yr sustainable post-ironic banh mi etsy venmo.', 'Caressa', '[\"#000\"]', 'sofas', 0, 1),
(31, 'Dining Table', 429.99, 5, 'https://images.pexels.com/photos/1571463/pexels-photo-1571463.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Fingerstache direct trade taiyaki neutra.', 'Liddy', '[\"#00ff00\", \"#0000ff\", \"#ff0000\"]', 'tables', 0, 0),
(32, 'Sofa Set', 899.99, 5, 'https://images.pexels.com/photos/276583/pexels-photo-276583.jpeg?auto=compress&cs=tinysrgb&w=1600', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf.', 'Marcos', '[\"#ffb900\", \"#00ff00\"]', 'sofas', 0, 1),
(34, 'Wooden Desk', 399.99, 5, 'https://images.pexels.com/photos/8251166/pexels-photo-8251166.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf.', 'Caressa', '[\"#00ff00\"]', 'tables', 0, 1),
(35, 'Wooden Table', 234.99, 5, 'https://images.pexels.com/photos/2647714/pexels-photo-2647714.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Pinterest offal chia health goth shoreditch jean shorts umami listicle pork belly cloud bread ramps sartorial mixtape.', 'Liddy', '[\"#ffb900\"]', 'tables', 0, 0),
(36, 'Dining Chair', 129.99, 5, 'https://images.pexels.com/photos/3704459/pexels-photo-3704459.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Schlitz pitchfork echo park williamsburg bicycle rights live-edge viral roof party. PBR&B letterpress literally green juice direct trade heirloom brunch.', 'Caressa', '[\"#ff0000\"]', 'chairs', 0, 1),
(40, 'Utopia Sofa', 799.99, 5, 'https://images.pexels.com/photos/1648768/pexels-photo-1648768.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Pinterest offal chia health goth shoreditch jean shorts umami listicle pork belly cloud bread ramps sartorial mixtape.', 'Liddy', '[\"#000\", \"#ffb900\"]', 'sofas', 0, 1),
(41, 'Dining Table', 429.99, 5, 'https://images.pexels.com/photos/3144581/pexels-photo-3144581.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Ennui snackwave craft beer fanny pack literally meditation woke.', 'Liddy', '[\"#ffb900\", \"#ff0000\", \"#00ff00\"]', 'tables', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `name`, `password`) VALUES
(3, 'janedoe@example.com', 'Jane Doe', '$2y$10$h84lu5aetvhBk.k5azhZUeOwwdk.WvZoZOsXFKUJVqy7RhMKc3G86'),
(4, 'janedodsae@example.com', 'Janeq Doe', '$2y$10$VwPloGUlxcbhyViEmTvQI.e3WxfCDG8qD8dIpWDign1ccTYMgIbqG'),
(5, 'janedodssae@example.com', 'Janeqq Doe', '$2y$10$EDA5GbydFcfQIFB4Z29lBeTCJ9iYP7eM/Vq7JHRooBiXUkf7ifYue'),
(6, 'johndodssae@example.com', 'john Doe', '$2y$10$EYCnWa73LWNIvOt293/XSuFxClq6fUVtHM627ZTJjCCrw8zZHlWjm'),
(7, 'johandodssae@example.com', 'johan Doe', '$2y$10$81xHx1kpJX2o0FEwsblKMufEuheUBE7cc2TJbjNlTO4DtF3gvU2m.'),
(8, 'johansdodssae@example.com', 'johans Doe', '$2y$10$gbqn4J3.nc5pc5TiMIST1.lTu79MWd2QHmg6X.JsJCQzRxG6rDbsq'),
(19, 'joeweqqeqwewqeeqwqwhn.ewqeqw1ddaoe@example.com', 'alert(&#039;hacked&#039;);John', '$2y$10$dgLRjOwc5yZPczZ3/bl23eRrqcVal/5rg0ntNueH21WvFkKr/9IpC'),
(20, 'wqeewqe@deqwe.hq', 'wqewqedsa', '$2y$10$UOVNB4m/AcTTWxZuHMIGlegqcjjzLJhmMrP/pn9FxjeRXPtowHU/q'),
(21, 'saddsad@eqweq.das', 'ewqwqeqw', '$2y$10$PU5S3FeswWQ9UwfQkr91du2Ge0udinycXq7ndo93IwzNV2If51zOy'),
(22, 'dsadsa@eqw.uo', 'eqwewq123', '$2y$10$tmy0Hw4B/0BIWcdDS5mziONylWThWCOUd7Kw7VmIHHRxfU3wczzQG'),
(23, 'mohamed@yahoo.com', 'Mohamed', '$2y$10$1cKLTo5nPbjsGNtLhlHivOmm9fXoKxkZdnEIkl8zcGFuzLEbsrxrO'),
(24, 'guest@example.com', 'guest', '$2y$10$WjztdQJJ7g0EVVR8vGbmXeDz4Ux7jeoDJaEGF5dOfJbUGQaXhAG9a');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

<?php
require_once __DIR__ . '/vendor/autoload.php';

// Require all type files
require_once 'graphql/types/UserType.php';
require_once 'graphql/types/StatusEnumType.php';
require_once 'graphql/types/ProductType.php';
require_once 'graphql/types/OrderedProductType.php';
require_once 'graphql/types/OrderType.php';
require_once 'graphql/types/QueryType.php';
require_once 'graphql/types/MutationType.php';
require_once 'Config/Database.php';
require_once 'Config/JwtManager.php';
require_once 'Config/ErrorHandler.php';
require_once 'Config/Validator.php';
require_once 'graphql/resolvers/UserResolver.php';
require_once 'graphql/resolvers/ProductsResolver.php';
require_once 'graphql/resolvers/OrderResolver.php';

use GraphQL\Type\Schema;
use Types\queryType;
use Types\MutationType;

$schema = new Schema([
  'query' => queryType::getInstance(),
  'mutation' => MutationType::getInstance()
],);

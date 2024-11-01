<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use Config\Database;
use Types\ProductsType;
use Types\OrdersType;

class QueryType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      $pdo = Database::getConnection();

      self::$instance = new ObjectType([
        'name' => 'Query',
        'fields' => [
          'products' => [
            'type' => ProductsType::getInstance(),
            'args' => [
              'page' => Type::int(),
              'category' => Type::string(),
              'company' => Type::string(),
              'price' => Type::float(),
              'search' => Type::string(),
              'limit' => Type::int(),
              'order' => Type::string(),
              'shipping' => Type::boolean()
            ],
            'resolve' => function ($root, $args) use ($pdo) {
              return resolveProducts($pdo, $args);
            }
          ],
          'product' => [
            'type' => ProductType::getInstance(),
            'args' => [
              'id' => Type::int(),
            ],
            'resolve' => function ($root, $args) use ($pdo) {
              return resolveProduct($pdo, $args['id']);
            }
          ],
          'featuredProducts' => [
            'type' => Type::listOf(ProductType::getInstance()),
            'args' => [],
            'resolve' => function ($root, $args) use ($pdo) {
              return resolveFeaturedProducts($pdo);
            }
          ],
          'orders' => [
            'type' => OrdersType::getInstance(),
            'args' => [
              'page' => Type::int(),
              'limit' => Type::int(),

            ],
            'resolve' => function ($root, $args, $context) use ($pdo) {
              return resolveOrders($pdo, $args, $context);
            }
          ]
        ]
      ]);
    }
    return self::$instance;
  }
}

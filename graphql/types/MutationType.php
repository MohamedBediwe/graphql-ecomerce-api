<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use Config\Database;
use Types\AuthType;
use Types\OrderedProductType;
use Types\CreateOrderResponse;

require_once __DIR__ . '/../resolvers/SignupResolver.php';
require_once __DIR__ . '/../resolvers/LoginResolver.php';
require_once __DIR__ . '/../resolvers/OrderResolver.php';

class MutationType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      $pdo = Database::getConnection();

      self::$instance = new ObjectType([
        'name' => 'Mutation',
        'fields' => [
          'signup' => [
            'type' => AuthType::getInstance(),
            'args' => [
              'email' => Type::nonNull(Type::string()),
              'name' => Type::nonNull(Type::string()),
              'password' => Type::nonNull(Type::string())
            ],
            'resolve' => function ($root, $args) use ($pdo) {
              return resolveSignup($pdo, $args);
            }
          ],
          'login' => [
            'type' => AuthType::getInstance(),
            'args' => [
              'identifier' => Type::nonNull(Type::string()),
              'password' => Type::nonNull(Type::string())
            ],
            'resolve' => function ($root, $args) use ($pdo) {
              return resolveLogin($pdo, $args);
            }
          ],
          'createOrder' => [
            'type' => CreateOrderResponse::getInstance(),
            'args' => [
              'name' => Type::nonNull(Type::string()),
              'address' => Type::nonNull(Type::string()),
              'cartItems' => Type::listOf(OrderedProductInputType::getInstance()),
              'chargeTotal' => Type::nonNull(Type::float()),
              'orderTotal' => Type::nonNull(Type::string()),
              'numItemsInCart' => Type::nonNull(Type::int()),
            ],
            'resolve' => function ($root, $args) use ($pdo) {
              return resolveCreateOrder($pdo, $args);
            }
          ]
        ]
      ]);
    }
    return self::$instance;
  }
}

<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
// use Types\OrderedProductType;
use Types\StatusEnumType;

class CreateOrderResponse
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'CreateOrderResponse',
        'fields' => [
          'order_id' => Type::int(),
          'user_id' => Type::int(),
          // 'ordered_products' => Type::listOf(OrderedProductType::getInstance()), 
          'total' => Type::float(),
          'status' => StatusEnumType::getInstance(),
          'address' => Type::string()
        ],
      ]);
    }

    return self::$instance;
  }
}

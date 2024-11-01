<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use Types\OrderedProductType;

class OrderType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'Order',
        'fields' => [
          'order_id' => Type::int(),
          'user_id' => Type::int(),
          'ordered_products' => Type::listOf(OrderedProductType::getInstance()), // Updated product type
          'total' => Type::float(),
          'status' => StatusEnumType::getInstance(),
          'created_at' => Type::string(),
          'name' => Type::string(),
          'address' => Type::string(),
          'numItemsInCart' => Type::int()
        ],
      ]);
    }

    return self::$instance;
  }
}

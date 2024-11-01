<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use Types\OrderedProductType;

class CreateOrderType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'CreateOrder',
        'fields' => [
          'address' => Type::string(),
          'cartItems' => Type::listOf(OrderedProductType::getInstance()),
          'orderTotal' => Type::float(),
          'name' => Type::String(),
          'numItemsInCart' => Type::int(),
        ],
      ]);
    }

    return self::$instance;
  }
}

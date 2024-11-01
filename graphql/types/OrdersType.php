<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use Types\OrderType;
use Types\MetaType;

class OrdersType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'OrdersResponse',
        'fields' => [
          'orders' => Type::listOf(OrderType::getInstance()),
          'meta' => MetaType::getInstance()
        ]
      ]);
    }
    return self::$instance;
  }
}

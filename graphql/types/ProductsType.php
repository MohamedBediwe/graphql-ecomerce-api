<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use Types\MetaType;

class ProductsType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'ProductsResponse',
        'fields' => [
          'products' => Type::listOf(ProductType::getInstance()),
          'meta' => MetaType::getInstance()
        ]
      ]);
    }
    return self::$instance;
  }
}

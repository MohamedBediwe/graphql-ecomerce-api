<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;

class ProductType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'Product',
        'fields' => [
          'id' => Type::int(),
          'title' => Type::string(),
          'price' => Type::float(),
          "quantity" => Type::int(),
          'image' => Type::string(),
          'description' => Type::string(),
          'company' => Type::string(),
          'colors' => Type::listOf(Type::string()),
          'category' => Type::string(),
          'featured' => Type::boolean(),
          "shipping" => Type::boolean(),
        ]
      ]);
    }
    return self::$instance;
  }
}

<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;

class OrderedProductType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'OrderedProduct',
        'fields' => [
          'productID' => Type::nonNull(Type::int()),
          'amount' => Type::nonNull(Type::int()),
          'cartID' => Type::string(),
          'company' => Type::nonNull(Type::string()),
          'image' => Type::string(),
          'price' => Type::nonNull(Type::float()),
          'productColor' => Type::string(),
          'title' => Type::nonNull(Type::string()),
        ],
      ]);
    }

    return self::$instance;
  }
}

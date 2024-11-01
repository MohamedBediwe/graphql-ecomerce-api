<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use Types\PaginationType;

class MetaType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance =
        new ObjectType([
          'name' => 'ProductsMeta',
          'fields' => [
            'pagination' => PaginationType::getInstance(),
            'categories' => Type::listOf(Type::string()),
            'companies' => Type::listOf(Type::string())
          ]
        ]);
    }
    return self::$instance;
  }
}

<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;

class PaginationType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance =
        new ObjectType([
          'name' => 'Pagination',
          'fields' => [
            'page' => Type::int(),
            'pageSize' => Type::int(),
            'pageCount' => Type::int(),
            'total' => Type::int()
          ]
        ]);
    }
    return self::$instance;
  }
}

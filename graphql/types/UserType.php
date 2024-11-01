<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;

class UserType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'User',
        'fields' => [
          'id' => Type::int(),
          'name' => Type::string(),
          'email' => Type::string(),
          'password' => Type::string(),
          // 'provider' => Type::string(),
          // 'confirmed' => Type::boolean(),
          // 'blocked' => Type::boolean(),
          // 'createdAt' => Type::string(),
          // 'updatedAt' => Type::string(),
        ],
      ]);
    }

    return self::$instance;
  }
}

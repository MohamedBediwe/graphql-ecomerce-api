<?php

namespace Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use Types\UserType;

class AuthType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ObjectType([
        'name' => 'Auth',
        'fields' => [
          'jwt' => Type::string(),
          'user' => UserType::getInstance(),
        ],
      ]);
    }

    return self::$instance;
  }
}

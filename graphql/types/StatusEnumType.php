<?php

namespace Types;

use GraphQL\Type\Definition\EnumType;

class StatusEnumType
{
  private static $instance = null;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new EnumType([
        'name' => 'Status',
        'values' => [
          'PENDING' => [
            'value' => 'pending',
            'description' => 'Order has been placed but not yet processed.'
          ],
          'SHIPPED' => [
            'value' => 'shipped',
            'description' => 'Order has been shipped to the customer.'
          ],
          'DELIVERED' => [
            'value' => 'delivered',
            'description' => 'Order has been delivered to the customer.'
          ],
          'CANCELLED' => [
            'value' => 'cancelled',
            'description' => 'Order has been cancelled.'
          ]
        ]
      ]);
    }
    return self::$instance;
  }
}

<?php

namespace Config;

use GraphQL\Error\FormattedError;

class ErrorHandler
{
  public static function handleError($error)
  {
    $error = FormattedError::createFromException($error);
    $error['extensions']['timestamp'] = time();
    return $error;
  }
}

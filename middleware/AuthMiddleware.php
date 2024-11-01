<?php

namespace Middleware;

use Config\JwtManager;

class AuthMiddleware
{
  public static function authenticate()
  {
    $token = $_SERVER['HTTP_AUTHORIZATION'] ?? null;

    if (!$token || !preg_match('/Bearer\s+(.*)$/i', $token, $matches)) {
      throw new \Exception('Authentication required');
    }

    $token = $matches[1];
    $decoded = JwtManager::verifyToken($token);

    if (!$decoded) {
      throw new \Exception('Invalid token');
    }

    return $decoded->user_id;
  }
}

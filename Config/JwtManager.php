<?php

namespace Config;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;


class JwtManager
{
  private static $secret_key; // Constant expression contains invalid operations
  private static $algorithm = 'HS256';

  public static function init()
  {
    self::$secret_key = $_ENV["JWT_SECRET_KEY"] ?? 'default_secret_key';
  }

  public static function getSecretKey()
  {
    if (!isset(self::$secret_key)) {
      self::init();
    }
    return self::$secret_key;
  }

  public static function generateToken($userId, $userEmail)
  {
    $issuedAt = time();
    $expire = $issuedAt + 3600; // 1 hour expiration

    $payload = [
      'iat' => $issuedAt,
      'exp' => $expire,
      'user_id' => $userId,
      'user_email' => $userEmail
    ];

    return JWT::encode($payload, self::getSecretKey(), self::$algorithm);
  }

  public static function verifyToken($token)
  {
    try {
      $decoded = JWT::decode($token, new Key(self::getSecretKey(), self::$algorithm));
      return $decoded;
    } catch (\Exception $e) {
      return false;
    }
  }
}

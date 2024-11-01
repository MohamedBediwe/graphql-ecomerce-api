<?php

use Config\JwtManager;
use Config\Validator;

function resolveSignup($pdo, $args)
{

  $name = htmlspecialchars(strip_tags($args['name']), ENT_QUOTES, 'UTF-8');
  $email = filter_var($args['email'], FILTER_SANITIZE_EMAIL);;
  $password = $args['password'];

  // Sanitize inputs
  if (Validator::string($password, 7, 256)) {
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
  } else {
    throw new \Exception('Password must be between 7 and 256 chars');
  }

  if (!Validator::string($name, 5)) {
    throw new \Exception("Name must be given $name");
  }
  if (!Validator::email($email)) {
    throw new \Exception('Invalid email');
  }
  // check whether the user exist or not
  $stmt = $pdo->prepare('SELECT id FROM users WHERE email = ?');
  $stmt->execute([$email]);
  if ($stmt->fetch()) {
    throw new \Exception('Email already exists');
  }
  $stmt = $pdo->prepare('SELECT id FROM users WHERE name = ?');
  $stmt->execute([$name]);
  if ($stmt->fetch()) {
    throw new \Exception('username already exists');
  }

  // Insert user into the database
  $stmt = $pdo->prepare("INSERT INTO users (name, email, password) VALUES (:name, :email, :password)");
  $stmt->execute([
    'name' => $name,
    'email' => $email,
    'password' => $hashedPassword
  ]);

  $userId = $pdo->lastInsertId();

  // Get the created user details
  $stmt = $pdo->prepare("SELECT * FROM users WHERE id = :id");
  $stmt->execute(['id' => $userId]);
  $user = $stmt->fetch();

  // Return JWT and user data
  return [
    'jwt' => JwtManager::generateToken($userId, $email),
    'user' => [
      'id' => $user['id'],
      'name' => $name,
      'email' => $email,
      'provider' => 'local',
      // 'confirmed' => true,
      // 'blocked' => false,
      // 'createdAt' => $user['created_at'],
      // 'updatedAt' => $user['updated_at']
    ]
  ];
}

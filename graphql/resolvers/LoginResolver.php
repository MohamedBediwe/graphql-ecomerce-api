<?php

use Config\JwtManager;

function resolveLogin($pdo, $args)
{
  // 1. Sanitize inputs
  $identifier = htmlspecialchars($args['identifier']);
  $password = htmlspecialchars($args['password']);

  // 2. Prepare the SQL query based on whether it's an email or username
  $query = '';
  if (filter_var($identifier, FILTER_VALIDATE_EMAIL)) {
    // If identifier is an email
    $query = 'SELECT * FROM users WHERE email = :identifier LIMIT 1';
  } else {
    // If identifier is a username
    $query = 'SELECT * FROM users WHERE name = :identifier LIMIT 1';
  }

  $stmt = $pdo->prepare($query);
  $stmt->bindParam(':identifier', $identifier);
  $stmt->execute();
  $user = $stmt->fetch(PDO::FETCH_ASSOC);

  if ($user) {
    // 3. Verify the password
    if (password_verify($password, $user['password'])) {
      // 4. If password matches, return the user (excluding the password field)
      unset($user['password']);
      return [
        'jwt' => JwtManager::generateToken($user['id'], $user['email']),
        'user' => [
          'id' => $user['id'],
          'name' => $user['name'],
          'email' => $user['email'],
          // 'provider' => $user['provider'],
          // 'confirmed' => $user['confirmed'],
          // 'blocked' => $user['blocked'],
          // 'createdAt' => $user['created_at'],
          // 'updatedAt' => $user['updated_at']
        ]
      ];
    } else {
      throw new Exception("Invalid password.", 400);
    }
  } else {
    throw new Exception("User not found.", 400);
  }
}

<?php

use Config\JwtManager;
use Middleware\AuthMiddleware;

function resolveOrders($pdo, $args)
{
  $userId = AuthMiddleware::authenticate();

  if (!$userId) {
    throw new Exception("Invalid or expired token", 401);
  }

  $query = "SELECT * FROM orders WHERE user_id = :user_id";

  $limit = isset($args['limit']) ? $args['limit'] : 10;
  $page = isset($args['page']) ? $args['page'] : 1;
  $offset = ($page - 1) * $limit;

  $query .= " LIMIT :limit OFFSET :offset";

  $stmt = $pdo->prepare($query);
  $stmt->execute(['user_id' => $userId, 'limit' => $limit, 'offset' => $offset]);
  $orders = $stmt->fetchAll();

  $total = $pdo->prepare('SELECT count(*) as count FROM orders WHERE user_id = :user_id');
  $total->execute(['user_id' => $userId]);
  $total = $total->fetch()['count'];

  foreach ($orders as &$order) {
    // Decode the ordered_products JSON string with the new fields for each order
    $order['ordered_products'] = json_decode($order['ordered_products'], true);
  }

  return [
    "orders" => $orders,
    "meta" => [
      "pagination" => [
        "page" => $page,
        "pageSize" => $limit,
        "pageCount" => ceil($total / $limit),
        "total" => $total
      ],
    ]
  ];
}


function resolveCreateOrder($pdo, $args)
{
  $token = $_SERVER['HTTP_AUTHORIZATION'] ?? null;

  if (!$token) {
    throw new Exception("Authorization token not found");
  }
  if (!str_starts_with($token, 'Bearer ')) {
    throw new Exception("Invalid token format");
  }

  $token = str_replace('Bearer ', '', $token);

  $userId = JwtManager::verifyToken($token)->user_id;

  if (!$userId) {
    throw new Exception("Invalid or expired token", 401);
  }



  // Prepare order data
  $name = htmlspecialchars($args['name']);
  $address = htmlspecialchars($args['address']);
  $cartItems = json_encode($args['cartItems']);
  $orderTotal = $args['chargeTotal'];
  $numItemsInCart = $args['numItemsInCart'];

  // Insert into orders table
  $stmt = $pdo->prepare("INSERT INTO orders (user_id, status, ordered_products, total, address, name, numItemsInCart) VALUES (:user_id, 'PENDING', :ordered_products, :total, :address, :name, :numItemsInCart)");
  $stmt->execute([
    ':user_id' => $userId,
    ':ordered_products' => $cartItems,
    ':total' => $orderTotal,
    ':address' => $address,
    ':name' => $name,
    ':numItemsInCart' => $numItemsInCart
  ]);

  // Get the order ID
  $orderId = $pdo->lastInsertId();

  return [
    'order_id' => $orderId,
    'user_id' => $userId,
    'status' => 'pending',
  ];
}

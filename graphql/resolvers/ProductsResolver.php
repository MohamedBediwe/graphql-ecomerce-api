<?php

function resolveFeaturedProducts($pdo)
{
  $stmt = $pdo->prepare("SELECT * FROM products WHERE featured = 1");
  $stmt->execute();
  $featuredProducts = $stmt->fetchAll(PDO::FETCH_ASSOC);
  return $featuredProducts;
}

function resolveProducts($pdo, $args)
{
  $query = "SELECT * FROM products WHERE 1=1";
  $params = [];

  if (isset($args['category']) and $args['category'] != "all") {
    $query .= " AND category = :category";
    $params[':category'] = $args['category'];
  }

  if (isset($args['company']) and $args['company'] != "all") {
    $query .= " AND company = :company";
    $params[':company'] = $args['company'];
  }

  if (isset($args['price'])) {
    $query .= " AND price <= :price";
    $params[':price'] = $args['price'];
  }

  if (isset($args['search']) and $args['search'] != "") {
    $query .= ' AND title LIKE :search';
    $params[':search'] = "%{$args['search']}%";
  }

  // shipping
  if (isset($args['shipping']) and $args['shipping'] == true) {
    $query .= " AND shipping = 1";
  }

  $countQuery = str_replace("SELECT *", "SELECT COUNT(*) as count", $query);
  $stmt = $pdo->prepare($countQuery);
  $stmt->execute($params);
  $total = $stmt->fetch(\PDO::FETCH_ASSOC)['count'];

  // Add ordering
  $order = isset($args['order']) ? $args['order'] : 'asc'; // Default to 'asc'

  switch ($order) {
    case 'a-z':
      $query .= ' ORDER BY title ASC';
      break;
    case 'z-a':
      $query .= ' ORDER BY title DESC';
      break;
    case 'low':
      $query .= ' ORDER BY price ASC';
      break;
    case 'high':
      $query .= ' ORDER BY price DESC';
      break;
  }

  $limit = isset($args['limit']) ? $args['limit'] : 10;
  $page = isset($args['page']) ? $args['page'] : 1;
  $offset = ($page - 1) * $limit;

  $query .= " LIMIT :limit OFFSET :offset";
  $params[':limit'] = $limit;
  $params[':offset'] = $offset;

  $stmt = $pdo->prepare($query);
  $stmt->execute($params);
  $products = $stmt->fetchAll(\PDO::FETCH_ASSOC);

  // Fetch all categories
  $categoryStmt = $pdo->query("SELECT DISTINCT category FROM products");
  $categories = array_merge(["all"], $categoryStmt->fetchAll(\PDO::FETCH_COLUMN));

  // Fetch all companies
  $companyStmt = $pdo->query("SELECT DISTINCT company FROM products");
  $companies = array_merge(["all"], $companyStmt->fetchAll(\PDO::FETCH_COLUMN));

  return [
    "products" => $products,
    "meta" => [
      "pagination" => [
        "page" => $page,
        "pageSize" => $limit,
        "pageCount" => ceil($total / $limit),
        "total" => $total
      ],
      "categories" => $categories,
      "companies" => $companies
    ]
  ];
}


function resolveProduct($pdo, $id)
{
  $stmt = $pdo->prepare('SELECT * FROM products WHERE id = ?');
  $stmt->execute([$id]);
  $product = $stmt->fetch(\PDO::FETCH_ASSOC);
  $product['colors'] = json_decode($product['colors']);
  return $product;
}

<?php
require 'vendor/autoload.php';
require 'schema.php';

use GraphQL\GraphQL;

$input = json_decode(file_get_contents('php://input'), true);
$query = isset($input['query']) ? $input['query'] : '';
$variables = isset($input['variables']) ? $input['variables'] : null;

// Execute the query and return the result
try {
  $result = GraphQL::executeQuery($schema, $query, null, null, $variables);
  $output = $result->toArray();
} catch (Throwable $e) {
  $output = [
    'errors' => [['message' => $e->getMessage()]],
  ];
}

// Set the content type to application/json
header('Content-Type: application/json');
echo json_encode($output);

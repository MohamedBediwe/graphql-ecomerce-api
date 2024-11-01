<?php
function resolveUsers($pdo)
{
  $stmt = $pdo->query('SELECT * FROM users');
  return $stmt->fetchAll();
}

function resolveUser($pdo, $args)
{
  $stmt = $pdo->prepare('SELECT * FROM users WHERE id = ?');
  $stmt->execute([$args['id']]);
  return $stmt->fetch();
}

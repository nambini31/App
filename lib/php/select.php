<?php
include "Connection.php";
$req = $conn->query("SELECT * from client ");

$list = [];

while ($row = $req->fetch_assoc()) {
    $list[] = $row;
}

echo json_encode($list);
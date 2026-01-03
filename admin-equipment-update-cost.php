<?php
// admin-equipment-update-cost.php
session_start();
include 'includes/connect.php';

// Check if user is admin
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'Admin') {
    echo 'Unauthorized access';
    exit;
}

// Get POST data
$maintenance_id = isset($_POST['maintenance_id']) ? (int)$_POST['maintenance_id'] : 0;
$total_cost = isset($_POST['total_cost']) ? floatval($_POST['total_cost']) : 0;

// Validate inputs
if ($maintenance_id <= 0) {
    echo 'Invalid maintenance ID';
    exit;
}

if ($total_cost < 0) {
    echo 'Cost cannot be negative';
    exit;
}

// Update the cost in the database
$query = "UPDATE maintenance 
          SET total_cost = $total_cost 
          WHERE maintenance_id = $maintenance_id";

$result = mysqli_query($con, $query);

if ($result) {
    // Check if any row was actually updated
    if (mysqli_affected_rows($con) >= 0) {
        echo 'success';
    } else {
        echo 'No changes made or maintenance record not found';
    }
} else {
    echo 'Database error: ' . mysqli_error($con);
}

mysqli_close($con);
?>
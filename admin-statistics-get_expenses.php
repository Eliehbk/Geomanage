<?php
include 'includes/connect.php';

$year = isset($_GET['year']) ? intval($_GET['year']) : date('Y');

// Months of the year
$months = [];
for($i=1; $i<=12; $i++){
    $months[] = sprintf('%04d-%02d', $year, $i);
}

$categories = ['Maintenance','Salaries','Equipment'];
$amounts = [];
foreach($categories as $cat){
    $amounts[$cat] = array_fill(0, count($months), 0);
}

// Maintenance
$sql = "SELECT DATE_FORMAT(maintenance_date, '%Y-%m') as month, SUM(total_cost) as amount
        FROM maintenance
        WHERE YEAR(maintenance_date) = $year
        GROUP BY month";
$result = mysqli_query($con, $sql);
while($row = mysqli_fetch_assoc($result)){
    $index = array_search($row['month'], $months);
    if($index !== false) $amounts['Maintenance'][$index] = floatval($row['amount']);
}

// Salaries from Contracts (calculate for each month)
for($i = 1; $i <= 12; $i++) {
    $month_start = sprintf('%d-%02d-01', $year, $i);
    $month_end = date('Y-m-t', strtotime($month_start)); // Last day of month
    
    $sql = "SELECT COALESCE(SUM(salary), 0) as total_salary
            FROM contract
            WHERE start_date <= '$month_end'
              AND end_date >= '$month_start'";
    
    $result = mysqli_query($con, $sql);
    $row = mysqli_fetch_assoc($result);
    $amounts['Salaries'][$i-1] = floatval($row['total_salary']);
}

// Equipment
$sql = "SELECT DATE_FORMAT(date, '%Y-%m') as month, SUM(cost) as amount
        FROM equipment
        WHERE YEAR(date) = $year
        GROUP BY month";
$result = mysqli_query($con, $sql);
while($row = mysqli_fetch_assoc($result)){
    $index = array_search($row['month'], $months);
    if($index !== false) $amounts['Equipment'][$index] = floatval($row['amount']);
}

// Return JSON
echo json_encode([
    'months' => $months,
    'amounts' => $amounts,
    'categories' => $categories
]);
?>
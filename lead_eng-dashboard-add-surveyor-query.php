<?php
// ========================================================================
// FILE: lead_eng-dashboard-add-surveyor-query.php
// Add ONE surveyor at a time with team size validation
// ========================================================================
include 'includes/connect.php';

$project_id = intval($_POST['project_id']);
$surveyor_id = intval($_POST['surveyor_id']);

// Get project team size limit and current assigned surveyors count
$team_check = mysqli_query($con, "
    SELECT p.team_size,
           COUNT(s.surveyor_id) as current_count
    FROM project p
    LEFT JOIN surveyor s ON s.project_id = p.project_id
    WHERE p.project_id = $project_id
    GROUP BY p.project_id
");

$team_data = mysqli_fetch_assoc($team_check);
$team_size_limit = intval($team_data['team_size'] ?? 0);
$current_count = intval($team_data['current_count'] ?? 0);

// Check if team is already full
if ($current_count >= $team_size_limit) {
    echo "team_full|$current_count|$team_size_limit";
    exit();
}

// Check if surveyor is available
$check_surveyor = mysqli_query($con, "
    SELECT status FROM surveyor WHERE surveyor_id = $surveyor_id
");
$surveyor_data = mysqli_fetch_assoc($check_surveyor);

if ($surveyor_data['status'] !== 'available') {
    echo "surveyor_not_available";
    exit();
}

// Add surveyor to project
$result = mysqli_query($con, "
    UPDATE surveyor 
    SET status='assigned', project_id=$project_id 
    WHERE surveyor_id=$surveyor_id AND status='available'
");

if($result && mysqli_affected_rows($con) > 0) {
    $new_count = $current_count + 1;
    echo "success|$new_count|$team_size_limit";
} else {
    echo "error";
}
?>
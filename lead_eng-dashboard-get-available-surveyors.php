<?php
// ========================================================================
// FILE: lead_eng-dashboard-get-available-surveyors.php
// Display available surveyors with team size status
// ========================================================================
include 'includes/connect.php';

$project_id = isset($_POST['project_id']) ? intval($_POST['project_id']) : 0;

// Get current team status if project_id is provided
$team_status = "";
if ($project_id > 0) {
    $team_check = mysqli_query($con, "
        SELECT p.team_size,
               COUNT(s.surveyor_id) as current_count
        FROM project p
        LEFT JOIN surveyor s ON s.project_id = p.project_id
        WHERE p.project_id = $project_id
        GROUP BY p.project_id
    ");
    
    if ($team_data = mysqli_fetch_assoc($team_check)) {
        $team_size_limit = intval($team_data['team_size']);
        $current_count = intval($team_data['current_count']);
        $remaining = $team_size_limit - $current_count;
        
        $status_color = $remaining > 0 ? '#28a745' : '#dc3545';
        $team_status = "
            <div style='background: #f8f9fa; padding: 10px; border-radius: 4px; margin-bottom: 10px; border-left: 3px solid $status_color;'>
                <div style='font-size: 12px; color: #555;'>
                    <strong>Team Capacity:</strong> $current_count / $team_size_limit surveyors
                    " . ($remaining > 0 ? 
                        "<span style='color: #28a745; margin-left: 5px;'>($remaining slots available)</span>" : 
                        "<span style='color: #dc3545; margin-left: 5px;'>(Team Full)</span>") . "
                </div>
            </div>
        ";
    }
}

echo $team_status;

// Get all available surveyors
$sql = "
    SELECT s.surveyor_id, u.user_id, u.full_name, u.email
    FROM surveyor s
    JOIN user u ON s.user_id = u.user_id
    WHERE s.status = 'available'
    ORDER BY u.full_name ASC
";

$result = $con->query($sql);

if($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        ?>
        <div style="padding: 8px; margin-bottom: 8px; background: white; border-radius: 4px; border: 1px solid #ddd;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div style="flex: 1;">
                    <strong style="font-size: 13px;"><?php echo htmlspecialchars($row['full_name']); ?></strong>
                    <span style="font-size: 12px; color: #666;"> - <?php echo htmlspecialchars($row['email']); ?></span>
                </div>
                <button type="button" class="btn btn-sm btn-primary" 
                    style="padding: 2px 8px; font-size: 11px;" 
                    onclick="addSingleSurveyor(<?php echo $row['surveyor_id']; ?>)">
                    <i class="fas fa-plus"></i> Add
                </button>
            </div>
        </div>
        <?php
    }
} else {
    echo '<p style="text-align: center; color: #999; padding: 10px; margin: 0;">No available surveyors.</p>';
}
?>
<?php
session_start();
include 'includes/connect.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'Admin') {
    exit('Unauthorized');
}

$equipment_id = isset($_POST['equipment_id']) ? (int)$_POST['equipment_id'] : 0;

if ($equipment_id <= 0) {
    echo '<p class="text-danger">Invalid equipment ID.</p>';
    exit;
}

// Get equipment details
$equipmentQuery = "SELECT equipment_name, equipment_type FROM equipment WHERE equipment_id = $equipment_id";
$equipmentResult = mysqli_query($con, $equipmentQuery);
$equipment = mysqli_fetch_assoc($equipmentResult);

if (!$equipment) {
    echo '<p class="text-danger">Equipment not found.</p>';
    exit;
}

echo "<div style='margin-bottom: 20px; padding: 15px; background: #f8f9fa; border-radius: 5px;' data-equipment-id='{$equipment_id}'>
        <h4 style='margin: 0 0 5px 0; color: #263a4f;'>{$equipment['equipment_name']}</h4>
        <p style='margin: 0; color: #666; font-size: 14px;'>Type: {$equipment['equipment_type']}</p>
      </div>";

// Get maintenance history with costs
$query = "SELECT 
    m.maintenance_id,
    m.request_date,
    m.maintenance_date,
    m.maintenance_type,
    m.description,
    m.total_cost,
    m.bill_file_path,
    u.full_name AS requested_by_name
    
FROM maintenance m
LEFT JOIN user u ON m.requested_by = u.user_id
 
WHERE m.equipment_id = $equipment_id
ORDER BY m.request_date DESC";

$result = mysqli_query($con, $query);

if (!$result) {
    echo '<p class="text-danger">Error loading maintenance history: ' . mysqli_error($con) . '</p>';
    mysqli_close($con);
    exit;
}

if (mysqli_num_rows($result) == 0) {
    echo '<p class="text-center text-muted" style="padding: 30px 0;">No maintenance history found for this equipment.</p>';
    mysqli_close($con);
    exit;
}

// Calculate total cost
$totalCost = 0;
$maintenanceData = [];

while ($row = mysqli_fetch_assoc($result)) {
    $maintenanceData[] = $row;
    if ($row['total_cost']) {
        $totalCost += floatval($row['total_cost']);
    }
}

// Display summary with improved color
echo "<div style='background: #f1f3f5; color: #263a4f; padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center;'>
        <h4 style='margin: 0 0 5px 0;'>Total Maintenance Costs</h4>
        <h2 style='margin: 0; font-size: 32px; color: #ff7607;'>$" . number_format($totalCost, 2) . "</h2>
        <p style='margin: 5px 0 0 0; opacity: 0.8;'>From " . count($maintenanceData) . " maintenance records</p>
      </div>";


// Display maintenance history table
echo '<div class="table-responsive">
        <table class="table table-bordered" style="background: white;">
            <thead style="background: #f8f9fa;">
                <tr>
                    <th style="width: 80px;">ID</th>
                    <th>Type</th>
                    <th>Description</th>
                    <th>Request Date</th>
                    <th>Completed</th>
                    <th>Requested By</th>
                    <th style="min-width: 150px;">Cost <small style="color: #999; font-weight: normal;">(click to edit)</small></th>
                    <th>Bill</th>
                </tr>
            </thead>
            <tbody>';

foreach ($maintenanceData as $row) {
    $id = $row['maintenance_id'];
    $type = htmlspecialchars($row['maintenance_type'] ?? 'N/A');
    $description = htmlspecialchars($row['description'] ?? 'N/A');
    $requestDate = date("M d, Y", strtotime($row['request_date']));
    $completionDate = $row['maintenance_date'] ? date("M d, Y", strtotime($row['maintenance_date'])) : '<span style="color: #ff7607;">Pending</span>';
    $requestedBy = htmlspecialchars($row['requested_by_name'] ?? 'N/A');
    
    $costValue = $row['total_cost'] ? floatval($row['total_cost']) : 0;
    $costDisplay = $costValue > 0 ? '$' . number_format($costValue, 2) : '<span style="color: #999;">Not Set</span>';
    
    // Editable cost cell with visual indicator
    $cost = "<div class='cost-cell-container' data-maintenance-id='{$id}' data-cost='{$costValue}' style='position: relative;'>
                <div class='cost-display' style='cursor: pointer; padding: 5px 8px; border-radius: 4px; transition: all 0.2s; display: inline-block; min-width: 100px; border: 1px dashed transparent;'>
                    <span class='cost-value' style='font-weight: 600; color: #263a4f;'>{$costDisplay}</span>
                    <i class='fas fa-edit' style='font-size: 11px; color: #999; margin-left: 5px;'></i>
                </div>
                <div class='cost-edit' style='display: none;'>
                    <input type='number' 
                           class='cost-input form-control form-control-sm' 
                           value='{$costValue}' 
                           step='0.01' 
                           min='0'
                           style='width: 120px; display: inline-block; padding: 4px 8px;'>
                    <button class='btn btn-sm btn-success save-cost-btn' style='padding: 4px 8px; margin-left: 5px;'>
                        <i class='fas fa-check'></i>
                    </button>
                    <button class='btn btn-sm btn-secondary cancel-cost-btn' style='padding: 4px 8px;'>
                        <i class='fas fa-times'></i>
                    </button>
                </div>
            </div>";
    
    $billButton = 'N/A';
    if ($row['bill_file_path']) {
        $billFile = htmlspecialchars($row['bill_file_path']);
        $billButton = "<a href='uploads/bills/{$billFile}' target='_blank' class='btn btn-sm btn-info' style='padding: 4px 8px; font-size: 12px;'>
                        <i class='fas fa-file-invoice-dollar'></i> View Bill
                       </a>";
    }
    
    echo "<tr>
            <td style='font-weight: 600;'>#MT-{$id}</td>
            <td>{$type}</td>
            <td style='max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;' title='{$description}'>{$description}</td>
            <td>{$requestDate}</td>
            <td>{$completionDate}</td>
            <td>{$requestedBy}</td>
            <td>{$cost}</td>
            <td>{$billButton}</td>
          </tr>";
}

echo '      </tbody>
        </table>
      </div>';

echo '<style>
.cost-display:hover {
    background: #f8f9fa;
    border-color: #ff7607 !important;
}

.cost-input:focus {
    border-color: #ff7607;
    box-shadow: 0 0 0 2px rgba(255, 118, 7, 0.2);
}
</style>';

echo '<script>
// Handle cost editing
$(document).on("click", ".cost-display", function() {
    var container = $(this).closest(".cost-cell-container");
    container.find(".cost-display").hide();
    container.find(".cost-edit").show();
    container.find(".cost-input").focus().select();
});

// Cancel cost editing
$(document).on("click", ".cancel-cost-btn", function() {
    var container = $(this).closest(".cost-cell-container");
    var originalCost = container.data("cost");
    container.find(".cost-input").val(originalCost);
    container.find(".cost-edit").hide();
    container.find(".cost-display").show();
});

// Save cost
$(document).on("click", ".save-cost-btn", function() {
    var container = $(this).closest(".cost-cell-container");
    var maintenanceId = container.data("maintenance-id");
    var newCost = parseFloat(container.find(".cost-input").val()) || 0;
    var saveBtn = $(this);
    
    saveBtn.prop("disabled", true).html("<i class=\"fas fa-spinner fa-spin\"></i>");
    
    $.ajax({
        url: "admin-equipment-update-cost.php",
        type: "POST",
        data: {
            maintenance_id: maintenanceId,
            total_cost: newCost
        },
        success: function(response) {
            if (response.trim() === "success") {
                // Update display
                container.data("cost", newCost);
                var displayText = newCost > 0 ? "$" + newCost.toFixed(2) : "<span style=\"color: #999;\">Not Set</span>";
                container.find(".cost-value").html(displayText);
                container.find(".cost-edit").hide();
                container.find(".cost-display").show();
                
                // Show success message briefly
                var originalHtml = container.find(".cost-display").html();
                container.find(".cost-display").html("<span style=\"color: #28a745;\"><i class=\"fas fa-check\"></i> Updated!</span>");
                setTimeout(function() {
                    container.find(".cost-value").html(displayText);
                    container.find(".cost-display").html(originalHtml);
                }, 2000);
                
                // Reload the modal to update total
                var equipmentId = $("#maintenanceCostModalBody").find("[data-equipment-id]").data("equipment-id");
                setTimeout(function() {
                    $.ajax({
                        url: "admin-equipment-cost-history.php",
                        type: "POST",
                        data: { equipment_id: equipmentId },
                        success: function(response) {
                            $("#maintenanceCostModalBody").html(response);
                        }
                    });
                }, 2500);
            } else {
                alert("Error updating cost: " + response);
            }
        },
        error: function() {
            alert("Error updating cost. Please try again.");
        },
        complete: function() {
            saveBtn.prop("disabled", false).html("<i class=\"fas fa-check\"></i>");
        }
    });
});

// Allow Enter key to save
$(document).on("keypress", ".cost-input", function(e) {
    if (e.which === 13) {
        $(this).siblings(".save-cost-btn").click();
    }
});

// Allow Escape key to cancel
$(document).on("keydown", ".cost-input", function(e) {
    if (e.which === 27) {
        $(this).siblings(".cancel-cost-btn").click();
    }
});
</script>';

mysqli_close($con);
?>
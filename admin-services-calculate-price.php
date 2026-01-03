<?php
include 'includes/connect.php';

if(isset($_POST['request_id'])) {
    $request_id = mysqli_real_escape_string($con, $_POST['request_id']);
    $query = "SELECT 
            land.land_area,
            land.distance_from_office,
            land.terrain_factor,
            service.min_price
          FROM land
          JOIN service_request ON service_request.land_id = land.land_id
          JOIN service ON service_request.service_id = service.service_id
          WHERE service_request.request_id = '$request_id'";

$result = mysqli_query($con, $query);

if($result && mysqli_num_rows($result) > 0) {
    $data = mysqli_fetch_assoc($result);
    
    // Get values (min_price is our base price)
    $basePrice = floatval($data['min_price']);
    $distance = floatval($data['distance_from_office']);
    $terrainFactor = floatval($data['terrain_factor']);
    $area = floatval($data['land_area']);
    
    // Area factor function
    function getAreaFactor($area) {
        if ($area <= 500) return 1.0;
        if ($area <= 1000) return 1.1;
        if ($area <= 2000) return 1.2;
        if ($area <= 5000) return 1.35;
        if ($area <= 10000) return 1.6;
        if ($area <= 20000) return 2.0;
        if ($area <= 50000) return 2.5;
        return null; // Manual quote required
    }
    
    $areaFactor = getAreaFactor($area);
    
    if($areaFactor === null) {
        echo json_encode([
            'error' => true,
            'message' => 'Manual quote required for areas over 50,000 m²'
        ]);
        exit;
    }
    
    // 🎯 FINAL FORMULA
    $distanceCost = $distance * 1; // $1 per km
    $terrainCost = $basePrice * ($terrainFactor - 1);
    $areaCost = $basePrice * ($areaFactor - 1);
    
    $automatedPrice = $basePrice + $distanceCost + $terrainCost + $areaCost;
    
    // Return as JSON
    echo json_encode([
        'automated_price' => number_format($automatedPrice, 2, '.', ''),
        'breakdown' => [
            'base_price' => number_format($basePrice, 2),
            'distance_cost' => number_format($distanceCost, 2),
            'terrain_cost' => number_format($terrainCost, 2),
            'area_cost' => number_format($areaCost, 2),
            'total' => number_format($automatedPrice, 2)
        ],
        'details' => [
            'area' => number_format($area, 0) . ' m²',
            'distance' => number_format($distance, 1) . ' km',
            'terrain_factor' => $terrainFactor,
            'area_factor' => $areaFactor
        ]
    ]);
} else {
    echo json_encode(['error' => true, 'message' => 'Request not found']);
}
} else {
echo json_encode(['error' => true, 'message' => 'Missing request_id']);
}
mysqli_close($con);
?>
<?php
include 'includes/connect.php';

// Fetch office location from database
$officeData = null;
$query = "SELECT coordinates_latitude, coordinates_longitude FROM office LIMIT 1";
$result = mysqli_query($con, $query);

if ($result && mysqli_num_rows($result) > 0) {
    $officeData = mysqli_fetch_assoc($result);
} else {
    // Fallback to default coordinates
    $officeData = [
        'coordinates_latitude' => 34.56677094701796,
        'coordinates_longitude' => 36.086523881335964
    ];
}

// Fetch land coordinates from database using request_id
$landData = null;
$debugInfo = '';
if (isset($_GET['request_id'])) {
    $request_id = (int) $_GET['request_id'];
    
    $landQuery = "SELECT l.coordinates_latitude, l.coordinates_longitude, l.land_number, l.land_address
                  FROM land l
                  JOIN service_request sr ON sr.land_id = l.land_id
                  WHERE sr.request_id = $request_id
                  LIMIT 1";
    
    $landResult = mysqli_query($con, $landQuery);
    
    if ($landResult && mysqli_num_rows($landResult) > 0) {
        $landData = mysqli_fetch_assoc($landResult);
        $debugInfo = "Found land data for request_id: $request_id";
    } else {
        $debugInfo = "No land data found for request_id: $request_id. Query: " . $landQuery;
    }
} else {
    $debugInfo = "No request_id provided in URL";
}

mysqli_close($con);

$landLat = $landData ? floatval($landData['coordinates_latitude']) : null;
$landLng = $landData ? floatval($landData['coordinates_longitude']) : null;
$landInfo = $landData ? $landData['land_number'] . ' - ' . $landData['land_address'] : 'Unknown Land';

// Debug output (comment out in production)
// echo "<!-- Debug: $debugInfo | Lat: $landLat | Lng: $landLng -->";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>View Land Location</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.css" />
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
      overflow: hidden;
    }

    #map {
      width: 100vw;
      height: 100vh;
    }

    .map-controls {
      position: absolute;
      top: 80px;
      left: 20px;
      z-index: 1000;
    }

    .satellite-toggle {
      background: white;
      padding: 10px 16px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.2);
      cursor: pointer;
      border: none;
      font-size: 14px;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 8px;
      transition: all 0.3s;
    }

    .satellite-toggle:hover {
      background: #f8f9fa;
    }

    .satellite-toggle.active {
      background: #0066cc;
      color: white;
    }

    .info-panel {
      position: absolute;
      top: 20px;
      right: 20px;
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.2);
      z-index: 1000;
      max-width: 300px;
    }

    .info-panel h3 {
      margin: 0 0 15px 0;
      font-size: 18px;
      color: #212529;
      border-bottom: 2px solid #0066cc;
      padding-bottom: 8px;
    }

    .info-item {
      margin-bottom: 10px;
      font-size: 14px;
    }

    .info-item strong {
      display: block;
      color: #666;
      font-size: 12px;
      margin-bottom: 3px;
    }

    .info-item span {
      color: #212529;
      font-weight: 600;
    }

    .spinner {
      width: 48px;
      height: 48px;
      border: 3px solid #f3f3f3;
      border-top: 3px solid #0066cc;
      border-radius: 50%;
      animation: spin 1s linear infinite;
      margin: 20px auto;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .legend {
      background: white;
      padding: 15px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.2);
      position: absolute;
      bottom: 20px;
      left: 20px;
      z-index: 1000;
    }

    .legend-item {
      display: flex;
      align-items: center;
      margin-bottom: 8px;
      font-size: 14px;
    }

    .legend-item:last-child {
      margin-bottom: 0;
    }

    .legend-marker {
      width: 20px;
      height: 20px;
      border-radius: 50%;
      margin-right: 10px;
    }

    .marker-red {
      background: #e74c3c;
    }

    .marker-blue {
      background: #3498db;
    }

    .legend-line {
      width: 30px;
      height: 4px;
      background: #e74c3c;
      margin-right: 10px;
      border-radius: 2px;
    }
  </style>
</head>
<body>
  <div id="map"></div>
  
  <!-- Satellite Toggle Button -->
  <div class="map-controls">
    <button id="satelliteToggle" class="satellite-toggle">
      <span>🛰️</span>
      <span id="toggleText">Street View</span>
    </button>
  </div>
  
  <div class="info-panel">
    <h3>📍 Location Details</h3>
    <div id="infoContent">
      <div class="spinner"></div>
      <p style="text-align: center; color: #666;">Loading route information...</p>
    </div>
  </div>

  <div class="legend">
    <div class="legend-item">
      <div class="legend-marker marker-red"></div>
      <span>Office Location</span>
    </div>
    <div class="legend-item">
      <div class="legend-marker marker-blue"></div>
      <span>Land Location</span>
    </div>
    <div class="legend-item">
      <div class="legend-line"></div>
      <span>Driving Route</span>
    </div>
  </div>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.js"></script>
  
  <script>
    // Office and land coordinates from PHP
    const OFFICE = {
      lat: <?php echo $officeData['coordinates_latitude']; ?>,
      lng: <?php echo $officeData['coordinates_longitude']; ?>,
      name: "Office Location"
    };

    const LAND = {
      lat: <?php echo $landLat !== null ? $landLat : 'null'; ?>,
      lng: <?php echo $landLng !== null ? $landLng : 'null'; ?>
    };

    console.log('Office:', OFFICE);
    console.log('Land:', LAND);

    // Check if land coordinates are valid before proceeding
    if (LAND.lat === null || LAND.lng === null) {
      document.getElementById('infoContent').innerHTML = '<p style="color: #e74c3c;">⚠️ Invalid or missing land coordinates in database</p>';
      alert('Land coordinates not found. Please ensure the land has valid coordinates in the database.');
    }

    // Initialize map
    const map = L.map('map').setView([OFFICE.lat, OFFICE.lng], 9);

    // Add street tile layer (default)
    const streetLayer = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors',
      maxZoom: 19
    }).addTo(map);

    // Add satellite tile layer (not added by default)
    const satelliteLayer = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
      attribution: 'Tiles &copy; Esri',
      maxZoom: 19
    });

    // Track which layer is active
    let useSatellite = false;

    // Satellite toggle button handler
    document.getElementById('satelliteToggle').addEventListener('click', function() {
      const toggleBtn = this;
      const toggleText = document.getElementById('toggleText');
      
      if (useSatellite) {
        // Switch to street view
        map.removeLayer(satelliteLayer);
        map.addLayer(streetLayer);
        toggleBtn.classList.remove('active');
        toggleText.textContent = 'Street View';
        useSatellite = false;
      } else {
        // Switch to satellite view
        map.removeLayer(streetLayer);
        map.addLayer(satelliteLayer);
        toggleBtn.classList.add('active');
        toggleText.textContent = 'Satellite View';
        useSatellite = true;
      }
    });

    // Add office marker (red)
    const officeIcon = L.icon({
      iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
      shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
      iconSize: [25, 41],
      iconAnchor: [12, 41],
      popupAnchor: [1, -34],
      shadowSize: [41, 41]
    });

    L.marker([OFFICE.lat, OFFICE.lng], { icon: officeIcon })
      .addTo(map)
      .bindPopup(`<b>${OFFICE.name}</b><br>Starting point`);

    // Check if land coordinates are valid
    if (LAND.lat && LAND.lng && LAND.lat !== null && LAND.lng !== null) {
      // Add land marker (blue)
      const landIcon = L.icon({
        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41]
      });

      L.marker([LAND.lat, LAND.lng], { icon: landIcon })
        .addTo(map)
        .bindPopup('<b>Land Location</b><br><?php echo htmlspecialchars($landInfo); ?>')
        .openPopup();

      // Fit map to show both markers
      const bounds = L.latLngBounds([
        [OFFICE.lat, OFFICE.lng],
        [LAND.lat, LAND.lng]
      ]);
      map.fitBounds(bounds, { padding: [50, 50] });

      // Calculate straight-line distance
      const straightDistance = calculateDistance(OFFICE.lat, OFFICE.lng, LAND.lat, LAND.lng);

      // Get driving route
      getRoute(OFFICE, LAND, straightDistance);
    } else {
      document.getElementById('infoContent').innerHTML = '<p style="color: #e74c3c;">Invalid land coordinates</p>';
    }

    // Calculate distance using Haversine formula
    function calculateDistance(lat1, lon1, lat2, lon2) {
      const R = 6371; // Earth's radius in km
      const dLat = toRad(lat2 - lat1);
      const dLon = toRad(lon2 - lon1);
      const a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);
      const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
      return R * c;
    }

    function toRad(degrees) {
      return degrees * (Math.PI / 180);
    }

    // Fetch and display driving route
    async function getRoute(from, to, straightDistance) {
      try {
        const response = await fetch(
          `https://router.project-osrm.org/route/v1/driving/${from.lng},${from.lat};${to.lng},${to.lat}?overview=full&geometries=geojson`,
          { signal: AbortSignal.timeout(5000) }
        );

        if (!response.ok) throw new Error('Route API failed');
        const data = await response.json();

        if (data.routes && data.routes.length > 0) {
          const route = data.routes[0];
          
          // Draw route on map
          const routeCoords = route.geometry.coordinates.map(coord => [coord[1], coord[0]]);
          L.polyline(routeCoords, {
            color: '#e74c3c',
            weight: 4,
            opacity: 0.7
          }).addTo(map);

          // Display route info
          const drivingDistance = (route.distance / 1000).toFixed(2);
          const duration = (route.duration / 60).toFixed(0);

          document.getElementById('infoContent').innerHTML = `
            <div class="info-item">
              <strong>Straight-Line Distance:</strong>
              <span>${straightDistance.toFixed(2)} km</span>
            </div>
            <div class="info-item">
              <strong>Driving Distance:</strong>
              <span>${drivingDistance} km</span>
            </div>
            <div class="info-item">
              <strong>Estimated Drive Time:</strong>
              <span>${duration} minutes</span>
            </div>
            <div class="info-item">
              <strong>Land Coordinates:</strong>
              <span>${LAND.lat.toFixed(6)}, ${LAND.lng.toFixed(6)}</span>
            </div>
          `;
        } else {
          throw new Error('No route found');
        }
      } catch (error) {
        console.error('Route error:', error);
        document.getElementById('infoContent').innerHTML = `
          <div class="info-item">
            <strong>Straight-Line Distance:</strong>
            <span>${straightDistance.toFixed(2)} km</span>
          </div>
          <div class="info-item">
            <strong>Land Coordinates:</strong>
            <span>${LAND.lat.toFixed(6)}, ${LAND.lng.toFixed(6)}</span>
          </div>
          <p style="color: #856404; background: #fff3cd; padding: 8px; border-radius: 4px; font-size: 12px; margin-top: 10px;">
            ⚠️ Driving route unavailable. Showing straight-line distance only.
          </p>
        `;
      }
    }
  </script>
</body>
</html>
<?php
include 'includes/connect.php';

if (isset($_POST['request_id'])) {
    $request_id = (int) $_POST['request_id'];

    $query = "SELECT l.land_number, l.land_address, l.land_area, l.general_description, l.land_type,
              l.coordinates_latitude, l.coordinates_longitude, l.specific_location_notes, 
              l.elevation_avg, l.elevation_min, l.elevation_max, l.slope, l.distance_from_office,
              l.geometry_approved, l.terrain_approved
              FROM land l
              JOIN service_request sr ON sr.land_id = l.land_id
              WHERE l.geometry_approved = 0 AND l.terrain_approved = 0
              AND sr.request_id = $request_id
              LIMIT 1";

    $result = mysqli_query($con, $query);

    if ($result && $row = mysqli_fetch_assoc($result)) {
        // Helper function to format display values
        function formatValue($value, $unit = '') {
            if (empty($value) || $value === null) {
                return '<span class="text-muted">Not specified</span>';
            }
            return htmlspecialchars($value) . ($unit ? ' ' . $unit : '');
        }
        ?>
        <div id='landInfoData' 
             class='land-details-container'
             data-lat='<?php echo htmlspecialchars($row['coordinates_latitude']); ?>' 
             data-lng='<?php echo htmlspecialchars($row['coordinates_longitude']); ?>'>
            
            <!-- Basic Information Section -->
            <div class='detail-section'>
                <h5 class='section-title'>
                    <i class='fas fa-info-circle'></i> Basic Information
                </h5>
                <div class='detail-grid'>
                    <div class='detail-item'>
                        <span class='detail-label'>Land Number</span>
                        <span class='detail-value'><?php echo formatValue($row['land_number']); ?></span>
                    </div>
                    <div class='detail-item'>
                        <span class='detail-label'>Land Type</span>
                        <span class='detail-value'><?php echo formatValue($row['land_type']); ?></span>
                    </div>
                    <div class='detail-item'>
                        <span class='detail-label'>Land Area</span>
                        <span class='detail-value'><?php echo formatValue($row['land_area'], 'm²'); ?></span>
                        <span class='data-source client'>
                            <i class='fas fa-user'></i> Client Provided
                        </span>
                    </div>
                    <div class='detail-item'>
                        <span class='detail-label'>Distance from Office</span>
                        <span class='detail-value'><?php echo formatValue($row['distance_from_office'], 'km'); ?></span>
                    </div>
                </div>
            </div>

            <!-- Location Section -->
            <div class='detail-section'>
                <h5 class='section-title'>
                    <i class='fas fa-map-marker-alt'></i> Location Details
                    <span class='section-badge client'>
                        <i class='fas fa-user'></i> Client Provided
                    </span>
                </h5>
                <div class='detail-grid'>
                    <div class='detail-item full-width'>
                        <span class='detail-label'>Address</span>
                        <span class='detail-value'><?php echo formatValue($row['land_address']); ?></span>
                    </div>
                    <div class='detail-item'>
                        <span class='detail-label'>Latitude</span>
                        <span class='detail-value'><?php echo formatValue($row['coordinates_latitude'], '°'); ?></span>
                    </div>
                    <div class='detail-item'>
                        <span class='detail-label'>Longitude</span>
                        <span class='detail-value'><?php echo formatValue($row['coordinates_longitude'], '°'); ?></span>
                    </div>
                    <?php if (!empty($row['specific_location_notes'])): ?>
                    <div class='detail-item full-width'>
                        <span class='detail-label'>Location Notes</span>
                        <span class='detail-value'><?php echo formatValue($row['specific_location_notes']); ?></span>
                    </div>
                    <?php endif; ?>
                </div>
                <div class='info-notice'>
                    <i class='fas fa-info-circle'></i>
                    <span>These coordinates are provided by the client and pending surveyor verification.</span>
                </div>
            </div>

            <!-- Terrain Information Section -->
            <div class='detail-section'>
                <h5 class='section-title'>
                    <i class='fas fa-mountain'></i> Terrain Information
                    <span class='section-badge client'>
                        <i class='fas fa-user'></i> Client Provided
                    </span>
                </h5>
                <div class='detail-grid terrain-grid'>
                    <div class='detail-item'>
                        <span class='detail-label'>Average Elevation</span>
                        <span class='detail-value highlight'><?php echo formatValue($row['elevation_avg'], 'm'); ?></span>
                    </div>
                    <div class='detail-item'>
                        <span class='detail-label'>Min Elevation</span>
                        <span class='detail-value'><?php echo formatValue($row['elevation_min'], 'm'); ?></span>
                    </div>
                    <div class='detail-item'>
                        <span class='detail-label'>Max Elevation</span>
                        <span class='detail-value'><?php echo formatValue($row['elevation_max'], 'm'); ?></span>
                    </div>
                    <div class='detail-item'>
                        <span class='detail-label'>Slope</span>
                        <span class='detail-value'><?php echo formatValue($row['slope'], '°'); ?></span>
                    </div>
                </div>
                <div class='info-notice'>
                    <i class='fas fa-info-circle'></i>
                    <span>These terrain measurements are provided by the client and pending surveyor verification.</span>
                </div>
            </div>

            <!-- Description Section -->
            <?php if (!empty($row['general_description'])): ?>
            <div class='detail-section'>
                <h5 class='section-title'>
                    <i class='fas fa-file-alt'></i> General Description
                </h5>
                <div class='description-content'>
                    <p><?php echo nl2br(htmlspecialchars($row['general_description'])); ?></p>
                </div>
            </div>
            <?php endif; ?>

            <!-- Status Section -->
            <div class='detail-section status-section'>
                <h5 class='section-title'>
                    <i class='fas fa-check-circle'></i> Approval Status
                </h5>
                <div class='status-badges'>
                    <span class='badge badge-warning'>
                        <i class='fas fa-clock'></i> Geometry Pending
                    </span>
                    <span class='badge badge-warning'>
                        <i class='fas fa-clock'></i> Terrain Pending
                    </span>
                </div>
            </div>
        </div>

        <style>
            * {
                box-sizing: border-box;
            }

            .land-details-container {
                padding: 0;
                max-height: 70vh;
                overflow-y: auto;
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            }

            .detail-section {
                margin-bottom: 0;
                padding: 24px;
                border-bottom: 1px solid #e5e7eb;
                background: #ffffff;
                transition: background-color 0.2s ease;
            }

            .detail-section:hover {
                background-color: #f9fafb;
            }

            .detail-section:last-child {
                border-bottom: none;
            }

            .status-section {
                background: #f8fafc;
            }

            .section-title {
                color: #1f2937;
                font-size: 15px;
                font-weight: 600;
                margin: 0 0 18px 0;
                display: flex;
                align-items: center;
                gap: 10px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                flex-wrap: wrap;
            }

            .section-title i {
                color: #3b82f6;
                font-size: 16px;
            }

            .section-badge {
                padding: 4px 12px;
                border-radius: 4px;
                font-size: 11px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                text-transform: uppercase;
                letter-spacing: 0.3px;
                margin-left: auto;
            }

            .section-badge.client {
                background-color: #dbeafe;
                color: #1e40af;
                border: 1px solid #93c5fd;
            }

            .section-badge i {
                font-size: 10px;
            }

            .data-source {
                font-size: 11px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 4px;
                padding: 3px 8px;
                border-radius: 4px;
                margin-top: 4px;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .data-source.client {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .data-source i {
                font-size: 10px;
            }

            .info-notice {
                margin-top: 16px;
                padding: 12px 16px;
                background-color: #eff6ff;
                border-left: 3px solid #3b82f6;
                border-radius: 4px;
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 13px;
                color: #1e40af;
                line-height: 1.5;
            }

            .info-notice i {
                font-size: 16px;
                color: #3b82f6;
                flex-shrink: 0;
            }

            .detail-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
            }

            .terrain-grid {
                grid-template-columns: repeat(4, 1fr);
            }

            .detail-item {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .detail-item.full-width {
                grid-column: 1 / -1;
            }

            .detail-label {
                font-size: 12px;
                color: #6b7280;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .detail-value {
                font-size: 15px;
                color: #111827;
                font-weight: 500;
                line-height: 1.5;
            }

            .detail-value.highlight {
                color: #2563eb;
                font-weight: 600;
            }

            .text-muted {
                color: #9ca3af !important;
                font-style: italic;
                font-weight: 400 !important;
            }

            .description-content {
                background-color: #f9fafb;
                padding: 16px 18px;
                border-radius: 8px;
                border-left: 4px solid #3b82f6;
            }

            .description-content p {
                margin: 0;
                line-height: 1.7;
                color: #374151;
                font-size: 14px;
            }

            .status-badges {
                display: flex;
                gap: 12px;
                flex-wrap: wrap;
            }

            .badge {
                padding: 10px 18px;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .badge-warning {
                background-color: #fef3c7;
                color: #92400e;
                border: 1px solid #fde68a;
            }

            .badge i {
                font-size: 14px;
            }

            /* Scrollbar Styling */
            .land-details-container::-webkit-scrollbar {
                width: 6px;
            }

            .land-details-container::-webkit-scrollbar-track {
                background: #f3f4f6;
            }

            .land-details-container::-webkit-scrollbar-thumb {
                background: #d1d5db;
                border-radius: 10px;
            }

            .land-details-container::-webkit-scrollbar-thumb:hover {
                background: #9ca3af;
            }

            /* Responsive Design */
            @media (max-width: 992px) {
                .terrain-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 768px) {
                .detail-grid,
                .terrain-grid {
                    grid-template-columns: 1fr;
                }
                
                .land-details-container {
                    max-height: 60vh;
                }

                .detail-section {
                    padding: 20px 16px;
                }

                .section-title {
                    font-size: 14px;
                }

                .detail-value {
                    font-size: 14px;
                }

                .section-badge {
                    font-size: 10px;
                    padding: 3px 10px;
                }

                .info-notice {
                    font-size: 12px;
                    padding: 10px 12px;
                }
            }
        </style>
        <?php
    } else {
        ?>
        <div class='alert-container'>
            <div class='alert alert-info'>
                <i class='fas fa-info-circle'></i>
                <div class='alert-content'>
                    <strong>No Data Found</strong>
                    <p>No land information found for this request.</p>
                </div>
            </div>
        </div>
        <style>
            .alert-container {
                padding: 32px 24px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 200px;
            }
            
            .alert {
                padding: 20px 24px;
                border-radius: 8px;
                display: flex;
                align-items: flex-start;
                gap: 16px;
                max-width: 500px;
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            }
            
            .alert-info {
                background-color: #dbeafe;
                color: #1e40af;
                border: 1px solid #93c5fd;
            }
            
            .alert i {
                font-size: 24px;
                margin-top: 2px;
                flex-shrink: 0;
            }

            .alert-content {
                flex: 1;
            }

            .alert-content strong {
                display: block;
                font-size: 15px;
                margin-bottom: 6px;
                font-weight: 600;
            }

            .alert-content p {
                margin: 0;
                font-size: 14px;
                line-height: 1.5;
                opacity: 0.9;
            }
        </style>
        <?php
    }
} else {
    ?>
    <div class='alert-container'>
        <div class='alert alert-danger'>
            <i class='fas fa-exclamation-triangle'></i>
            <div class='alert-content'>
                <strong>Invalid Request</strong>
                <p>The request could not be processed. Please try again or contact support if the issue persists.</p>
            </div>
        </div>
    </div>
    <style>
        .alert-container {
            padding: 32px 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 200px;
        }
        
        .alert {
            padding: 20px 24px;
            border-radius: 8px;
            display: flex;
            align-items: flex-start;
            gap: 16px;
            max-width: 500px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }
        
        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
        
        .alert i {
            font-size: 24px;
            margin-top: 2px;
            flex-shrink: 0;
        }

        .alert-content {
            flex: 1;
        }

        .alert-content strong {
            display: block;
            font-size: 15px;
            margin-bottom: 6px;
            font-weight: 600;
        }

        .alert-content p {
            margin: 0;
            font-size: 14px;
            line-height: 1.5;
            opacity: 0.9;
        }
    </style>
    <?php
}

mysqli_close($con);
?>
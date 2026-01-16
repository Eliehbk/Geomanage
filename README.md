# 🌍 GeoManage – Enterprise Surveying & Land Management System

> A collaborative full-stack web application for surveying engineering firms to manage land operations, client services, HR workflows, and field equipment

[![Original Repository](https://img.shields.io/badge/Original-Repository-blue)](https://github.com/Georges266/Geomanage)

---

## 📋 About This Fork

This is a fork of **GeoManage**, a senior project developed collaboratively by a team of 2 developers for a surveying engineering firm. This repository showcases **my contributions** to the system, including the complete development of the Client Portal, HR Management Module, Surveyor Field Operations, and Maintenance Technician workflows.

**Original Repository**: [Georges266/Geomanage](https://github.com/Georges266/Geomanage)  
**Team Size**: 2 Developers  
**My Role**: Full-Stack Developer (Client Portal, HR, Surveyor & Salesperson Modules)  
**Partner's Role**: Full-Stack Developer (Admin, Lead Engineer & Maintenance Technician)

---

## 🎯 Project Overview

GeoManage is an enterprise-grade web application designed for surveying engineering firms to streamline land management, client service requests, employee workflows, and equipment maintenance. The system serves multiple stakeholders including clients, HR personnel, surveyors, technicians, engineers, and administrators.

**Industry Context**: Surveying Engineering Firm Operations  
**Purpose**: Digitize and automate land assessment, service delivery, HR processes, and field operations

---

## 🔧 My Contributions

I was responsible for developing four complete user-facing modules from database design to frontend implementation:

### 1. 🏘️ Client Portal & Land Marketplace

**Client-Side Features I Built**:

**Features I Built**:
- **Land Marketplace System**
  - Clients can upload land listings for sale
  - Interactive map tool for land boundary drawing
  - Automatic photo generation from drawn land maps for listings
  - Browse and search available land listings
  
- **Service Request Workflow**
  - Request surveying services for owned land
  - **Dual input methods I created**:
    - Manual land information entry
    - **Custom map drawing tool** that auto-calculates land metrics (area, perimeter, coordinates, elevation)
  - Upload supporting documents
  - Track service request status
  
- **ML-Powered Land Valuation**
  - Built and integrated **machine learning model** for land price prediction
  - Clients can estimate their land value based on features
  - Uses engineered features from land data
  
- **Project Dashboard**
  - View assigned projects and their status
  - Access project deliverables (if payment is completed)
  - Track service progress
  
- **Job Application System**
  - Clients can apply for positions at the firm
  - Upload CV and cover letter
  - Track application status

- **Authentication System**
  - User registration with role assignment
  - Secure login with session management

**Technologies Used**: PHP, MySQL, JavaScript, Leaflet.js, Python (scikit-learn for ML), HTML5/CSS3

---

### 2. 👥 HR Management Module

**Features I Built**:
- **Job Opportunity Management**
  - Create, edit, and publish job postings
  - Open/close positions
  - Automatic rejection emails when positions close
  
- **Application Processing System**
  - View all submitted job applications
  - Download and review uploaded CVs
  - **Application actions**:
    - Hire candidates (automatically creates employee records)
    - Reject applications (with notification)
    - Schedule interviews
  
- **Interview Scheduling**
  - Calendar-based appointment system
  - View personal interview schedule
  - Reschedule appointments with applicants
  
- **Employee Management**
  - Promote employees to different roles
  - Terminate employment
  - Salary adjustments (increase/decrease)
  - Employee directory with role-based filtering

**Technologies Used**: PHP, MySQL, JavaScript, HTML5/CSS3, Session Management

---

### 3. 🗺️ Surveyor Field Operations Module

**Features I Built**:
- **Project Assignment Dashboard**
  - View assigned surveying projects
  - Access all lands within each project
  - See all requested services per land
  
- **Land Data Management**
  - Update land information based on field surveillance
  - Input actual measurements and findings
  - Override client-submitted data with verified information
  
- **Document Management**
  - Upload missing land documentation
  - Submit project deliverables (reports, maps, analysis)
  - Organize files by project and land
  
- **Equipment Tracking**
  - View equipment assigned to current project
  - Real-time equipment status monitoring
  - Request maintenance for faulty equipment
  - Document equipment issues with descriptions

**Technologies Used**: PHP, MySQL, JavaScript, File Upload Handling, HTML5/CSS3

---

### 4. 💼 Salesperson Module

**Features I Built**:
- **Land Sale Request Management**
  - View all client-submitted land listings awaiting approval
  - Review land details and marketplace listings
  - Approve or reject land sale requests
  
- **Sales Processing**
  - Mark approved lands as "Sold" when transactions complete
  - Track sales pipeline (pending → approved → sold)
  - Manage active land listings in the marketplace

**Technologies Used**: PHP, MySQL, JavaScript, HTML5/CSS3

---

## 💻 Technical Implementation Highlights

### Database Design
- Designed relational schema for:
  - Land listings and marketplace transactions
  - Service requests with land associations
  - Job postings and applications with status tracking
  - Employee records with salary history
  - Interview scheduling with calendar integration
  - Equipment assignment and maintenance logs
  - Land sale approvals and sales tracking workflow
- Implemented foreign key constraints for data integrity
- Optimized queries for complex joins (projects → lands → services)

### Map Drawing Tool (Custom Feature)
- Built interactive land boundary drawing tool using **Leaflet.js**
- **Auto-calculation engine** I developed:
  - Area calculation using polygon coordinates
  - Perimeter measurement
  - Center point coordinates
  - Elevation data extraction from map APIs
- Photo generation from map canvas for land listings
- GeoJSON export for land boundaries

### Machine Learning Integration
- Trained **regression model** for land price prediction using Python (scikit-learn)
- Feature engineering from land characteristics (area, location, elevation, etc.)
- PHP interface to Python model for real-time predictions
- Model serves as decision-support tool for clients

### File Management System
- Secure file upload with validation (CV, land documents, deliverables)
- Organized storage structure by user/project/type
- Access control based on user roles and payment status

### Email Automation
- Automated notifications for:
  - Job application status changes
  - Interview scheduling
  - Position closure (mass rejection emails)
  - Service request updates
  - Land sale approval notifications
- Used PHPMailer for reliable email delivery

---

## 🏗️ Architecture

**My Modules Follow MVC Pattern**:
```
Client Request → PHP Controller → Business Logic → MySQL Database
                      ↓
                 View Rendering → Dynamic HTML/JS → User Interface
```

**Key Design Decisions I Made**:
- Separated land data entry (manual vs. map-based) for user flexibility
- Centralized equipment tracking across surveyor and technician roles
- Interview scheduling integrated with HR calendar for conflict prevention
- ML model exposed via API endpoint for frontend integration
- Approval workflow for land listings to ensure quality control

---

## 🛠️ Tech Stack (My Work)

| Layer | Technology |
|----------------|-------------------------------|
| **Backend** | PHP 7.4+ |
| **Database** | MySQL 8.0 (Schema Design) |
| **Frontend** | HTML5, CSS3, Vanilla JavaScript |
| **Mapping** | Leaflet.js, OpenStreetMap |
| **ML Model** | Python (scikit-learn) |
| **Email** | PHPMailer |
| **File Handling** | PHP File Upload API |
| **Authentication** | PHP Sessions |

---

## 🎓 Skills Demonstrated

Through my contributions to GeoManage, I demonstrated proficiency in:

- **Full-Stack Development**: End-to-end feature development from database to UI
- **Geospatial Programming**: Interactive map tools with calculation engines
- **Machine Learning Integration**: Model training, deployment, and web integration
- **Database Design**: Normalized schemas with complex relationships
- **API Development**: RESTful-style endpoints for AJAX operations
- **File Management**: Secure upload, storage, and access control
- **Email Automation**: Transactional emails with dynamic content
- **Business Logic**: Workflow automation (job applications, equipment tracking)
- **User Experience**: Dual input methods for different user preferences

---

## 📁 Project Structure (My Modules)

```
Geomanage/
├── client/                 # Client portal pages
│   ├── marketplace.php     # Land listings
│   ├── request_service.php # Service requests with map tool
│   ├── ml_valuation.php    # Land price prediction
│   └── my_projects.php     # Project dashboard
├── hr/                     # HR management
│   ├── job_postings.php    # Create/manage positions
│   ├── applications.php    # Process applications
│   ├── schedule.php        # Interview calendar
│   └── employees.php       # Employee management
├── surveyor/               # Surveyor operations
│   ├── projects.php        # Assigned projects
│   ├── update_land.php     # Field data entry
│   ├── deliverables.php    # Upload reports
│   └── equipment.php       # Equipment tracking
├── salesperson/            # Sales module
│   ├── pending_lands.php   # Review land sale requests
│   └── manage_sales.php    # Approve/mark as sold
├── models/                 # ML model files
│   └── land_price_model.pkl
├── uploads/                # User-uploaded files
│   ├── cvs/
│   ├── land_docs/
│   └── deliverables/
└── assets/                 # CSS, JS, images
```

---

## 🚀 Installation & Setup

### Prerequisites
- PHP 7.4+
- MySQL 8.0+
- XAMPP/WAMP (Apache + MySQL)
- Python 3.8+ (for ML model)

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/[your-username]/Geomanage.git
   cd Geomanage
   ```

2. Import database:
   - Open phpMyAdmin (`http://localhost/phpmyadmin`)
   - Create database: `geomanage`
   - Import SQL file from `database/geomanage.sql`

3. Configure database connection in `config/database.php`:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USER', 'root');
   define('DB_PASS', '');
   define('DB_NAME', 'geomanage');
   ```

4. Start Apache & MySQL via XAMPP Control Panel

5. Access application: `http://localhost/Geomanage`


---


## 🤝 Collaboration

This project was developed in partnership with **Georges266** who implemented:
- Admin dashboard and system configuration
- Lead Engineer project management
- Maintenance Technician equipment workflows
- Financial tracking and reporting
- Automated pricing engine

**Division of Work**: We split the system into user-facing modules, with clear separation of responsibilities while maintaining consistent architecture and database design.

---

## 🔮 Future Enhancements (Ideas)

- [ ] Mobile app for surveyors (offline field data collection)
- [ ] Advanced ML models (project timeline prediction, equipment failure prediction)
- [ ] Real-time notifications using WebSockets
- [ ] Multi-language support for international clients
- [ ] Cloud deployment (AWS/Azure)
- [ ] API documentation for third-party integrations

---

## 📞 Contact

I'm happy to discuss my contributions, technical decisions, and the development process in detail.

📧 eliehabka987@gmail.com  

---

## 🙏 Acknowledgments

- **Project Partner**: Georges deeb - for seamless collaboration and complementary development
- **Academic Advisors**: For guidance and feedback throughout the project
- **Open-Source Community**: Leaflet.js, PHPMailer, and other libraries used

---

**⭐ If you find this project interesting or want to learn more about my approach to full-stack development, feel free to reach out!**

---

## 📄 License

This project was developed as an academic senior project. Please contact for usage permissions.

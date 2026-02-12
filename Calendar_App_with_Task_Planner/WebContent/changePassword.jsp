<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password | Calendar System</title>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: #f5f7fa;
            height: 100vh;
            overflow: hidden;
        }
        
        .dashboard {
            display: flex;
            height: 100vh;
        }
        
        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            background: linear-gradient(180deg, #2c3e50 0%, #1a2530 100%);
            color: white;
            padding-top: 20px;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        }
        
        .nav-menu {
            list-style: none;
        }
        
        .nav-item {
            margin-bottom: 5px;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: #ecf0f1;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }
        
        .nav-link:hover {
            background: rgba(255, 255, 255, 0.1);
            border-left: 4px solid #3498db;
        }
        
        .nav-link.active {
            background: rgba(52, 152, 219, 0.2);
            border-left: 4px solid #3498db;
            color: white;
        }
        
        .nav-link i {
            width: 25px;
            margin-right: 15px;
            font-size: 18px;
        }
        
        .nav-link span {
            font-size: 16px;
        }
        
        /* Main Content Styles */
        .main-content {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e6ed;
        }
        
        .header h1 {
            color: #2c3e50;
            font-size: 28px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-info span {
            color: #2c3e50;
            font-weight: 600;
        }
        
        .logout-btn {
            padding: 8px 20px;
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background: #c0392b;
        }
        
        /* Change Password Specific Styles */
        .content-area {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
            min-height: 500px;
        }
        
        .section-title {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 24px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e6ed;
        }
        
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            max-width: 600px;
            margin: 0 auto;
            border: 1px solid #e9ecef;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 600;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            padding-right: 40px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 38px;
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
            font-size: 18px;
        }
        
        .password-toggle:hover {
            color: #3498db;
        }
        
        .password-strength {
            margin-top: 8px;
            height: 5px;
            background: #e9ecef;
            border-radius: 3px;
            overflow: hidden;
        }
        
        .strength-meter {
            height: 100%;
            width: 0;
            transition: width 0.3s, background-color 0.3s;
        }
        
        .strength-weak {
            background-color: #e74c3c;
        }
        
        .strength-medium {
            background-color: #f39c12;
        }
        
        .strength-strong {
            background-color: #2ecc71;
        }
        
        .strength-text {
            font-size: 14px;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .password-requirements {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            margin-top: 10px;
            font-size: 14px;
            color: #6c757d;
        }
        
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }
        
        .requirement i {
            margin-right: 8px;
            font-size: 12px;
        }
        
        .requirement.valid {
            color: #2ecc71;
        }
        
        .requirement.invalid {
            color: #e74c3c;
        }
        
        .btn-submit {
            padding: 12px 30px;
            background: #2ecc71;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
        }
        
        .btn-submit:hover {
            background: #27ae60;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-submit:disabled {
            background: #95a5a6;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .btn-secondary {
            padding: 12px 30px;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        .message {
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        /* Logout Modal Styles */
        .logout-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .logout-modal-content {
            background: white;
            padding: 30px;
            border-radius: 10px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.3);
            animation: modalSlideIn 0.3s ease;
            text-align: center;
        }
        
        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .logout-modal-icon {
            color: #e74c3c;
            font-size: 50px;
            margin-bottom: 20px;
        }
        
        .logout-modal-title {
            color: #2c3e50;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .logout-modal-message {
            color: #495057;
            font-size: 16px;
            line-height: 1.5;
            margin-bottom: 25px;
        }
        
        .logout-modal-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        
        .btn-logout-confirm {
            padding: 10px 25px;
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-logout-confirm:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-logout-cancel {
            padding: 10px 25px;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-logout-cancel:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }
            
            .nav-link span {
                display: none;
            }
            
            .nav-link i {
                margin-right: 0;
                font-size: 20px;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .logout-modal-actions {
                flex-direction: column;
            }
            
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .user-info {
                align-self: flex-end;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<%
    /* ===============================
       PROCESS PASSWORD CHANGE USING POST
       =============================== */
    String username = (String) session.getAttribute("username");
    
    // Check if user is logged in
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");

    if("POST".equalsIgnoreCase(request.getMethod())) {

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        Connection con2 = null;
        PreparedStatement pst2 = null;
        ResultSet rs2 = null;

        try {
            // Validate input
            if (currentPassword == null || currentPassword.trim().isEmpty() ||
                newPassword == null || newPassword.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
                
                response.sendRedirect("changePassword.jsp?error=All fields are required!");
                return;
            }
            
            // Check if new passwords match
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("changePassword.jsp?error=New passwords do not match!");
                return;
            }
            
            // Check if new password is same as current password
            if (currentPassword.equals(newPassword)) {
                response.sendRedirect("changePassword.jsp?error=New password must be different from current password!");
                return;
            }
            
            // Validate password strength
            if (newPassword.length() < 8) {
                response.sendRedirect("changePassword.jsp?error=New password must be at least 8 characters long!");
                return;
            }
            
            Class.forName("com.mysql.jdbc.Driver");
            con2 = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/calendar_system?useSSL=false&serverTimezone=UTC",
                "root", ""
            );

            // Verify current password
            String checkQuery = "SELECT password FROM register WHERE username = ?";
            pst2 = con2.prepareStatement(checkQuery);
            pst2.setString(1, username);
            rs2 = pst2.executeQuery();
            
            if (rs2.next()) {
                String storedPassword = rs2.getString("password");
                
                // Check if current password matches
                if (!storedPassword.equals(currentPassword)) {
                    response.sendRedirect("changePassword.jsp?error=Current password is incorrect!");
                    return;
                }
                
                // Close previous statement
                pst2.close();
                
                // Update password
                String updateQuery = "UPDATE register SET password = ? WHERE username = ?";
                pst2 = con2.prepareStatement(updateQuery);
                pst2.setString(1, newPassword);
                pst2.setString(2, username);
                
                int rows = pst2.executeUpdate();
                
                if(rows > 0){
                    // Password changed successfully - stay logged in
                    response.sendRedirect("changePassword.jsp?success=Password changed successfully!");
                    return;
                } else {
                    response.sendRedirect("changePassword.jsp?error=Failed to change password");
                    return;
                }
                
            } else {
                // User not found
                response.sendRedirect("changePassword.jsp?error=User not found!");
                return;
            }

        } catch(Exception ex){
            ex.printStackTrace();
            response.sendRedirect("changePassword.jsp?error=Server Error: " + ex.getMessage());
            return;
        } finally {
            try { if(rs2 != null) rs2.close(); } catch(Exception e){}
            try { if(pst2 != null) pst2.close(); } catch(Exception e){}
            try { if(con2 != null) con2.close(); } catch(Exception e){}
        }
    }
%>

    <div class="dashboard">
        <nav class="sidebar">
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="dashboard.jsp" class="nav-link">
                        <i class="fas fa-calendar-alt"></i>
                        <span>View Calendar</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="addTask.jsp" class="nav-link">
                        <i class="fas fa-plus-circle"></i>
                        <span>Add Task</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="viewAllTasks.jsp" class="nav-link">
                        <i class="fas fa-list-ul"></i>
                        <span>View All Tasks</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="searchTask.jsp" class="nav-link">
                        <i class="fas fa-search"></i>
                        <span>Search Task</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="editTask.jsp" class="nav-link">
                        <i class="fas fa-edit"></i>
                        <span>Edit Task</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="deleteTask.jsp" class="nav-link">
                        <i class="fas fa-trash-alt"></i>
                        <span>Delete Task</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="changePassword.jsp" class="nav-link active">
                        <i class="fas fa-key"></i>
                        <span>Change Password</span>
                    </a>
                </li>
            </ul>
        </nav>
        
        <div class="main-content">
            <div class="header">
                <h1>Task Management Dashboard</h1>
                <div class="user-info">
                    <span>Welcome, <%= username %></span>
                    <button onclick="showLogoutConfirmation()" class="logout-btn">Logout</button>
                </div>
            </div>
            
            <div class="content-area">
                <h2 class="section-title">Change Password</h2>
                
                <% if (successMsg != null) { %>
                    <div class="message success">
                        <i class="fas fa-check-circle"></i> <%= successMsg %>
                    </div>
                <% } %>
                
                <% if (errorMsg != null) { %>
                    <div class="message error">
                        <i class="fas fa-exclamation-circle"></i> <%= errorMsg %>
                    </div>
                <% } %>
                
               
                
                <!-- Change Password Form -->
                <div class="form-container">
                    <form action="changePassword.jsp" method="post" id="passwordForm">
                        <div class="form-group">
                            <label for="currentPassword">
                                <i class="fas fa-lock"></i> Current Password *
                            </label>
                            <input type="password" id="currentPassword" name="currentPassword" class="form-control" 
                                   placeholder="Enter your current password" required>
                            <button type="button" class="password-toggle" onclick="togglePassword('currentPassword', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        
                        <div class="form-group">
                            <label for="newPassword">
                                <i class="fas fa-key"></i> New Password *
                            </label>
                            <input type="password" id="newPassword" name="newPassword" class="form-control" 
                                   placeholder="Enter new password" required>
                            <button type="button" class="password-toggle" onclick="togglePassword('newPassword', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                            
                            <!-- Password Strength Meter -->
                            <div class="password-strength">
                                <div class="strength-meter" id="strengthMeter"></div>
                            </div>
                            <div class="strength-text" id="strengthText">Password strength: None</div>
                            
                            <!-- Password Requirements -->
                            <div class="password-requirements">
                                <div class="requirement" id="reqLength">
                                    <i class="fas fa-circle"></i> At least 8 characters
                                </div>
                                <div class="requirement" id="reqUppercase">
                                    <i class="fas fa-circle"></i> At least one uppercase letter
                                </div>
                                <div class="requirement" id="reqLowercase">
                                    <i class="fas fa-circle"></i> At least one lowercase letter
                                </div>
                                <div class="requirement" id="reqNumber">
                                    <i class="fas fa-circle"></i> At least one number
                                </div>
                                <div class="requirement" id="reqSpecial">
                                    <i class="fas fa-circle"></i> At least one special character (!@#$%^&*)
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="confirmPassword">
                                <i class="fas fa-key"></i> Confirm New Password *
                            </label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                                   placeholder="Confirm new password" required>
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                            <div class="strength-text" id="matchText">Passwords must match</div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="submit" class="btn-submit" id="submitBtn" disabled>
                                <i class="fas fa-save"></i> Change Password
                            </button>
                            <a href="dashboard.jsp" class="btn-secondary">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Logout Confirmation Modal -->
    <div class="logout-modal" id="logoutModal">
        <div class="logout-modal-content">
            <i class="fas fa-sign-out-alt logout-modal-icon"></i>
            <div class="logout-modal-title">Confirm Logout</div>
            <div class="logout-modal-message">
                Are you sure you want to logout from the system?
            </div>
            <div class="logout-modal-actions">
                <button type="button" class="btn-logout-confirm" onclick="performLogout()">
                    <i class="fas fa-check"></i> Yes, Logout
                </button>
                <button type="button" class="btn-logout-cancel" onclick="hideLogoutConfirmation()">
                    <i class="fas fa-times"></i> Cancel
                </button>
            </div>
        </div>
    </div>
    
    <script>
        // Toggle password visibility
        function togglePassword(fieldId, button) {
            const field = document.getElementById(fieldId);
            const icon = button.querySelector('i');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        // Password validation setup
        document.addEventListener('DOMContentLoaded', function() {
            const newPassword = document.getElementById('newPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            const currentPassword = document.getElementById('currentPassword');
            const submitBtn = document.getElementById('submitBtn');
            
            let passwordValid = false;
            let passwordsMatch = false;
            
            // Check password strength
            newPassword.addEventListener('input', function() {
                const password = this.value;
                checkPasswordStrength(password);
                checkRequirements(password);
                validateForm();
            });
            
            // Check password match
            confirmPassword.addEventListener('input', function() {
                checkPasswordMatch();
                validateForm();
            });
            
            currentPassword.addEventListener('input', validateForm);
            
            function checkPasswordStrength(password) {
                let strength = 0;
                const meter = document.getElementById('strengthMeter');
                const text = document.getElementById('strengthText');
                
                if (password.length >= 8) strength++;
                if (password.length >= 12) strength++;
                if (/[A-Z]/.test(password)) strength++;
                if (/[a-z]/.test(password)) strength++;
                if (/[0-9]/.test(password)) strength++;
                if (/[^A-Za-z0-9]/.test(password)) strength++;
                
                let strengthClass = 'strength-weak';
                let strengthText = 'Weak';
                
                if (strength >= 5) {
                    strengthClass = 'strength-strong';
                    strengthText = 'Strong';
                    passwordValid = true;
                } else if (strength >= 3) {
                    strengthClass = 'strength-medium';
                    strengthText = 'Medium';
                    passwordValid = true;
                } else {
                    passwordValid = false;
                }
                
                meter.className = 'strength-meter ' + strengthClass;
                meter.style.width = (strength * 16.66) + '%';
                text.textContent = 'Password strength: ' + strengthText;
            }
            
            function checkRequirements(password) {
                const requirements = {
                    length: password.length >= 8,
                    uppercase: /[A-Z]/.test(password),
                    lowercase: /[a-z]/.test(password),
                    number: /[0-9]/.test(password),
                    special: /[^A-Za-z0-9]/.test(password)
                };
                
                document.getElementById('reqLength').className = requirements.length ? 'requirement valid' : 'requirement invalid';
                document.getElementById('reqUppercase').className = requirements.uppercase ? 'requirement valid' : 'requirement invalid';
                document.getElementById('reqLowercase').className = requirements.lowercase ? 'requirement valid' : 'requirement invalid';
                document.getElementById('reqNumber').className = requirements.number ? 'requirement valid' : 'requirement invalid';
                document.getElementById('reqSpecial').className = requirements.special ? 'requirement valid' : 'requirement invalid';
                
                const requirementsElements = document.querySelectorAll('.requirement i');
                requirementsElements.forEach((icon, index) => {
                    const reqKey = Object.keys(requirements)[index];
                    if (requirements[reqKey]) {
                        icon.className = 'fas fa-check-circle';
                    } else {
                        icon.className = 'fas fa-times-circle';
                    }
                });
            }
            
            function checkPasswordMatch() {
                const newPass = document.getElementById('newPassword').value;
                const confirmPass = document.getElementById('confirmPassword').value;
                const matchText = document.getElementById('matchText');
                
                if (confirmPass.length === 0) {
                    matchText.textContent = 'Passwords must match';
                    matchText.style.color = '#6c757d';
                    passwordsMatch = false;
                } else if (newPass === confirmPass) {
                    matchText.textContent = '✓ Passwords match';
                    matchText.style.color = '#2ecc71';
                    passwordsMatch = true;
                } else {
                    matchText.textContent = '✗ Passwords do not match';
                    matchText.style.color = '#e74c3c';
                    passwordsMatch = false;
                }
            }
            
            function validateForm() {
                const currentPass = document.getElementById('currentPassword').value;
                const newPass = document.getElementById('newPassword').value;
                const confirmPass = document.getElementById('confirmPassword').value;
                
                if (currentPass && newPass && currentPass === newPass) {
                    submitBtn.disabled = true;
                    submitBtn.title = "New password must be different from current password";
                    return;
                }
                
                if (currentPass && newPass && confirmPass && 
                    passwordValid && passwordsMatch && 
                    currentPass !== newPass) {
                    submitBtn.disabled = false;
                    submitBtn.title = "Click to change password";
                } else {
                    submitBtn.disabled = true;
                    submitBtn.title = "Please fill all fields and meet password requirements";
                }
            }
        });
        
        // Show logout confirmation modal
        function showLogoutConfirmation() {
            const modal = document.getElementById('logoutModal');
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';
            
            setTimeout(() => {
                document.querySelector('.btn-logout-cancel').focus();
            }, 100);
        }
        
        // Hide logout confirmation modal
        function hideLogoutConfirmation() {
            const modal = document.getElementById('logoutModal');
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
            document.querySelector('.logout-btn').focus();
        }
        
        // Perform logout action
        function performLogout() {
            hideLogoutConfirmation();
            
            const loadingOverlay = document.createElement('div');
            loadingOverlay.className = 'logout-modal';
            loadingOverlay.style.display = 'flex';
            loadingOverlay.innerHTML = `
                <div class="logout-modal-content" style="text-align: center;">
                    <i class="fas fa-spinner fa-spin logout-modal-icon"></i>
                    <div class="logout-modal-title">Logging Out...</div>
                    <div class="logout-modal-message">
                        Please wait while we end your session...
                    </div>
                </div>
            `;
            
            document.body.appendChild(loadingOverlay);
            
            setTimeout(function() {
                window.location.href = 'login.jsp';
            }, 1500);
        }
        
        // Close modal when clicking outside
        document.getElementById('logoutModal').addEventListener('click', function(e) {
            if (e.target === this) {
                hideLogoutConfirmation();
            }
        });
        
        // Close modal with Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && document.getElementById('logoutModal').style.display === 'flex') {
                hideLogoutConfirmation();
            }
        });
        
        // Form validation before submit
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const currentPass = document.getElementById('currentPassword').value;
            const newPass = document.getElementById('newPassword').value;
            const confirmPass = document.getElementById('confirmPassword').value;
            
            if (!currentPass || !newPass || !confirmPass) {
                e.preventDefault();
                alert('All fields are required.');
                return false;
            }
            
            if (newPass !== confirmPass) {
                e.preventDefault();
                alert('Passwords do not match.');
                return false;
            }
            
            if (currentPass === newPass) {
                e.preventDefault();
                alert('New password must be different from current password.');
                return false;
            }
            
            if (newPass.length < 8) {
                e.preventDefault();
                alert('Password must be at least 8 characters long.');
                return false;
            }
            
            return true;
        });
        
        // Auto-hide success/error messages after 5 seconds
        setTimeout(function() {
            const messages = document.querySelectorAll('.message');
            messages.forEach(msg => {
                msg.style.transition = 'opacity 0.5s';
                msg.style.opacity = '0';
                setTimeout(function() {
                    msg.style.display = 'none';
                }, 500);
            });
        }, 5000);
    </script>
</body>
</html>
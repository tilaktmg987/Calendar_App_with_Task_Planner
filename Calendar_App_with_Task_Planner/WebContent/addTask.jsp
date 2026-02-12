<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Task | Calendar System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        
        /* Add Task Specific Styles */
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
            max-width: 800px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 20px;
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
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border 0.3s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .btn-submit {
            padding: 12px 30px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: block;
            margin: 20px auto 0;
        }
        
        .btn-submit:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .message {
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
            animation: fadeIn 0.5s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
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
</head>
<body>
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
                    <a href="addTask.jsp" class="nav-link active">
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
                    <a href="changePassword.jsp" class="nav-link">
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
                    <span>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></span>
                    <button onclick="showLogoutConfirmation()" class="logout-btn">
                        Logout
                    </button>
                </div>
            </div>
            
            <div class="content-area">
                <h2 class="section-title">Add New Task</h2>
                
                <% 
                    String successMsg = (String) request.getAttribute("successMsg");
                    String errorMsg = (String) request.getAttribute("errorMsg");
                %>
                
                <% if (successMsg != null) { %>
                    <div class="message success" id="successMessage">
                        <i class="fas fa-check-circle"></i> <%= successMsg %>
                        <button onclick="document.getElementById('successMessage').style.display='none'" 
                                style="float:right; background:none; border:none; cursor:pointer;">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                <% } %>
                
                <% if (errorMsg != null) { %>
                    <div class="message error" id="errorMessage">
                        <i class="fas fa-exclamation-circle"></i> <%= errorMsg %>
                        <button onclick="document.getElementById('errorMessage').style.display='none'" 
                                style="float:right; background:none; border:none; cursor:pointer;">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                <% } %>
                
                <div class="form-container">
                    <form action="addTask" method="post" id="taskForm" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="taskTitle">Task Title *</label>
                            <input type="text" id="taskTitle" name="taskTitle" class="form-control" 
                                   placeholder="Enter task title" required maxlength="100">
                            <small class="error-text" id="titleError" style="color:red; display:none;"></small>
                        </div>
                        <div class="form-group">
                            <label for="taskDescription">Description</label>
                            <textarea id="taskDescription" name="taskDescription" class="form-control" 
                                      rows="4" placeholder="Enter task description" maxlength="500"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="taskDate">Date *</label>
                            <input type="date" id="taskDate" name="taskDate" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="taskPriority">Priority</label>
                            <select id="taskPriority" name="taskPriority" class="form-control">
                                <option value="low">Low</option>
                                <option value="medium" selected>Medium</option>
                                <option value="high">High</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="taskStatus">Status</label>
                            <select id="taskStatus" name="taskStatus" class="form-control">
                                <option value="pending" selected>Pending</option>
                                <option value="in-progress">In Progress</option>
                                <option value="completed">Completed</option>
                            </select>
                        </div>
                        <button type="submit" class="btn-submit">
                            <i class="fas fa-plus"></i> Add Task
                        </button>
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
        // Set default date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('taskDate').value = today;
            
            // Auto-hide messages after 5 seconds
            setTimeout(() => {
                const messages = document.querySelectorAll('.message');
                messages.forEach(msg => {
                    msg.style.display = 'none';
                });
            }, 5000);
        });
        
        // Form validation
        function validateForm() {
            const title = document.getElementById('taskTitle').value.trim();
            const date = document.getElementById('taskDate').value;
            const titleError = document.getElementById('titleError');
            
            // Reset error
            titleError.style.display = 'none';
            
            // Check if title is empty
            if (title === '') {
                titleError.textContent = 'Task title is required';
                titleError.style.display = 'block';
                document.getElementById('taskTitle').focus();
                return false;
            }
            
            // Check if date is in the past
            const selectedDate = new Date(date);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            
            if (selectedDate < today) {
                alert('Cannot add tasks for past dates. Please select today or a future date.');
                document.getElementById('taskDate').focus();
                return false;
            }
            
            return true;
        }
        
        // Logout functions (copied from editTask.jsp)
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
    </script>
</body>
</html>
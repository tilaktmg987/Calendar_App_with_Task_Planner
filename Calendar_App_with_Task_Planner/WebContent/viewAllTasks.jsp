<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Tasks | Calendar System</title>
    
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
        
        /* View Tasks Specific Styles */
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
        
        .task-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
        }
        
        .task-table th {
            background: #3498db;
            color: white;
            padding: 15px;
            text-align: left;
        }
        
        .task-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e6ed;
        }
        
        .task-table tr:hover {
            background: #f8f9fa;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .status-in-progress {
            background: #cce5ff;
            color: #004085;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .status-completed {
            background: #d4edda;
            color: #155724;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .priority-low {
            background: #d1ecf1;
            color: #0c5460;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .priority-medium {
            background: #fff3cd;
            color: #856404;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .priority-high {
            background: #f8d7da;
            color: #721c24;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .no-tasks {
            text-align: center;
            padding: 50px;
            color: #6c757d;
            font-size: 18px;
        }
        
        .no-tasks a {
            color: #3498db;
            text-decoration: none;
        }
        
        .no-tasks a:hover {
            text-decoration: underline;
        }
        
        .actions {
            display: flex;
            gap: 5px;
        }
        
        .btn-action {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.3s;
        }
        
        .btn-edit {
            background: #17a2b8;
            color: white;
        }
        
        .btn-edit:hover {
            background: #138496;
        }
        
        .btn-delete {
            background: #dc3545;
            color: white;
        }
        
        .btn-delete:hover {
            background: #c82333;
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
            
            .task-table {
                font-size: 14px;
            }
            
            .task-table th,
            .task-table td {
                padding: 8px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                    <a href="addTask.jsp" class="nav-link">
                        <i class="fas fa-plus-circle"></i>
                        <span>Add Task</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="viewAllTasks.jsp" class="nav-link active">
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
                    <button onclick="showLogoutConfirmation()" class="logout-btn">Logout</button>
                </div>
            </div>
            
            <div class="content-area">
                <h2 class="section-title">All Tasks</h2>
                
                <div class="table-container">
                    <table class="task-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Date</th>
                                <th>Priority</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String username = (String) session.getAttribute("username");
                                Connection con = null;
                                PreparedStatement pst = null;
                                ResultSet rs = null;
                                int taskCount = 0;
                                
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    con = DriverManager.getConnection(
                                        "jdbc:mysql://localhost:3306/calendar_system?useSSL=false&serverTimezone=UTC", 
                                        "root", 
                                        "");
                                    
                                    String query = "SELECT id, task_title, task_description, task_date, task_priority, task_status FROM tasks WHERE username = ?";
                                    pst = con.prepareStatement(query);
                                    pst.setString(1, username);
                                    rs = pst.executeQuery();
                                    
                                    while(rs.next()) {
                                        taskCount++;
                                        String id = rs.getString("id");
                                        String title = rs.getString("task_title");
                                        String description = rs.getString("task_description");
                                        String date = rs.getString("task_date");
                                        String priority = rs.getString("task_priority");
                                        String status = rs.getString("task_status");
                                        
                                        String priorityClass = "priority-low";
                                        if ("Medium".equalsIgnoreCase(priority)) {
                                            priorityClass = "priority-medium";
                                        } else if ("High".equalsIgnoreCase(priority)) {
                                            priorityClass = "priority-high";
                                        }
                                        
                                        String statusClass = "status-pending";
                                        if ("In Progress".equalsIgnoreCase(status)) {
                                            statusClass = "status-in-progress";
                                        } else if ("Completed".equalsIgnoreCase(status)) {
                                            statusClass = "status-completed";
                                        }
                            %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= title %></td>
                                <td><%= description != null && !description.isEmpty() ? description : "-" %></td>
                                <td><%= date %></td>
                                <td><span class="<%= priorityClass %>"><%= priority %></span></td>
                                <td><span class="<%= statusClass %>"><%= status %></span></td>
                                <td>
                                    <div class="actions">
                                        <button class="btn-action btn-edit" onclick="editTask('<%= id %>')">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn-action btn-delete" onclick="deleteTask('<%= id %>', '<%= title %>')">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='7' style='color:red; text-align:center;'>Error: " + e.getMessage() + "</td></tr>");
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if(rs != null) rs.close();
                                        if(pst != null) pst.close();
                                        if(con != null) con.close();
                                    } catch(SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                
                                if (taskCount == 0) {
                            %>
                            <tr>
                                <td colspan="7" class="no-tasks">
                                    No tasks found.<br> <a href="addTask.jsp">Add your first task!</a>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
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
        // Edit task function
        function editTask(taskId) {
            window.location.href = 'editTask.jsp?id=' + taskId;
        }
        
        // Delete task function
       function deleteTask(taskId, taskTitle) {
  
        window.location.href = 'deleteTask.jsp?taskId=' + taskId;
    
}
        
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
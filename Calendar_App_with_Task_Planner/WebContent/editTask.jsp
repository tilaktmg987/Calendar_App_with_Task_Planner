<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Task | Calendar System</title>

    <style>
        /* ==================== BASE STYLES ==================== */
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
        
        /* ==================== SIDEBAR STYLES ==================== */
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
        
        /* ==================== MAIN CONTENT STYLES ==================== */
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
        
        /* ==================== EDIT TASK SPECIFIC STYLES ==================== */
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
            background: #17a2b8;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            background: #138496;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
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
        
        .search-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border: 1px solid #e9ecef;
        }
        
        .search-form label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 600;
        }
        
        .search-row {
            display: flex;
            gap: 10px;
            align-items: flex-end;
        }
        
        .search-group {
            flex: 1;
        }
        
        .task-details {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #17a2b8;
        }
        
        .task-details h4 {
            color: #2c3e50;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .task-details h4 i {
            color: #17a2b8;
        }
        
        .details-row {
            display: flex;
            gap: 20px;
            margin-bottom: 10px;
            flex-wrap: wrap;
        }
        
        .detail-item {
            flex: 1;
            min-width: 200px;
        }
        
        .detail-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
        }
        
        .detail-value {
            color: #6c757d;
            padding: 5px 0;
        }
        
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }
        
        .status-pending, .status-Pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-in-progress, .status-In.Progress {
            background: #cce5ff;
            color: #004085;
        }
        
        .status-completed, .status-Completed {
            background: #d4edda;
            color: #155724;
        }
        
        .priority-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }
        
        .priority-low, .priority-Low {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .priority-medium, .priority-Medium {
            background: #fff3cd;
            color: #856404;
        }
        
        .priority-high, .priority-High {
            background: #f8d7da;
            color: #721c24;
        }
        
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        /* ==================== LOGOUT MODAL STYLES ==================== */
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
        
        /* ==================== RESPONSIVE DESIGN ==================== */
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
            
            .search-row {
                flex-direction: column;
            }
            
            .details-row {
                flex-direction: column;
            }
            
            .detail-item {
                min-width: 100%;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .button-group {
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
       PROCESS UPDATE USING POST
       =============================== */
    String username = (String) session.getAttribute("username");

    if("POST".equalsIgnoreCase(request.getMethod())) {

        String taskIdForm = request.getParameter("taskId");
        String titleForm = request.getParameter("taskTitle");
        String descForm = request.getParameter("taskDescription");
        String dateForm = request.getParameter("taskDate");
        String priorityForm = request.getParameter("taskPriority");
        String statusForm = request.getParameter("taskStatus");

        Connection con2 = null;
        PreparedStatement pst2 = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con2 = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/calendar_system?useSSL=false&serverTimezone=UTC",
                "root", ""
            );

            String updateQuery = "UPDATE tasks SET task_title=?, task_description=?, task_date=?, task_priority=?, task_status=? WHERE id=? AND username=?";
            pst2 = con2.prepareStatement(updateQuery);

            pst2.setString(1, titleForm);
            pst2.setString(2, descForm);
            pst2.setString(3, dateForm);
            pst2.setString(4, priorityForm);
            pst2.setString(5, statusForm);
            pst2.setString(6, taskIdForm);
            pst2.setString(7, username);

            int rows = pst2.executeUpdate();

            if(rows > 0){
                response.sendRedirect("editTask.jsp?id=" + taskIdForm + "&success=1");
                return;
            } else {
                response.sendRedirect("editTask.jsp?id=" + taskIdForm + "&error=Update failed");
                return;
            }

        } catch(Exception ex){
            ex.printStackTrace();
            response.sendRedirect("editTask.jsp?id=" + taskIdForm + "&error=Server Error");
            return;
        } finally {
            try { if(pst2 != null) pst2.close(); } catch(Exception e){}
            try { if(con2 != null) con2.close(); } catch(Exception e){}
        }
    }
%>

<%
    /* ===============================
       FETCH TASK DETAILS
       =============================== */
    String taskIdParam = request.getParameter("id");
    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");

    String taskId = "";
    String taskTitle = "";
    String taskDescription = "";
    String taskDate = "";
    String taskPriority = "";
    String taskStatus = "";
    boolean taskFound = false;

    if (taskIdParam != null && !taskIdParam.isEmpty()) {

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/calendar_system?useSSL=false&serverTimezone=UTC", 
                "root", ""
            );

            String query = "SELECT * FROM tasks WHERE id=? AND username=?";
            pst = con.prepareStatement(query);
            pst.setString(1, taskIdParam);
            pst.setString(2, username);
            rs = pst.executeQuery();

            if (rs.next()) {
                taskFound = true;
                taskId = rs.getString("id");
                taskTitle = rs.getString("task_title");
                taskDescription = rs.getString("task_description");
                taskDate = rs.getString("task_date");
                taskPriority = rs.getString("task_priority");
                taskStatus = rs.getString("task_status");
            }

        } catch(Exception e){
            e.printStackTrace();
        } finally {
            try { if(rs!=null) rs.close(); } catch(Exception e){}
            try { if(pst!=null) pst.close(); } catch(Exception e){}
            try { if(con!=null) con.close(); } catch(Exception e){}
        }
    }
%>

<div class="dashboard">

    <!-- Sidebar -->
    <nav class="sidebar">
        <ul class="nav-menu">
            <li class="nav-item"><a href="dashboard.jsp" class="nav-link"><i class="fas fa-calendar-alt"></i><span>View Calendar</span></a></li>
            <li class="nav-item"><a href="addTask.jsp" class="nav-link"><i class="fas fa-plus-circle"></i><span>Add Task</span></a></li>
            <li class="nav-item"><a href="viewAllTasks.jsp" class="nav-link"><i class="fas fa-list-ul"></i><span>View All Tasks</span></a></li>
            <li class="nav-item"><a href="searchTask.jsp" class="nav-link"><i class="fas fa-search"></i><span>Search Task</span></a></li>
            <li class="nav-item"><a href="editTask.jsp" class="nav-link active"><i class="fas fa-edit"></i><span>Edit Task</span></a></li>
            <li class="nav-item"><a href="deleteTask.jsp" class="nav-link"><i class="fas fa-trash-alt"></i><span>Delete Task</span></a></li>
            <li class="nav-item"><a href="changePassword.jsp" class="nav-link"><i class="fas fa-key"></i><span>Change Password</span></a></li>
        </ul>
    </nav>

    <!-- Main -->
    <div class="main-content">

        <div class="header">
            <h1>Task Management Dashboard</h1>
            <div class="user-info">
                <span>Welcome, <%= username %></span>
                <button onclick="showLogoutConfirmation()" class="logout-btn">Logout</button>
            </div>
        </div>

        <div class="content-area">
            <h2 class="section-title">Edit Task</h2>

            <% if (successMsg != null) { %>
                <div class="message success"><i class="fas fa-check-circle"></i> Task updated successfully!</div>
            <% } %>

            <% if (errorMsg != null) { %>
                <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= errorMsg %></div>
            <% } %>
            
            <% if (taskIdParam != null && !taskFound) { %>
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i> Task not found or you don't have permission to edit it.
                </div>
            <% } %>

            <!-- Search Form -->
            <div class="search-form">
                <h3 style="color: #2c3e50; margin-bottom: 15px;">
                    <i class="fas fa-search"></i> Find Task to Edit
                </h3>
                <form method="get" action="editTask.jsp">
                    <div class="search-row">
                        <div class="search-group">
                            <label for="searchTaskId">Enter Task ID</label>
                            <input type="text" id="searchTaskId" name="id" class="form-control" 
                                   placeholder="Enter task ID" value="<%= taskIdParam != null ? taskIdParam : "" %>" required>
                        </div>
                        <div class="button-group">
                            <button type="submit" class="btn-submit">
                                <i class="fas fa-search"></i> Find Task
                            </button>
                            <a href="editTask.jsp" class="btn-secondary">
                                <i class="fas fa-redo"></i> Clear
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <% if (taskFound) { %>

                <!-- Current Task Details -->
                <div class="task-details">
                    <h4>
                        <i class="fas fa-info-circle"></i> Current Task Details (ID: <%= taskId %>)
                    </h4>
                    <div class="details-row">
                        <div class="detail-item">
                            <div class="detail-label">Task Title</div>
                            <div class="detail-value"><%= taskTitle %></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Status</div>
                            <div class="detail-value">
                                <span class="status-badge status-<%= taskStatus.replace(" ", ".") %>">
                                    <%= taskStatus %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="details-row">
                        <div class="detail-item">
                            <div class="detail-label">Priority</div>
                            <div class="detail-value">
                                <span class="priority-badge priority-<%= taskPriority %>">
                                    <%= taskPriority %>
                                </span>
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Due Date</div>
                            <div class="detail-value"><%= taskDate %></div>
                        </div>
                    </div>
                    <div class="details-row">
                        <div class="detail-item">
                            <div class="detail-label">Description</div>
                            <div class="detail-value"><%= taskDescription %></div>
                        </div>
                    </div>
                </div>

                <!-- Edit Form -->
                <div class="form-container">
                    <form action="editTask.jsp" method="post" id="editTaskForm">
                        <input type="hidden" name="taskId" value="<%= taskId %>">

                        <div class="form-group">
                            <label for="editTaskTitle">Task Title *</label>
                            <input type="text" id="editTaskTitle" name="taskTitle" value="<%= taskTitle %>" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="editTaskDescription">Description</label>
                            <textarea id="editTaskDescription" name="taskDescription" class="form-control" rows="4"><%= taskDescription %></textarea>
                        </div>

                        <div class="form-group">
                            <label for="editTaskDate">Due Date *</label>
                            <input type="date" id="editTaskDate" name="taskDate" class="form-control" value="<%= taskDate %>" required>
                        </div>

                        <div class="form-group">
                            <label for="editTaskPriority">Priority</label>
                            <select id="editTaskPriority" name="taskPriority" class="form-control">
                                <option value="Low" <%= "Low".equals(taskPriority) ? "selected" : "" %>>Low</option>
                                <option value="Medium" <%= "Medium".equals(taskPriority) ? "selected" : "" %>>Medium</option>
                                <option value="High" <%= "High".equals(taskPriority) ? "selected" : "" %>>High</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="editTaskStatus">Status</label>
                            <select id="editTaskStatus" name="taskStatus" class="form-control">
                                <option value="Pending" <%= "Pending".equals(taskStatus) ? "selected" : "" %>>Pending</option>
                                <option value="In Progress" <%= "In Progress".equals(taskStatus) ? "selected" : "" %>>In Progress</option>
                                <option value="Completed" <%= "Completed".equals(taskStatus) ? "selected" : "" %>>Completed</option>
                            </select>
                        </div>

                        <div class="form-actions">
                            <button class="btn-submit" type="submit">
                                <i class="fas fa-save"></i> Update Task
                            </button>
                            <a href="viewAllTasks.jsp" class="btn-secondary">
                                <i class="fas fa-list"></i> View All Tasks
                            </a>
                        </div>
                    </form>
                </div>

            <% } %>

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
    
    // Form validation
    const editForm = document.getElementById('editTaskForm');
    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            const taskTitle = document.getElementById('editTaskTitle').value.trim();
            const taskDate = document.getElementById('editTaskDate').value;
            
            if (!taskTitle) {
                e.preventDefault();
                alert('Task title is required.');
                document.getElementById('editTaskTitle').focus();
                return false;
            }
            
            if (!taskDate) {
                e.preventDefault();
                alert('Due date is required.');
                document.getElementById('editTaskDate').focus();
                return false;
            }
            
            return true;
        });
    }
</script>

</body>
</html>
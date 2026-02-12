<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | CalendarAppwithTaskPlanner</title>
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .login-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 450px;
            padding: 40px;
            animation: slideIn 0.5s ease;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-header h2 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .login-header p {
            color: #495057;
            font-size: 16px;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 600;
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            padding-right: 40px;
            border: 2px solid #e0e6ed;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s;
            color: #2c3e50;
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
            transition: color 0.3s;
        }
        
        .password-toggle:hover {
            color: #3498db;
        }
        
        .btn-login {
            width: 100%;
            padding: 14px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn-login:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }
        
        .btn-login:disabled {
            background: #95a5a6;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .message {
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
            animation: fadeIn 0.5s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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
        
        .register-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #e0e6ed;
        }
        
        .register-link p {
            color: #495057;
            font-size: 14px;
        }
        
        .register-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        
        .register-link a:hover {
            color: #2980b9;
            text-decoration: underline;
        }
        
        /* Loading Modal */
        .loading-modal {
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
        
        .loading-modal-content {
            background: white;
            padding: 40px;
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
        
        .loading-modal-icon {
            font-size: 60px;
            margin-bottom: 20px;
            color: #3498db;
        }
        
        .spinner {
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        .loading-modal-title {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .loading-modal-text {
            font-size: 16px;
            color: #6c757d;
        }
        
        .loading-dots {
            display: inline-block;
        }
        
        .loading-dots span {
            animation: blink 1.4s infinite;
            animation-fill-mode: both;
        }
        
        .loading-dots span:nth-child(2) {
            animation-delay: 0.2s;
        }
        
        .loading-dots span:nth-child(3) {
            animation-delay: 0.4s;
        }
        
        @keyframes blink {
            0%, 80%, 100% {
                opacity: 0;
            }
            40% {
                opacity: 1;
            }
        }
        
        @media (max-width: 768px) {
            .login-container {
                padding: 30px 20px;
            }
            
            .login-header h2 {
                font-size: 24px;
            }
            
            .loading-modal-content {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h2><i class="fas fa-sign-in-alt"></i> Welcome Back</h2>
            <p>Login to CalendarAppwithTaskPlanner</p>
        </div>
        
        <%
            String error = (String) request.getAttribute("errorMsg");
            String success = (String) request.getAttribute("successMsg");
            
            if (error != null) {
        %>
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <%
            } else if (success != null) {
        %>
            <div class="message success">
                <i class="fas fa-check-circle"></i> <%= success %>
            </div>
        <%
            }
        %>
        
        <form action="login" method="post" id="loginForm">
            <div class="form-group">
                <label for="username">
                    <i class="fas fa-user"></i> Username *
                </label>
                <input type="text" id="username" name="username" class="form-control" 
                       placeholder="Enter your username" required autofocus>
            </div>
            
            <div class="form-group">
                <label for="password">
                    <i class="fas fa-lock"></i> Password *
                </label>
                <input type="password" id="password" name="password" class="form-control" 
                       placeholder="Enter your password" required>
                <button type="button" class="password-toggle" onclick="togglePassword()">
                    <i class="fas fa-eye"></i>
                </button>
            </div>
            
            <button type="submit" class="btn-login" id="loginBtn">
                <i class="fas fa-sign-in-alt"></i> Login
            </button>
        </form>
        
        <div class="register-link">
            <p>Don't have an account? <a href="register.jsp"><i class="fas fa-user-plus"></i> Register here</a></p>
        </div>
    </div>
    
    <!-- Loading Modal -->
    <div class="loading-modal" id="loadingModal">
        <div class="loading-modal-content">
            <div class="loading-modal-icon">
                <i class="fas fa-spinner spinner"></i>
            </div>
            <h3 class="loading-modal-title">Logging In</h3>
            <p class="loading-modal-text">
                Please wait<span class="loading-dots"><span>.</span><span>.</span><span>.</span></span>
            </p>
        </div>
    </div>
    
    <script>
        // Toggle password visibility
        function togglePassword() {
            const field = document.getElementById('password');
            const icon = document.querySelector('.password-toggle i');
            
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
        
        // Show loading modal on form submit with minimum 5 second display
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault(); // Prevent immediate form submission
            
            // Show loading modal
            const modal = document.getElementById('loadingModal');
            modal.style.display = 'flex';
            
            // Disable submit button
            const loginBtn = document.getElementById('loginBtn');
            loginBtn.disabled = true;
            loginBtn.innerHTML = '<i class="fas fa-spinner spinner"></i> Logging In...';
            
            // Record start time
            const startTime = Date.now();
            const form = this;
            
            // Wait for at least 2 seconds before submitting
            setTimeout(function() {
                form.submit(); // Now submit the form
            }, 2000);
        });
        
        // Auto-hide messages after 5 seconds
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
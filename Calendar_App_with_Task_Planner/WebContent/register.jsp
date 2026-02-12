<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register | CalendarAppwithTaskPlanner</title>
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
        
        .register-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 500px;
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
        
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .register-header h2 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .register-header p {
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
        
        .form-control.error {
            border-color: #e74c3c;
        }
        
        .form-control.success {
            border-color: #2ecc71;
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
        
        .password-strength {
            margin-top: 8px;
            height: 5px;
            background: #e0e6ed;
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
            font-size: 13px;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .password-requirements {
            background: #f5f7fa;
            padding: 12px;
            border-radius: 6px;
            margin-top: 10px;
            font-size: 13px;
            color: #6c757d;
            border: 1px solid #e0e6ed;
        }
        
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }
        
        .requirement:last-child {
            margin-bottom: 0;
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
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 40px;
            color: #6c757d;
            font-size: 16px;
        }
        
        .form-control.with-icon {
            padding-left: 45px;
        }
        
        .btn-register {
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
        
        .btn-register:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }
        
        .btn-register:disabled {
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
        
        .login-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #e0e6ed;
        }
        
        .login-link p {
            color: #495057;
            font-size: 14px;
        }
        
        .login-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        
        .login-link a:hover {
            color: #2980b9;
            text-decoration: underline;
        }
        
        .security-info {
            background: #e3f2fd;
            border: 1px solid #bbdefb;
            border-left: 4px solid #3498db;
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 20px;
            font-size: 13px;
            color: #0d47a1;
        }
        
        .security-info i {
            color: #3498db;
            margin-right: 8px;
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
        }
        
        .loading-modal-icon.spinner {
            color: #3498db;
            animation: spin 1s linear infinite;
        }
        
        .loading-modal-icon.success {
            color: #2ecc71;
            animation: successPop 0.5s ease;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @keyframes successPop {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
        
        .loading-modal-title {
            color: #2c3e50;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .loading-modal-message {
            color: #495057;
            font-size: 16px;
            line-height: 1.5;
            margin-bottom: 25px;
        }
        
        .redirect-info {
            color: #3498db;
            font-size: 14px;
            margin-top: 15px;
        }
        
        .loading-progress {
            width: 100%;
            height: 4px;
            background: #e0e6ed;
            border-radius: 2px;
            overflow: hidden;
            margin-top: 20px;
        }
        
        .loading-progress-bar {
            height: 100%;
            background: #3498db;
            width: 0;
            transition: width 0.3s ease;
        }
        
        @media (max-width: 768px) {
            .register-container {
                padding: 30px 20px;
            }
            
            .register-header h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h2><i class="fas fa-user-plus"></i> Create Account</h2>
            <p>Join CalendarAppwithTaskPlanner</p>
        </div>
        
        <%
            String error = (String) request.getAttribute("errorMsg");
            String registrationSuccess = (String) request.getAttribute("registrationSuccess");
            
            if (error != null) {
        %>
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <%
            }
        %>
        
        <form action="register" method="post" id="registerForm">
            <div class="form-group">
                <label for="fullName">
                    <i class="fas fa-user"></i> Full Name *
                </label>
                <input type="text" id="fullName" name="fullName" class="form-control" 
                       placeholder="Enter your full name" required>
            </div>
            
            <div class="form-group">
                <label for="email">
                    <i class="fas fa-envelope"></i> Email Address *
                </label>
                <input type="email" id="email" name="email" class="form-control" 
                       placeholder="Enter your email" required>
            </div>
            
            <div class="form-group">
                <label for="username">
                    <i class="fas fa-user-circle"></i> Username *
                </label>
                <input type="text" id="username" name="username" class="form-control" 
                       placeholder="Choose a username" required minlength="4">
            </div>
            
            <div class="form-group">
                <label for="password">
                    <i class="fas fa-lock"></i> Password *
                </label>
                <input type="password" id="password" name="password" class="form-control" 
                       placeholder="Create a strong password" required>
                <button type="button" class="password-toggle" onclick="togglePassword('password', this)">
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
                    <i class="fas fa-lock"></i> Confirm Password *
                </label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                       placeholder="Confirm your password" required>
                <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', this)">
                    <i class="fas fa-eye"></i>
                </button>
                <div class="strength-text" id="matchText">Passwords must match</div>
            </div>
            
            <button type="submit" class="btn-register" id="submitBtn" disabled>
                <i class="fas fa-user-plus"></i> Create Account
            </button>
        </form>
        
        <div class="login-link">
            <p>Already have an account? <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login here</a></p>
        </div>
    </div>
    
    <!-- Loading/Success Modal -->
    <div class="loading-modal" id="loadingModal">
        <div class="loading-modal-content">
            <i class="fas fa-spinner fa-spin loading-modal-icon spinner" id="modalIcon"></i>
            <div class="loading-modal-title" id="modalTitle">Processing...</div>
            <div class="loading-modal-message" id="modalMessage">
                Please wait while we create your account...
            </div>
            <div class="loading-progress">
                <div class="loading-progress-bar" id="progressBar"></div>
            </div>
            <div class="redirect-info" id="redirectInfo"></div>
        </div>
    </div>
    
    <%
        // Check if registration was successful and show modal
        if ("true".equals(registrationSuccess)) {
    %>
        <script>
            window.onload = function() {
                showSuccessModal();
            };
        </script>
    <%
        }
    %>
    
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
        
        // Password validation
        document.addEventListener('DOMContentLoaded', function() {
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const submitBtn = document.getElementById('submitBtn');
            const fullName = document.getElementById('fullName');
            const email = document.getElementById('email');
            const username = document.getElementById('username');
            
            let passwordValid = false;
            let passwordsMatch = false;
            
            // Check password strength
            password.addEventListener('input', function() {
                const pass = this.value;
                checkPasswordStrength(pass);
                checkRequirements(pass);
                checkPasswordMatch();
                validateForm();
            });
            
            // Check password match
            confirmPassword.addEventListener('input', function() {
                checkPasswordMatch();
                validateForm();
            });
            
            // Validate form on other inputs
            fullName.addEventListener('input', validateForm);
            email.addEventListener('input', validateForm);
            username.addEventListener('input', validateForm);
            
            function checkPasswordStrength(pass) {
                let strength = 0;
                const meter = document.getElementById('strengthMeter');
                const text = document.getElementById('strengthText');
                
                if (pass.length >= 8) strength++;
                if (pass.length >= 12) strength++;
                if (/[A-Z]/.test(pass)) strength++;
                if (/[a-z]/.test(pass)) strength++;
                if (/[0-9]/.test(pass)) strength++;
                if (/[^A-Za-z0-9]/.test(pass)) strength++;
                
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
            
            function checkRequirements(pass) {
                const requirements = {
                    length: pass.length >= 8,
                    uppercase: /[A-Z]/.test(pass),
                    lowercase: /[a-z]/.test(pass),
                    number: /[0-9]/.test(pass),
                    special: /[^A-Za-z0-9]/.test(pass)
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
                const pass = document.getElementById('password').value;
                const confirmPass = document.getElementById('confirmPassword').value;
                const matchText = document.getElementById('matchText');
                
                if (confirmPass.length === 0) {
                    matchText.textContent = 'Passwords must match';
                    matchText.style.color = '#6c757d';
                    passwordsMatch = false;
                } else if (pass === confirmPass) {
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
                const name = fullName.value.trim();
                const mail = email.value.trim();
                const user = username.value.trim();
                const pass = password.value;
                const confirmPass = confirmPassword.value;
                
                if (name && mail && user.length >= 4 && pass && confirmPass && 
                    passwordValid && passwordsMatch) {
                    submitBtn.disabled = false;
                    submitBtn.title = "Click to register";
                } else {
                    submitBtn.disabled = true;
                    submitBtn.title = "Please fill all fields and meet password requirements";
                }
            }
        });
        
        // Form validation before submit - FIXED: No AJAX
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }
            
            if (password.length < 8) {
                e.preventDefault();
                alert('Password must be at least 8 characters long!');
                return false;
            }
            
            // Show loading modal
            showLoadingModal();
            
            // Let form submit normally to server
            return true;
        });
        
        // Show loading modal with progress bar
        function showLoadingModal() {
            const modal = document.getElementById('loadingModal');
            const progressBar = document.getElementById('progressBar');
            const modalIcon = document.getElementById('modalIcon');
            const modalTitle = document.getElementById('modalTitle');
            const modalMessage = document.getElementById('modalMessage');
            
            // Reset modal to loading state
            modalIcon.className = 'fas fa-spinner fa-spin loading-modal-icon spinner';
            modalTitle.textContent = 'Processing...';
            modalMessage.textContent = 'Please wait while we create your account...';
            progressBar.parentElement.style.display = 'block';
            progressBar.style.width = '0%';
            
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';
            
            // Animate progress bar
            let progress = 0;
            const interval = setInterval(function() {
                progress += 2;
                progressBar.style.width = progress + '%';
                if (progress >= 100) {
                    clearInterval(interval);
                }
            }, 40);
        }
        
        // Show success modal with countdown
        function showSuccessModal() {
            const modal = document.getElementById('loadingModal');
            const modalIcon = document.getElementById('modalIcon');
            const modalTitle = document.getElementById('modalTitle');
            const modalMessage = document.getElementById('modalMessage');
            const redirectInfo = document.getElementById('redirectInfo');
            const progressBar = document.getElementById('progressBar');
            
            // Show modal
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';
            
            // Update to success state
            modalIcon.className = 'fas fa-check-circle loading-modal-icon success';
            modalTitle.textContent = 'Registration Successful!';
            modalMessage.textContent = 'Your account has been created successfully. Redirecting you to login page...';
            
            // Hide progress bar
            progressBar.parentElement.style.display = 'none';
            
            // Start countdown
            let countdown = 3;
            redirectInfo.textContent = `Redirecting in ${countdown} seconds...`;
            
            const countdownInterval = setInterval(function() {
                countdown--;
                if (countdown > 0) {
                    redirectInfo.textContent = `Redirecting in ${countdown} seconds...`;
                } else {
                    clearInterval(countdownInterval);
                    redirectInfo.textContent = 'Redirecting now...';
                    setTimeout(function() {
                        window.location.href = 'login.jsp';
                    }, 500);
                }
            }, 1000);
        }
        
        // Auto-hide error messages after 10 seconds
        setTimeout(function() {
            const messages = document.querySelectorAll('.message');
            messages.forEach(msg => {
                msg.style.transition = 'opacity 0.5s';
                msg.style.opacity = '0';
                setTimeout(function() {
                    msg.style.display = 'none';
                }, 500);
            });
        }, 10000);
    </script>
</body>
</html>
package sneha;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class register extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            // Server-side validation
            if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                
                request.setAttribute("errorMsg", "All fields are required!");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
                return;
            }
            
            // Validate password
            if (password.length() < 8) {
                request.setAttribute("errorMsg", "Password must be at least 8 characters long!");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
                return;
            }
            
            // Validate password match
            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMsg", "Passwords do not match!");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
                return;
            }
            
            // Use updated driver class - IMPORTANT FIX
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/calendar_system?useSSL=false&serverTimezone=UTC", 
                "root", 
                "");
            
            // Check if username already exists
            String checkQuery = "SELECT COUNT(*) FROM register WHERE username = ? OR email = ?";
            pst = con.prepareStatement(checkQuery);
            pst.setString(1, username);
            pst.setString(2, email);
            rs = pst.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                request.setAttribute("errorMsg", "Username or email already exists!");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
                return;
            }
            
            // Close the check query
            rs.close();
            pst.close();
            
            // Insert new user with column names specified
            String insertQuery = "INSERT INTO register(full_name, email, username, password) VALUES (?, ?, ?, ?)";
            pst = con.prepareStatement(insertQuery);
            pst.setString(1, fullName);
            pst.setString(2, email);
            pst.setString(3, username);
            pst.setString(4, password); // NOTE: In production, ALWAYS hash passwords!
            
            int result = pst.executeUpdate();
            
            if (result > 0) {
                // Set success flag for JSP to show modal
                request.setAttribute("registrationSuccess", "true");
                request.setAttribute("successMsg", "Registration successful! Redirecting to login...");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("errorMsg", "Registration failed. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
            }
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database driver not found: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        } finally {
            // Close resources properly
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
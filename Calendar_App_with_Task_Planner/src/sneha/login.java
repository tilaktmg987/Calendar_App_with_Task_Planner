package sneha;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class login extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public login() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/calendar_system?useSSL=false&serverTimezone=UTC", 
                "root", 
                "");
             
            String str = "SELECT username, password FROM register WHERE username=?";
            pst = con.prepareStatement(str);
            pst.setString(1, username);
            
            rs = pst.executeQuery();
            
            if (rs.next()) {
                // Get stored password from database
                String storedPassword = rs.getString("password");
                
                // Compare passwords (plain text comparison - insecure!)
                // If passwords are hashed, use: passwordEncoder.matches(password, storedPassword)
                if (password.equals(storedPassword)) {
                    // Successful login
                	request.getSession().setAttribute("username", username);
                    RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
                    rd.forward(request, response);
                } else {
                    // Wrong password
                    request.setAttribute("errorMsg", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }
            } else {
                // User doesn't exist
                request.setAttribute("errorMsg", "Invalid username or password");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "System error. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
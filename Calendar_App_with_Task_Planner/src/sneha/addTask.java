package sneha;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addTask
 */
@WebServlet("/addTask")
public class addTask extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addTask() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to doPost or forward to JSP
        doPost(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        
        // Check if user is logged in
        if (username == null || username.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String taskTitle = request.getParameter("taskTitle");
        String taskDescription = request.getParameter("taskDescription");
        String taskDate = request.getParameter("taskDate");
        String taskPriority_checked = request.getParameter("taskPriority");
        String taskPriority;
        if("low".equals(taskPriority_checked)){
        	taskPriority = "Low";
	     }else if("medium".equals(taskPriority_checked)){
	    	 taskPriority = "Medium";
	     }else{
	    	 taskPriority = "High";
	     }
        String taskStatus_checked = request.getParameter("taskStatus");
        String taskStatus;
        if("pending".equals(taskStatus_checked)){
        	taskStatus = "Pending";
	     }else if("in-progress".equals(taskStatus_checked)){
	    	 taskStatus = "In Progress";
	     }else{
	    	 taskStatus = "Completed";
	     }
        Connection con = null;
        PreparedStatement pst = null;
        
        try {
            
            Class.forName("com.mysql.jdbc.Driver");
            
            // Fixed connection URL with proper parameters
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/calendar_system?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", 
                "root", 
                ""
            );
            
            // Insert query with correct column names
            String insertQuery = "INSERT INTO tasks(username, task_title, task_description, task_date, task_priority, task_status) VALUES (?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(insertQuery);
            pst.setString(1, username);
            pst.setString(2, taskTitle);
            pst.setString(3, taskDescription);
            pst.setString(4, taskDate);
            pst.setString(5, taskPriority);
            pst.setString(6, taskStatus);
            
            int result = pst.executeUpdate();
            
            if (result > 0) {
                // Set success message and forward
                request.setAttribute("successMsg", "Task added successfully!");
                // Clear form by redirecting to GET request pattern
                RequestDispatcher rd = request.getRequestDispatcher("addTask.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("errorMsg", "Failed to add task. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("addTask.jsp");
                rd.forward(request, response);
            }
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database driver error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("addTask.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("addTask.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Unexpected error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("addTask.jsp");
            rd.forward(request, response);
        } finally {
            // Close resources
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
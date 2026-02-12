<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<div class="calendar-section">
    <%
        Calendar cal = Calendar.getInstance();
        int currentYear = cal.get(Calendar.YEAR);
        String yearParam = request.getParameter("year");
        int displayYear = currentYear;
        
        if (yearParam != null && !yearParam.trim().isEmpty()) {
            try {
                displayYear = Integer.parseInt(yearParam.trim());
                if (displayYear < 1000 || displayYear > 9999) {
                    displayYear = currentYear;
                }
            } catch (NumberFormatException e) {
                displayYear = currentYear;
            }
        }
        
        boolean isLeapYear = (displayYear % 4 == 0 && displayYear % 100 != 0) || (displayYear % 400 == 0);
        int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if (isLeapYear) {
            daysInMonth[2] = 29;
        }
        
        int d1 = (displayYear - 1) / 4;
        int d2 = (displayYear - 1) / 100;
        int d3 = (displayYear - 1) / 400;
        int dayCode = (displayYear + d1 - d2 + d3) % 7;
        
        String[] monthNames = {"", "January", "February", "March", "April", "May", "June", 
                              "July", "August", "September", "October", "November", "December"};
        
        int currentMonth = cal.get(Calendar.MONTH) + 1;
        int currentDay = cal.get(Calendar.DAY_OF_MONTH);
        boolean isCurrentDisplayYear = displayYear == currentYear;
    %>
    
    <style>
        .calendar-header-container {
            text-align: center;
            margin-bottom: 30px;
            padding: 25px;
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .year-title {
            font-size: 2.5em;
            margin: 0;
        }
        
        .leap-year-badge {
            display: inline-block;
            background-color: #3498db;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.8em;
            margin-left: 10px;
            vertical-align: middle;
        }
        
        .calendar-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .year-form {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .form-control-small {
            padding: 10px 15px;
            border: 2px solid #e0e6ed;
            border-radius: 5px;
            font-size: 16px;
            width: 120px;
            transition: border-color 0.3s;
        }
        
        .form-control-small:focus {
            outline: none;
            border-color: #3498db;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }
        
        .btn-secondary {
            background-color: #2c3e50;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(44, 62, 80, 0.3);
        }
        
        .calendar-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .month-calendar {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
            border: 1px solid #e0e6ed;
        }
        
        .month-calendar:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.15);
            border-color: #3498db;
        }
        
        .month-title {
            text-align: center;
            color: #2c3e50;
            margin: 0 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 3px solid #3498db;
            font-size: 1.5em;
            font-weight: 600;
        }
        
        .calendar-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .calendar-table th {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 12px;
            text-align: center;
            font-weight: bold;
            border: 1px solid #2980b9;
            font-size: 14px;
        }
        
        .calendar-table td {
            padding: 12px 5px;
            text-align: center;
            border: 1px solid #e0e6ed;
            height: 40px;
            vertical-align: middle;
            font-size: 14px;
            transition: background-color 0.2s;
        }
        
        .calendar-table td:hover:not(:empty) {
            background-color: #ecf0f1;
        }
        
        .calendar-table td:empty {
            background-color: #f8f9fa;
        }
        
        .sunday {
            color: #e74c3c;
            font-weight: bold;
        }
        
        .saturday {
            color: #3498db;
            font-weight: bold;
        }
        
        .today {
            background: linear-gradient(135deg, #3498db, #2980b9) !important;
            color: white !important;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            font-weight: bold;
            box-shadow: 0 2px 8px rgba(52, 152, 219, 0.4);
        }
        
        .month-indicator {
            text-align: center;
            font-size: 0.9em;
            color: #7f8c8d;
            margin-top: 15px;
            padding-top: 10px;
            border-top: 1px solid #e0e6ed;
        }
        
        .error-message {
            background-color: #ffe6e6;
            color: #e74c3c;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            border: 2px solid #e74c3c;
            font-weight: 600;
        }
        
        .calendar-footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            color: #7f8c8d;
            font-size: 0.9em;
            border-top: 2px solid #e0e6ed;
        }
        
        @media (max-width: 768px) {
            .calendar-container {
                grid-template-columns: 1fr;
            }
            
            .calendar-controls {
                flex-direction: column;
                gap: 15px;
            }
            
            .year-form {
                width: 100%;
                justify-content: center;
            }
            
            .year-title {
                font-size: 2em;
            }
        }
    </style>
    
    <div class="calendar-header-container">
        <h1 class="year-title">
            &#128197; Calendar for Year <%= displayYear %>
            <% if (isLeapYear) { %>
                <span class="leap-year-badge">Leap Year</span>
            <% } %>
        </h1>
    </div>
    
    <div class="calendar-controls">
        <form method="get" class="year-form" action="dashboard.jsp">
            <input type="hidden" name="page" value="viewCalendar">
            <input type="text" 
                   name="year" 
                   value="<%= displayYear %>" 
                   placeholder="Enter year"
                   required
                   pattern="\d{4}"
                   title="Please enter a 4-digit year"
                   class="form-control-small">
            <button type="submit" class="btn btn-primary">Go</button>
        </form>
        
        <div>
            <a href="dashboard.jsp?page=viewCalendar&year=<%= displayYear - 1 %>" 
               class="btn btn-secondary">&#11013; Previous Year</a>
            <a href="dashboard.jsp?page=viewCalendar&year=<%= displayYear + 1 %>" 
               class="btn btn-secondary" style="margin-left: 10px;">Next Year &#10145;</a>
        </div>
    </div>
    
    <% if (request.getParameter("error") != null) { %>
        <div class="error-message">
            Error: <%= request.getParameter("error") %>
        </div>
    <% } %>
    
    <div class="calendar-container">
        <%
            for (int month = 1; month <= 12; month++) {
                int dayCounter = 1;
                int startDay = dayCode;
                int totalCells = daysInMonth[month] + startDay;
                int rows = (int) Math.ceil(totalCells / 7.0);
        %>
        <div class="month-calendar">
            <h2 class="month-title"><%= monthNames[month] %></h2>
            <table class="calendar-table">
                <thead>
                    <tr>
                        <th class="sunday">Sun</th>
                        <th>Mon</th>
                        <th>Tue</th>
                        <th>Wed</th>
                        <th>Thu</th>
                        <th>Fri</th>
                        <th class="saturday">Sat</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int week = 0; week < rows; week++) {
                    %>
                    <tr>
                        <%
                            for (int dayOfWeek = 0; dayOfWeek < 7; dayOfWeek++) {
                                int dayNumber = 0;
                                String cellClass = "";
                                
                                if (dayOfWeek == 0) cellClass = "sunday";
                                else if (dayOfWeek == 6) cellClass = "saturday";
                                
                                int position = (week * 7) + dayOfWeek;
                                if (position >= startDay && dayCounter <= daysInMonth[month]) {
                                    dayNumber = dayCounter;
                                    
                                    if (isCurrentDisplayYear && month == currentMonth && 
                                        dayNumber == currentDay) {
                                        cellClass += " today";
                                    }
                                    dayCounter++;
                                }
                        %>
                        <td class="<%= cellClass %>">
                            <%= dayNumber > 0 ? dayNumber : "" %>
                        </td>
                        <% } %>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <div class="month-indicator">
                <%= rows %> weeks, <%= daysInMonth[month] %> days
            </div>
        </div>
        <% 
                dayCode = (dayCode + daysInMonth[month]) % 7;
            } 
        %>
    </div>
    
</div>
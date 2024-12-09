<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.servlet.RequestDispatcher"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign Up</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<%
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		long phone = Long.parseLong(request.getParameter("phone"));
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		// Check if user meets the age requirement
		if (age < 18) {
			// User is under 18, display error message
			out.println("<h3>Sorry, You are not eligible because your age is below 18.</h3>");
			out.println("<h3>You can signup with proper credential </h3>");
			out.println("<a href='signup.jsp'><button>Back to signup</button></a>");
		} else {
			// Check if the user already exists based on phone number or email
			String checkQuery = "SELECT * FROM digital_voting.signup WHERE phone = ? OR email = ?";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_voting", "root", "Andhe@007");
			PreparedStatement psCheck = c.prepareStatement(checkQuery);
			psCheck.setLong(1, phone);
			psCheck.setString(2, email);
			ResultSet rs = psCheck.executeQuery();

			if (rs.next()) {
				// User is already signed up
				out.println("<h3>You have already signed up with this phone number or email.</h3>");
				out.println("<a href='login.jsp'>Go to Login</a>");
			} else {
				// User is not signed up yet, so proceed with the registration
				String query = "INSERT INTO digital_voting.signup (id, name, age, phone, email, password) VALUES (?, ?, ?, ?, ?, ?)";
				PreparedStatement ps = c.prepareStatement(query);
				ps.setString(1, id);
				ps.setString(2, name);
				ps.setInt(3, age);
				ps.setLong(4, phone);
				ps.setString(5, email);
				ps.setString(6, password);
				ps.executeUpdate();

				// Forward the user to login after successful signup
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.forward(request, response);
			}
		}
	%>
</body>
</html>

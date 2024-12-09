<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Vote Submission</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<%
	String vote = request.getParameter("vote");
	long phone = Long.parseLong(request.getParameter("phone"));
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_voting?user=root&password=Andhe@007");
	String query = "update digital_voting.signup set voted = ? where phone=?";
	PreparedStatement ps = c.prepareStatement(query);
	ps.setString(1, vote);
	ps.setLong(2, phone);
	int result = ps.executeUpdate();

	if (result > 0) {
		out.println("<h1>Thank you for voting!</h1>");
		out.println("<h1>You have voted for "+vote+"</h1>");
	} else {
		out.println("<h2>Error occurred while submitting your vote. Please try again.</h2>");
	}
	%>
</body>
</html>

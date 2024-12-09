<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<%
	long phone = Long.parseLong(request.getParameter("phone"));
	String password = request.getParameter("password");
	String query = "select * from 	digital_voting.signup where phone=? AND password=?";

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306 ? user=root && password= Andhe@007");
	PreparedStatement ps = c.prepareStatement(query);
	ps.setLong(1, phone);
	ps.setString(2, password);
	ResultSet rs = ps.executeQuery();
	
	if(rs.next()&& phone== rs.getLong("phone")){
		rs=ps.executeQuery("select * from digital_voting.signup where phone = "+phone);
		rs.next();
		if(rs.getInt("age")>=18 && rs.getString("voted")==null){
		long phone1 = Long.parseLong(rs.getString("phone"));
		out.println("<html><head><title>User Details</title></head><body>");
		out.println("<h2>User Details</h2>");
		out.println(
		"<table border='1'><tr><th>ID</th><th>name</th><th>age</th><th>phone</th> <th>Email</th> <th>Password</th></tr>");

		out.println("<tr>");
		out.println("<td>" + rs.getString("id") + "</td>");
		out.println("<td>" + rs.getString("name") + "</td>");
		out.println("<td>" + rs.getString("age") + "</td>");
		out.println("<td>" + rs.getString("phone") + "</td>");
		out.println("<td>" + rs.getString("email") + "</td>");
		out.println("<td>" + rs.getString("password") + "</td>");
		out.println("</tr>");

		out.println("</table> ");

		out.println("<html><head><title>User Details</title></head><body>");
		out.println("<h2>Please Select Any one</h2>");
		out.println("<table >");

		out.println("<form action='Voted.jsp'><tr>");
		out.println("<input type='hidden' name='phone' value='" + phone1 + "'>");
		out.println("<td> <h1>Congress</h1></td>");
		out.println("<td> <input type='radio' name='vote' value='congress' > </td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td> <h1>Bjp</h1></td>");
		out.println("<td><input type='radio' name='vote' value='bjp'> </td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td> <h1>Others</h1></td>");
		out.println("<td> <input type='radio' name='vote' value='Others'> </td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td> <h1>NOTA</h1></td>");
		out.println("<td> <input type='radio' name='vote' value='NOTA'> </td>");
		out.println("</tr>");

		out.println("</table> ");
		out.println("<button ><h1>Vote</h1></button></form>");
		}else{
			out.println("<h1>You have votes already</h1> ");
			out.println("<h1>You are not allowed to vote more than 1 time</h1> ");
			out.println("<h1>Thank You</h1> ");
		}
	
	}else{
	
	out.println("<h1>Sorry You Have Entered Wrong</h1>");}
	%>
</body>
</html>
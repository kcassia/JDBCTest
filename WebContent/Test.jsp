<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@page import = "java.sql.*" %>
<%@page import = "java.io.*" %>
<%@page import = "org.json.JSONObject" %>
<%@page import = "java.net.URLDecoder" %>
<%!
	String host = "jdbc:mysql://localhost/toner";
	String user = "root";
	String pw = "p125214";
	Connection conn;
	Statement stmt;
	// String sql;
	ResultSet rs;
	boolean ok = true;
%>
</head>
<body>
<%
	InputStreamReader reader = new InputStreamReader(request.getInputStream());
	BufferedReader bReader = new BufferedReader(reader);

	String message = "";
	
	while(true){
		String temp = bReader.readLine();
		if(temp == null)
			break;
		
		message += temp;
	}
	
	JSONObject jsonObj = new JSONObject(message);
	

	String name = URLDecoder.decode(jsonObj.getString("name"), "UTF-8");
	double grade = jsonObj.getDouble("grade");
	
	System.out.println(name);
	System.out.println(grade);
	
	PreparedStatement pstmt = null;
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(host, user, pw);
		pstmt = conn.prepareStatement("insert into store values( ? , ?)");
		
		pstmt.setString(1 , name);
		pstmt.setDouble(2 , grade);
		
		pstmt.executeUpdate();
		
		// sql = "insert into store values ('" + name + "', " + grade + ");"; SQL Injection 취약
	}
	catch(ClassNotFoundException e)
	{
	}
%>
</body>
</html>

<html>
<head>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,javax.naming.InitialContext,javax.naming.Context"%>
</head>

<body>
<%
InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env"); 
			DataSource ds = (DataSource) envContext.lookup("jdbc/bean_chat");
			Connection conn = ds.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rset= stmt.executeQuery("SELECT VERSION();");
			while(rset.next()){
				out.println("MYSQL Version:"+ rset.getString("version()"));
			}
			rset.close();
			stmt.close();
			conn.close();
			initContext.close();
			
			
			
			
			
			%>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.UserStore" %>

<!DOCTYPE html>
<html>
<head>
  <title>CodeU Chat App</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App - Team 34</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <a href="/interest">Interest Chats</a>
  </nav>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>Admin Page</h1>
      
        <% if (request.getAttribute("error") != null) { %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    	<% } %>
 		
  
    <!-- Retrieves # of conversations from servlet -->  
    <% int numConvos = (int) request.getAttribute("numConvos");%>
      
    <!-- Retrieves # of messages from servlet -->  
    <% int numMessages = (int) request.getAttribute("numMessages");%>
    
    <!-- Retrieves # of users from servlet -->  
    <% int numUsers = (int) request.getAttribute("numUsers");%>
    
    <!-- Retrieves most active user from servlet -->  
    <%  String activeUser = (String) request.getAttribute("activeUserName");%>
    
	<% String adminAccess = "Justice, Araceliz, Tema, Lucy"; %>
	  
	  <p>Admin Access: <%= adminAccess %></p>
	  <p>Number of Users: <%= numUsers %> </p>
	  <p>Number of Conversations: <%= numConvos %></p>
	  <p>Number of Messages: <%= numMessages %></p>
	  <p>Most Active User: <%= activeUser %></p>
	  

    </div>
  </div>
</body>
</html>

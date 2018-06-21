<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ page import="java.util.List"%>
<%@ page import="codeu.model.data.Conversation"%>
<%@ page import="codeu.model.store.basic.UserStore" %>

<!DOCTYPE html>
<html>
<head>
<title>ActivityFeed</title>
<link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App Team 34</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a href="/users/<%= request.getSession().getAttribute("user") %>" > <%= request.getSession().getAttribute("user") %>'s Profile</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <a href="/users/<%= request.getSession().getAttribute("user") %>">Profile</a>
    <a href="/profile">Profile</a>
    <a href="/activityfeed">Activity Feed</a>
  </nav>


  <div id="container">

	<%
	  if (request.getAttribute("error") != null) {
  %>
	<h2 style="color: red"><%=request.getAttribute("error")%></h2>
    
	<% } %>

	<h1>Activity Feed</h1>

	<h2>This where you see what the world is up to!</h2>

	<%
	List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
	%>
	<ul class="mdl-list">
	<%
	  for (Conversation conversation : conversations) {
	%>
	<li><a href="/chat/<%=conversation.getTitle()%>"> <%=conversation.getTitle()%></a></li>
	<% } %>
	</ul>
  </div>
</body>
</html>

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
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.time.Instant" %>
<%
/** Gets the UserStore instance to access all users. */
UserStore userStore = UserStore.getInstance();
%>

<!DOCTYPE html>
<html>
<head>
  <title>Profile</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App Team 34</a>
    <a href="/conversations">Conversations</a>
    <% if (request.getSession().getAttribute("user") != null) { %>
    	 <a href="/users/<%= request.getSession().getAttribute("user") %>" > <%= request.getSession().getAttribute("user") %>'s Profile</a>
    <% } else { %>
      	<a href="/login">Login</a>
    <% } %>
    <a href="/activityfeed">Activity Feed</a>
    <a href="/about.jsp">About</a>
  </nav>

  <div id="container">
  	<div
			style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">
			
			<%/** depending on who's page we are on we will see different name and content */ %>
			<%
			String sessionUser = (String) request.getSession().getAttribute("user");
			String userProfile = (String) request.getAttribute("userProfile");
			User currentUser = userStore.getUser(userProfile);
			
			if (userProfile.equals("")) { %>
				<h1>Error This User Does Not Exist</h1>
			
			<% } else {
					 if (sessionUser != null && sessionUser.equals(userProfile)){ %>
						<h1 style="color:#3498DB"><strong>Welcome To Your Profile Page!</strong></h1>
						<hr class="section-heading-spacer">
					<% } else { %>
						<h1><strong>Welcome to <%=userProfile %>'s Profile Page</strong></h1>
						<hr class="section-heading-spacer">
					<% } %>
		
			<%/** defult profile pic is a cute puppy */ %>
			<div id="avatar">
				<img alt="cute dog" src = "https://learnwebcode.com/images/lessons/insert-image-funny-dog.jpg" class="center">
			</div>
			<br/>
			
			
			<%/** user's bio/aboutme section of profile */ %>
			<% String profileBio = currentUser.getBiography(); %>
			<h2 style="color:#083BF9">About <%=userProfile %> </h2>
			<hr class="section-heading-spacer">
			<a> <%= profileBio %></a>
			<br/>
			<br/>
			
			<%/** Edit profile bio aboutme */ %>
			
			<% if (sessionUser != null && sessionUser.equals(userProfile)) { %>
				<a>Edit Your Bio Here <%=sessionUser %> (only you can see this)</a>
				<form action="/users/<%=sessionUser %>" method="POST">
					<input type="text" name="biography" value="<%= currentUser.getBiography() %>" >
					<br/>
				<button type="Submit">Submit</button>
				</form>
			<% } %>
			
			<hr class="section-heading-spacer">
			<h3 class="font-semibold mgbt-xs-5"> Google CodeU Summer 2018 Student </h3>
			<hr class="section-heading-spacer">
			
			<h2 style="color:indigo"> <%= userProfile %>'s Sent Messages </h2>
			<hr class="section-heading-spacer">
			<% List<Message> messagesSent = (List) request.getAttribute("messages");
				for (Message message: messagesSent) { %>
					<a><strong> <%=message.getTime() %> </strong> : <%= message.getContent() %></a>
					<br/>
				<% } %>
				<hr class="section-heading-spacer">
			<% } %>
			

		</div>
	</div>
</body>
</html>



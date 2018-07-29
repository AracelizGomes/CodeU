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
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<style>
	body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif}
	.w3-bar,h1,button {font-family: "Montserrat", sans-serif}
	.fa-anchor,.fa-coffee {font-size:200px}
</style>
<body>

  <!-- Navbar -->
  <nav>
  <div class="w3-top">
 	  <div class="w3-bar w3-red w3-card w3-left-align w3-large">
    	<a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-red" href="javascript:void(0);" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    	<a href="/" class="w3-bar-item w3-button w3-padding-large w3-white">Team 34 Chat App <i class="fa fa-space-shuttle" style="font-size:36px;color:black"></i></a>
    	<a href="/conversations" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Conversations</a>
   		<% if (request.getSession().getAttribute("user") != null) { %>
    		<a href="/users/<%= request.getSession().getAttribute("user") %>" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white"> <%= request.getSession().getAttribute("user") %>'s Profile</a>
    	<% } else { %>
      	<a href="/login" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Login</a>
   		<% } %>
    	<a href="/activityfeed" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Activity Feed</a>
    	<a href="/about.jsp" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">About</a>
    	<a href="/interest" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Interest Chats</a>
    </div>
    
    <!-- Navbar on smaller screens -->
    <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium w3-large">
    	<a href="/conversations" class="w3-bar-item w3-button w3-padding-large">Conversations</a>
    	<% if (request.getSession().getAttribute("user") != null) { %>
    	 	<a href="/users/<%= request.getSession().getAttribute("user") %>" class="w3-bar-item w3-button w3-padding-large"> <%= request.getSession().getAttribute("user") %>'s Profile</a>
    	<% } else { %>
      	<a href="/login" class="w3-bar-item w3-button w3-padding-large">Login</a>
    	<% } %>
    	<a href="/activityfeed" class="w3-bar-item w3-button w3-padding-large">Activity Feed</a>
    	<a href="/about.jsp" class="w3-bar-item w3-button w3-padding-large">About</a>
    	<a href="/interest" class="w3-bar-item w3-button w3-padding-large">Interest Chats</a>
    </div>	
    
  </div>
  </nav>
  <br><br><br><br><br><br>
  <div id="container">
  	<div
			style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">
			
			<%/** depending on who's page we are on we will see different name and content */ %>
			<%
			String sessionUser = (String) request.getSession().getAttribute("user");
			String userProfile = (String) request.getAttribute("userProfile");
			User currentUser = userStore.getUser(userProfile);
			
			if (userProfile.equals("")) { %>
				<h1 class="w3-xxlarge">Error This User Does Not Exist</h1>
			
			<% } else {
					 if (sessionUser != null && sessionUser.equals(userProfile)){ %>
						<h1 style="color:#3498DB" class="w3-xxlarge"><strong>Welcome To Your Profile Page!</strong></h1>
						<hr class="section-heading-spacer">
					<% } else { %>
						<h1 class="w3-xxlarge"><strong>Welcome to <%=userProfile %>'s Profile Page</strong></h1>
						<hr class="section-heading-spacer">
					<% } %>
		
			<%/** defult profile pic is a cute puppy */ %>
			<div id="avatar">
				<img alt="cute dog" src = "https://learnwebcode.com/images/lessons/insert-image-funny-dog.jpg" class="center w3-circle w3-center" style="height:400px; width:650px">
			</div>
			<br/>
			
			
			<%/** user's bio/aboutme section of profile */ %>
			<% String profileBio = currentUser.getBiography(); %>
			<h2 class="w3-xxlarge" style="color:#083BF9">About <%=userProfile %> </h2>
			<hr class="section-heading-spacer">
			<a class="w3-xlarge"> <%= profileBio %></a>
			<br/>
			<br/>
			
			<%/** Edit profile bio aboutme */ %>
			
			<% if (sessionUser != null && sessionUser.equals(userProfile)) { %>
				<a class="w3-xlarge">Edit Your Bio Here <%=sessionUser %> (only you can see this)</a>
				<form class="w3-xlarge" action="/users/<%=sessionUser %>" method="POST">
					<input class="w3-xlarge" type="text" name="biography" value="<%= currentUser.getBiography() %>" >
					<br/>
				<button type="Submit" class="btn btn-primary mb-2 w3-hover-white">Submit</button>
				</form>
			<% } %>
			
			<hr class="section-heading-spacer">
			<h3 class="font-semibold mgbt-xs-5 w3-xlarge"> Google CodeU Summer 2018 Student </h3>
			<hr class="section-heading-spacer">
			
			<h2 style="color:indigo"> <%= userProfile %>'s Sent Messages </h2>
			<hr class="section-heading-spacer">
			<% List<Message> messagesSent = (List) request.getAttribute("messages");
				for (Message message: messagesSent) { %>
					<a class="w3-xlarge"><strong> <%=message.getTime() %> </strong> : <%= message.getContent() %></a>
					<br/>
				<% } %>
				<hr class="section-heading-spacer">
			<% } %>
			

		</div>
	</div>
</body>

<style>
    #activityfeed {
      background-color: #f5eff4;
      height: 500px;
      overflow-y: scroll
    }
    html {
      zoom:80%;
    }
    .texts {
      font-size:20px;
    }
  </style>
</html>



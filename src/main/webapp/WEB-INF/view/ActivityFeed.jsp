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
<%@ page import="codeu.model.data.User"%>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%
List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations"); 		
%>
<%
List<User> users = (List<User>) request.getAttribute("users");		
%>

<!DOCTYPE html>
<html>
<head>
	<title>ActivityFeed</title>
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="icon" type="image/png" href="https://images.vexels.com/media/users/3/145824/isolated/preview/3fe096b55537e8c0dd845224b3254d11-rocket-silhouette-by-vexels.png">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
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
  <br><br><br><br><br>


  <div id="container">

	<h1 class="w3-xxlarge">Activity Feed</h1>

	<h2 class="w3-xxlarge">This where you see what the world is up to!</h2>
	<hr class="section-heading-spacer">
	<div id="activityfeed">
	
	<ul class="mdl-list w3-large">
	
	<%
	  for (Conversation conversation : conversations) {
	  	String owner = UserStore.getInstance()
	  	  .getUser(conversation.getOwnerId()).getName();
	  	String creation = conversation.getTime();
	%>
	<hr class="section-heading-spacer">
	<li class="w3-xlarge texts"><strong><a href="/users/<%=owner%>"><%=owner%></a></strong> created the conversation <a href="/chat/<%=conversation.getTitle()%>"> <%=conversation.getTitle()%></a> on <font style="color:blue"> <%=creation%> </font></li>
	<% } %>
	<hr class="section-heading-spacer">
	<%
	  for (User user : users) {
	  	String name = UserStore.getInstance()
	  	  .getUser(user.getId()).getName();
	  	String creation = user.getTime();
	%>
	<li class="w3-xlarge texts"><strong><a href="/users/<%=name%>"><%=name%></a></strong> joined CodeU Chat App Team 34 on <font style="color:blue"> <%=creation%> </font></li>
	<hr class="section-heading-spacer">
	<% } %>
	</ul>
	</div>
  </div>
</body>
<style>
	body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif}
	.w3-bar,h1,button {font-family: "Montserrat", sans-serif}
	.fa-anchor,.fa-coffee {font-size:200px}
</style>

<style>
    #activityfeed {
      background: linear-gradient( #FFA07A, white, turquoise);
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

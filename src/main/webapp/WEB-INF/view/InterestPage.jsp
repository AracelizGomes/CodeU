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
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>

<!DOCTYPE html>
<html>
<head>
  <title>Interest Page</title>
  <link rel="stylesheet" href="/css/main.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="icon" type="image/png" href="https://images.vexels.com/media/users/3/145824/isolated/preview/3fe096b55537e8c0dd845224b3254d11-rocket-silhouette-by-vexels.png">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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

    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red" class="w3-xxlarge"><%= request.getAttribute("error")%></h2>
    <% } %>

    <% if(request.getSession().getAttribute("user") != null){ %>
      <h1 class="w3-xxlarge">Pick Interest Conversation</h1>
      
      
      <p>Select interest from drop-down list:</p>

	<form action="/interest" method="POST" class="w3-xlarge"> 
	  <select name="interestChoice" class="w3-xlarge">
	    <option value="Movies" >Movies</option>
	    <option value="Sports">Sports</option>
	    <option value="Readings">Readings</option>
	    <option value="Fitness">Fitness</option>
	    <option value="Traveling">Traveling</option>
	  </select>
	  <br><br>
	  <input type="submit" class="btn btn-primary mb-2">
	</form>
      
      <hr>
    <% } %>

    <h1 class="w3-xxlarge">Interest Conversations</h1>
		<% List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations"); 
				for(Conversation conversation: conversations){
				  if(conversation.getTitle().equals("Movies") || 
				      conversation.getTitle().equals("Sports") || 
				      conversation.getTitle().equals("Readings") || 
				      conversation.getTitle().equals("Fitness") || 
				      conversation.getTitle().equals("Traveling")){ %>
				    <div class="card" style="width: 18rem;">
  					<ul class="list-group list-group-flush">
  						<li class="list-group-item w3-xlarge"><a href="/chat/<%= conversation.getTitle() %>"><%= conversation.getTitle() %>
  						<div class="input-group-append">
    						<button name="delete" class="btn btn-primary mb-2" type="submit">Delete</button>
 						</div>
 						</a>
 						</li>
 					</ul>
				</div>
				  <% }
				}
		%>
	
   
    <hr/>
   
    <hr/>
  </div>
</body>
<style>
	body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif}
	.w3-bar,h1,button {font-family: "Montserrat", sans-serif}
	.fa-anchor,.fa-coffee {font-size:200px}
</style>
</html>

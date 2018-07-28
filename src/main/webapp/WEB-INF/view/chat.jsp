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
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.UUID" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>
<%
Conversation conversation = (Conversation) request.getAttribute("conversation");
List<Message> messages = (List<Message>) request.getAttribute("messages");
UserStore userStore = UserStore.getInstance();
List<User> users = (List<User>) userStore.getAllUsers();
ConversationStore conversationStore = ConversationStore.getInstance();
%>

<!DOCTYPE html>
<html>
<head>
  <title><%= conversation.getTitle() %></title>
  <link rel="stylesheet" href="/css/main.css" type="text/css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://cdn.ckeditor.com/4.7.2/basic/ckeditor.js"></script>
  <style>
	body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif}
	.w3-bar,h1,button {font-family: "Montserrat", sans-serif}
	.fa-anchor,.fa-coffee {font-size:200px}
  </style>

  <script>
    // scroll the chat div to the bottom
    function scrollChat() {
      var chatDiv = document.getElementById('chat');
      chatDiv.scrollTop = chatDiv.scrollHeight;
    };
  </script>
</head>
<body onload="scrollChat()">

  <!-- Navbar -->
  <nav>
  <div class="w3-top">
 	  <div class="w3-bar w3-red w3-card w3-left-align w3-large">
    	<a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-red" href="javascript:void(0);" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    	<a href="/" class="w3-bar-item w3-button w3-padding-large w3-white">Team 34 Chat App</a>
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
    <h1><%= conversation.getTitle() %>
      <a href="" style="float: right">&#8635;</a></h1>
    
    <div id="addContributor">
    	<h3 class="w3-xlarge">Add User To Conversation</h3>
    	<% 
    	System.out.println(users + "- users");
    	%>
    	  <form action="/chat/<%= conversation.getTitle() %>" class="w3-large" method="POST"> 
    	  	<select name="addContributor">
    	  	<% for (User user: users){ %>
    	  		<li> <option value="<%= user.getName() %>"><%= user.getName() %></option></li>
    	  	<% } %>
    	  	</select>
    	  	<br><br>
    	  	<input type="submit">
    	  </form>
    	<% conversationStore.updateConversation(conversation); %>
    </div>
    
    <div id="deleteContributor">
    	<h3 class="w3-xlarge">Delete User From Conversation</h3>
    	<% 
    	HashSet<UUID> contributorList = (HashSet<UUID>) conversation.getContributorList(); 
      %>
    	  <form action="/chat/<%= conversation.getTitle() %>" class="w3-large" method="POST"> 
    	  	<select name="deleteContributor">
    	  	<% for (UUID id: contributorList){ %>
    	  		<li><option value="<%= (userStore.getUser(id)).getName() %>"><%= (userStore.getUser(id)).getName() %></option></li>
    	  		<% } %>
    	  	</select>
    	  	<br><br>
    	  	<input type="submit">
    	  	<br><br>
    	  </form>
    	<% conversationStore.updateConversation(conversation); %>
    </div>
		
    <div id="chat" style="background-color:white">
      <ul class="w3-xxlarge">
    <%
      int messageIndex = 0;
      for (Message message : messages) {
        String author = UserStore.getInstance()
          .getUser(message.getAuthorId()).getName();
    %>
      <li class="w3-large"><strong><%= author %>:</strong> <%= message.getContentWithHtml() %> </li>
      <form class="w3-xlarge" action="/chat/<%= conversation.getTitle() %>" method="POST">
          <button name="delete" value="<%= messageIndex %>" type="submit">Delete</button>
      </form>
    <% messageIndex ++; } %>
      </ul>
    </div>

    <hr/>
    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <textarea name="message" class="w3-xxlarge"></textarea>
        <br/>
        <input class="w3-xlarge" name="send" type="submit" value="Send"></input>
    </form>

    <script>
      CKEDITOR.replace('message');
    </script>

    <% } else { %>
      <p><a href="/login">Login</a> to send a message.</p>
    <% } %>

    <hr/>

  </div>

</body>
</html>

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
  <link rel="stylesheet" href="/css/chat.css" type="text/css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <link rel="icon" type="image/png" href="https://images.vexels.com/media/users/3/145824/isolated/preview/3fe096b55537e8c0dd845224b3254d11-rocket-silhouette-by-vexels.png">
  <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
  <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
  <script src="https://cdn.ckeditor.com/4.7.2/basic/ckeditor.js"></script>
  <!-- First include jquery js -->
  <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
  <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <!-- Then include bootstrap js -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
  
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
    	<a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-red" href="javascript:void(0);" onclick="conversation.myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
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
  <div id="container" style="margin-top: 50px;">
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
    	  	<input class="btn btn-primary mb-2 w3-hover-white" type="submit">
    	  </form>
    	<% conversationStore.updateConversation(conversation); %>
    </div>
    <hr class="section-heading-spacer">
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
    	  	<input class="btn btn-primary mb-2 w3-hover-white" type="submit">
    	  	<br><br>
    	  </form>
    	<% conversationStore.updateConversation(conversation); %>
    </div>
	<hr class="section-heading-spacer">
    <div class="container">
    <div class="row">
        <div class="col-md-5">
            <div class="panel panel-primary">
                <div class="panel-heading" id="accordion">
                    <span class="glyphicon glyphicon-comment"></span> Chat
                    <div class="btn-group pull-right">
                        <a type="button" class="btn btn-default btn-xs" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </a>
                    </div>
                </div>
            <div>
                <div class="panel-body">
                    <ul class="chat">
                        <li class="left clearfix"><span class="chat-img pull-left">
                            <img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <strong class="primary-font"></strong> <small class="pull-right text-muted">
                                        <span class="glyphicon glyphicon-time"></span>July 2018</small>
                                </div>
                                <ul class="w3-xxlarge">
                                <%
                                int messageIndex = 0;
                                for (Message message : messages) {
                                    String author = UserStore.getInstance()
                                    .getUser(message.getAuthorId()).getName(); %>
                                    <a class="btn-xs"><strong> <%=message.getTime() %> </strong></a>
                  									
                                
                                <li class="w3-large"><strong><%= author %>:</strong> <%= message.getContentWithHtml() %> </li>
                   	            
                                <form class="w3-xlarge" action="/chat/<%= conversation.getTitle() %>" method="POST">
                                     <button name="delete" value="<%= message.getId() %>" class="btn btn-primary mb-2 w3-hover-white" type="submit">Delete</button>
                                </form>
                            <% messageIndex ++; } %>
                            </ul>
                            </div>
                        </li>
                    </ul>
                </div>
                
                <div class="panel-footer">
                    <div class="input-group">
                        <span class="input-group-btn">
                            <% if (request.getSession().getAttribute("user") != null) { %>
                                <form action="/chat/<%= conversation.getTitle() %>" method="POST">
                                    <textarea name="message" class="w3-xxlarge"></textarea>
                                    <br/>
                                    <input class="w3-xlarge btn btn-warning" name="send" type="submit" value="Send"></input>
                                 </form>
                        </span>
                    </div>
                </div>
            </div>

    <script>
      CKEDITOR.replace('message');
    </script>
	<hr class="section-heading-spacer">
    <% } else { %>
      <p><a href="/login">Login</a> to send a message.</p>
    <% } %>

    <hr/>

  </div>

</body>  
</html>

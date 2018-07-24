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
  <script src="https://cdn.ckeditor.com/4.7.2/basic/ckeditor.js"></script>
  <style>
    #chat {
      background-color: white;
      height: 500px;
      overflow-y: scroll
    }
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

  <nav>
    <a id="navTitle" href="/">CodeU Chat App - Team 34</a>
    <a href="/conversations">Conversations</a>
    <% if (request.getSession().getAttribute("user") != null) { %>
    	 <a href="/users/<%= request.getSession().getAttribute("user") %>" > <%= request.getSession().getAttribute("user") %>'s Profile</a>
    <% } else { %>
      	<a href="/login">Login</a>
    <% } %>
    <a href="/activityfeed">Activity Feed</a>
    <a href="/about.jsp">About</a>
    <a href="/interest">Interest Chats</a>
  </nav>

  <div id="container">
    <h1><%= conversation.getTitle() %>
      <a href="" style="float: right">&#8635;</a></h1>
    
    <div id="addContributor">
    	<h3>Add User To Conversation</h3>
    	<% 
    	int addCount = 0;
    	System.out.println(users + "- users");
    	%>
    	  <form action="/chat/<%= conversation.getTitle() %>" method="POST"> 
    	  	<select name="addContributor" multiple>
    	  	<% for (User user: users){ %>
    	  		<li> <option value="<%= addCount %>"><%= user.getName() %></option></li>
    	  	<% } %>
    	  	</select>
    	  	<br><br>
    	  	<input type="submit" name="add">
    	  </form>
    	  
    	<% addCount++; %>
    	
    </div>
    
    <div id="deleteContributor">
    	<h3>Delete User From Conversation</h3>
    	<% 
    	int deleteCount = 0;
    	HashSet<UUID> contributorList = (HashSet<UUID>) conversation.getContributorList(); 
      %>
    	  <form action="/chat/<%= conversation.getTitle() %>" method="POST"> 
    	  	<select name="deleteContributor" multiple>
    	  	<% for (UUID id: contributorList){ %>
    	  		<li><option value="<%= deleteCount %>">><%= userStore.getUser(id) %></option></li>
    	  		<% } %>
    	  	</select>
    	  	<br><br>
    	  	<input type="submit" name="delete">
    	  </form>
    	 
    	<% deleteCount++;  %>
    	
    </div>
		
    <div id="chat">
      <ul>
    <%
      int messageIndex = 0;
      for (Message message : messages) {
        String author = UserStore.getInstance()
          .getUser(message.getAuthorId()).getName();
    %>
      <li><strong><%= author %>:</strong> <%= message.getContentWithHtml() %> </li>
      <form action="/chat/<%= conversation.getTitle() %>" method="POST">
          <button name="delete" value="<%= messageIndex %>" type="submit">Delete</button>
      </form>
    <% messageIndex ++; } %>
      </ul>
    </div>

    <hr/>
    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <textarea name="message"></textarea>
        <br/>
        <input name="send" type="submit" value="Send"></input>
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

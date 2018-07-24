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
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.UUID" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.time.Instant" %>
<%
/** Gets the UserStore instance to access all users. */
UserStore userStore = UserStore.getInstance();
ConversationStore conversationStore = ConversationStore.getInstance();
%>

<!DOCTYPE html>
<html>
<head>
  <title>Conversations</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

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

    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    <% } %>

    <% if(request.getSession().getAttribute("user") != null){ %>
      <h1>New Conversation</h1>
      <form action="/conversations" method="POST">
          <div class="form-group">
            <label class="form-control-label">Title:</label>
          <input type="text" name="conversationTitle">
        </div>
        <button name="send" type="submit" value="Send">Create</button>
      </form>

      <hr>
    <% } %>

    <h1><%= request.getSession().getAttribute("user") %>'s Conversations</h1>

    <%
    String username = (String) request.getSession().getAttribute("user");
    User user = userStore.getUser(username);
    UUID id = (UUID) request.getSession().getAttribute("uuid");
    
    List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
   
    %>
    <%
    if(conversationStore.userHasConversations(id) == false || user == null){
    %>
      <p>Create a conversation to get started.</p>
    <%
    }
    else{
    %>
      <p>Your Conversations Are Here</p>
      <ul class="mdl-list">
    <%
    	int conversationIndex = 0;
    	for(Conversation conversation : conversations){ %>
    		<%if(conversation.isContributor(user)) { %>
  			<li><a href="/chat/<%= conversation.getTitle() %>">
    		<%= conversation.getTitle() %></a></li>
    <% } %>
        <form action="/conversations" method="POST">
          <button name="delete" value="<%= conversationIndex %>" type="submit">Delete</button>
        </form>
    <%
      conversationIndex ++;
      }
    %>
	<% } %>
   	
    <hr/>
    <hr/>
  </div>
</body>
</html>

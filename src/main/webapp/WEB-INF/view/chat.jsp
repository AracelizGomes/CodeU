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
ConversationStore conversationStore = ConversationStore.getInstance();
%>

<!DOCTYPE html>
<html>
<head>
  <title><%= conversation.getTitle() %></title>
  <link rel="stylesheet" href="/css/main.css" type="text/css">
  <script src="http://cdn.ckeditor.com/4.7.2/basic/ckeditor.js"></script>
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
    <h1><%= conversation.getTitle() %>
      <a href="" style="float: right">&#8635;</a></h1>
    
    <div id="removeContributor"> 
	  <%List<User> Users = userStore.getInstance().getAllUsers();
	  	int counter_remove=0;%>
	  <ul class="mdl-list">
		  <% for(User user: Users){
		  	String removeContributor = user.getName();
		  
	   	  %>
	   	  <li class="mdl-list__item"> 
				  	 		<span class="mdl-list__item-primary-content">
				  	 			<i class="material-icons mdl-list__item-avatar">Remove User</i>
				  	 			<a class="mdl-color-text--blue-grey-300" href="/user/<%=removeContributor%>"><%= removeContributor %></a>
				  			</span>
				  			<span class="mdl-list__item-secondary-action">
				  				<label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="removeContributor">
				  					<input type="checkbox" name="<%=counter_remove%>" value="<%=removeContributor%>" id="removeContributor"/>
				  				</label>
				  			</span>
				  	</li>
				  	<%request.getSession().setAttribute("counter_remove", counter_remove); 
				  		counter_remove++;%>
			<% } %>
	  </ul>
    <hr/>
    </div>
    
		<form>
		<h1>Add/Remove Users</h1>
		<div id="addContributor">
			<% List<User> users = UserStore.getInstance().getAllUsers();
				 int counter_add=0; 
			%>
			
			<ul class="mdl-list"> 
				<% for(User user: users){
				  
				  	if (!(conversation.isContributor(user))){
				  	  String addContributor = user.getName(); %>
				  	 	
				  	 <li class="mdl-list__item"> 
				  	 		<span class="mdl-list__item-primary-content">
				  	 			<i class="material-icons mdl-list__item-avatar">Add User</i>
				  	 			<a class="mdl-color-text--blue-grey-300" href="/user/<%=addContributor%>"><%= addContributor %></a>
				  			</span>
				  			<span class="mdl-list__item-secondary-action">
				  				<label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="addContributor">
				  					<input type="checkbox" name="<%=counter_add%>" value="<%=addContributor%>" id="addContributor"/>
				  				</label>
				  			</span>
				  	</li>
				  	<%request.getSession().setAttribute("counter_add", counter_add); 
				  		counter_add++;%>
				  	
				  	<% } %>
				  	
				<% } %>
			</ul>
		<hr/>
				<input class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" type="submit" name="addUsers" value="Add Contributor">
				<input class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" type="submit" name="removeUsers" value="Remove Contributor">
		
		</form>
				</div>
		 </div>
		<hr/>







    <div id="chat">
      <ul>
    <%
      for (Message message : messages) {
        String author = UserStore.getInstance()
          .getUser(message.getAuthorId()).getName();
    %>
      <li><strong><%= author %>:</strong> <%= message.getContentWithHtml() %> </li>
    <%
      }
    %>
      </ul>
    </div>

    <hr/>
    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <textarea name="message"></textarea>
        <br/>
        <input name="send" type="submit" value="Send"></input>
        <input name="delete" type="submit" value="Delete Last Message"></input>
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

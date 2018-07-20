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

<!DOCTYPE html>
<html>
<head>
  <title>Interest Page</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App - Team 34</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a href="/users/<%= request.getSession().getAttribute("user") %>" > <%= request.getSession().getAttribute("user") %>'s Profile</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <a href="/users/<%= request.getSession().getAttribute("user") %>">Profile</a>
    <a href="/interest">Interest Chats</a>
  </nav>


  <div id="container">

    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    <% } %>

    <% if(request.getSession().getAttribute("user") != null){ %>
      <h1>Pick Interest Conversation</h1>
      
      
      <p>Select interest from drop-down list:</p>

<form action="/interest" method="POST">
  <select name="interestChoice">
    <option value="Movies">Movies</option>
    <option value="Sports">Sports</option>
    <option value="Readings">Readings</option>
    <option value="Fitness">Fitness</option>
    <option value="Traveling">Traveling</option>
  </select>
  <br><br>
  <input type="submit">
</form>
      
      <hr>
    <% } %>

    <h1>Interest Conversations</h1>
	
	
   
    <hr/>
   
    <hr/>
  </div>
</body>
</html>
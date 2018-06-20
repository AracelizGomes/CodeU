// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

/** Servlet class responsible for the admin page. */
public class AdminServlet extends HttpServlet {

	 /** Store class that gives access to Conversations. */
	  private ConversationStore conversationStore;

	  /** Store class that gives access to Messages. */
	  private MessageStore messageStore;

	  /** Store class that gives access to Users. */
	  private UserStore userStore;

	  /** Set up state for handling chat requests. */
	  @Override
	  public void init() throws ServletException {
	    super.init();
	    setConversationStore(ConversationStore.getInstance());
	    setMessageStore(MessageStore.getInstance());
	    setUserStore(UserStore.getInstance());
	  }

	  /**
	   * Sets the ConversationStore used by this servlet. This function provides a common setup method
	   * for use by the test framework or the servlet's init() function.
	   */
	  void setConversationStore(ConversationStore conversationStore) {
	    this.conversationStore = conversationStore;
	  }

	  /**
	   * Sets the MessageStore used by this servlet. This function provides a common setup method for
	   * use by the test framework or the servlet's init() function.
	   */
	  void setMessageStore(MessageStore messageStore) {
	    this.messageStore = messageStore;
	  }

	  /**
	   * Sets the UserStore used by this servlet. This function provides a common setup method for use
	   * by the test framework or the servlet's init() function.
	   */
	  void setUserStore(UserStore userStore) {
	    this.userStore = userStore;
	  }

	  /**
	   * This function fires when a user requests the /login URL. It simply forwards the request to
	   * admin.jsp.
	   */
	  @Override
	  public void doGet(HttpServletRequest request, HttpServletResponse response)
	      throws IOException, ServletException {
		  List<Conversation> conversations = conversationStore.getAllConversations();
		  request.setAttribute("conversations", conversations);
		  
		  int numConvos = getNumConvos(conversations);
		  request.setAttribute("numConvos", numConvos);
		  
		  String activeUserName = getActiveUser(conversations);
		  request.setAttribute("activeUserName", activeUserName);
		  
		  int numMessages = getNumMessages(conversations);
		  request.setAttribute("numMessages", numMessages);
		  
		  int numUsers = userStore.getNumUsers();
		  request.setAttribute("numUsers", numUsers);
		  
		  request.getRequestDispatcher("/WEB-INF/view/admin.jsp").forward(request, response);
	  }
	  
	  /** Calculates the most popular value in a List */
	  public UUID getPopularElement(List<UUID> idList) {
		if (idList == null)
			return null;
		else {
			int count = 1;
			int	idCount = count;
		    UUID popular = idList.get(0);
		    UUID tempId = null;
		    for (int i = 0; i < (idList.size() - 1); i++) {
		      tempId = idList.get(i);
		      idCount = 0;
		      for (int j = 1; j < idList.size(); j++) {
		        if (tempId == idList.get(j))
		          idCount++;
		      }
		      if (idCount > count) {
		        popular = tempId;
		        count = idCount;
		      }
		    }
		    return popular;
		}
	    
	  }
	  
	  /** Calculates the number of conversations. */
	  public int getNumConvos(List<Conversation> conversations) {
	 	  int numConvos = 0;
			if (conversations == null || conversations.isEmpty()) {
				numConvos = 0;
			}
			else {
				for(Conversation conversation : conversations) {
					numConvos++;
				}
			}
			return numConvos;
	  }
	  
	  /** Calculates the number of messages. */
	  public int getNumMessages(List<Conversation> conversations) {
		  if (conversations == null) 
			  return 0;
		  
			  int numMessages = 0;
			  for(Conversation conversation : conversations) {
				UUID id = conversation.getId();
				List<Message> messages = messageStore.getMessagesInConversation(id);
				for (Message message : messages) {
					numMessages++;		
				}		
			  }
			  return numMessages;
	  }	  
	  
	  
	  /** Returns username of most active user by finding user with most messages. */
	  public String getActiveUser (List<Conversation> conversations) {
		  if (conversations == null)
			  return null;
		  else {
			  List<UUID> userId = new ArrayList<UUID>();
			  for (Conversation conversation : conversations) {
					UUID id = conversation.getId();
					List<Message> messages = messageStore.getMessagesInConversation(id);
					for (Message message : messages) {
						userId.add(message.getAuthorId());			
					}		
			  }	
			  UUID activeUserId = getPopularElement(userId);
			  User activeUser = userStore.getUser(activeUserId);
			  String activeUserName = activeUser.getName();
			  
			  return activeUserName;
		  }		 		  
	  }	

}


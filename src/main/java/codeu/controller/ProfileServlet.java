package codeu.controller;

import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;


import org.mindrot.jbcrypt.BCrypt;
/** Servlet class responsible for the Profile page. */
public class ProfileServlet extends HttpServlet {
	private UserStore userStore;
	
	private ConversationStore conversationStore;
	
	private MessageStore messageStore;
	
	@Override
	  public void init() throws ServletException {
	    super.init();
	    setUserStore(UserStore.getInstance());
	    setConversationStore(ConversationStore.getInstance());
	    setMessageStore(MessageStore.getInstance());
	    
	  }

	  /**
	   * Sets the UserStore used by this servlet. This function provides a common setup method for use
	   * by the test framework or the servlet's init() function.
	   */
	  void setUserStore(UserStore userStore) {
	    this.userStore = userStore;
	  }
	  
	  void setConversationStore(ConversationStore conversationStore) {
		 this.conversationStore = conversationStore;
	  }
	  
	  void setMessageStore(MessageStore messageStore) {
		 this.messageStore = messageStore;
	  }
	  
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	  String requestUrl = request.getRequestURI();
	  String userProfile = requestUrl.substring("/users/".length());
				
	  User user = userStore.getUser(userProfile); //no one logged in
	  if (user == null) {
		  System.out.println("Not logged in " + userProfile);
        response.sendRedirect("/login");
		return;
	  }
	  
	  //someone is logged in
				
	  UUID userid = user.getId();
	  MessageStore message = MessageStore.getInstance();
	  List<Message> messagesSent = message.getMessagesOfUser(userid); //get the users messages
	  
	  request.setAttribute("user", user);
	  request.setAttribute("userProfile", userProfile);
	  
	  request.setAttribute("messages", messagesSent);
	  
	  //goes to profile page
	  request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
				
	}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	  String requestUrl = request.getRequestURI();
	  String userProfile = requestUrl.substring("/users/".length());
		
	  User user = userStore.getUser(userProfile);
	  String username = (String) request.getSession().getAttribute("user");
	  
	  String biography = request.getParameter("biography"); //get bio
	  String cleanedBiography = Jsoup.clean(biography,Whitelist.none()); //removes html tags
	  user.setBiography(cleanedBiography); //sets bio as instance var for user
		
	  userStore.updateUser(user);
		
		
		/*
			if (username == null) {
				response.sendRedirect("/login");
				return;
			}
			
			if (user == null) {
				response.sendRedirect("/login");
				return;
			}
		*/	
	  response.sendRedirect("/users/" + userProfile);
	}
	
}




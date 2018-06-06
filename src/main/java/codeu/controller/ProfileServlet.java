package codeu.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import codeu.model.data.User;
import java.time.Instant;
import java.time.format.DateTimeFormatter;
import java.util.UUID;
import java.util.List;
import codeu.model.store.basic.UserStore;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import codeu.model.data.User;
import codeu.model.data.Message;

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
	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException {
				String requestUrl = request.getRequestURI();
				String userProfile = requestUrl.substring("/users/".length());
				
				User user = userStore.getUser(userProfile);
				if (user == null) {
					response.sendRedirect("/login");
					return;
				}
		
			request.setAttribute("user", user);
			request.setAttribute("userProfile", userProfile);
				
			UUID writer = user.getId();
			MessageStore message = MessageStore.getInstance();
			List<Message> messagesSent = message.getMessageOfUser(writer); //get the users messages
			
			request.setAttribute("messages", messagesSent);
			
			request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
				
	}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws IOException, ServletException {
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




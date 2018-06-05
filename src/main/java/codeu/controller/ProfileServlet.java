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

import org.mindrot.jbcrypt.BCrypt;
/** Servlet class responsible for the Profile page. */
public class ProfileServlet extends HttpServlet {
	
	private UserStore userStore;
	
	@Override
	  public void init() throws ServletException {
	    super.init();
	    setUserStore(UserStore.getInstance());
	  }

	  /**
	   * Sets the UserStore used by this servlet. This function provides a common setup method for use
	   * by the test framework or the servlet's init() function.
	   */
	  void setUserStore(UserStore userStore) {
	    this.userStore = userStore;
	  }
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException {
				String requestUrl = request.getRequestURI();
				String userProfile = requestUrl.substring("/users/".length());
				
				User user = userStore.getUser(userProfile);
				//UUID userID = UserStore.getInstance().getUser(username).getId();
				
				//if (userID == null) {
					//response.sendRedirect("/login");
					//return;
				//}
			
				if (user == null) {
					response.sendRedirect("/login");
					return;
				}
			
			request.setAttribute("user", user);
			//request.setAttribute("userID", userID);
			request.setAttribute("userProfile", userProfile);
			request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
		
	}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws IOException, ServletException {
			String requestUrl = request.getRequestURI();
			String userProfile = requestUrl.substring("/users/".length());
		
		String username = (String) request.getSession().getAttribute("user");
			if (username == null) {
				response.sendRedirect("/login");
				return;
			}
			
			
		User user = userStore.getUser(userProfile);
			if (user == null) {
				response.sendRedirect("/login");
				return;
			}
	response.sendRedirect("/users/" + username);
	}
	
}




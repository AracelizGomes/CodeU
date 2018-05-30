package codeu.controller;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**import codeu.model.data.ActivityFeed;*/

/** Servlet class responsible for the activity feed. */
public class ActivityFeedServlet extends HttpServlet{
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.getOutputStream().println("This is the Activity Feed");
		
	}


}

package codeu.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

public class ActivityFeedServletTest {
	private ActivityFeedServlet activityfeedServlet;
	private HttpServletRequest mockRequest;
	private HttpServletResponse mockResponse; 
	private ServletOutputStream mockOutputStream;


	@Before
	public void setup() throws IOException {
		activityfeedServlet = new ActivityFeedServlet(); 
		mockRequest = Mockito.mock(HttpServletRequest.class);
		mockResponse = Mockito.mock(HttpServletResponse.class);
		mockOutputStream = Mockito.mock(ServletOutputStream.class);
		Mockito.when(mockResponse.getOutputStream())
        	.thenReturn(mockOutputStream);
	}
	@Test
	  public void testDoGet() throws IOException, ServletException {
	    activityfeedServlet.doGet(mockRequest, mockResponse);
	    Mockito.verify(mockOutputStream).println("This is the Activity Feed");
	}
}
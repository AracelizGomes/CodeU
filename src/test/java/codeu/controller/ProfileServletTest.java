package codeu.controller;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;

public class ProfileServletTest {
      private ProfileServlet profileServlet;
	  private HttpServletRequest mockRequest;
	  private RequestDispatcher mockRequestDispatcher;
	  private HttpServletResponse mockResponse;
	  
	  @Before
	  public void setup() throws IOException {
	    profileServlet = new ProfileServlet();
	    mockRequest = Mockito.mock(HttpServletRequest.class);
	    mockResponse = Mockito.mock(HttpServletResponse.class);
	    mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
	    Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/profile.jsp"))
	        .thenReturn(mockRequestDispatcher);
	  }

	  
	  @Test
	  public void testDoGet_userValid() throws IOException, ServletException {
		  User userMock = new User(
				  UUID.randomUUID(), "Mock", "mockpassword", Instant.now());
		  UserStore mockUserStore = Mockito.mock(UserStore.class);
		  
		  Mockito.when(mockRequest.getRequestURI()).thenReturn("/users/mock");
		  Mockito.when(mockUserStore.getUser("mock")).thenReturn(userMock);
		  
		  profileServlet.setUserStore(mockUserStore);
		  profileServlet.doGet(mockRequest, mockResponse);
		  Mockito.verify(mockRequestDispatcher).forward(mockRequest,mockResponse);
	  }
	  
	  @Test
	  public void testDoGet_UserDoesNotExist() throws IOException, ServletException {
		  
		  UserStore mockUserStore = Mockito.mock(UserStore.class);
		  
		  Mockito.when(mockRequest.getRequestURI()).thenReturn("/users/mock");
		  Mockito.when(mockUserStore.getUser("Mock")).thenReturn(null);
		  
		  profileServlet.setUserStore(mockUserStore);
		  profileServlet.doGet(mockRequest, mockResponse);
		  Mockito.verify(mockRequestDispatcher).forward(mockRequest,mockResponse);
	  }

	  @Test
	  public void testDoPost() throws IOException, ServletException {
		  User userMock = new User(
				  UUID.randomUUID(), "Mock", "mockpassword", Instant.now());
		  UserStore mockUserStore = Mockito.mock(UserStore.class);
		  
		  Mockito.when(mockRequest.getRequestURI()).thenReturn("/users/mock");
		  Mockito.when(mockUserStore.getUser("Mock")).thenReturn(userMock);
		  Mockito.when(mockRequest.getParameter("biography")).thenReturn("Mock Bio");
		  
		  profileServlet.setUserStore(mockUserStore);
		  profileServlet.doGet(mockRequest, mockResponse);
		  Assert.assertEquals("Mock Bio", userMock.getBiography());
		  Mockito.verify(mockResponse).sendRedirect("/users/mock");
	  }

	  @Test
	  public void testDoPost_UncleanedBio() throws IOException, ServletException {
		  User userMock = new User(
				  UUID.randomUUID(), "Mock", "mockpassword", Instant.now());
		  UserStore mockUserStore = Mockito.mock(UserStore.class);
		  
		  Mockito.when(mockRequest.getRequestURI()).thenReturn("/users/mock");
		  Mockito.when(mockUserStore.getUser("Mock")).thenReturn(userMock);
		  Mockito.when(mockRequest.getParameter("biography")).thenReturn("<h1> Mock's Bio </h1>");
		  
		  profileServlet.setUserStore(mockUserStore);
		  profileServlet.doGet(mockRequest, mockResponse);
		  Assert.assertEquals("Mock's Bio", userMock.getBiography());
		  Mockito.verify(mockResponse).sendRedirect("/users/mock");
	  }


}
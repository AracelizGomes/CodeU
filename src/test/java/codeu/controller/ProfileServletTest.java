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
	private HttpSession mockSession;
	private HttpServletResponse mockResponse;
	private RequestDispatcher mockRequestDispatcher;
	private UserStore mockUserStore;
	  
	  @Before
	  public void setup() throws IOException {
	    profileServlet = new ProfileServlet();
	    
	    mockRequest = Mockito.mock(HttpServletRequest.class);
	    mockSession = Mockito.mock(HttpSession.class);
	    Mockito.when(mockRequest.getSession()).thenReturn(mockSession);
	    
	    mockResponse = Mockito.mock(HttpServletResponse.class);
	    mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
	    Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/profile.jsp"))
	      .thenReturn(mockRequestDispatcher);
	    
	    mockUserStore = Mockito.mock(UserStore.class);
	    profileServlet.setUserStore(mockUserStore);
	  }
	  
	  
	  @Test
	  public void testDoGet_userValid() throws IOException, ServletException {
		  Mockito.when(mockRequest.getRequestURI()).thenReturn("/users/test_username");
		  Mockito.when(mockSession.getAttribute("user")).thenReturn("test_username");
		  User fakeUser = new User(
			  UUID.randomUUID(), 
				"test_username", 
				"$2a$10$bBiLUAVmUFK6Iwg5rmpBUOIBW6rIMhU1eKfi3KR60V9UXaYTwPfHy", 
				Instant.now());
		  
		  Mockito.when(mockUserStore.getUser("test_username")).thenReturn(fakeUser);
		  profileServlet.setUserStore(mockUserStore);
		  profileServlet.doGet(mockRequest, mockResponse);
		  Mockito.verify(mockRequest).setAttribute("user", fakeUser);
		  Mockito.verify(mockRequestDispatcher).forward(mockRequest,mockResponse);
	  }
}
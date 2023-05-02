package semiproject.dak.common.controller;

import java.io.*;
import java.lang.reflect.Constructor;
import java.util.* ;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FrontController
 */
@WebServlet(
		description = "사용자가 웹에서 *.dak 을 했을 경우 이 서블릿이 응답을 해주도록 한다.",
		urlPatterns = { "*.dak" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "C:/git/FiveDak/FiveDak/src/main/webapp/WEB-INF/Command.properties",
						description = "*.dak 에 대한 클래스의 매핑파일")
		})

public class FrontController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	Map<String, Object> cmdMap = new HashMap<>() ; 
	public void init(ServletConfig config) throws ServletException {
		FileInputStream fis = null ;
		
		String props = config.getInitParameter("propertyConfig");
		try {
			fis = new FileInputStream(props);
			
			Properties pr = new Properties();
			pr.load(fis);
			Enumeration<Object> en = pr.keys(); 
			
			while(en.hasMoreElements()) {
				String key = (String)en.nextElement();
			//	System.out.println("~~~ 확인용 key => "+key);
				String className = pr.getProperty(key);
			//  System.out.println("=== 확인용 className => "+className);
				
				if ( className != null ) {
					className = className.trim(); 
					Class<?> cls = Class.forName(className);
					
					Constructor<?> constrt = cls.getDeclaredConstructor();
					// 생성자 만들기
					Object obj = constrt.newInstance();
					// System.out.println("### 확인용 : "+obj);
				
					// System.out.println("--- 확인용 : "+obj.toString());
					// --- 확인용 : ### 클래스 Test2Controller 의 인스턴스 메소드 toString()을 호출함 ###
					// --- 확인용 : @@@ 클래스 Test1Controller 의 인스턴스 메소드 toString()을 호출함 @@@
					
					cmdMap.put(key, obj);
				}
				
				
			}// end of while
			
		} catch (FileNotFoundException e) {
			System.out.println(" >>> C:/NCS/workspace(jsp)/MyMVC/src/main/webapp/WEB-INF/Command.properties 에 파일이 없습니다. <<< ");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println(">>> 문자열로 명명되어진 클래스가 존재하지 않습니다.<<<");
			e.printStackTrace();
		}catch (Exception e) { // 위에의 EXCEPTION을 제외한 기타나머지를 모두 받는다.
			e.printStackTrace();
		}
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String uri = request.getRequestURI();
		
		String key = uri.substring(request.getContextPath().length());
		
		AbstractController action = (AbstractController)cmdMap.get(key);
		
		if ( action == null ) {
			System.out.println(">>> "+key+" 은 URI 패턴에 매핑된 클래스가 없습니다. <<<");
		}
		
		else {
			try {
				
				request.setCharacterEncoding("UTF-8");
				
				action.execute(request, response);
				boolean bool = action.isRedirect();
				String viewPage = action.getViewPage();
				if ( ! bool ) {
					if( viewPage != null ) {
					RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
					dispatcher.forward(request, response);
					}
				}
				else { 
					if ( viewPage != null ) {
						response.sendRedirect(viewPage);
						
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		

	}// END OF PROTECTED VOID DOGET(HTTPSERVLETREQUEST REQUEST, HTTPSERVLETRESPONSE RESPONSE) THROWS SERVLETEXCEPTION, IOEXCEPTION {
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

package semiproject.dak.admin.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;

public class AdminProductInsertAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// === 관리자(admin)로 로그인 했을 때만 제품등록이 가능하도록 해야 한다. === //
				HttpSession session = request.getSession();
				
				MemberDTO loginuser = (MemberDTO)session.getAttribute("loginuser");
				
				if(loginuser != null && "admin".equals(loginuser.getUserid())) {
					//관리자(admin)로 로그인 했을 경우
					
					String method = request.getMethod();
					
					if(!"POST".equalsIgnoreCase(method)) {  //"GET: 이라면
					
						//카테고리 목록을 조회해오기
						super.getCategoryList(request);  //productRegister.jsp 페이지에 사용가능하도록
						
						//spec 목록을 조회해오기
						InterProductDAO pdao = new ProductDAO();
						List<SpecVO> specList = pdao.selectSpecList();
						request.setAttribute("specList", specList);
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/myshop/admin/productRegister.jsp");
						
					} else { 

						MultipartRequest mtrequest = null;
						/*
			               MultipartRequest mtrequest 은 
			               HttpServletRequest request 가 하던일을 그대로 승계받아서 일처리를 해주고 
			               동시에 파일을 받아서 업로드, 다운로드까지 해주는 기능이 있다.      
						*/
						
						//1. 첨부되어진 파일을 디스크의 어느 경로에 업로드 할 것인지 그 경로를 설정해야 한다.
						ServletContext svlCtx = session.getServletContext();
						String uploadFileDir = svlCtx.getRealPath("/images");
						
					//	System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> "+uploadFileDir);
						//=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\MyMVC\images
						
						/*
			             MultipartRequest의 객체가 생성됨과 동시에 파일 업로드가 이루어 진다.
			                   
			             MultipartRequest(HttpServletRequest request,
			                               String saveDirectory, -- 파일이 저장될 경로
			                            int maxPostSize,      -- 업로드할 파일 1개의 최대 크기(byte)
			                            String encoding,
			                            FileRenamePolicy policy) -- 중복된 파일명이 올라갈 경우 파일명다음에 자동으로 숫자가 붙어서 올라간다.   
			                  
			             파일을 저장할 디렉토리를 지정할 수 있으며, 업로드제한 용량을 설정할 수 있다.(바이트단위)
			             이때 업로드 제한 용량을 넘어서 업로드를 시도하면 IOException 발생된다. 
			             또한 국제화 지원을 위한 인코딩 방식을 지정할 수 있으며, 중복 파일 처리 인터페이스를사용할 수 있다.
			                        
			             이때 업로드 파일 크기의 최대크기를 초과하는 경우이라면
			             IOException 이 발생된다.
			             그러므로 Exception 처리를 해주어야 한다.                
						*/
						
						// === 파일을 업로드 해준다. === //
						//cf. 1024*1024 는 1MB! ==> 따라서 10*1024*1024 는 10MB!
						try {
							mtrequest = new  MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());   
						} catch(IOException e) {
							request.setAttribute("message", "업로드 되어질 경로가 잘못 되었거나 또는 최대용량 10MB를 초과했으므로 파일 업로드 실패함!!");
							request.setAttribute("loc", request.getContextPath()+"/shop/admin/productRegister.up");
							
							super.setRedirect(false);
							super.setViewPage("/WEB-INF/msg.jsp");
							return;  //종료
						}
						
						// === 첨부 이미지 파일, 제품설명서 파일을 올렸으니 그 다음으로 제품정보(제품명, 정가, 제품수량, .....)를 DB의 tbl_product 테이블에 insert 를 해주어야 한다. ===
						
						//새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기
						String fk_cnum = mtrequest.getParameter("fk_cnum");
						String pname = mtrequest.getParameter("pname");
						String pcompany = mtrequest.getParameter("pcompany");
						
						// 업로드되어진 시스템의 첨부파일 이름(파일서버에 업로드 되어진 실제파일명)을 얻어 올때는 
			            // cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
			            // 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
						String pimage1 = mtrequest.getFilesystemName("pimage1");   //제품 이미지 파일명(파일서버에 업로드 되어진 실제 파일명)
						String pimage2 = mtrequest.getFilesystemName("pimage2");   //제품 이미지 파일명(파일서버에 업로드 되어진 실제 파일명)
					//	System.out.println("~~~ 확인용 pimage1 : " + pimage1);
					//	System.out.println("~~~ 확인용 pimage2 : " + pimage2);
						
						String prdmanual_systemFileName = mtrequest.getFilesystemName("prdmanualFile");
						//제품 이미지 파일명(파일서버에 업로드 되어진 실제 파일명)
						//제품설명서 파일명 입력은 선택사항이므로 NULL 이 될 수 있다.
					//	System.out.println("~~~ 확인용 prdmanual_systemFileName : "+prdmanual_systemFileName);
						//~~~ 확인용 prdmanual_systemFileName : LG_싸이킹청소기_사용설명서.pdf
						//~~~ 확인용 prdmanual_systemFileName : LG_싸이킹청소기_사용설명서1.pdf
						//~~~ 확인용 prdmanual_systemFileName : LG_싸이킹청소기_사용설명서2.pdf
						
						String prdmanual_orginFileName = mtrequest.getOriginalFileName("prdmanualFile");
						// 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명
			            // 제품설명서 파일명 입력은 선택사항이므로 NULL 이 될 수 있다.
			            // 첨부파일들 중 이것만 파일다운로드를 해주기 때문에 getOriginalFileName(String name) 메소드를 사용한다. 
						
						
						String pqty = mtrequest.getParameter("pqty");
						String price  = mtrequest.getParameter("price");
						String saleprice = mtrequest.getParameter("saleprice");
						String fk_snum = mtrequest.getParameter("fk_snum");
						
						// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 !!!! //
						String pcontent = mtrequest.getParameter("pcontent");
						pcontent = pcontent.replaceAll("<", "&lt;");  // "<"가 포함되어 있다면, "<"를 부등호로 바꿔서 pcontent에 다시 집어넣는다.
						pcontent = pcontent.replaceAll(">", "&gt;");  // ">"가 포함되어 있다면, ">"를 부등호로 바꿔서 pcontent에 다시 집어넣는다.
						/*
							<script type="text/javascript">
				                alert("안녕하세요~~ 빨강파랑 ㅋㅋㅋ");
				                
				                var body = document.getElementsByTagName("body");
				                body[0].style.backgroundColor = "red";
				                
				                var arrDiv = document.getElementsByTagName("div");
				                for(var i=0; i<arrDiv.length; i++) {
				                     arrDiv[i].style.backgroundColor = "blue";
				                }
			            	</script>
						*/
						
						//입력한 내용에서 엔터는 <br>로 변환시키기
						pcontent = pcontent.replaceAll("\r\n", "<br>");   // "\r\n"(엔터)를 <br>로 다 바꿔서 pcontent에 넣어주기
						
						String point = mtrequest.getParameter("point");
						
						InterProductDAO pdao = new ProductDAO();
						
						int pnum = pdao.getPnumOfProduct(); //제품번호 채번 해오기
						
						ProductVO pvo = new ProductVO();
						pvo.setPnum(pnum);
						pvo.setPname(pname);
						pvo.setFk_cnum(Integer.parseInt(fk_cnum));
			            pvo.setPcompany(pcompany);
			            pvo.setPimage1(pimage1);
			            pvo.setPimage2(pimage2);
			            pvo.setPrdmanual_systemFileName(prdmanual_systemFileName);
			            pvo.setPrdmanual_orginFileName(prdmanual_orginFileName);
			            pvo.setPqty(Integer.parseInt(pqty));
			            pvo.setPrice(Integer.parseInt(price));
			            pvo.setSaleprice(Integer.parseInt(saleprice));
			            pvo.setFk_snum(Integer.parseInt(fk_snum));
			            pvo.setPcontent(pcontent);
			            pvo.setPoint(Integer.parseInt(point));
						
						String message = "";
						String loc = "";
						
						try {
							// tbl_product (부모)테이블에 insert 하기
							pdao.productInsert(pvo);
							
							// === 추가이미지파일이 있다라면 tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 === //
							String str_attachCount = mtrequest.getParameter("attachCount"); 
				            // str_attachCount 이 추가이미지 파일의 개수이다. "" "0" ~ "10" 이 들어온다.
							
							int attachCount = 0;
							
							if(!"".equals(str_attachCount)) {
								attachCount = Integer.parseInt(str_attachCount);
							}
							
							//첨부파일의 파일명(파일서버에 업로드 되어진 실제파일명) 알아오기
							for(int i=0; i<attachCount; i++) {
								String attachFileName = mtrequest.getFilesystemName("attach"+i);
								
								pdao.product_imagefile_Insert(pnum, attachFileName);
														   // pnum 은 위에서 채번해온 제품번호이다.
								
							}//end of for-----------------------------------
							
							message = "제품등록 성공!!";
							loc = request.getContextPath()+"/shop/mallHome1.up";   //시작 페이지로 이동
						} catch(SQLException e) {
							
							e.printStackTrace();
				              
							message = "제품등록 실패!!";
							loc = request.getContextPath()+"/shop/admin/productRegister.up";
						}
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
						
					}
					
					
				}	
					
				
				else {  
					//로그인을 안 한 경우 또는 일반사용자로 로그인 한 경우
					String message = "관리자만 접근이 가능합니다.";
					String loc = "javascript:history.back()";
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				
				
			}
		
		
		
	

}

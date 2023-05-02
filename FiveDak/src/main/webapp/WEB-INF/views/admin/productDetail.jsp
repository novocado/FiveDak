<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header-final.jsp"/>

<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>


<style type="text/css">



</style>
<div class="col-md-9">
      <!-- 오른쪽에 들어갈 내용 -->
         <h2 class="h2 mb-3" style="text-align: center;"> 제품 정보 상세 페이지</h2>
         <hr style="border: 1px solid; clear:both;"/>
         <div style="border: solid 1px black;">
            <table class="table">
               <tbody>
                  <tr>
                     <th class="MemberShowDetailth">제품번호</th>
                     <td></td>    
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">제품이름</th>
                     <td></td>
                     <th class="MemberShowDetailth">브랜드</th>
                     <td></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">휴대폰</th>
                     <td></td>
                     <th class="MemberShowDetailth">카테고리</th>
                     <td></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">성별</th>
                     <td></td>
                     <th class="MemberShowDetailth">생일</th>
                  	<td></td>
                  </tr>
                  
                  <tr>
                     <th class="MemberShowDetailth">우편번호</th>
                     <td></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">주소</th>
                     <td></td>
                     <th class="MemberShowDetailth">상세주소</th>
                     <td></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">보유 포인트</th>
                     <td></td>
                     <th class="MemberShowDetailth">회원 티어</th>
                  	 <td></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">구입수량</th>
                     <td></td>
                     <th class="MemberShowDetailth">회원 가입일</th>
                     <td></td>                 
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">회원 상태</th>
                  	 <td></td>   
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">계정 상태</th>
                      <td></td>   
                  </tr>
                  
                  
               </tbody>
            </table>
         </div>
         
         <div style = "text-align: center; margin-top: 50px;">
            <button type="button" class="btn" style="background-color: #FF7E32;">뒤로가기</button>
            <button type="button" class="btn" style="background-color: #FF7E32;">수정하기</button>
            <button type="button" class="btn" style="background-color: #FF7E32;">삭제하기</button> 
         </div> 
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
































<jsp:include page="/WEB-INF/views/footer.jsp"/>

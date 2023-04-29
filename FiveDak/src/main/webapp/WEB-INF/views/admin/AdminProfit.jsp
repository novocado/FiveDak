<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header-final.jsp"/>

<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/echarts@5.2.1/dist/echarts.min.js"></script>


<div id="chart" style="width: 800px; height:700px;"></div>
































      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>

<script type="text/javascript">
		//현재 날짜 생성
		var currentDate = new Date();
		
		// 1달전, 2달전, 3달전 계산
		var oneMonthAgo = new Date(currentDate.getFullYear(), currentDate.getMonth() - 1, 1);
		var twoMonthsAgo = new Date(currentDate.getFullYear(), currentDate.getMonth() - 2, 1);
		var threeMonthsAgo = new Date(currentDate.getFullYear(), currentDate.getMonth() - 3, 1);
		var fourMonthsAgo = new Date(currentDate.getFullYear(), currentDate.getMonth() - 4, 1);
		var fiveMonthsAgo = new Date(currentDate.getFullYear(), currentDate.getMonth() - 5, 1);
		var sixMonthsAgo = new Date(currentDate.getFullYear(), currentDate.getMonth() - 6, 1);
		
		// 년월 정보 추출
		var formatDate = function(date) {
		  var year = date.getFullYear();
		  var month = date.getMonth() + 1;
		  if (month < 10) {
		    month = '0' + month;
		  }
		  return year + '-' + month;
		};
		
		// 년월 정보 배열 생성
		var data1 = [
		  formatDate(sixMonthsAgo),
		  formatDate(fiveMonthsAgo),
		  formatDate(fourMonthsAgo),
		  formatDate(threeMonthsAgo),
		  formatDate(twoMonthsAgo),
		  formatDate(oneMonthAgo),
		  formatDate(currentDate),
		];
		
		
		//그래프를 그릴 HTML 요소를 가져옵니다.
		var chartDom = document.getElementById('chart');
		
		// echarts 객체를 생성합니다.
		var myChart = echarts.init(chartDom);
		
		// 그래프에 사용할 데이터를 설정합니다.
		var data = [5, 20, 36, 10, 10, 20 , 30 ];
		
		// 그래프의 옵션을 설정합니다.
		var option = {
		    // 그래프 타입을 설정합니다. (여기서는 선 그래프를 사용합니다.)
		    xAxis: {
		        type: 'category',
		        data: data1
		    },
		    yAxis: {
		        type: 'value'
		    },
		    series: [{
		        data: data,
		        type: 'line'
		    }]
		};
		
		// 그래프를 그립니다.
		myChart.setOption(option);		

</script>
<jsp:include page="/WEB-INF/views/footer.jsp"/>
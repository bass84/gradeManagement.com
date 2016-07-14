<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(document).on("ready", function() {
		var attendanceScoreRatio = ${subject.attendanceScoreRatio};
		
		$(document)
			.on("click", "#studentRegistButton", function() {
				$("#student").val("").attr("selected", "selected");
		});
		
		$(document)
			.on("click", "#student", function() {
				if($("input:checkbox[id='student']").is(":checked")) {
					$("input:checkbox[name='student']").prop("checked", true);
					
				}
				else {
					$("input:checkbox[name='student']").prop("checked", false);
				}
		});
		
		$(document)
			.on("click", "#courses", function() {
				if($("input:checkbox[id='courses']").is(":checked")) {
					$("input:checkbox[name='courses']").prop("checked", true);
				}
				else {
					$("input:checkbox[name='courses']").prop("checked", false);
				}
		});
		
		$(document)
			.on("click", "#addButton", function() {
				var checkedLength = $("input:checkbox[name='student']:checked").length;
				if(checkedLength != 0) {
					if(window.confirm("등록하시겠습니까?")) {
						$("#studentAddForm").submit();
					}
				}
				else {
					alert("한명 이상의 학생을 선택하여주세요.");
					return false;
				}
		});
		
		$(document)
			.on("click", "#studentDeleteButton", function() {
				var checkedValue = "";
				var checkedLength = $("input:checkbox[name='courses']:checked").length;
				if(checkedLength != 0) {
					$("input:checkbox[name='courses']:checked").each(function(i , element) {
						if(i != (checkedLength - 1)) {
							checkedValue += element.value + ",";
						}
						else {
							checkedValue += element.value;
						}
					});
					if(window.confirm("정말 삭제하시겠습니까?")) {
						$.ajax({
							url: "${pageContext.request.contextPath}/management/deleteStudentIncourses"
							, data: {"checkedValue" : checkedValue}
							, async: false
							, type : "POST"
							, success : function(result) {
								if(result) {
									location.reload();
									alert("정상 삭제되었습니다.");
								}
								else {
									alert("정상 삭제되지 않았습니다.");
								}
							}
						});
					}
					
				}
				
				else {
					alert("한명 이상의 학생을 선택하여주세요");
					return false;
				}
		});
		
		$(document)
			.on("click", "#ScoreRegistButton", function() {
				if(window.confirm("점수등록을 하시겠습니까?")) {
					var buttons = $("#buttons > button");
					for(var i = 0; i < buttons.length; i++) {
						$(buttons[i]).hide();
					}
					$("#buttons").append('<button id="addScoreButton" class="btn btn-primary btn-lg">등록</button>');
					var courses = $("#subjectTbody > tr");
					var gate = function(i) {
						var attendance = $(courses[i]).find("td").eq(4).text();
						var attendanceScore = $(courses[i]).find("td").eq(5).text();
						var midtermExamScore = $(courses[i]).find("td").eq(6).text();
						var finalExamScore = $(courses[i]).find("td").eq(7).text();
						var reportScore = $(courses[i]).find("td").eq(8).text();
						var totalScore = $(courses[i]).find("td").eq(9).text();
						
						$(courses[i]).find("td").eq(4).text("")
							.append('<input type="text" class="form-control" id="attendance' + i + '" value="' + attendance + '" style="text-align:center;"/>');
						$(courses[i]).find("td").eq(5).text("")
							.append('<input type="text" class="form-control" readonly id="attendanceScore' + i + '" name="attendanceScore" value="' + attendanceScore + '" style="text-align:center;"/>');
						$(courses[i]).find("td").eq(6).text("")
							.append('<input type="text" class="form-control" id="midtermExamScore' + i + '" value="' + midtermExamScore + '" style="text-align:center;"/>');
						$(courses[i]).find("td").eq(7).text("")
							.append('<input type="text" class="form-control" id="finalExamScore' + i + '" value="' + finalExamScore + '" style="text-align:center;"/>');
						$(courses[i]).find("td").eq(8).text("")
							.append('<input type="text" class="form-control" id="reportScore' + i + '" value="' + reportScore + '" style="text-align:center;"/>');
						$(courses[i]).find("td").eq(9).text("")
							.append('<input type="text" class="form-control" readonly id="totalScore' + i + '" value="' + totalScore + '" style="text-align:center;"/>');
						
						$("#attendance" + i).keyup(function() {
							//var index = $(this).attr("id").substr(10);
							$("#attendanceScore" + i).val(attendanceScoreRatio - (((15 - $(this).val()) * 2/15) * attendanceScoreRatio));
						});
						
					}
					for(var i = 0; i < courses.length; i++) {
						gate(i);
					}
					
					
				}
		});
		
		
		
		$('#courseTable').DataTable({
	    	responsive: true
	   	});
	 	$(".col-sm-6").eq(1).css("text-align", "right");
		$(".col-sm-6").eq(3).css("text-align", "left");
		$(".col-sm-6").eq(2).css("width", "39%");	
	
	});
</script>

<div class="row">
            <div class="col-lg-12">
                 <div class="panel panel-default">
                     <div class="panel-heading">
                         DataTables Advanced Tables
                     </div>
                     <!-- /.panel-heading -->
            <div class="panel-body">
                <div class="dataTable_wrapper">
                	<form id="addScoreForm" action="${pageContext.request.contextPath}/management/addScores">
	                    <table class="table table-striped table-bordered table-hover" id="courseTable">
	                        <thead>
	                            <tr>
	                            	<th style="text-align:center;"><input type="checkbox" id="courses" style="width:16px; height:16px;"/></th>
	                            	<th style="text-align:center; font-size:17px; font-weight:bold">학년</th>
	                            	<th style="text-align:center; font-size:17px; font-weight:bold">학번</th>
	                                <th style="text-align:center; font-size:17px; font-weight:bold">학생이름</th>
	                                <th style="text-align:center; font-size:17px; font-weight:bold">출석일수</th>
	                                <th style="text-align:center; font-size:17px; font-weight:bold">출결점수</th>
	                                <th style="text-align:center; font-size:17px; font-weight:bold">중간고사점수</th>
	                                <th style="text-align:center; font-size:17px; font-weight:bold">기말고사점수</th>
	                                <th style="text-align:center; font-size:17px; font-weight:bold">레포트점수</th>
	                                <th style="text-align:center; font-size:17px; font-weight:bold">총점</th>
	                            </tr>
	                        </thead>
	                        <tbody id="subjectTbody">
	                        	<c:choose>
		                        	<c:when test="${fn:length(courseList) == 0}">
		                        		<tr class="odd gradeX">
		                        			<td colspan="10" style="height:200px; text-align:center; vertical-align:middle;">
		                        				<font size="100">등록된 학생이 없습니다.</font>
		                        			</td>
		                        		</tr>
		                        		
		                        	</c:when>
		                        	
		                        	<c:otherwise>
		                        		<c:forEach items="${courseList}" var="list" varStatus="i">
				                            <tr class="odd gradeX">
				                            	<td style="text-align:center">
				                            		<input type="checkbox" id="courses${i.index}" name="courses" value="${list.collegeId}#${list.studentId}#${list.semester}#${list.subjectName}" style="width:16px; height:16px;"/>
				                            	</td>
				                            	<td style="text-align:center">${list.grade}</td>
				                            	<td style="text-align:center">${list.studentId}</td>
				                            	<td style="text-align:center">${list.studentName}</td>
				                                <td style="text-align:center">${list.attendance}</td>
				                                <td style="text-align:center">${list.attendanceScore}</td>
				                                <td style="text-align:center">${list.midtermExamScore}</td>
				                                <td style="text-align:center">${list.finalExamScore}</td>
				                                <td style="text-align:center">${list.reportScore}</td>
				                                <td style="text-align:center">${list.totalScore}</td>
				                            </tr>
		                            	</c:forEach>
		                        	</c:otherwise>
	                        	</c:choose>
	                        	
	                        </tbody>
	                    </table>
                    </form>
                    <div style="text-align:right;" id="buttons">
                    	<button class="btn btn-danger btn-lg" id="studentDeleteButton">학생삭제</button>
                    	<button class="btn btn-success btn-lg" id="ScoreRegistButton">점수등록</button>
                    	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#studentRegistModal" id="studentRegistButton">학생등록</button>
                    </div>
                    <div class="modal fade" id="studentRegistModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <form id="studentAddForm" action="${pageContext.request.contextPath}/management/addStudentForCourses" method="POST">
                        	<input type="hidden" name="collegeId" value="${subject.collegeId}" />
                        	<input type="hidden" name="semester" value="${subject.semester}" />
                        	<input type="hidden" name="subjectName" value="${subject.subjectName}" />
	                        <div class="modal-dialog">
	                            <div class="modal-content">
	                                <div class="modal-header">
	                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                                    <h4 class="modal-title" id="myModalLabel">관리정보입력</h4>
	                                </div>
	                                <div class="modal-body" style="height:300px; overflow:auto;" >
	                                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
					                        <tbody>
					                        	<tr class="odd gradeX">
					                        		<!-- <th style="width:25%; height:10px; text-align:center; vertical-align:middle;">학생정보</th> -->
					                        		<td style="padding:0px;">
					                        			<table class="table table-striped table-bordered table-hover" id="studentCheckTable">
					                        				<tbody>
					                        					<tr class="odd gradeX">
					                        						<th style="text-align:center;">
					                        							<input type="checkbox" id="student" style="width:16px; height:16px;"/>
					                        						</th>
					                        						<th style="text-align:center; font-weight:bold; font-size:17px;">학번</th>
					                        						<th style="text-align:center; font-weight:bold; font-size:17px;">이름</th>
					                        						<th style="text-align:center; font-weight:bold; font-size:17px;">학년</th>
					                        					</tr>
					                        					<c:forEach items="${studentList}" var="list" varStatus="i">
						                        					<tr class="odd gradeX" id="studentTr">
						                        						<td style="text-align:center;">
						                        							<input type="checkbox" id="student${i.index}" name="student" value="${list.studentId}" style="width:16px; height:16px;"/>
						                        						</td>
						                        						<td style="text-align:center; font-weight:bold;">${list.studentId}</td>
						                        						<td style="text-align:center; font-weight:bold;">${list.studentName}</td>
						                        						<td style="text-align:center; font-weight:bold;">${list.grade}</td>
						                        					</tr>
						                        				</c:forEach>
					                        			</table>
						                        	</td>
					                        	</tr>
				                            </tbody>
	                                    </table>
	                                </div>
	                                <div class="modal-footer">
	                                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	                                    <input type="button" class="btn btn-primary" id="addButton" value="저장"/>
	                                </div>
	                            </div>
	                            <!-- /.modal-content -->
	                        </div>
                        </form>
                        <!-- /.modal-dialog -->
                    </div>
                </div>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
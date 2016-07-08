<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

$(document).ready(function() {
	
	
	var list = $("#studentManagementDiv > table > tbody > tr");
	
	if(list.size() >= 1) {
		var gate = function(i) {
			list[i].onclick = function() {
				var studentObject = {
						"studentId" : $("#studentId" + i).val()
				}
				
				$.ajax({
					url: "${pageContext.request.contextPath}/studentManagement/getStudentManagement"
					, method: "GET"
					, data: studentObject
					, async: false
					, success: function(data) {
						$("#studentManagementForm").attr("action", "${pageContext.request.contextPath}/studentManagement/updateStudentManagement");
						$("#studentName").val(data.studentName);
						$("#studentId").val(data.studentId).attr("readonly", true);
						$("#deleteStudentManagementBtn").show();
						$(".error").text('');
						var collegeTr = $("#addStudentManagementTable > tbody > tr").eq(0);
						collegeTr.remove();
						
						
						$("#addStudentManagementTable > tbody").prepend(
							'<tr class="odd gradeX">'
		                		+ '<th style="width:40%; text-align:center; vertical-align:middle">학교이름</th>'
				             	+ '<td>'
				             		+ '<select id="collegeId${i.index}" class="form-control">'
										+ '<c:forEach var="college" items="${collegeList}" varStatus="i">'
					             			+ '<option value="${college.collegeId}">${college.collegeName}</option>'
										+ '</c:forEach>'
				             		+ '</select>'
			             		+ '</td>'
			               	+ '</tr>'
						);
						
					}
				});
			}
		}
		for(var i = 0, length = list.size(); i < length; i++) {
			gate(i);
		}
	}
	
	
	$("#addButton").click(function() {
		$("#studentName").val('').attr("readonly", false);
		$("#studentId").val('').attr("readonly", false);
		$("#deleteStudentManagementBtn").hide();
		var collegeTr = $("#addStudentManagementTable > tbody > tr").eq(0);
		collegeTr.remove();
		
		$("#addStudentManagementTable > tbody").prepend(
				'<tr class="odd gradeX">'
            		+ '<th style="width:40%; text-align:center; vertical-align:middle">학교이름</th>'
	             	+ '<td>'
	             		+ '<select id="collegeId" name="collegeId" class="form-control">'
	             			+ '<option value="${college.collegeId}">${college.collegeName}</option>'
	             		+ '</select>'
             		+ '</td>'
               	+ '</tr>'
		);
		$("#studentManagementForm").attr("action", "${pageContext.request.contextPath}/studentManagement/addStudent");
		$(".error").text('');
	});
	
	$("#deleteStudentManagementBtn").click(function() {
		if(window.confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				url : "${pageContext.request.contextPath}/studentManagement/deleteStudentManagement"
				, method : "POST"
				, data : {
					"studentId" : $("#studentId").val()
				}
				, success: function(data) {
					if(data) {
						alert("정상 삭제 되었습니다.");
						location.reload();
					}
					else {
						alert("삭제가 되지 않았습니다.")
					}
				}
			});
		}
	});
	
	$("#studentManagementForm").validate({
		rules : {
			collegeId : {
				required : true
				, remote : {
					method: "GET"
					, url : "${pageContext.request.contextPath}/studentManagement/checkStudentPkOverlap"
					, data : {
						studentId : function() {
							return $("#studentId").val() != '' || null ? $("#studentId").val() : 0;
						},
						collegeId : function() {
							return $("#collegeId").val() != '' || null ? $("#collegeId").val() : 0;
						}
					}
				}
			}
			, studentId : {
				required : true
				, remote : {
					method: "GET"
					, url : "${pageContext.request.contextPath}/studentManagement/checkStudentPkOverlap"
					, data : {
						studentId : function() {
							return $("#studentId").val() != '' || null ? $("#studentId").val() : 0;
						},
						collegeId : function() {
							return $("#collegeId").val() != '' || null ? $("#collegeId").val() : 0;
						}
					}
				}
			}
			
		},
		messages: {
			studentId : {
				required: "학번을 입력하세요."
				, remote: "존재하는 학번입니다."
			}
			, collegeId : {
				remote: "존재하는 학번입니다."
			}
			
			
		},
		submitHandler: function() {
			if(confirm("이대로 저장하시겠습니까?")) {
				return true;
			}
			else {
				return false;
			}
		}
		
	});
	
	
	
	$('#studentManagementTable').DataTable({
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
            <div class="panel-body" style="padding-left:20%; padding-right:20%;">
                <div class="dataTable_wrapper" id="studentManagementDiv">
                    <table class="table table-striped table-bordered table-hover" id="studentManagementTable">
                        <thead>
                            <tr>
                                <th style="text-align:center; font-size:17px; font-weight:bold">학교이름</th>
                                <th style="text-align:center; font-size:17px; font-weight:bold">학번</th>
                                <th style="text-align:center; font-size:17px; font-weight:bold">학생이름</th>
                            </tr>
                        </thead>
                        <tbody>
	                        <c:choose>
	                        	<c:when test="${fn:length(studentManagementList) == 0}">
		                            <tr class="odd gradeX" >
		                                <td colspan="6" style="height:200px; text-align:center; vertical-align:middle;">데이터가 없습니다.</td>
		                                
		                            </tr>
		                        </c:when>
		                        <c:otherwise>
		                        	<c:forEach items="${studentManagementList}" var="list" varStatus="i">
				                        <tr class="odd gradeX" id="studentManagementListContent${i.index}" style="text-align:center;" 
				                        	data-toggle="modal" data-target="#addStudentManagementModal">
				                        	
				                        	<td><b>${college.collegeName}</b><input type="hidden" id="collegeId${i.index}" value="${college.collegeId}"/></b></td>
				                        	<td><b>${list.studentId}<input type="hidden" id="studentId${i.index}" value="${list.studentId}"/></b></td>
				                        	<td><b>${list.studentName}</b></td>
				                        </tr>
			                        </c:forEach>
		                        </c:otherwise>
		                    </c:choose>
                        </tbody>
                    </table>
                    <div style="text-align: right; position:relative;">
                    	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#addStudentManagementModal" id="addButton">등록</button>
                    </div>
                
                </div>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>


<div class="modal fade" id="addStudentManagementModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <form id="studentManagementForm" action="${pageContext.request.contextPath}/studentManagement/addStudent" method="POST">
    	<%-- <input type="hidden" name="collegeId" value="${college.collegeId}"/> --%>
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabel">관리정보입력</h4>
	            </div>
	            <div class="modal-body">
                	<table class="table table-striped table-bordered table-hover" id="addStudentManagementTable">
			        	<tbody>
			                <tr class="odd gradeX">
			                	<th style="width:40%; text-align:center; vertical-align:middle">학교이름</th>
				             	<td>
				             		<select id="collegeId" name="collegeId" class="form-control">
				             			<option value="${college.collegeId}">${college.collegeName}</option>
				             		</select>
				             	</td>
			                </tr>
			                <tr class="odd gradeX">
			                	<th style="width:40%; text-align:center; vertical-align:middle">학번</th>
				             	<td>
				             		<input type="text" id="studentId" name="studentId" class="form-control" placeholder="학번을 입력하세요." style="text-align:center;"/>
				             	</td>
			                </tr>
			                <tr class="odd gradeX">
			                	<th style="width:40%; text-align:center; vertical-align:middle">학생이름</th>
				             	<td>
				             		<input type="text" id="studentName" name="studentName" class="form-control" placeholder="학생 이름을 입력하세요." style="text-align:center;"/>
				             	</td>
			                </tr>
				        </tbody>
	                </table>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-danger" id="deleteStudentManagementBtn">삭제</button>
	                <input type="submit" class="btn btn-primary" id="addStudentManagementBtn" value="저장"/>
	            </div>
	        </div>
	        <!-- /.modal-content -->
	    </div>
    </form>
    <!-- /.modal-dialog -->
</div>
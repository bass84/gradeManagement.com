<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

$(document).ready(function() {
	var list = $("#collegeManagementDiv > table > tbody > tr");
	
	var gate = function(i) {
		list[i].onclick = function() {
			//console.log($(list[i]).children().eq(3).html());
			var collegeObject = {
					"collegeName" : $("#collegeName" + i).val()
			}
			
			$.ajax({
				url: "${pageContext.request.contextPath}/collegeManagement/getCollegeManagement"
				, method: "GET"
				, data: collegeObject
				, success: function(data) {
					$("#collegeManagementForm").attr("action", "${pageContext.request.contextPath}/collegeManagement/updateCollegeManagement");
					$("#collegeName").val(data.collegeName).attr("disabled", true);
					$("#deleteCollegeManagementBtn").show();
				}
			});
		}
	}
	for(var i = 0, length = list.size(); i < length; i++) {
		gate(i);
	}
	
	$("#addButton").click(function() {
		$("#collegeName").val('').attr("disabled", false);
		$("#deleteCollegeManagementBtn").hide();
		$(".error").text('');
	});
	
	$("#deleteCollegeManagementBtn").click(function() {
		if(window.confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				url : "${pageContext.request.contextPath}/collegeManagement/deleteCollegeManagement"
				, method : "POST"
				, data : {
					"collegeId" : $("#collegeId").val()
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
	
	$("#year").datepicker({
        format: 'yyyy',
        language: "kr",
 	});
	
	$("#collegeManagementForm").validate({
		rules : {
			collegeName : {
				required : true
				, remote : {
					method: "GET"
					, url : "${pageContext.request.contextPath}/collegeManagement/checkCollegePkOverlap"
					, data : {
						collegeName : function() {
							return $("#collegeName").val() != '' || null ? $("#collegeName").val() : '';
						}
					}
				}
			}
			
			
		},
		messages: {
			collegeName : {
				required: "학교이름을 입력하세요."
				, remote: "존재하는 학교이름입니다."
			},
			
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
	
	
	
	$('#collegeManagementTable').DataTable({
           responsive: true
   	});
	$(".col-sm-6").eq(1).css("text-align", "right");
	$(".col-sm-6").eq(3).css("text-align", "left");
	$(".col-sm-6").eq(2).css("width", "32%");
	

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
                <div class="dataTable_wrapper" id="collegeManagementDiv">
                    <table class="table table-striped table-bordered table-hover" id="collegeManagementTable">
                        <thead>
                            <tr>
                                <th style="text-align:center; font-size:17px; font-weight:bold">학교ID</th>
                                <th style="text-align:center; font-size:17px; font-weight:bold">학교이름</th>
                            </tr>
                        </thead>
                        <tbody>
	                        <c:choose>
	                        	<c:when test="${fn:length(collegeManagementList) == 0}">
		                            <tr class="odd gradeX" >
		                                <td colspan="6" style="height:200px; text-align:center; vertical-align:middle;">데이터가 없습니다.</td>
		                                
		                            </tr>
		                        </c:when>
		                        <c:otherwise>
		                        	<c:forEach items="${collegeManagementList}" var="list" varStatus="i">
				                        <tr class="odd gradeX" id="collegeManagementListContent${i.index}" style="text-align:center;" 
				                        	data-toggle="modal" data-target="#addCollegeManagementModal">
				                        	
				                        	<td><b>${list.collegeId}<input type="hidden" id="collegeId${i.index}" value="${list.collegeId}"/></b></td>
				                        	<td><b>${list.collegeName}</b></td>
				                        </tr>
			                        </c:forEach>
		                        </c:otherwise>
		                    </c:choose>
                        </tbody>
                    </table>
                    <div style="text-align: right; position:relative; top:-87px;">
                    	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#addCollegeManagementModal" id="addButton">등록</button>
                    </div>
                
                </div>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>


<div class="modal fade" id="addCollegeManagementModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <form id="collegeManagementForm" action="${pageContext.request.contextPath}/collegeManagement/addCollegeManagement" method="POST">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabel">관리정보입력</h4>
	            </div>
	            <div class="modal-body">
	                 <table class="table table-striped table-bordered table-hover" id="addCollegeManagementTable">
				         <tbody>
				                <tr class="odd gradeX">
				                	<th style="width:40%; text-align:center; vertical-align:middle">학교이름</th>
				             	<td>
				             		<input type="text" id="collegeName" name="collegeName" class="form-control" placeholder="학교 이름을 입력하세요." style="text-align:center;"/>
				             	</td>
				                </tr>
				         </tbody>
	                 </table>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-danger" id="deleteCollegeManagementBtn">삭제</button>
	                <input type="submit" class="btn btn-primary" id="addCollegeManagementBtn" value="저장"/>
	            </div>
	        </div>
	        <!-- /.modal-content -->
	    </div>
    </form>
    <!-- /.modal-dialog -->
</div>
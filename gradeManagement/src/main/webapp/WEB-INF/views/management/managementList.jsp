<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(document).ready(function() {
		
		var list = $("#subjectTbody > tr");
		
		for(var i = 0; i < list.length; i++) {
			list[i].onclick = function() {
				var collegeId = $("#collegeId" + i).val();
				var semester = $("#semester" + i).val();
				var subjectName = $("#subjectName" + i).val();
				location.href = "${pageContext.request.contextPath}/management/getManagementView?collegeId=" + collegeId
						+ "&semester=" + semester + "&subjectName=" + subjectName;
				
			}
		}
		
		$("#year").datepicker({
	        changeYear: true,
	        showButtonPanel: true,
	        dateFormat: 'yy',
	        onClose: function(dateText, inst) { 
	            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	            $(this).datepicker('setDate', new Date(year));
	        }

		});
		
		$(document)
			.on("change", "#subjectInformation", function() {
				var subjectValue = $("#subjectInformation").val().split("#");
				
				/* 모든 값들 초기화  */
				$("input[name='collegeId']").val("");
				$("input[name='semester']").val("");
				$("input[name='subjectName']").val("");
				
				$("#collegeName").val("");
				$("#classYear").val("");
				$("#classSemester").val("");
				$("#className").val("");
				
				/* 방금 선택한 값 입력  */
				if($("#subjectInformation").val() != "") {
					
					$("input[name='collegeId']").val(subjectValue[0]);
					$("#collegeName").val(subjectValue[1]);
					
					$("input[name='semester']").val(subjectValue[2]);
					$("#classYear").val(subjectValue[2].substr(0, 4));
					$("#classSemester").val(subjectValue[2].substr(4, 1));
					
					$("input[name='subjectName']").val(subjectValue[3]);
					$("#className").val(subjectValue[3]);	
				}
				
			});
		
		$(document)
			.on("click", "#registButton", function() {
				$("select[id='subjectInformation']").val("").attr("selected", "selected");
		});
		
		/* $("#subjectTbody")
			.on("click", "td", function() {
				location.href="${pageContext.request.contextPath}/management/getManagementView?collegeId=" + ${collegeId} + "&semester=" + ${semester} + "&SubjectName=" + ${subjectName}
			}); */
		
		
			$("#managementAddForm").validate({
				rules : {
					subjectInformation : {
						required : true
					},
					
				}
				, messages: {
					subjectInformation : {
						required: "과목정보를 선택하여주세요."
					},
					
				}
				, submitHandler: function() {
					if(confirm("이대로 저장하시겠습니까?")) {
						return true
					}
					else {
						return false;
					}
				}
			});
	
		$('#subjectTable').DataTable({
	           responsive: true
	   	});
	 	$(".col-sm-6").eq(1).css("text-align", "right");
		$(".col-sm-6").eq(3).css("text-align", "left");
		$(".col-sm-6").eq(2).css("width", "39%");
	
	});
</script>
<style>
.ui-datepicker-calendar {
    display: none;
    }
</style>

<div class="row">
             <div class="col-lg-12">
                 <div class="panel panel-default">
                     <div class="panel-heading">
                         DataTables Advanced Tables
                     </div>
                     <!-- /.panel-heading -->
            <div class="panel-body">
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="subjectTable">
                        <thead>
                            <tr>
                                <th style="text-align:center; font-size:17px; font-weight:bold">학교이름</th>
                                <th style="text-align:center; font-size:17px; font-weight:bold">연도구분</th>
                                <th style="text-align:center; font-size:17px; font-weight:bold">학기구분</th>
                                <th style="text-align:center; font-size:17px; font-weight:bold">과목이름</th>
                            </tr>
                        </thead>
                        <tbody id="subjectTbody">
                        	<c:forEach items="${subjectListUseY}" var="list" varStatus="i">
	                            <tr class="odd gradeX" id="">
	                            	<input type="hidden" id="collegeId${i.count}" value="${list.collegeId}"/>
	                            	<input type="hidden" id="semester${i.count}" value="${list.year}${list.semester}"/>
	                            	<input type="hidden" id="subjectName${i.count}" value="${list.subjectName}"/>
	                                <td style="text-align:center">${list.collegeName}</td>
	                                <td style="text-align:center">${list.year}</td>
	                                <td style="text-align:center">${list.semester}</td>
	                                <td style="text-align:center">${list.subjectName}</td>
	                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div style="text-align: right;">
                    	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" id="registButton">
                                등록
                        </button>
                    </div>
                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <form id="managementAddForm" action="${pageContext.request.contextPath}/management/addManagement" method="POST">
	                        <input type="hidden" name="collegeId"/>
	                        <input type="hidden" name="semester" />
	                        <input type="hidden" name="subjectName" />
	                        <div class="modal-dialog"  style="width:720px;">
	                            <div class="modal-content">
	                                <div class="modal-header">
	                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                                    <h4 class="modal-title" id="myModalLabel">관리정보입력</h4>
	                                </div>
	                                <div class="modal-body">
	                                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
					                        <tbody>
					                        	<tr class="odd gradeX">
					                        		<th style="width:40%; text-align:center">학교이름</th>
					                        		<td>
						                        		<select id="subjectInformation" name="subjectInformation" class="form-control">
						                        			<option value="" style="text-align:center;">선택하세요</option>
						                        			<c:forEach items="${subjectListUseN}" var="list">
							                        			<option value="${list.collegeId}#${list.collegeName}#${list.year}${list.semester}#${list.subjectName}">
							                        				학교이름(${list.collegeName}), 연도(${list.year}), 학기(${list.semester}), 과목이름(${list.subjectName})
							                        			</option>
						                        			</c:forEach>
						                        		</select>
					                        		</td>
					                        	</tr>
				                                <tr class="odd gradeX">
				                                	<th style="width:40%; text-align:center">학교이름</th>
				                                	<td><input type="text" class="form-control" id="collegeName" style="text-align:center;" readonly/></td>
				                                </tr>
					                            <tr class="odd gradeX">
					                            	<th style="width:40%; text-align:center">연도구분</th>
					                            	<td><input type="text" class="form-control" id="classYear" style="text-align:center;" readonly/></td>
					                            </tr>
					                            <tr class="odd gradeX">
					                            	<th style="width:40%; text-align:center">학기구분</th>
					                            	<td><input type="text" class="form-control" id="classSemester" style="text-align:center;" readonly/></td>
					                            </tr>
					                            <tr class="odd gradeX">
					                            	<th style="width:40%; text-align:center">과목이름</th>
					                            	<td><input type="text" class="form-control" id="className" style="text-align:center;" readonly/></td>
					                            </tr>
					                        </tbody>
	                                    </table>
	                                </div>
	                                <div class="modal-footer">
	                                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	                                    <input type="submit" class="btn btn-primary" id="addButton" value="저장"/>
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



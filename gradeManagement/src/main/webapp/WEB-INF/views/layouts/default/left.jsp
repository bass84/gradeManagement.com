<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="sidebar-nav navbar-collapse">
	
	<ul class="nav" id="side-menu">
		<li>
            <a href="${pageContext.request.contextPath}/collegeManagement/getCollegeManagementList">
            	<i class="fa fa-edit fa-fw"></i> 
            	학교관리
           	</a>
        </li>
        <li>
	        <a href="#">
	        	<i class="fa fa-folder"></i>
	        		학생관리
	        	<span class="fa arrow"></span>
	        </a>
	        <ul class="nav nav-second-level">
	            <c:forEach var="collegeList" items="${collegeList}">
		            <li>
		                <a href="${pageContext.request.contextPath}/studentManagement/getStudentManagementList?collegeId=${collegeList.collegeId}&collegeName=${collegeList.collegeName}">
		                ${collegeList.collegeName}
		                </a>
		            </li>
	            </c:forEach>
	        </ul>
	    </li>
        <li>
            <a href="${pageContext.request.contextPath}/subjectManagement/getSubjectManagementList">
            	<i class="fa fa-folder"></i> 
            	수업관리
           	</a>
        </li>
		
		<%-- <li>
	        <a href="${pageContext.request.contextPath}/subjectManagement/getSubjectManagementList">
	        	<i class="fa fa-folder"></i>
	        		수업관리
	        	<span class="fa arrow"></span>
	        </a>
	        <ul class="nav nav-second-level">
	            <li>
	                <a href="${pageContext.request.contextPath}/subjectManagement/getSubjectManagementList">충청대</a>
	            </li>
	        </ul>
	    </li> --%>
	</ul>
</div>
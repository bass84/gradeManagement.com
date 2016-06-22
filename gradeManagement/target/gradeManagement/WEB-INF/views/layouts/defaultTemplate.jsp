<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
 	<tiles:insertAttribute name="header"/>
 </head>
 <body>
	<!-- jQuery -->
    <script src="/resources/bootstrap/bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/bootstrap/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/bootstrap/bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/bootstrap/bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
    <script src="/resources/bootstrap/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/bootstrap/dist/js/sb-admin-2.js"></script>
    
	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> -->
	
	<!-- <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> -->
	<script src="/resources/bootstrap/datepicker/bootstrap-datepicker.js"></script>
	
	<script src="/resources/bootstrap/datepicker/bootstrap-datepicker.kr.js"></script>
	
  	
  	<script type="text/javascript" src="/resources/jqueryValidation/dist/jquery.validate.min.js"></script>
	
	<script type="text/javascript" src="/resources/jqueryValidation/dist/additional-methods.min.js"></script>
	
	<script type="text/javascript" src="/resources/jqueryValidation/dist/localization/messages_ko.min.js"></script>
	
	<div id="wrapper">
		
		<div id="left">
	  		<tiles:insertAttribute name="left" />
	  	</div>
	  	<div id="content">
	  		<tiles:insertAttribute name="content" />
	  	</div>
	  
	</div>
	
	
	
	
	
 </body>
</html>
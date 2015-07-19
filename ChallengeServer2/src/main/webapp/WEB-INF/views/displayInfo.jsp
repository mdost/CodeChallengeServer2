<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Info</title>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	
<script>
function submitForm() {
    var name = jQuery("#id").val();

    $.ajax({
    	type: "GET",
        url : "dogs/"+name,
        dataType: "json",
        contentType: "applicaton/json",
        success : function(response) {
        	alert("hello");
            document.open();
            document.write(response);
            document.close();
        },
        error: function(){
        	alert("not working");
        }
    }); 
   
}
</script>

 <style>
 #id{
    border-left: 0;
    outline: none;
    box-shadow: none;
}

.form-control:focus {
	outline: none;
	border-color: lightgrey !important;
	-webkit-box-shadow: none!important;
	-moz-box-shadow: none!important;
	box-shadow: none!important;
}
 </style>
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" id="nav">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">
<!-- 				<img src="DVI_Logo_footer.png" class="img-rounded" width="70px" height="25px">
 -->				</a>
			</div>
			<div>
				<ul class="nav navbar-nav">
				<li><a href="/">Home</a></li>
				<li><a href="createDog.html">Register Dog</a></li>
				<li class="active"><a href="dogs">List of Dogs</a></li>
				<li><a href="map.html">Maps</a></li>
				<li><a href="algorithm.html">Algorithm</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="container" style="margin-top: 100px;">
		<c:if test="${not empty error}">
			<div class="alert alert-danger" id="msgAlert">
				<a href="#" class="close" onclick="$('#msgAlert').hide()">&times;</a>
				<strong>Error: </strong>${error}
			</div>
		</c:if>
		<c:if test="${not empty deletedDog}">
			<div class="alert alert-success" id="deleted">
				<a href="#" class="close" onclick="$('#deleted').hide()">&times;</a>
				<strong>Success: </strong>${deletedDog}
			</div>
		</c:if>
		<c:if test="${not empty updatedDog}">
			<div class="alert alert-success" id="updated">
				<a href="#" class="close" onclick="$('#updated').hide()">&times;</a>
				<strong>Success: </strong>${updatedDog.name} has been updated!
			</div>
		</c:if>
		
		<form:form action="searchDog" method="get">	
			<div class="row">
				<div class="col-md-3">					
					<div class="input-group">
					<div class="input-group-addon" style="background-color: transparent; border-right:0 solid transparent;"><span class="glyphicon glyphicon-search"></span></div>
					
					<input type="text" class="form-control" placeholder="search by ID #" name="id" id="id"/>
					<div class="input-group-btn">
					<input type="submit" class="btn btn-info" value="Go" />
					</div>	
					</div>				
				</div>
					<br><br>
			</div>
		</form:form>	
		<c:choose>
		<c:when test="${not empty dogId}">
			<fieldset style="text-align: center;">
		<legend><strong>Search Results</strong></legend></fieldset>
		<table class="table table-striped">
			<thead>
				<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Heartbeat (b/min)</th>
				<th>Weight (lb)</th>
				<th>Temperature (C)</th>
				<th>Lat</th>
				<th>Long</th>
				<th>Edit/Delete</th>
				</tr>
			</thead>
			<tr>
				<td><c:out value="${dogId.getId()}"/></td>
				<td><c:out value="${dogId.getName()}"/></td>
				<td><c:out value="${dogId.getHeartbeat()}"/></td>
				<td><c:out value="${dogId.getWeight()}"/></td>
				<td><c:out value="${dogId.getTemperature()}"/></td>
				<td><c:out value="${dogId.getLat()}"/></td>
				<td><c:out value="${dogId.getLon()}"/></td>
				
				<td>
					<div class="row">
					<div class="col-md-3">
					<form:form action="edit" method="get">
					<input type="hidden" name="dogID" value="${dogId.id}"/>
					<input type="submit" class="btn-info" value="Edit" name="edit" id="edit"/>
					</form:form></div>
					
					<div class="col-md-3"><form:form action="delete" method="get">
					<input type="hidden" name="id" value="${dogId.id}"/>
					<input type="submit" class="btn-danger"  value="Delete" name="delete" id="delete"/>
					</form:form></div></div>
				</td>				
			</tr>
			</table>
		</c:when>
		<c:when test="${not empty listOfDogs}">
		<fieldset style="text-align: center;">
		<legend><strong>List of all dogs</strong></legend></fieldset>
		<table class="table table-striped">
			<thead>
				<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Heartbeat (b/min)</th>
				<th>Weight (lb)</th>
				<th>Temperature (C)</th>
				<th>Lat</th>
				<th>Long</th>
				<th>Edit/Delete</th>
				</tr>
			</thead>
			<c:forEach items="${listOfDogs}" var="listDog">
				<tr>
					<td><c:out value="${listDog.getId()}"/></td>
					<td><c:out value="${listDog.getName()}"/></td>
					<td><c:out value="${listDog.getHeartbeat()}"/></td>
					<td><c:out value="${listDog.getWeight()}"/></td>
					<td><c:out value="${listDog.getTemperature()}"/></td>
					<td><c:out value="${listDog.getLat()}"/></td>
					<td><c:out value="${listDog.getLon()}"/></td>
					
					
					<td>
					<div class="row">
					<div class="col-md-3">
					<form:form action="edit" method="get">
					<input type="hidden" name="dogID" value="${listDog.getId()}"/>
					<input type="submit" class="btn-info" value="Edit" name="edit" id="edit"/>
					</form:form></div>
					
					<div class="col-md-3"><form:form action="delete" method="get">
					<input type="hidden" name="id" value="${listDog.getId()}"/>
					<input type="submit" class="btn-danger"  value="Delete" name="delete" id="delete"/>
					</form:form></div></div>
					</td>
				</tr>
			</c:forEach>
			
		</table>
		</c:when>
		</c:choose>
		<footer style="padding-bottom: 20px; margin-top: 40px; height:100%; width:100%; positon:absolute; text-align:center;">
			<span class="glyphicon glyphicon-copyright-mark"></span> copyright Hippity Hop Inc. | <a href="#">Financials</a> | <a href="#">Legal Statement</a> | <a href="#">Developers</a> | <a href="#">Media</a>
		</footer>
	</div>

</body>
</html>
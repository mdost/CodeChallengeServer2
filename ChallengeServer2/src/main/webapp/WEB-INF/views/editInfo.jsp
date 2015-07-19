<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Edit Info</title>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
 <script>
 function checkform(){
	 var name = jQuery("#name").val();
	 var weight = jQuery("#weight").val();
	 var temperature = jQuery("#temperature").val();
	 var heartbeat = jQuery("#heartbeat").val();
	 var lat = jQuery("#lat").val();
	 var lon = jQuery("#lon").val();
	 
	 if(name == null || name == 0 || weight == 0 || heartbeat == 0 || temperature == 0 || lat == 0 || lon == 0){
		 document.getElementById("formError").innerHTML="<div class='alert alert-danger' id='formMessage'><a href='#' class='close' onclick='$('#msgAlert').hide()'>&times;</a><strong>Error: </strong>One or more fields is empty. Please enter value for all fields!</div>"
		 return false;
	 }
	 if(weight %1 !=0){
		 document.getElementById("formError").innerHTML="<div class='alert alert-danger' id='formMessage'><a href='#' class='close' onclick='$('#msgAlert').hide()'>&times;</a><strong>Error: </strong>Weight must be a int</div>"
		return false;
	 }else if(heartbeat %1 != 0){
		 document.getElementById("formError").innerHTML="<div class='alert alert-danger' id='formMessage'><a href='#' class='close' onclick='$('#msgAlert').hide()'>&times;</a><strong>Error: </strong>Heartbeat must be a int</div>"
		return false;
	 }else if(temperature %1 !=0){
		 document.getElementById("formError").innerHTML="<div class='alert alert-danger' id='formMessage'><a href='#' class='close' onclick='$('#msgAlert').hide()'>&times;</a><strong>Error: </strong>Tempearture must be a int</div>"
		return false;
	 }else if(lat %1 ==0){
		 document.getElementById("formError").innerHTML="<div class='alert alert-danger' id='formMessage'><a href='#' class='close' onclick='$('#msgAlert').hide()'>&times;</a><strong>Error: </strong>Latitude must be a double</div>"
		return false;
	 }else if(lon %1 ==0){
		 document.getElementById("formError").innerHTML="<div class='alert alert-danger' id='formMessage'><a href='#' class='close' onclick='$('#msgAlert').hide()'>&times;</a><strong>Error: </strong>Longitude must be a double</div>"
		return false;
	 }
	 
	 return true;
 }
 </script>
 
 <style>
.fieldset {
  border: 1px solid #ccc;
  padding: 30px;
}
 
 </style>
 
 
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" id="nav">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">
				</a>
			</div>
			<div>
				<ul class="nav navbar-nav">
				<li><a href="/">Home</a></li>
				<li><a href="createDog.html">Register Dog</a></li>
				<li><a href="dogs">List of Dogs</a></li>
				<li><a href="map">Maps</a></li>
				<li><a href="algorithm.html">Algorithm</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="container" style="margin-top: 100px;">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<c:if test="${not empty message}">
					<div class="alert alert-success" id="msgAlert">
						<a href="#" class="close" onclick="$('#msgAlert').hide()">&times;</a>
						<strong>Success: </strong>${message}
					</div>
				</c:if>
				<div id="formError"></div>
				<fieldset class="fieldset">
				<legend style="display: block; text-align: center;">Edit Info</legend>
				<p><em style="color: red;">*</em> Edit one or more fields</p>
				<div class="form-group row-fluid">
				<form:form action="dogEdited" method="get" onSubmit="return checkform()">
					<label for="usr">Name:</label>
					<input type="text" class="form-control" value="${updateDog.name}" name="name" id="name"><br>
					<label for="usr">Weight (lb):</label>
					<input type="text" class="form-control" value="${updateDog.weight}" name="weight" id="weight"><br>
					<label for="usr">Heartbeat (b/min):</label>
					<input type="text" class="form-control" value="${updateDog.heartbeat}" name="heartbeat" id="heartbeat"><br>
					<label for="usr">Temperature (C):</label>
					<input type="text" class="form-control" value="${updateDog.temperature}" name="temperature" id="temperature"><br>
					<label for="usr">Lat:</label>
					<input type="text" class="form-control" value="${updateDog.lat}" name="lat" id="lat"><br>
					<label for="usr">Long:</label>
					<input type="text" class="form-control" value="${updateDog.lon}" name="lon" id="lon"><br>
					<input type="hidden" class="form-control" name="id" value="${updateDog.id}"/>
					<div style="text-align: center; display: block;">
						<input type="submit" class="btn-success" value="Enter" />	
						<input type="button" class="btn-primary" onclick="location.href='dogs'" value="Cancel"/>					
					</div>
				</form:form>				
				</div>
				</fieldset>
			</div>
		
		</div>
	
	
		<footer style="padding-bottom: 20px; margin-top: 40px; height:100%; width:100%; positon:absolute; text-align:center;">
			<span class="glyphicon glyphicon-copyright-mark"></span> copyright Hippity Hop Inc. | <a href="#">Financials</a> | <a href="#">Legal Statement</a> | <a href="#">Developers</a> | <a href="#">Media</a>
		</footer>
	</div>

</body>
</html>
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
 	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>  
 	
 <style>
 #id{
 	padding-left: 30px;
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
				<li><a href="dogs">List of Dogs</a></li>
				<li><a href="map.html">Maps</a></li>
				<li class="active"><a href="algorithm.html">Algorithm</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="container" style="margin-top: 100px; height: 100%;">
		<div class="row">
			<c:if test="${not empty deletedDog}">
				<div class="alert alert-success" id="deleted">
				<a href="#" class="close" onclick="$('#deleted').hide()">&times;</a>
				<strong>Success: </strong>${deletedDog}
				</div>
			</c:if>
			<c:if test="${not empty error}">
			<div class="alert alert-danger" id="msgAlert">
				<a href="#" class="close" onclick="$('#msgAlert').hide()">&times;</a>
				<strong>Error: </strong>${error}
			</div>
			</c:if>
			<div style="display: block; text-align: center;">
			<h3>K-Means Clustering Algorithm</h3><br>
			<p>Please input the number of clusters you would like to have:</p>
			</div>
		
			<form:form action="dogClusters" method="get">
 				<div class="col-md-2 col-md-offset-5 input-group">
 					<input type="text" class="form-control" placeholder="# of clusters" name="k" id="k" />
 					<span class="input-group-btn"><input type="submit" class="btn btn-info btn-block" value="Go" /></span>
 				</div>					
			</form:form>
		
		</div>
		<br><br>
		
		<c:if test="${not empty clusteredPts}">
			<fieldset style="text-align: center;">
		<legend><strong>Clustered Dogs</strong></legend></fieldset>
		<table class="table table-striped">
			<thead>
				<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Temperature</th>
				<th>Heartbeat</th>
				<th>Lat</th>
				<th>Long</th>
				<th>Weight</th>
				<th>Cluster</th>
				</tr>
			</thead>
			<c:set var="count" value="1" scope="page" />
			<c:forEach var="row" items="${clusteredPts}">
				<c:forEach var="column" items="${row}">
					<c:if test="${column != null}">
					<tr>
					<td>${column.id}</td>
					<td>${column.name}</td>
					<td>${column.temperature}</td>
					<td>${column.heartbeat}</td>
					<td>${column.lat}</td>
					<td>${column.lon}</td>
					<td>${column.weight}</td>
					<td>${count}</td>
					</tr>
					</c:if>
				</c:forEach>
				<c:set var="count" value="${count + 1}" scope="page"/>
			</c:forEach>
		</table>
		</c:if>
			
	</div>
	
	<div class="container">
		<footer style="padding-bottom: 20px; margin-top: 40px; height:100%; width:100%; positon:absolute; text-align:center;">
			<span class="glyphicon glyphicon-copyright-mark"></span> copyright Hippity Hop Inc. | <a href="#">Financials</a> | <a href="#">Legal Statement</a> | <a href="#">Developers</a> | <a href="#">Media</a>
		</footer>
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Maps</title>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
 	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>  
	<%response.setIntHeader("Refresh", 60); %>
<script>
	/* $.ajax({
		type: "GET",
		url: "dogs",
		contentType: "applicaton/json",
		success: function(){
			System.out.println("success")
		},
		error: function(response){
			System.out.println()
		}
		
	}); */
	
	function loadMap() {
		
		<c:choose>
			<c:when test="${not empty filterDogLocation}">
				var getDog = new Object();
				
				getDog.name = '${filterDogLocation.name}';
				getDog.id = '${filterDogLocation.id}';
				getDog.lat = '${filterDogLocation.lat}';
				getDog.lon = '${filterDogLocation.lon}';
				getDog.weight = '${filterDogLocation.weight}';
				getDog.temperature = '${filterDogLocation.temperature}';
			    getDog.heartbeat = '${filterDogLocation.heartbeat}';
				
			    var latLong = new google.maps.LatLng(getDog.lat, getDog.lon);
			    
				var info = new google.maps.InfoWindow();

				var options = {
						 zoom: 18,
						 center: latLong,
						 mapTypeId: google.maps.MapTypeId.HYBRID
					};
					
				var mapLocal = new google.maps.Map(document.getElementById("map_container"),options);
			
				var markerpt = new google.maps.Marker({
		      		position: latLong, 
		      		map: mapLocal, 
		      		title: getDog.name,
		    	}); 
				
				var content="Name: "+getDog.name+"\nHeartbeat: "+getDog.heartbeat+"\nTemperature: "+getDog.temperature+"\nWeight: "+getDog.weight;
		    	
		    	 google.maps.event.addListener(markerpt, 'click', function() {
		    		 info.close();
		    		 info.setContent(content);
		    		 info.open(mapLocal,markerpt);
		    	  }); 
			    
			</c:when>
			<c:otherwise>
		var dogs = new Array();

		<c:forEach items="${listOfDogs}" var="item">
		    var dog = new Object();
	
		    dog.name = '${item.name}';
		    dog.id = '${item.id}';
		    dog.lat = '${item.lat}';
		    dog.lon = '${item.lon}';
		    dog.weight = '${item.weight}';
		    dog.temperature = '${item.temperature}';
		    dog.heartbeat = '${item.heartbeat}';
		    
		    dogs.push(dog);
		</c:forEach>
		
		var infowindow = new google.maps.InfoWindow();
		
		var myOptions = {
			 zoom: 18,
			 mapTypeId: google.maps.MapTypeId.HYBRID
		};
		var map = new google.maps.Map(document.getElementById("map_container"),myOptions);
		
		dogs.forEach(function(arrayItem){
	    	var latlng = new google.maps.LatLng(arrayItem.lat, arrayItem.lon);
	    
	    	var marker = new google.maps.Marker({
	      		position: latlng, 
	      		map: map, 
	      		title: arrayItem.name,
	      		animation: google.maps.Animation.BOUNCE
	    	}); 
	    	map.setCenter(marker.getPosition());
	    	
	    	var contentString="Name: "+arrayItem.name+"\nHeartbeat: "+arrayItem.heartbeat+"\nTemperature: "+arrayItem.temperature+"\nWeight: "+arrayItem.weight;
	    	
	    	 google.maps.event.addListener(marker, 'click', function() {
	    		infowindow.close();
	    		infowindow.setContent(contentString);
	    	    infowindow.open(map,marker);
	    	  }); 
	    	
		});
		</c:otherwise>
		</c:choose>
		
	 }

	
</script>

<style>
#map_container{	
	width: 1150px;
	height: 500px;
}

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
<body onload="loadMap()">
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
				<li class="active"><a href="map.html">Maps</a></li>
				<li><a href="algorithm.html">Algorithm</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="container" style="margin-top: 100px;">
		<c:if test="${not empty error}">
		<div class="row">
			<div class="col-md-5 col-md-offset-3">
				<div class="alert alert-danger" id="msgAlert">
				<a href="#" class="close" onclick="$('#msgAlert').hide()">&times;</a>
				<strong>Error: </strong>${error}
				</div>
			</div>
		</div>
		</c:if>
		<div class="row">
			<div class="col-md-3" style="margin-top: 23px;">
				<form:form action="MapById" method="post">	
					<div class="input-group">
					<div class="input-group-addon" style="background-color: transparent; border-right:0 solid transparent;"><span class="glyphicon glyphicon-search"></span></div>
					
					<input type="text" class="form-control" placeholder="search by ID #" name="id" id="id" />
					<div class="input-group-btn">
					<input type="submit" class="btn btn-info" value="Go" />
					</div>	
					</div>				
				</form:form>			
			</div>
			
			<div class="col-md-8">
				<h3 style="display: block; text-align: center;">Maps</h3>
			</div>
			
		</div>
		<hr></hr>
		<div class="row">
<!-- 			<div class="col-md-4"><p>The map below shows where the location of all dogs</p></div>
 -->			<div class="col-md-12">
				<p>The map below shows the location of all dogs registered into the system. If you would like to display a map for a specific dog, please enter the dogs ID #. </p>
				<div id="map_container"></div>
			</div>
		</div>
		
		<footer style="padding-bottom: 20px; margin-top: 40px; height:100%; width:100%; positon:absolute; text-align:center;">
			<span class="glyphicon glyphicon-copyright-mark"></span> copyright Hippity Hop Inc. | <a href="#">Financials</a> | <a href="#">Legal Statement</a> | <a href="#">Developers</a> | <a href="#">Media</a>
		</footer>
	</div>

</body>
</html>
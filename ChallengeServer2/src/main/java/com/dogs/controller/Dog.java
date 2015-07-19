package com.dogs.controller;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/** @author mariamdost
 * Class for dogs that stores all information about dogs
 */

@JsonIgnoreProperties(ignoreUnknown = true)
public class Dog{
	/**
	 * 
	 */
	private Long id;

	private String name;
	private int weight;
	private int heartbeat;
	private int temperature;
	private double lat;
	private double lon;
	
	public void setId(Long id){
		this.id=id;
	}
	
	public void setName(String name){
		this.name=name;
	}
	
	public void setWeight(int weight){
		this.weight = weight;
	}
	
	public void setHeartbeat(int heartbeat){
		this.heartbeat = heartbeat;
	}
	
	public void setTemperature(int temp){
		this.temperature = temp;
	}
	
	public void setLat(double lat){
		this.lat = lat;
	}
	
	public void setLon(double lon){
		this.lon = lon;
	}
	
	public Long getId(){
		return this.id;
	}
	
	public String getName(){
		return this.name;
	}
	
	public int getWeight(){
		return this.weight;
	}
	
	public int getHeartbeat(){
		return this.heartbeat;
	}
	
	public int getTemperature(){
		return this.temperature;
	}
	
	public double getLat(){
		return this.lat;
	}
	
	public double getLon(){
		return this.lon;
	}
	
}

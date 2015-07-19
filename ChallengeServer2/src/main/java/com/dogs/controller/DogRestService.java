package com.dogs.controller;

import java.io.IOException;
import java.util.List;

//import org.codehaus.jackson.JsonNode;
//import org.codehaus.jackson.JsonProcessingException;
//import org.codehaus.jackson.map.ObjectMapper;
//import org.codehaus.jackson.map.annotate.JsonSerialize.Inclusion;
//import org.codehaus.jackson.map.type.TypeFactory;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.annotation.JsonSerialize.Inclusion;
import com.fasterxml.jackson.databind.type.TypeFactory;

/*
 * 
 */
public class DogRestService {
	
	/*
	 * Call server #1 (webservice) to create a dog
	 * return the new dog that is added to the database (JPA repository)
	 */
	public Dog createDog(Dog newDog){
		RestTemplate rest = new RestTemplate();
		rest.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		rest.getMessageConverters().add(new StringHttpMessageConverter());

		ObjectMapper mapper = new ObjectMapper();
		
		String response = rest.postForObject("https://rest-serverhh.herokuapp.com/createDog", newDog, String.class);
		
		mapper.setSerializationInclusion(Include.NON_NULL);
		Dog dog = null;
		
		try {
			JsonNode node = mapper.readTree(response);
			dog = mapper.treeToValue(node, Dog.class);			
			
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dog;
	}
	
	/*
	 * Call server #1 to get all dogs available in the system. If database empty the list returned is null.
	 * returns a list of type Dog
	 */
	public List<Dog> getAllDogs(){
		RestTemplate rest = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		
		String response = null;
		response = rest.getForObject("https://rest-serverhh.herokuapp.com/dogs", String.class);
		
		mapper.setSerializationInclusion(Include.NON_NULL);
		List<Dog> dogs = null;
		
		try {
			if(response != null)
				dogs = mapper.readValue(response,TypeFactory.defaultInstance().constructCollectionType(List.class,  Dog.class));

//			for(Dog i : dogs){
//				System.out.println(i.getName());
//			}
			
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dogs;
	}
	
	/*
	 * Call server #1 where it passes the ID of the dog to search for. If no ID exists in the database, returns null.
	 * returns the search result
	 */
	public Dog searchDogById(Long value){
		RestTemplate rest = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		
		String response= null;
		response = rest.getForObject("https://rest-serverhh.herokuapp.com/dogs/"+value, String.class);
				
		mapper.setSerializationInclusion(Include.NON_NULL);
		Dog dog =null;
		
		try {
			
			if(response != null){
				System.out.println("This is the response");
				System.out.println(response);
				
				JsonNode node = mapper.readTree(response);
				dog = mapper.treeToValue(node, Dog.class);
				System.out.println(dog.getName());
			}

		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return dog;
	}
	
	/*
	 * Call server #1 with specific ID of dog that should be deleted. 
	 * returns the list of dogs that does not contain the deleted dog.
	 */
	public List<Dog> deleteDogById(Long value){
		RestTemplate rest = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		
		String response = rest.getForObject("https://rest-serverhh.herokuapp.com/delete/"+value, String.class);
				
		mapper.setSerializationInclusion(Include.NON_NULL);
		List<Dog> dog =null;
		
		try {
			dog = mapper.readValue(response,TypeFactory.defaultInstance().constructCollectionType(List.class,  Dog.class));
			
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return dog;
	}
	
	/*
	 * Calls server #1 to update dog with specific ID passed to it.
	 * returns a list of dogs.
	 */
	public List<Dog> updateDogById(Dog updatedDog){
		RestTemplate rest = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		
		rest.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
		rest.getMessageConverters().add(new StringHttpMessageConverter());
		String response = rest.postForObject("https://rest-serverhh.herokuapp.com/update", updatedDog, String.class);

		mapper.setSerializationInclusion(Include.NON_NULL);
		List<Dog> dog =null;
		
		try {
			dog = mapper.readValue(response,TypeFactory.defaultInstance().constructCollectionType(List.class,  Dog.class));
			
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return dog;
	}
	
	/*
	 * Calls server #1 to perform k-mean clustering on the dogs weight. In the GET request it passes the number cluster the user would like to have. 
	 * returns a 2D array containing the available data that has been clustered. 
	 */
	public Dog[][] kMeanClustering(int value){
		RestTemplate rest = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		
		String response = rest.getForObject("https://rest-serverhh.herokuapp.com/dogClusters?k="+value, String.class);
				
		mapper.setSerializationInclusion(Include.NON_NULL);
		List<List<Dog>> dog =null;
		Dog[][] getValue = null;
		
		try {
			dog = mapper.readValue(response, new TypeReference<List<List<Dog>>>(){});
			
			getValue = new Dog[dog.size()][];
			for (int i = 0; i < dog.size(); i++) {
			    List<Dog> row = dog.get(i);
			    getValue[i] = row.toArray(new Dog[row.size()]);
			}
			
//			for(int i=0; i< dog.size(); i++){
//				for(int j=0; j< getValue[i].length; j++){
//					if(getValue[i][j] != null){
//						System.out.println("Cluster: "+i);
//						System.out.println(getValue[i][j].getName());
//					}
//				}
//			}
						
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return getValue;
	}
}

package com.dogs.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;

/*
 * This controller calls the webservice (server #1) to get data or edit/delete data from the database (JPA repository) stored from the database.
 */

@Controller
public class DogController {
	
	private DogRestService restServ=new DogRestService();
	
	/*
	 * Call the webservice that will create an object of type Dogs and store it in the database (JPA Repository)
	 * return a response status of 200-created
	 */
	@RequestMapping(value = "dogCreated", method = RequestMethod.POST)
	@ResponseStatus(HttpStatus.CREATED)
	public String createDog(@ModelAttribute Dog dog, BindingResult result, Model model){
		Dog created_dog = restServ.createDog(dog);
		
		model.addAttribute("dog", created_dog);
		model.addAttribute("message", dog.getName()+" has been entered into the system!");
		
		return "createDog";
	}
	
	/*
	 * Get all dogs from the webservice and set it to a specific ID that will be called in the view
	 */
	@RequestMapping(value ="dogs", method=RequestMethod.GET)
	public String getAllDogs(ModelMap model){
		List<Dog> dogs = restServ.getAllDogs();
		
		if(dogs.size() != 0){
			model.addAttribute("listOfDogs", dogs);
		}else{
			model.addAttribute("error", "At this time there are no registered dogs. Please register a dog!");
		}
		
		return "displayInfo";
	}
	
	/*
	 * Send id to webservice that will find dog that matches the specific ID passed in the URL
	 * return the displayInfo view
	 */
	@RequestMapping(value ="searchDog", method = RequestMethod.GET)
	public String getDogId(@RequestParam("id") Long value, ModelMap model){
		Dog dog =restServ.searchDogById(value);
		
		if(dog != null){
			model.addAttribute("dogId", dog);
		}else{
			model.addAttribute("error", "invalid id, ID # does not exist in the system!");
			List<Dog> dogs = restServ.getAllDogs();
			model.addAttribute("listOfDogs", dogs);
		}

		return "displayInfo";
	}
	
	/*
	 * Get all dogs from the database (JPA repository), return the map view (render)
	 */
	@RequestMapping(value = "/map", method = RequestMethod.GET)
	public String displayMap(ModelMap model, HttpServletResponse response){
		List<Dog> dogs = restServ.getAllDogs();
		
		if(dogs.isEmpty() != true){
			model.addAttribute("listOfDogs", dogs);
		}else{
			model.addAttribute("error", "There are no dogs registered into system. Please register a dog!");
		}
		
		return "map";
	}
	
	/*
	 * Get dog by ID and render the view for map
	 */
	@RequestMapping(value ="MapById", method = RequestMethod.POST)
	public String getMapByDogID(@RequestParam("id") Long value, Model model){
		Dog dog =restServ.searchDogById(value);
		
		if(dog != null){
			model.addAttribute("filterDogLocation", dog);
		}else{
			model.addAttribute("error", "invalid id, ID # does not exist in the system!");
			List<Dog> dogs = restServ.getAllDogs();
			model.addAttribute("listOfDogs", dogs);
		}
		
		return "map";
	}
	
	/*
	 * Call webservice that will delete object (dog) with ID that matches the user input ID # from the database.
	 * return the displayInfo view (render)
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("id") Long value, ModelMap model, HttpServletResponse response){
		List<Dog> dogs = restServ.deleteDogById(value);
		
		if(dogs.isEmpty() != true){
			model.addAttribute("listOfDogs", dogs);
			model.addAttribute("deletedDog", "Dog has been deleted!");
		}else{
			model.addAttribute("error", "invalid id, ID # does not exist in the system!");
		}
	
		return "displayInfo";
	}
	
	/*
	 * Render the editInfo page, as well as call webservice that will find dog that matches user input ID and pass it to the editInfo view
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(@RequestParam("dogID") Long id, ModelMap model, HttpServletResponse response){
		Dog dog =restServ.searchDogById(id);
		model.addAttribute("updateDog", dog);
		
		return "editInfo";
	}
	
	/*
	 * Call webservice that will update the dog object that matches the ID # the user has provided
	 * return displayInfo view (render)
	 */
	@RequestMapping(value = "/dogEdited", method = RequestMethod.GET)
	public String editDog(@RequestParam("id") Long id, @ModelAttribute Dog updatedDog,ModelMap model, HttpServletResponse response){	
		Dog dog = new Dog();
		dog.setId(id);
		dog.setName(updatedDog.getName());
		dog.setHeartbeat(updatedDog.getHeartbeat());
		dog.setTemperature(updatedDog.getTemperature());
		dog.setWeight(updatedDog.getWeight());
		dog.setLat(updatedDog.getLat());
		dog.setLon(updatedDog.getLon());
		
		List<Dog> dogs = restServ.updateDogById(dog);
		
		if(dogs.isEmpty() != true){
			model.addAttribute("listOfDogs", dogs);
			model.addAttribute("updatedDog", updatedDog);
		}else{
			model.addAttribute("error", "invalid id, ID # does not exist in the system!");
		}
		
		return "displayInfo";
	}
	
	/*
	 * Call webservice that will perform the k-mean clustering algorithm for dogs weight on the dataset that is available in server #1.
	 * return the algorithm view (render)
	 */
	@RequestMapping(value = "dogClusters", method = RequestMethod.GET)
	public String kMeanClustering(@RequestParam("k") int clusters, ModelMap model, HttpServletResponse response){
		Dog[][] dog_clusters = restServ.kMeanClustering(clusters);
		model.addAttribute("clusteredPts", dog_clusters);
		
		return "algorithm";
	}
}

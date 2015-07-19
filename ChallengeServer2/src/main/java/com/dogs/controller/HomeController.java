package com.dogs.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
		
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	/**
	 * Renders the createDog page
	 */
	@RequestMapping(value = "/createDog", method = RequestMethod.GET)
	public String createDogMap(){
		return "createDog";
	}
	
	/**
	 * Renders the displayInfo page
	 */
	@RequestMapping(value = "/displayInfo", method = RequestMethod.GET)
	public String displayInfoMap(){
		return "displayInfo";
	}
	
	/**
	 * Renders the algorithm page
	 */
	@RequestMapping(value = "/algorithm", method = RequestMethod.GET)
	public String displayAlgorithmMap(){
		return "algorithm";
	}
	
}

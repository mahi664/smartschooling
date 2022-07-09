package com.example.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.service.UserLogInService;

@RestController(value="UserLogin")
public class LoginController {

	@Autowired
	private UserLogInService userLoginService;
	
//	@RequestMapping(path="/")
//	public String home(){
//		return "Home";
//	}
	
	@GetMapping(path="/UserLogin/wel-come")
	public String welcomeMessage(){
		return "Ebter Username and password";
	}
	
	@GetMapping(path="/UserLogin/wel-come/{username}/{password}")
	public String validateUserLogin(@PathVariable String username, @PathVariable String password){
		return userLoginService.validateUserLogin(username,password);
	}
}

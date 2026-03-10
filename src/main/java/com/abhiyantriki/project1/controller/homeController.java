package com.abhiyantriki.project1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class homeController {
	
	// Redirect root path to role maker
	@GetMapping({"", "/", "/index"})
	public String home() {
		return "redirect:/roles/maker";
	}
	
}

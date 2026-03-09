package com.abhiyantriki.project1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.abhiyantriki.project1.entity.employee;
import com.abhiyantriki.project1.service.employeeService;

@Controller
@RequestMapping("/employees")

public class employeeController {
	@Autowired
	employeeService empService;
	
	// add
	
	@PostMapping ("/add")
	public String addEmployee(employee emp) {
		
		empService.addEmployee(emp);
		
		return "redirect:/employees/list";
		
	}
	

	// show employee list
	@GetMapping("/list")
	public String showEmployeeList(Model model)
	{
		List<employee> employees = empService.getEmployees();
		model.addAttribute("employees", employees);
		return "list";
	}
	
	// show employee register form
	@GetMapping("/register")
	public String showEmployee()
	{
		return "employeeRegister";
	}
	//delete Employee
	
	@DeleteMapping("/delete/{id}")
	public String deletEmployee(@PathVariable String id) {
		boolean status = empService.deleteEmployee(id);
		
		if (status) {
			return "employee deleted succesfelly";
		}
		else {
			return "employee not found ";
		}
	}
	
	
	
	
	// open update form
	@GetMapping("/edit/{id}")
	public String editEmployee(@PathVariable String id, Model model)
	{
	    employee emp = empService.getEmployeeById(id);
	    model.addAttribute("employee", emp);
	    return "update";
	}

	// save updated employee
	@PostMapping("/update")
	public String updateEmployee(employee emp, RedirectAttributes redirectAttributes)
	{
		try {
			empService.updateEmployee(emp);
			redirectAttributes.addFlashAttribute("message", "Employee updated successfully.");
			return "redirect:/employees/list";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", e.getMessage());
			if (emp.getId() == null || emp.getId().isBlank()) {
				return "redirect:/employees/list";
			}
			return "redirect:/employees/edit/" + emp.getId();
		}
	}
	

}

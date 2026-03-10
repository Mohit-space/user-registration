package com.abhiyantriki.project1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.abhiyantriki.project1.dao.employeeRepo;
import com.abhiyantriki.project1.entity.employee;

@Service
public class employeeService {
	
	@Autowired
	employeeRepo employeeRepository;
	
	

	
	// Add Employee 
	public employee addEmployee(employee emp) {
		
	  return employeeRepository.addEmployee(emp);
		
	}
	
	// Delete Employee 
	 public boolean deleteEmployee(String id ) {
		 
		 return employeeRepository.deleteEmployee(id);
		 
	 }
	 //Show employee 
	 public List<employee> showEmployee(){
		 
		return employeeRepository.getEmployees();
		}
		
	 
	 
	 //Update Employee 
	 public employee updateEmployee(employee emp) {
		 return  employeeRepository.updateEmployee(emp);
	 }
	 public List<employee>getEmployees()
	 {
		 return employeeRepository.getEmployees();
	 }

	public employee getEmployeeById(String id) {
		return employeeRepository.getEmployeeById(id);
	}
	
	// Get Employees by Role
	public List<employee> getEmployeesByRole(String role) {
		return employeeRepository.getEmployeesByRole(role);
	}
	
	
}


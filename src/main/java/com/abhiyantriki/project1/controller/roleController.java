package com.abhiyantriki.project1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.abhiyantriki.project1.entity.employee;
import com.abhiyantriki.project1.entity.role;
import com.abhiyantriki.project1.service.employeeService;
import com.abhiyantriki.project1.service.roleService;

@Controller
@RequestMapping("/roles")
public class roleController {
	
	@Autowired
	employeeService empService;

	@Autowired
	roleService roleService;
	
	// Show role maker landing page
	@GetMapping("/maker")
	public String showRoleMaker(Model model) {
		model.addAttribute("roles", roleService.getRoleNames());
		return "rolemaker";
	}

	// Show role management page with all roles
	@GetMapping("/manage")
	public String manageRoles(Model model) {
		model.addAttribute("allRoles", roleService.getRoles());
		return "roleManagement";
	}

	@PostMapping("/add")
	public String addRole(@RequestParam String roleName, RedirectAttributes redirectAttributes) {
		try {
			roleService.addRole(roleName);
			redirectAttributes.addFlashAttribute("message", "Role added successfully.");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", e.getMessage());
		}
		return "redirect:/roles/manage";
	}

	// Show edit form for a role
	@GetMapping("/edit/{id}")
	public String editRole(@PathVariable String id, Model model, RedirectAttributes redirectAttributes) {
		try {
			role roleItem = roleService.getRoleById(id);
			if (roleItem == null) {
				redirectAttributes.addFlashAttribute("error", "Role not found.");
				return "redirect:/roles/manage";
			}
			model.addAttribute("role", roleItem);
			model.addAttribute("allRoles", roleService.getRoles());
			return "roleManagement";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", e.getMessage());
			return "redirect:/roles/manage";
		}
	}

	// Update role
	@PostMapping("/update")
	public String updateRole(@RequestParam String id, @RequestParam String roleName, RedirectAttributes redirectAttributes) {
		try {
			roleService.updateRole(id, roleName);
			redirectAttributes.addFlashAttribute("message", "Role updated successfully.");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", e.getMessage());
		}
		return "redirect:/roles/manage";
	}

	// Delete role
	@GetMapping("/delete/{id}")
	public String deleteRole(@PathVariable String id, RedirectAttributes redirectAttributes) {
		try {
			boolean deleted = roleService.deleteRole(id);
			if (deleted) {
				redirectAttributes.addFlashAttribute("message", "Role deleted successfully.");
			} else {
				redirectAttributes.addFlashAttribute("error", "Role not found.");
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Cannot delete role: " + e.getMessage());
		}
		return "redirect:/roles/manage";
	}
	
	// Get employees by selected role
	@PostMapping("/get-employees")
	public String getEmployeesByRole(@RequestParam(required = false) String role, Model model) {
		model.addAttribute("roles", roleService.getRoleNames());
		
		if (role != null && !role.isBlank()) {
			List<employee> employees = empService.getEmployeesByRole(role);
			model.addAttribute("selectedRole", role);
			model.addAttribute("employees", employees);
			model.addAttribute("employeeCount", employees.size());
		}
		
		return "rolemaker";
	}
	
}

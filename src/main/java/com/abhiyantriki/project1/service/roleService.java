package com.abhiyantriki.project1.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.abhiyantriki.project1.dao.roleRepo;
import com.abhiyantriki.project1.entity.role;

@Service
public class roleService {

    @Autowired
    roleRepo roleRepository;

    public List<role> getRoles() {
        return roleRepository.getRoles();
    }

    public List<String> getRoleNames() {
        return getRoles().stream().map(role::getName).collect(Collectors.toList());
    }

    public role addRole(String roleName) {
        return roleRepository.addRole(roleName);
    }

    public role getRoleById(String id) {
        return roleRepository.getRoleById(id);
    }

    public role updateRole(String id, String newName) {
        return roleRepository.updateRole(id, newName);
    }

    public boolean deleteRole(String id) {
        return roleRepository.deleteRole(id);
    }
}

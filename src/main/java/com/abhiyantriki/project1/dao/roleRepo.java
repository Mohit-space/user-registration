package com.abhiyantriki.project1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.abhiyantriki.project1.entity.role;

@Repository
public class roleRepo {

    private static final List<String> DEFAULT_ROLES = Arrays.asList(
        "Software Developer",
        "Project Manager",
        "QA Engineer",
        "UI Designer",
        "HR Manager",
        "Business Analyst"
    );

    connectionBean bean = new connectionBean();

    private void ensureRoleTable(Connection conn) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS roles ("
            + "id INT AUTO_INCREMENT PRIMARY KEY, "
            + "name VARCHAR(100) NOT NULL UNIQUE"
            + ")";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.executeUpdate();
        ps.close();
    }

    private void seedDefaultRolesIfEmpty(Connection conn) throws SQLException {
        String countSql = "SELECT COUNT(*) FROM roles";
        PreparedStatement countPs = conn.prepareStatement(countSql);
        ResultSet rs = countPs.executeQuery();

        int total = 0;
        if (rs.next()) {
            total = rs.getInt(1);
        }

        rs.close();
        countPs.close();

        if (total == 0) {
            String insertSql = "INSERT INTO roles (name) VALUES (?)";
            PreparedStatement insertPs = conn.prepareStatement(insertSql);
            for (String roleName : DEFAULT_ROLES) {
                insertPs.setString(1, roleName);
                insertPs.addBatch();
            }
            insertPs.executeBatch();
            insertPs.close();
        }
    }

    public List<role> getRoles() {
        List<role> roleList = new ArrayList<>();

        try {
            Connection conn = bean.getConnectionobj();
            ensureRoleTable(conn);
            seedDefaultRolesIfEmpty(conn);

            String sql = "SELECT id, name FROM roles ORDER BY name";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                role roleItem = new role();
                roleItem.setId(rs.getString("id"));
                roleItem.setName(rs.getString("name"));
                roleList.add(roleItem);
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return roleList;
    }

    public role addRole(String roleName) {
        if (roleName == null || roleName.isBlank()) {
            throw new IllegalArgumentException("Role name is required.");
        }

        String cleanedRoleName = roleName.trim();

        try {
            Connection conn = bean.getConnectionobj();
            ensureRoleTable(conn);

            String sql = "INSERT INTO roles (name) VALUES (?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cleanedRoleName);
            ps.executeUpdate();

            ps.close();
            conn.close();

            role savedRole = new role();
            savedRole.setName(cleanedRoleName);
            return savedRole;
        } catch (SQLException e) {
            if (e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate")) {
                throw new IllegalArgumentException("Role already exists: " + cleanedRoleName);
            }
            throw new RuntimeException("Failed to add role: " + e.getMessage(), e);
        } catch (Exception e) {
            throw new RuntimeException("Failed to add role: " + e.getMessage(), e);
        }
    }

    public role getRoleById(String id) {
        role roleItem = null;
        try {
            Connection conn = bean.getConnectionobj();
            String sql = "SELECT id, name FROM roles WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                roleItem = new role();
                roleItem.setId(rs.getString("id"));
                roleItem.setName(rs.getString("name"));
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roleItem;
    }

    public role updateRole(String id, String newName) {
        if (id == null || id.isBlank()) {
            throw new IllegalArgumentException("Role ID is required.");
        }
        if (newName == null || newName.isBlank()) {
            throw new IllegalArgumentException("Role name is required.");
        }

        String cleanedName = newName.trim();

        try {
            Connection conn = bean.getConnectionobj();
            String sql = "UPDATE roles SET name = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cleanedName);
            ps.setString(2, id);

            int result = ps.executeUpdate();
            if (result == 0) {
                throw new IllegalArgumentException("Role not found with id: " + id);
            }

            ps.close();
            conn.close();

            role updatedRole = new role();
            updatedRole.setId(id);
            updatedRole.setName(cleanedName);
            return updatedRole;
        } catch (SQLException e) {
            if (e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate")) {
                throw new IllegalArgumentException("Role already exists: " + cleanedName);
            }
            throw new RuntimeException("Failed to update role: " + e.getMessage(), e);
        } catch (Exception e) {
            throw new RuntimeException("Failed to update role: " + e.getMessage(), e);
        }
    }

    public boolean deleteRole(String id) {
        if (id == null || id.isBlank()) {
            throw new IllegalArgumentException("Role ID is required.");
        }

        try {
            Connection conn = bean.getConnectionobj();
            String sql = "DELETE FROM roles WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);

            int result = ps.executeUpdate();
            ps.close();
            conn.close();

            return result > 0;
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete role: " + e.getMessage(), e);
        }
    }
}

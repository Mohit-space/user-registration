package com.abhiyantriki.project1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.abhiyantriki.project1.entity.employee;


@Repository
public class employeeRepo {

    private static final DateTimeFormatter DB_DATE_FORMAT = DateTimeFormatter.ISO_LOCAL_DATE;
    private static final DateTimeFormatter[] INPUT_DATE_FORMATS = new DateTimeFormatter[] {
        DateTimeFormatter.ISO_LOCAL_DATE,
        DateTimeFormatter.ofPattern("dd/MM/yyyy"),
        DateTimeFormatter.ofPattern("dd-MM-yyyy"),
        DateTimeFormatter.ofPattern("dd MM yyyy")
    };
	
	connectionBean bean = new connectionBean();

    private String normalizeDob(String dobValue) {
        if (dobValue == null || dobValue.isBlank()) {
            return null;
        }

        String cleaned = dobValue.trim().replaceAll("\\s+", "").replace('.', '-').replace('/', '-');
        for (DateTimeFormatter formatter : INPUT_DATE_FORMATS) {
            try {
                LocalDate parsed = LocalDate.parse(cleaned, formatter);
                return parsed.format(DB_DATE_FORMAT);
            } catch (DateTimeParseException ignored) {
                // try next supported format
            }
        }

        throw new IllegalArgumentException("DOB format is invalid. Use YYYY-MM-DD or DD/MM/YYYY.");
    }

    private String normalizeRole(String roleValue) {
        if (roleValue == null || roleValue.isBlank()) {
            return "Software Developer";
        }
        return roleValue.trim();
    }
	
	
	// create 
	public employee addEmployee(employee emp) {
	
		System.out.println("Adding employee: " + emp.getId() + ", " + emp.getFirstName());
		
		try {
			Connection conn = bean.getConnectionobj();
			
            String sql = "insert into employee (firstName, secondName, lastName, email, mobileNo, dob, address, city, state, country, pinCode, roles) values(?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, emp.getFirstName());
            ps.setString(2, emp.getSecondName());
            ps.setString(3, emp.getLastName());
            ps.setString(4, emp.getEmail());
            ps.setString(5, emp.getMobileNo());
            ps.setString(6, normalizeDob(emp.getDob()));
            ps.setString(7, emp.getAddress());
            ps.setString(8, emp.getCity());
            ps.setString(9, emp.getState());
            ps.setString(10, emp.getCountry());
            ps.setString(11, emp.getPinCode());
            ps.setString(12, normalizeRole(emp.getRole()));
           

            int result = ps.executeUpdate();
            if(result>0) {
            	
            System.out.println("Employee Added successfully");
            } else {
            	System.out.println("Employee not added, result: " + result);
            }
            
            conn.close();
            

        } catch (Exception e) {
            e.printStackTrace();
        }
		return emp;
    }
	


// read 

public List<employee>getEmployees()
{
	List<employee>list = new ArrayList<>();

	try {
		Connection conn = bean.getConnectionobj();
		String sql = "Select * FROM employee";
		PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {

            employee emp = new employee();

            emp.setId(rs.getString("id"));
            emp.setFirstName(rs.getString("firstName"));
            emp.setSecondName(rs.getString("secondName"));
            emp.setLastName(rs.getString("lastName"));
            emp.setEmail(rs.getString("email"));
            emp.setMobileNo(rs.getString("mobileNo"));
            emp.setDob(rs.getString("dob"));
            emp.setAddress(rs.getString("address"));
            emp.setCity(rs.getString("city"));
            emp.setState(rs.getString("state"));
            emp.setCountry(rs.getString("country"));
            emp.setPinCode(rs.getString("pinCode"));
            emp.setRole(rs.getString("roles"));
            

            list.add(emp);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
    
}
		


// UPDATE
public employee updateEmployee(employee emp) {
	
	System.out.println("----"+emp.getId());
    if (emp.getId() == null || emp.getId().isBlank()) {
        throw new IllegalArgumentException("Employee id is required for update.");
    }

    try {

        Connection conn = bean.getConnectionobj();

        String sql = "UPDATE employee SET firstName=?, secondName=?, lastName=?, email=?, mobileNo=?, dob=?, address=?, city=?, state=?, country=?, pinCode=?, roles=? WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, emp.getFirstName());
        ps.setString(2, emp.getSecondName());
        ps.setString(3, emp.getLastName());
        ps.setString(4, emp.getEmail());
        ps.setString(5, emp.getMobileNo());
        ps.setString(6, normalizeDob(emp.getDob()));
        ps.setString(7, emp.getAddress());
        ps.setString(8, emp.getCity());
        ps.setString(9, emp.getState());
        ps.setString(10, emp.getCountry());
        ps.setString(11, emp.getPinCode());
        ps.setString(12, normalizeRole(emp.getRole()));
        ps.setString(13, emp.getId());

       int result =  ps.executeUpdate();
       if(result>0) {
        System.out.println("Employee Updated, rows affected: " + result);
       } else {
        throw new IllegalStateException("No employee found with id: " + emp.getId());
       }
       conn.close();

    } catch (Exception e) {
		throw new RuntimeException("Failed to update employee: " + e.getMessage(), e);
    	}
     return emp;
	}



// Get by ID

    public employee getEmployeeById(String id) {
        employee emp = null;
        try {
            Connection conn = bean.getConnectionobj();
            String sql = "SELECT * FROM employee WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                emp = new employee();
                emp.setId(rs.getString("id"));
                emp.setFirstName(rs.getString("firstName"));
                emp.setSecondName(rs.getString("secondName"));
                emp.setLastName(rs.getString("lastName"));
                emp.setEmail(rs.getString("email"));
                emp.setMobileNo(rs.getString("mobileNo"));
                emp.setDob(rs.getString("dob"));
                emp.setAddress(rs.getString("address"));
                emp.setCity(rs.getString("city"));
                emp.setState(rs.getString("state"));
                emp.setCountry(rs.getString("country"));
                emp.setPinCode(rs.getString("pinCode"));
                emp.setRole(rs.getString("roles"));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emp;
    }

// Delete 
public boolean deleteEmployee(String id){
	
	boolean status = false;
	try {
		Connection conn = bean.getConnectionobj();
		String sql = "Delete from employee where id=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		
		ps.setString(1,id);
		 int row = ps.executeUpdate();
		 if(row>0) {
			 status = true;
		 }
		System.out.println("employee deleted");
		conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	return status;
    }

// Get Employees by Role
public List<employee> getEmployeesByRole(String role) {
	List<employee> list = new ArrayList<>();
	
	try {
		Connection conn = bean.getConnectionobj();
        String sql = "SELECT * FROM employee WHERE roles = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, role);
		
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			employee emp = new employee();
			emp.setId(rs.getString("id"));
			emp.setFirstName(rs.getString("firstName"));
			emp.setSecondName(rs.getString("secondName"));
			emp.setLastName(rs.getString("lastName"));
			emp.setEmail(rs.getString("email"));
			emp.setMobileNo(rs.getString("mobileNo"));
			emp.setDob(rs.getString("dob"));
			emp.setAddress(rs.getString("address"));
			emp.setCity(rs.getString("city"));
			emp.setState(rs.getString("state"));
			emp.setCountry(rs.getString("country"));
			emp.setPinCode(rs.getString("pinCode"));
            emp.setRole(rs.getString("roles"));
			
			list.add(emp);
		}
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	return list;
}

}


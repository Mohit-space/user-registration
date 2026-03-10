<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
<title>Role Maker - Employee Management</title>

<style>

body{
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #667eea, #764ba2);
    margin:0;
    padding:20px;
    min-height:100vh;
}

.container{
    max-width:1000px;
    margin:0 auto;
}

h1{
    text-align:center;
    color:white;
    margin-bottom:10px;
    font-size:36px;
    text-shadow:2px 2px 4px rgba(0,0,0,0.3);
}

.subtitle{
    text-align:center;
    color:#e0e0e0;
    margin-bottom:30px;
    font-size:16px;
}

.role-selector{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0px 4px 15px rgba(0,0,0,0.2);
    margin-bottom:30px;
}

.role-selector h2{
    color:#333;
    margin-top:0;
    border-bottom:2px solid #667eea;
    padding-bottom:10px;
}

.role-form{
    display:flex;
    gap:10px;
    align-items:center;
    flex-wrap:wrap;
    margin-top:16px;
}

.role-create-form{
    display:flex;
    gap:10px;
    align-items:center;
    flex-wrap:wrap;
    margin-top:14px;
}

.role-input{
    flex:1;
    min-width:240px;
    padding:12px;
    border:1px solid #ccc;
    border-radius:5px;
    font-size:14px;
}

.role-add-btn{
    background:#4CAF50;
    color:white;
    border:2px solid #4CAF50;
    padding:12px 20px;
    border-radius:5px;
    cursor:pointer;
    font-size:14px;
    font-weight:bold;
    transition:all 0.3s;
}

.role-add-btn:hover{
    background:#45a049;
    border-color:#45a049;
}

.role-select{
    flex:1;
    min-width:240px;
    padding:12px;
    border:1px solid #ccc;
    border-radius:5px;
    font-size:14px;
}

.role-submit{
    background:#667eea;
    color:white;
    border:2px solid #667eea;
    padding:12px 20px;
    border-radius:5px;
    cursor:pointer;
    font-size:14px;
    font-weight:bold;
    transition:all 0.3s;
}

.role-submit:hover{
    background:#764ba2;
    border-color:#764ba2;
}

.employee-list-section{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0px 4px 15px rgba(0,0,0,0.2);
    margin-bottom:30px;
    display:none;
}

.employee-list-section.show{
    display:block;
}

.employee-list-section h2{
    color:#333;
    margin-top:0;
    border-bottom:2px solid #667eea;
    padding-bottom:10px;
}

.employee-count{
    color:#667eea;
    font-weight:bold;
    margin-bottom:20px;
    font-size:16px;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
}

th{
    background:#667eea;
    color:white;
    padding:12px;
    text-align:left;
}

td{
    padding:12px;
    border-bottom:1px solid #f0f0f0;
}

tr:hover{
    background:#f5f5f5;
}

.update-btn, .delete-btn{
    padding:6px 12px;
    border:none;
    border-radius:4px;
    cursor:pointer;
    text-decoration:none;
    display:inline-block;
    margin-right:5px;
}

.update-btn{
    background:#2196F3;
    color:white;
}

.update-btn:hover{
    background:#0b7dda;
}

.delete-btn{
    background:#f44336;
    color:white;
}

.delete-btn:hover{
    background:#da190b;
}

.action-buttons{
    text-align:center;
    margin-top:30px;
    padding-top:20px;
    border-top:2px solid #f0f0f0;
}

.add-btn, .back-btn{
    display:inline-block;
    padding:12px 25px;
    margin:0 10px;
    border:none;
    border-radius:5px;
    cursor:pointer;
    font-size:14px;
    font-weight:bold;
    transition:all 0.3s;
    text-decoration:none;
}

.add-btn{
    background:#4CAF50;
    color:white;
}

.add-btn:hover{
    background:#45a049;
    transform:translateY(-2px);
    box-shadow:0px 4px 10px rgba(0,0,0,0.2);
}

.back-btn{
    background:#999;
    color:white;
}

.back-btn:hover{
    background:#777;
    transform:translateY(-2px);
}

.empty-message{
    text-align:center;
    color:#999;
    padding:20px;
    font-style:italic;
}

.alert{
    padding:10px 12px;
    border-radius:6px;
    margin-top:12px;
    font-size:14px;
}

.alert-success{
    background:#e9f7ec;
    border:1px solid #b6e3bf;
    color:#1e6d2f;
}

.alert-error{
    background:#ffe9e9;
    border:1px solid #ffc2c2;
    color:#9e1c1c;
}

@media (max-width: 768px) {
    .role-form{
        flex-direction:column;
        align-items:stretch;
    }
    
    table{
        font-size:12px;
    }
    
    td, th{
        padding:8px;
    }
}

</style>

</head>

<body>

<div class="container">

    <h1>🎯 Role Maker</h1>
    <p class="subtitle">Select a role to view and manage employees</p>

    <!-- Role Selection Section -->
    <div class="role-selector">
        <h2>Select a Role</h2>

        <form action="${pageContext.request.contextPath}/roles/get-employees" method="post" class="role-form">
            <select name="role" class="role-select" required>
                <option value="">-- Select a Role --</option>
                <c:forEach var="role" items="${roles}">
                    <option value="${role}" <c:if test='${role == selectedRole}'>selected</c:if>>${role}</option>
                </c:forEach>
            </select>
            <button type="submit" class="role-submit">Show Employees</button>
        </form>

        <form action="${pageContext.request.contextPath}/roles/add" method="post" class="role-create-form">
            <input type="text" name="roleName" class="role-input" placeholder="Add new role" required>
            <button type="submit" class="role-add-btn">Add Role</button>
        </form>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
    </div>

    <!-- Employee List Section -->
    <c:if test="${not empty selectedRole}">
        <div class="employee-list-section show">
            <h2>Employees - ${selectedRole}</h2>
            <div class="employee-count">Total Employees: ${employeeCount}</div>
            
            <c:if test="${not empty employees}">
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Mobile</th>
                        <th>City</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                    
                    <c:forEach var="emp" items="${employees}">
                        <tr>
                            <td>${emp.id}</td>
                            <td>${emp.firstName}</td>
                            <td>${emp.lastName}</td>
                            <td>${emp.email}</td>
                            <td>${emp.mobileNo}</td>
                            <td>${emp.city}</td>
                            <td>${emp.role}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/employees/edit/${emp.id}" class="update-btn">Update</a>
                                <a href="javascript:void(0);" class="delete-btn" onclick="if(confirm('Are you sure?')) location.href='${pageContext.request.contextPath}/employees/delete/${emp.id}';">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
            
            <c:if test="${empty employees}">
                <div class="empty-message">
                    No employees found in this role.
                </div>
            </c:if>
        </div>
    </c:if>

    <!-- Action Buttons -->
    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/employees/register" class="add-btn">➕ Add New Employee</a>
        <a href="${pageContext.request.contextPath}/employees/list" class="back-btn">📋 View All Employees</a>
    </div>

</div>

</body>
</html>

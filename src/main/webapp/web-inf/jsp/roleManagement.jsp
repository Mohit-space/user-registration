<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
<title>Role Management</title>

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

.management-section{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0px 4px 15px rgba(0,0,0,0.2);
    margin-bottom:30px;
}

.management-section h2{
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
    margin-bottom:20px;
}

.role-input{
    flex:1;
    min-width:240px;
    padding:12px;
    border:1px solid #ccc;
    border-radius:5px;
    font-size:14px;
}

.btn{
    padding:10px 20px;
    border:none;
    border-radius:5px;
    cursor:pointer;
    font-size:14px;
    font-weight:bold;
    transition:all 0.3s;
    text-decoration:none;
    display:inline-block;
}

.btn-add{
    background:#4CAF50;
    color:white;
}

.btn-add:hover{
    background:#45a049;
}

.btn-edit{
    background:#2196F3;
    color:white;
}

.btn-edit:hover{
    background:#0b7dda;
}

.btn-delete{
    background:#f44336;
    color:white;
}

.btn-delete:hover{
    background:#da190b;
}

.btn-cancel{
    background:#999;
    color:white;
}

.btn-cancel:hover{
    background:#777;
}

.btn-update{
    background:#FF9800;
    color:white;
}

.btn-update:hover{
    background:#e68900;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    margin-top:20px;
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

.alert{
    padding:10px 12px;
    border-radius:6px;
    margin-bottom:20px;
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

.empty-message{
    text-align:center;
    color:#999;
    padding:20px;
    font-style:italic;
}

.action-buttons{
    text-align:center;
    margin-top:30px;
    padding-top:20px;
    border-top:2px solid #f0f0f0;
}

.edit-form-section{
    background:#f0f4ff;
    padding:20px;
    border-radius:8px;
    border:2px solid #667eea;
    margin-bottom:20px;
}

.edit-form-section h3{
    margin-top:0;
    color:#667eea;
}

</style>

</head>

<body>

<div class="container">

    <h1>🎭 Role Management</h1>
    <p class="subtitle">Add, Edit, and Delete Roles</p>

    <div class="management-section">
        <h2>Manage Roles</h2>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <!-- Edit Form (shown when editing) -->
        <c:if test="${not empty role}">
            <div class="edit-form-section">
                <h3>Edit Role</h3>
                <form action="${pageContext.request.contextPath}/roles/update" method="post" class="role-form">
                    <input type="hidden" name="id" value="${role.id}">
                    <input type="text" name="roleName" class="role-input" value="${role.name}" required>
                    <button type="submit" class="btn btn-update">Update Role</button>
                    <a href="${pageContext.request.contextPath}/roles/manage" class="btn btn-cancel">Cancel</a>
                </form>
            </div>
        </c:if>

        <!-- Add New Role Form -->
        <c:if test="${empty role}">
            <div>
                <h3>Add New Role</h3>
                <form action="${pageContext.request.contextPath}/roles/add" method="post" class="role-form">
                    <input type="text" name="roleName" class="role-input" placeholder="Enter role name" required>
                    <button type="submit" class="btn btn-add">Add Role</button>
                </form>
            </div>
        </c:if>

        <!-- Roles Table -->
        <h3 style="margin-top:30px;">All Roles</h3>
        
        <c:if test="${not empty allRoles}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Role Name</th>
                        <th style="text-align:center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="roleItem" items="${allRoles}">
                        <tr>
                            <td>${roleItem.id}</td>
                            <td>${roleItem.name}</td>
                            <td style="text-align:center;">
                                <a href="${pageContext.request.contextPath}/roles/edit/${roleItem.id}" class="btn btn-edit">Edit</a>
                                <a href="javascript:void(0);" class="btn btn-delete" 
                                   onclick="if(confirm('Are you sure you want to delete this role? This may affect employees with this role.')) 
                                   location.href='${pageContext.request.contextPath}/roles/delete/${roleItem.id}';">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty allRoles}">
            <div class="empty-message">
                No roles found. Add a new role to get started.
            </div>
        </c:if>

    </div>

    <!-- Action Buttons -->
    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/roles/maker" class="btn btn-cancel">🎯 Back to Role Maker</a>
        <a href="${pageContext.request.contextPath}/employees/register" class="btn btn-add">➕ Add New Employee</a>
        <a href="${pageContext.request.contextPath}/employees/list" class="btn btn-cancel">📋 View All Employees</a>
    </div>

</div>

</body>
</html>

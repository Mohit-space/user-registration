<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
<title>Employee List</title>

<style>

body{
    font-family: Arial, sans-serif;
    background: linear-gradient(to right,#74ebd5,#9face6);
    margin:0;
    padding:20px;
}

h1{
    text-align:center;
    color:#333;
}

.alert{
    width:80%;
    margin:10px auto 16px;
    padding:10px;
    border-radius:4px;
    text-align:center;
    background:#e8f6ea;
    color:#1f6f2a;
    border:1px solid #bfe7c5;
}

table{
    width:80%;
    margin:auto;
    border-collapse:collapse;
    background:white;
    box-shadow:0px 4px 10px rgba(0,0,0,0.2);
}

th{
    background:#4CAF50;
    color:white;
    padding:10px;
}

td{
    padding:10px;
    text-align:center;
}

tr:nth-child(even){
    background:#f2f2f2;
}

tr:hover{
    background:#e6f7ff;
}

a{
    text-decoration:none;
}

a[href*="edit"]{
    background:#2196F3;
    color:white;
    padding:5px 10px;
    border-radius:4px;
}

a[href*="edit"]:hover{
    background:#0b7dda;
}

.add-btn{
    display:block;
    width:200px;
    margin:20px auto;
    text-align:center;
    padding:10px;
    background:#4CAF50;
    color:white;
    border-radius:5px;
}

.add-btn:hover{
    background:#45a049;
}

a.role-maker-btn{
    display:block;
    width:200px;
    margin:20px auto 0;
    text-align:center;
    padding:10px;
    background:#667eea;
    color:white;
    border-radius:5px;
    text-decoration:none;
}

</style>

</head>

<body>

<h1>Employee List</h1>

<c:if test="${not empty message}">
<div class="alert">${message}</div>
</c:if>

<table border="1">

<tr>
<th>ID</th>
<th>First Name</th>
<th>Middle Name</th>
<th>Last Name</th>
<th>Email</th>
<th>Mobile</th>
<th>Address</th>
<th>City</th>
<th>State</th>
<th>Country</th>
<th>Pincode</th>
<th>Role</th>
<th>Action</th>
</tr>

<c:forEach var="emp" items="${employees}">
<tr>

<td>${emp.id}</td>
<td>${emp.firstName}</td>
<td>${emp.secondName}</td>
<td>${emp.lastName}</td>
<td>${emp.email}</td>
<td>${emp.mobileNo}</td>
<td>${emp.address}</td>
<td>${emp.city}</td>
<td>${emp.state}</td>
<td>${emp.country}</td>
<td>${emp.pinCode}</td>
<td>${emp.role}</td>

<td>
<a href="${pageContext.request.contextPath}/employees/edit/${emp.id}">Update</a>
</td>

</tr>
</c:forEach>

</table>

<a href="${pageContext.request.contextPath}/employees/register" class="add-btn">Add New Employee</a>

<a href="${pageContext.request.contextPath}/roles/maker" class="role-maker-btn">← Back to Role Maker</a>
</body>
</html>
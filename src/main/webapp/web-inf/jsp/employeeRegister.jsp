<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
<title>Employee Register</title>

<style>

body{
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #74ebd5, #9face6);
    margin:0;
    padding:0;
}

.container{
    width:400px;
    margin:60px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0px 4px 10px rgba(0,0,0,0.2);
}

h1{
    text-align:center;
    color:#333;
}

p{
    text-align:center;
    color:gray;
}

label{
    font-weight:bold;
}

input, select{
    width:100%;
    padding:8px;
    margin-top:5px;
    margin-bottom:15px;
    border:1px solid #ccc;
    border-radius:5px;
}

input:focus{
    border-color:#4CAF50;
    outline:none;
}

input[type="submit"]{
    background:#4CAF50;
    color:white;
    border:none;
    padding:10px;
    cursor:pointer;
    font-size:16px;
    border-radius:5px;
}

input[type="submit"]:hover{
    background:#45a049;
}

a.back-link{
    display:block;
    text-align:center;
    background:#999;
    color:white;
    padding:10px;
    cursor:pointer;
    border-radius:5px;
    text-decoration:none;
    margin-top:15px;
}

a.back-link:hover{
    background:#777;
}

</style>

</head>

<body>

<div class="container">

<h1>Employee Register</h1>
<p>Please Enter Employee Details</p>

<form action="${pageContext.request.contextPath}/employees/add" method="post">

<label>Employee ID</label>
<input type="text" name="id" required>

<label>First Name</label>
<input type="text" name="firstName" required>

<label>Middle Name</label>
<input type="text" name="secondName">

<label>Last Name</label>
<input type="text" name="lastName" required>

<label>Email</label>
<input type="text" name="email" required>

<label>Mobile Number</label>
<input type="text" name="mobileNo" required>

<label>Date of Birth</label>
<input type="text" name="dob" placeholder="YYYY-MM-DD">

<label>Address</label>
<input type="text" name="address">

<label>City</label>
<input type="text" name="city">

<label>State</label>
<input type="text" name="state">

<label>Country</label>
<input type="text" name="country">

<label>Pincode</label>
<input type="text" name="pinCode">

<label>Role</label>
<select name="role" required>
<option value="">-- Select Role --</option>
<c:forEach var="role" items="${roles}">
    <option value="${role}">${role}</option>
</c:forEach>
</select>

<input type="submit" value="Add Employee">

</form>

<a href="${pageContext.request.contextPath}/roles/maker" class="back-link">← Back to Role Maker</a>

</div>

</body>
</html> register page



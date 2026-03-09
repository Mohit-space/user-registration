<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
<title>Update Employee</title>

<style>

body{
    font-family: Arial, sans-serif;
    background-color: #f4f6f9;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

form{
    background:white;
    padding:30px;
    border-radius:8px;
    width:500px;
    box-shadow:0 0 10px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    margin-bottom:20px;
}

.alert{
    padding:10px;
    margin-bottom:12px;
    border-radius:4px;
    font-size:14px;
}

.alert-error{
    background:#ffe7e7;
    color:#b00020;
    border:1px solid #ffc2c2;
}

input[type="text"], select{
    width:100%;
    padding:10px;
    margin:8px 0;
    border:1px solid #ccc;
    border-radius:5px;
}

input[readonly]{
    background:#eee;
}

input[type="submit"]{
    width:100%;
    padding:10px;
    background:#007bff;
    color:white;
    border:none;
    border-radius:5px;
    font-size:16px;
    cursor:pointer;
}

input[type="submit"]:hover{
    background:#0056b3;
}

</style>

</head>

<body>

<form action="${pageContext.request.contextPath}/employees/update" method="post">

<h2>Update Employee</h2>

<c:if test="${not empty error}">
    <div class="alert alert-error">${error}</div>
</c:if>

<input type="text" name="id" value="${employee.id}" readonly>

<input type="text" name="firstName" value="${employee.firstName}" placeholder="First Name">

<input type="text" name="secondName" value="${employee.secondName}" placeholder="Second Name">

<input type="text" name="lastName" value="${employee.lastName}" placeholder="Last Name">

<input type="text" name="email" value="${employee.email}" placeholder="Email">

<input type="text" name="mobileNo" value="${employee.mobileNo}" placeholder="Mobile Number">

<input type="date" name="dob" value="${employee.dob}">

<input type="text" name="address" value="${employee.address}" placeholder="Address">

<input type="text" name="city" value="${employee.city}" placeholder="City">

<input type="text" name="state" value="${employee.state}" placeholder="State">

<input type="text" name="country" value="${employee.country}" placeholder="Country">

<input type="text" name="pinCode" value="${employee.pinCode}" placeholder="Pin Code">

<input type="submit" value="Update Employee">

</form>

</body>
</html>
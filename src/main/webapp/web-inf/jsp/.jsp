<html>
<head>
<title>Employee Register</title>
</head>

<body>

<div class="container">

<h1>Employee Register</h1>
<p>Please Enter Employee Details</p>
<form action="" method="post"></form>
<label for="id"> Enter Employee ID </label>
<input type="text" placeholder="Enter ID" name="id" id="id" required>
</br>

<label for="firstName"> Enter First Name </label>
<input type="text" placeholder="First Name" name="firstName" id="firstName" required>
</br>

<label for="middleName"> Enter Middle Name </label>
<input type="text" placeholder="Middle Name" name="middleName" id="middleName">
</br>

<label for="lastName"> Enter Last Name </label>
<input type="text" placeholder="Last Name" name="lastName" id="lastName" required>
</br>

<label for="mobileNumber"> Enter Mobile Number </label>
<input type="number" placeholder="Mobile Number" name="mobileNumber" id="mobileNumber" required>
</br>

<label for="gender"> Gender </label>
<select name="gender" id="gender">
<option value="Male">Male</option>
<option value="Female">Female</option>
</select>
</br>

<label for="address"> Address </label>
<input type="text" placeholder="Enter Address" name="address" id="address">
</br>

<label for="city"> City </label>
<input type="text" placeholder="Enter City" name="city" id="city">
</br>

<label for="state"> State </label>
<input type="text" placeholder="Enter State" name="state" id="state">
</br>

<label for="country"> Country </label>
<input type="text" placeholder="Enter Country" name="country" id="country">
</br>

<label for="pincode"> Pincode </label>
<input type="text" placeholder="Enter Pincode" name="pincode" id="pincode">
</br>

<input type="submit" value="Add Employee">

</div>

</form>

</body>
</html>
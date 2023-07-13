<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>DataTables</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link href="https://unpkg.com/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <link rel="stylesheet" href="css/datatables.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/sweetalert2.min.css">

    <link rel="stylesheet" href="css/view.css">
</head>

<body class="bg-gray-100 text-gray-900 tracking-wider leading-normal">
<!-- Container -->
<jsp:include page="navBar.jsp" />

<div class="container w-full md:w-4/5 xl:w-3/5 mx-auto px-2">
    <!-- Card -->
    <div class="row">
        <div class="col-md-12">
            <div class="card" style="margin-left: 75px;">
                <div class="card-body">
                    <div class="table-responsive">
                        <div class="flex justify-end mt-4">
                            <a href="registration.jsp" class="icon-button mr-2">
                                <i class="fas fa-arrow-left" style="font-size: 30px"></i> <!-- Back icon -->
                            </a>
                            <a href="index.jsp" class="icon-button">
                                <i class="fas fa-home" style="font-size: 30px"></i> <!-- Home icon -->
                            </a>
                        </div>
                        <table id="example" class="display table table-striped table-bordered" style="width: 100%">
                            <thead>
                            <tr>
                                <th data-priority="1">User ID</th>
                                <th data-priority="2">Full Name</th>
                                <th data-priority="3">NIC</th>
                                <th data-priority="4">Address</th>
                                <th data-priority="5">Phone Number</th>
                                <th data-priority="6">Action</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Update Registration</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="form" onsubmit="event.preventDefault(); ApiCallForUserUpdate()">

                    <input type="hidden" id="userIdI" name="uid" value="">
                    <label for="nameI" class="form-label12 animation a3">Full Name:</label>
                    <input type="text" class="form-field animation a3" placeholder="Full Name" name="nameI" id="nameI" required>

                    <label for="addressI" class="form-label12 animation a3">Address:</label>
                    <input type="text" class="form-field animation a3" placeholder="Address" name="addressI" id="addressI" required>

                    <label for="phoneI" class="form-label12 animation a3">Phone Number:</label>
                    <input type="text" class="form-field animation a3" placeholder="Phone Number" name="phoneI" id="phoneI" required pattern="^(07\d{8}|7\d{8}|\+947\d{8}|947\d{8})$">

                    <label for="nicI" class="form-label12 animation a4">NIC:</label>
                    <input type="text" class="form-field animation a4" placeholder="NIC" name="nicI" id="nicI" required pattern="[0-9]{9}|[0-9]{12}|[0-9]{9}[vV]|([0-9]{12})" title="Invalid NIC">

                    <label for="birthdayI" class="form-label12 animation a4">Birthday:</label>
                    <input type="text" class="form-field animation a4" placeholder="Birthday" name="birthdayI" id="birthdayI">

                    <label for="ageI" class="form-label12 animation a4">Age:</label>
                    <input type="text" class="form-field animation a4" placeholder="Age" name="ageI" id="ageI">

                    <label for="genderI" class="form-label12 animation a5">Gender:</label>
                    <input type="text" class="form-field animation a5" placeholder="Gender" name="genderI" id="genderI">

                    <button class="animation a6" id="submitBtn">Update</button>
                </form>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/datatables.min.js"></script>
<script src="js/sweetalert2.min.js"></script>
<script src="js/sweetalert.script.min.js"></script>

<script>
    function calculateInfo() {
        var gender = "";
        var year = "";
        var month = "";
        var day = "";

        var nicValue = document.getElementById("nicI").value;

        if (nicValue === "") {
            document.getElementById("ageI").value = "";
            document.getElementById("genderI").value = "";
            document.getElementById("birthdayI").value = "";
        } else {
            var oldPatternNIC = /[0-9]{9}[V|X|v|x]/;
            var newPatternNIC = /^[0-9]{12}$/;

            if (oldPatternNIC.test(nicValue) || newPatternNIC.test(nicValue)) {
                if (nicValue.length == 12) {
                    year = parseInt(nicValue.substr(0, 4));
                    console.log(year);

                    var midnumber = nicValue.substr(4, 3);
                    console.log(midnumber);
                } else {
                    year = parseInt(nicValue.substr(0, 2));
                    year = 1900 + year;
                    console.log(year);

                    var midnumber = nicValue.substring(2, 5);
                    console.log(midnumber);
                }

                var intMidValue = parseInt(midnumber);

                if (intMidValue > 500) {
                    gender = "Female";
                    intMidValue = intMidValue - 500;
                } else {
                    gender = "Male";
                }
                document.getElementById("genderI").value = gender;

                if (intMidValue < 1 || intMidValue > 366) {
                    // Invalid NIC number, do nothing
                } else {
                    if (intMidValue > 335) {
                        day = intMidValue - 335;
                        month = "12";
                    } else if (intMidValue > 305) {
                        day = intMidValue - 305;
                        month = "11";
                    } else if (intMidValue > 274) {
                        day = intMidValue - 274;
                        month = "10";
                    } else if (intMidValue > 244) {
                        day = intMidValue - 244;
                        month = "09";
                    } else if (intMidValue > 213) {
                        day = intMidValue - 213;
                        month = "08";
                    } else if (intMidValue > 182) {
                        day = intMidValue - 182;
                        month = "07";
                    } else if (intMidValue > 152) {
                        day = intMidValue - 152;
                        month = "06";
                    } else if (intMidValue > 121) {
                        day = intMidValue - 121;
                        month = "05";
                    } else if (intMidValue > 91) {
                        day = intMidValue - 91;
                        month = "04";
                    } else if (intMidValue > 60) {
                        day = intMidValue - 60;
                        month = "03";
                    } else if (intMidValue > 31) {
                        day = intMidValue - 31;
                        month = "02";
                    } else if (intMidValue <= 31) {
                        day = intMidValue;
                        month = "01";
                    }

                    document.getElementById("birthdayI").value = year + "-" + month + "-" + day;
                    var currentDate = new Date();
                    var currentYear = currentDate.getFullYear();
                    document.getElementById("ageI").value = currentYear - year;
                }
            }
        }
    }

    // Attach the calculateInfo function to the NIC field's onblur event
    document.getElementById("nicI").addEventListener("blur", calculateInfo);
</script>

<script>

    // var table;
    // // Define the fetchUserData
    // function fetchUserData() {
    //     $.ajax({
    //         url: 'http://localhost:8082/v1/user/view',
    //         method: 'GET',
    //         dataType: 'json',
    //         success: function(response) {
    //             // Clear the existing table rows
    //             table.clear();
    //
    //             // Iterate over the user data and add rows to the table
    //             response.forEach(function(user) {
    //                 var rowData = [
    //                     user.uid,
    //                     user.name,
    //                     user.nic,
    //                     user.address,
    //                     user.phoneNumber,
    //                     '<input type="button" value="Update" onclick="editRow(event)" data-toggle="modal" data-target="#exampleModal" data-userid="' + user.uid + '" data-name="' + user.name + '" data-nic="' + user.nic + '" data-address="' + user.address + '" data-phone="' + user.phoneNumber + '" data-birthday="' + user.birthday + '" data-age="' + user.age + '" data-gender="' + user.gender + '" style="background-color: blue; color: white; border-width: 5px; border-color: blue; border-radius: 2px">' +
    //                     '<input type="button" value="Delete" onclick="deleteUser(' + user.uid + ')" style="background-color: darkred; color: white; border-width: 5px; border-color: darkred; border-radius: 2px">',
    //                     user.birthday,  // Hidden field
    //                     user.age,       // Hidden field
    //                     user.gender     // Hidden field
    //                 ];
    //
    //                 // Add the row to the table
    //                 table.row.add(rowData);
    //             });
    //
    //             // Draw the updated table
    //             table.draw();
    //         },
    //         error: function(error) {
    //             console.log('Error retrieving user data:', error);
    //         }
    //     });
    // }

    var table;

    // Define the fetchUserData function
    function fetchUserData() {
        $.ajax({
            url: 'http://localhost:8082/v1/user/view',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                // Clear the existing table rows
                table.clear();

                // Iterate over the user data and add rows to the table
                response.forEach(function(user) {
                    var rowData = [
                        user.uid,
                        user.name,
                        user.nic,
                        user.address,
                        user.phoneNumber,
                        '<div class="button-container">' +
                        '<input type="button" value="Update" onclick="editRow(event)" data-toggle="modal" data-target="#exampleModal" data-userid="' + user.uid + '" data-name="' + user.name + '" data-nic="' + user.nic + '" data-address="' + user.address + '" data-phone="' + user.phoneNumber + '" data-birthday="' + user.birthday + '" data-age="' + user.age + '" data-gender="' + user.gender + '" class="custom-button update-button">' +
                        '<input type="button" value="Delete" onclick="deleteUser(' + user.uid + ')" class="custom-button delete-button" style="background-color: darkred; border-color: darkred">' +
                        '</div>',
                        user.birthday,  // Hidden field
                        user.age,       // Hidden field
                        user.gender     // Hidden field
                    ];

                    // Add the row to the table
                    table.row.add(rowData);
                });

                // Draw the updated table
                table.draw();
            },
            error: function(error) {
                console.log('Error retrieving user data:', error);
            }
        });
    }


    $(document).ready(function() {
        // Initialize the DataTable
        table = $('#example').DataTable({
            "paging": true,
            "dom": 'Bfrtip',
            "buttons": [
                'copy', 'csv', 'excel', 'pdf', 'print'
            ],
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": true,
            "responsive": true,
            // "autoWidth": false,
            // "responsive": false,
            "bDestroy": true
        });

        // Call fetchUserData initially to populate the DataTable
        fetchUserData();
    });
//delete function
    function deleteUser(userId) {
        var baseUrl = 'http://localhost:8082/';
        var deleteUrl = baseUrl + 'v1/user/delete/' + userId;

        $.ajax({
            url: deleteUrl,
            method: 'DELETE',
            success: function(response) {
                swal({
                    type: 'success',
                    title: 'Success!',
                    text: 'User has been deleted successfully',
                    buttonsStyling: false,
                    confirmButtonClass: 'btn btn-lg btn-success'
                }).then(function() {
                    // Fetch and reload the updated user data
                    fetchUserData();
                });
            },
            error: function(error) {
                console.log('Error deleting user:', error);
            }
        });
    }
//auto fill modal
//     function editRow(event) {
//         var button = event.target;
//         var userId = button.getAttribute("data-userid");
//         var name = button.getAttribute("data-name");
//         var nic = button.getAttribute("data-nic");
//         var address = button.getAttribute("data-address");
//         var phone = button.getAttribute("data-phone");
//         var birthday = button.getAttribute("data-birthday");
//         var age = button.getAttribute("data-age");
//         var gender = button.getAttribute("data-gender");
//
//         document.getElementById("userIdI").value = userId;
//         document.getElementById("nameI").value = name;
//         document.getElementById("nicI").value = nic;
//         document.getElementById("addressI").value = address;
//         document.getElementById("phoneI").value = phone;
//         document.getElementById("birthdayI").value = birthday;
//         document.getElementById("ageI").value = age;
//         document.getElementById("genderI").value = gender;
//     }

    function editRow(event) {
        var button = event.target;
        var userId = button.getAttribute("data-userid");
        var name = button.getAttribute("data-name");
        var nic = button.getAttribute("data-nic");
        var address = button.getAttribute("data-address");
        var phone = button.getAttribute("data-phone");
        var birthday = button.getAttribute("data-birthday");
        var age = button.getAttribute("data-age");
        var gender = button.getAttribute("data-gender");

        // Map the gender value to the corresponding label
        var genderLabel = "";
        if (gender === "F") {
            genderLabel = "Female";
        } else if (gender === "M") {
            genderLabel = "Male";
        }

        document.getElementById("userIdI").value = userId;
        document.getElementById("nameI").value = name;
        document.getElementById("nicI").value = nic;
        document.getElementById("addressI").value = address;
        document.getElementById("phoneI").value = phone;
        document.getElementById("birthdayI").value = birthday;
        document.getElementById("ageI").value = age;
        document.getElementById("genderI").value = genderLabel;
    }

    //update function
    function ApiCallForUserUpdate() {
        var baseUrl = "http://localhost:8082/";
        var uid = document.getElementById("userIdI").value;
        var name = document.getElementById("nameI").value;
        var address = document.getElementById("addressI").value;
        var phone = document.getElementById("phoneI").value;
        var nic = document.getElementById("nicI").value;
        var birthday = document.getElementById("birthdayI").value;
        var age = document.getElementById("ageI").value;
        var gender = document.getElementById("genderI").value;

        var RequestUrl = baseUrl + 'v1/user/' + uid;
        var RequestObject = {
            "name": name,
            "address": address,
            "phoneNumber": phone,
            "nic": nic,
            "birthday": birthday,
            "age": age,
            "gender": gender
        };

        $.ajax({
            url: RequestUrl,
            method: 'PUT',
            contentType: 'application/json',
            dataType: 'json',
            data: JSON.stringify(RequestObject),
            success: function(Data, StatusText, XHR) {
                if (XHR.status === 200) {
                    swal({
                        type: 'success',
                        title: 'Success!',
                        text: 'User details have been successfully updated',
                        buttonsStyling: false,
                        confirmButtonClass: 'btn btn-lg btn-success'
                    }).then(function() {
                        window.location.href = 'view.jsp';

                    });
                } else {
                    consoleconsole.log('ApiCallForUserUpdate.Response.status:', XHR.status);
                }
            },
            error: function(Error) {
                console.log('ApiCallForUserUpdate.Response.Error:', Error);
            }
        });
    }


</script>
</body>
</html>

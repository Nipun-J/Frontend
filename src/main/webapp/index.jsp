
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>NIC Validation</title>
    <link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Arimo' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Hind:300' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/style1.css">
    <link rel="stylesheet" href="css/sweetalert2.min.css">

    <style>
        .custom-confirm-btn {
            background-color: green;
            border-color: green;
            color: white;
        }
    </style>



</head>
<body style="background:url('images/b.jpg') no-repeat center center fixed;">
<img src="images\b.jpg" alt="background" class="responsive-image">
<div id="login-button">
    <img src="http://dqcgrsy5v35b9.cloudfront.net/cruiseplanner/assets/img/icons/login-w-icon.png">
</div>
<div id="container">
    <h1>Log In</h1>
    <span class="close-btn">
            <img src="https://cdn4.iconfinder.com/data/icons/miu/22/circle_close_delete_-128.png">
        </span>


<%--login--%>
    <form id="login-form" onsubmit="event.preventDefault(); ApiCallForLogin();" >
        <input type="email" name="email" id="emailI" placeholder="E-mail" required >
        <input type="password" name="password" id="passI" placeholder="Password" required>
        <button  id="lobt" type="submit">Log in</button>

        <div id="remember-container">
            <input type="checkbox" id="checkbox-2-1" class="checkbox" checked="checked"/>
            <span id="remember">Remember me</span>
            <span id="forgotten">Forgotten password</span>
        </div>
    </form>
<%--login --%>
</div>

<!-- Forgotten Password Container -->
<div id="forgotten-container">
    <h1>Forgotten</h1>
    <span id="forgotten-close-btn" class="close-btn">
            <img src="https://cdn4.iconfinder.com/data/icons/miu/22/circle_close_delete_-128.png"></img>
        </span>

<%--update--%>
    <form onsubmit="event.preventDefault(); ApiCallForUpdate();">
        <input type="email" id="Femail" name="emailN" placeholder="E-mail" required>
        <input type="password" id="Fpassword" name="newPassword" placeholder="Password" required pattern="[0-9]{5}" title ="Type 5 digits Password">
        <button id="fobt" class="orange-btn" type="submit" >Get new password</button>
    </form>
<%--update--%>
</div>

<script src='http://cdnjs.cloudflare.com/ajax/libs/gsap/1.16.1/TweenMax.min.js'></script>
<%--<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>--%>
<script src="js/jquery.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%--<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>--%>
<script src="js/sweetalert2.min.js"></script>
<script src="js/sweetalert.script.min.js"></script>


<script>
    $('#login-button').on('click', function() {
        $('#login-button').fadeOut("slow", function() {
            $("#container").fadeIn();
        });
    });

    $(".close-btn").click(function() {
        $("#container").fadeOut(800, function() {
            $("#login-button").fadeIn(800);
        });
    });

    $('#forgotten').click(function(){
        $("#container").fadeOut(function(){
            $("#forgotten-container").fadeIn();
        });
    });

    // Handle close button click in forgotten-container
    $("#forgotten-close-btn").click(function(){
        $("#forgotten-container").fadeOut(800, function(){
            $("#login-button").fadeIn(800);
        });
    });

</script>

<script>
    // ApiCallForLogin
    const baseUrl = "http://localhost:8082/";

    let email = document.getElementById("emailI");
    let password = document.getElementById("passI");

    function ApiCallForLogin() {
        let RequestUrl = baseUrl + 'v1/admin/login';
        let RequestObject = {
            "email": email.value,
            "password": password.value,
        };

        $.ajax({
            url: RequestUrl,
            method: 'POST',
            contentType: 'application/json',
            dataType: 'json',
            data: JSON.stringify(RequestObject),
            success: function (Data, StatusText, XHR) {
                if (XHR.status === 200) {
                    swal({
                        type: 'success',
                        title: 'Success!',
                        text: 'Login successful',
                        buttonsStyling: false,
                        // confirmButtonClass: 'btn btn-lg btn-success'
                        confirmButtonClass: 'btn btn-lg btn-success custom-confirm-btn'
                    }).then(() => {
                        window.location.href = 'registration.jsp'; // Redirect to index.jsp
                    });
                    InputFieldsReset();
                } else {
                    console.log('ApiCallForLogin.Response.status:', XHR.status);
                }
            },
            error: function (XHR, textStatus, errorThrown) {
                console.log('ApiCallForLogin.Response.Error:', errorThrown);
                swal({
                    type: 'error',
                    title: 'Error',
                    text: 'An error occurred while logging in. Please try again later.',
                    buttonsStyling: false,
                    confirmButtonClass: 'btn btn-lg btn-danger'
                });
            }
        });
    }

</script>

<script>
    // forgot password
    // const baseUrl = "http://localhost:8082/";

    let emailN = document.getElementById("Femail");
    let newPassword = document.getElementById("Fpassword");

    // function ApiCallForUpdate() {
    //     let RequestUrl = baseUrl + 'v1/admin/forgot-password';
    //
    //     let RequestObject = {
    //         "email": emailN.value,
    //         "newPassword": newPassword.value,
    //     };
    //
    //     $.ajax({
    //         url: RequestUrl,
    //         method: 'POST',
    //         contentType: 'application/json',
    //         dataType: 'json',
    //         data: JSON.stringify(RequestObject),
    //         success: function (Data, StatusText, XHR) {
    //             if (XHR.status === 200) {
    //                 swal({
    //                     type: 'success',
    //                     title: 'Success!',
    //                     text: 'Password updated successfully',
    //                     buttonsStyling: false,
    //                     confirmButtonClass: 'btn btn-lg btn-success'
    //                 }).then(() => {
    //                     window.location.href = 'index.jsp'; // Redirect to index.jsp
    //                 });
    //                 InputFieldsReset();
    //             } else {
    //                 console.log('ApiCallForUserSave.Response.status:', XHR.status);
    //             }
    //         },
    //         error: function (Error) {
    //             console.log('ApiCallForUserSave.Response.Error:', Error);
    //         }
    //     }).then();
    // }

    function ApiCallForUpdate() {
        let RequestUrl = baseUrl + 'v1/admin/forgot-password';

        let RequestObject = {
            "email": emailN.value,
            "newPassword": newPassword.value,
        };

        $.ajax({
            url: RequestUrl,
            method: 'POST',
            contentType: 'application/json',
            dataType: 'text', // Change the dataType to 'text'
            data: JSON.stringify(RequestObject),
            success: function (response, status, xhr) {
                if (xhr.status === 200) {
                    swal({
                        type: 'success',
                        title: 'Success!',
                        text: response, // Use the response text as the success message
                        buttonsStyling: false,
                        // confirmButtonClass: 'btn btn-lg btn-success'
                        confirmButtonClass: 'btn btn-lg btn-success custom-confirm-btn'
                    }).then(() => {
                        window.location.href = 'index.jsp'; // Redirect to index.jsp
                    });
                    // InputFieldsReset();
                } else {
                    console.log('ApiCallForUserSave.Response.status:', xhr.status);
                }
            },
            error: function (xhr, status, error) {
                console.log('ApiCallForUserSave.Response.Error:', error);
            }
        });
    }

</script>

</body>
</html>





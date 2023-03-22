
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
/*            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 99%, 78% 89%, 49% 100%, 28% 89%, 0 95%, 0% 35%, 0 0);
            }*/
            .margin{
                margin-top: 60px;
            }
            body {
                /*                background: url('img/plainbackground.jpg');
                                background-repeat: no-repeat;
                                background-size: 100% 100vh;*/

                background-image: url("img/plainbackground.jpg");
                min-height: 100%;
                background-repeat: repeat;
                background-attachment: fixed;
                background-position: center;
                background-size: cover;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <main class="d-flex align-item-center " style="padding-bottom: 170px">
            <div class="container ">
                <div class="col-md-4 offset-md-4">
                    <div class="card mt-5">
                        <div class="card-header primary-background tetx-white text-center">
                            <span class="fa fa-user-plus fa-3x"></span>
                            </br>
                            Register here
                        </div>
                        <div class="card-body">

                            <form id="reg-form" action="RegisterServlet" method="POST">
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input name="user_name" type="text" class="form-control" id="name"  placeholder="Enter name">

                                </div>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>


                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>

                                <div class="form-group">
                                    <label for="gender">Gender</label></br>
                                    <input type="radio" id="gender" name="gender" value="male">Male
                                    <input type="radio" id="gender" name="gender" value="female">Female
                                </div>
                                <div class="form-group">
                                    <textarea id="textarea" name="about" rows="2" class="form-control" placeholder="Enter something about yourself"> </textarea>
                                </div>

                                <div class="form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree terms and conditions</label>
                                </div>
                                </br>
                                <div class="container text-center" style="display:none;">
                                    <span class="fa fa-hourglass-half fa-spin fa-4x" ></span>
                                    <h6>Please wait...</h6>
                                </div>
                                <button id="submit-btn" type="submit" class="btn btn-primary btn-center">Submit</button>
                            </form>

                        </div>
                        <div class="card-footer">

                        </div>
                    </div>
                </div>
            </div>
        </main>


        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <script
            src="https://code.jquery.com/jquery-2.2.4.min.js"
            integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {
                console.log("loaded........")

                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);
                    $("#submit-btn").hide();
                    $("#loader").show();
                    //send register servlet
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)

                            $("#submit-btn").show();
                            $("#loader").hide();

                            if (data.trim() === 'done') {

                                swal("Registered successfully..Redirecting to login page")
                                        .then((value) => {
                                            window.location = "login_page.jsp"
                                        });

                            } else{
                                swal(data);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            
                            $("#submit-btn").show();
                            $("#loader").hide();
                            swal("Something went wrong");
                        },

                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>

    </body>
</html>

<%--<%@page import="org.apache.coyote.http11.Constants.a"%>--%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.techblog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

        <title><%= p.getpTitle()%></title>
        <style>
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-code{

            }
            .post-userinfo{
                font-style: italic;
            }
            .post-date{
                font-weight: 100;
                font-style: bold;
            }
            /*            body{
                            background: url(pics/backgroung.jpg);
                            background-size: cover;
                            background-attachment: fixed;
                        }*/
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
            .cardbodybackground{
                background-color: white;
            }
        </style>
    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v16.0" nonce="M4fgEcxK"></script>
</head>
<body>


    <!--navbar-->
    <nav class="navbar navbar-expand-lg navbar-dark  bg-dark ">
        <a class="navbar-brand" href="index.jsp">Techblog</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">LearnCodeWithMe <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contact</a>
                </li>


                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal">Do Post</a>
                </li>


            </ul>
            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link disabled" href="#!" data-toggle="modal" data-target="#exampleModal"><%= user.getName()%></a>
                </li
                <li class="nav-item">
                    <a class="nav-link disabled" href="LogoutServlet">Logout</a>
                </li
            </ul>
        </div>
    </nav>
    <!--end of navbar-->


    <!-- page header -->
    <header class="header" >
        <div class="overlay"></div>
        <div class="header-content">

        </div>
    </header><!-- end of page header -->
    <!--main content of the body-->

    <div class="container">
        <div class="row my-4">
            <div class="col-md-6 offset-md-3">
                <div class="card-header primary-background tetx-white">
                    <h4 class="post-title" ><%= p.getpTitle()%></h4>
                </div>
                <div class="card-body cardbodybackground">
                    <img class="card-img-top my-4" src="blog_pics/<%= p.getpPic()%>" alt="alt"/>

                    <div class="row">
                        <div class="col-md-8">
                            <%
                                UserDao ud = new UserDao((ConnectionProvider.getConnection()));
                            %>
                            <p class="post-userinfo"> <a href="#"> <%= ud.getUserByUserId(p.getUserId()).getName()%> </a></p>
                        </div>
                        <div class="col-md-4">
                            <p class="post-date">
                                <%= DateFormat.getDateInstance().format(p.getpDate())%>
                            </p>
                        </div>
                    </div>

                    <p class="post-content" ><%= p.getpContent()%></p>

                    <br><!-- comment -->
                    <br><!-- comment -->
                    <pre class="post-code" >
                        <%= p.getpCode()%>
                    </pre>


                </div
                <div class="container">
                    <div class="card-footer primary-background tetx-white btn-outline-light">

                        <%
                            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                        %>

                        <a href="#" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-primary btn-sm "> <i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= ld.countLikeOnPost(p.getPid())%></span></a>
                        <a href="#" class="btn btn-outline-primary btn-sm "> <i class="fa fa-commenting-o"></i><span>20</span></a>
                        <input align="right" type="text" name="comment" placeholder="Comment here"/><i class="fa fa-location-arrow ml-4 fa-2x"></i>
                    </div>
                </div>




                <div class="container">

                </div>
            </div>
        </div>
    </div>

    <!--end of main content of the body-->

    <!--message-->

    <%
        Message m = (Message) session.getAttribute("msg");
        if (m != null) {
    %>
    <div class="alert <%= m.getCssClass()%>" role="alert">
        <%= m.getContent()%>
    </div>
    <%
            session.removeAttribute("msg");
        }

    %>

    <!--end of message-->



    <!--start of profile model-->



    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header primary-background text-center">
                    <h5 class="modal-title" id="exampleModalLabel">Techblog</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:50%"/>
                        <br>
                        <h5 class="modal-title" id="exampleModalLabel"><%= user.getName()%></h5>

                        <div id="profile-details">
                            <table class="table">

                                <tbody>
                                    <tr>
                                        <th scope="row">ID</th>
                                        <td><%= user.getId()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td><%= user.getEmail()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Gender</th>
                                        <td><%=user.getGender()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Status</th>
                                        <td><%=user.getAbout()%></td> 

                                    </tr>
                                    <tr>
                                        <th scope="row">Registered on</th>
                                        <td><%= user.getDateTime().toString()%></td>

                                    </tr>
                                </tbody>
                            </table>

                        </div>
                        <!--profile-editing-->
                        <div id="profile-edit" style="display: none">
                            <h3 class="mt-2">Please Edit Carefully</h3>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID:</td>
                                        <td><%= user.getId()%></td>
                                    </tr>
                                    <tr>
                                        <td>Email:</td>
                                        <td> <input type="email"  class="form-control" name="user_email" value="<%= user.getEmail()%>"</td>
                                    </tr>
                                    <tr>
                                        <td>Name:</td>
                                        <td> <input type="text"  class="form-control" name="user_name" value="<%= user.getName()%>"</td>
                                    </tr>
                                    <tr>
                                        <td>Password:</td>
                                        <td> <input type="password"  class="form-control" name="user_password" value="<%= user.getPassword()%>"</td>
                                    </tr>
                                    <tr>
                                        <td>Gender:</td>
                                        <td> <%= user.getGender().toUpperCase()%></td>
                                    </tr>
                                    <tr>
                                        <td>About:</td>
                                        <td>
                                            <textarea class="form-control" rows="3" name="user_about" > <%= user.getAbout()%>
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>New Profile:</td>
                                        <td> <input type="file" name="image" class="form-control" step="hegight:50px;width:50px"/> </td>
                                    </tr>
                                </table>
                                <div class="container">
                                    <button type="submit" class="btn-outline-primary">Save</button>
                                </div>
                            </form>
                        </div>

                    </div>

                    ...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>
    <!--end of profile model-->

    <!--add post model-->
    <!-- Button trigger modal -->


    <!-- Modal -->
    <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ...
                    <form id="add-post-form" action="AddPostServlet" method="post">
                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>Select category</option>

                                <%
                                    PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = postd.getAllCategories();
                                    for (Category c : list) {
                                %>
                                <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                <%
                                    }
                                %>

                            </select>
                        </div>
                        <div class="form-group">
                            <input name="pTitle" type="text" placeholder="Enter post title" class="form-control"/>

                        </div>

                        <div class="form-group">
                            <textarea name="pContent" class="form-control" placeholder="Enter your content here"  rows="3" cols="30"></textarea>
                        </div>

                        <div class="form-group">
                            <textarea name="pCode" class="form-control" placeholder="Enter your program(if any)"  rows="3" cols="30"></textarea>
                        </div>

                        <div class="form-group">
                            <label>Select file</label> <br>
                            <input type="file" name="pic">
                        </div>
                        <dic class="container text-center">
                            <center>
                                <button type="submit" class="btn-outline-primary">Post</button>
                            </center>

                        </dic>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!--end of post model-->



    <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/myjs.js" type="text/javascript"></script>
    <!--            </<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>-->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
                        $(document).ready(function () {

                            let editStatus = false;
                            $('#edit-profile-button').click(function () {
                                // alert("button clicked")
                                if (editStatus == false) {
                                    $("#profile-details").hide()

                                    $("#profile-edit").show();
                                    editStatus = true;
                                    $(this).text("Back")
                                } else {
                                    $("#profile-details").show()

                                    $("#profile-edit").hide();
                                    editStatus = true;
                                    $(this).text("Edit")
                                }

                            })
                        });
    </script>

    <!--        now add javascript for post-->

    <script>
        $(document).ready(function (e) {
            $("#add-post-form").on("submit", function (event) {
                //this code gets called when form get submitted


                event.preventDefault();
                console.log("you have submitted")
                let form = new FormData(this);
                //now requesting to server
                $.ajax({
                    url: "AddPostServlet",
                    type: 'POST',
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        //Success
                        console.log(data);
                        if (data.trim() === 'done') {
                            swal("Good job!", "Uploaded successfully", "success");
                        } else {
                            swal("Error!", "Something went wrong try again", "error");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //error
                        swal("Good job!", "Something went wrong try again", "error");
                    },
                    processData: false,
                    contentType: false
                })
            })
        })
    </script>





</body>
</html>

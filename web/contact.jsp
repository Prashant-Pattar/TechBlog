
<%@page import="com.techblog.entities.JavaEmail" %>
<%@page import="javax.mail.MessagingException"%>



<%
    String message = null;
    String status = null;
    if (request.getParameter("submit") != null) {
        JavaEmail javaEmail = new JavaEmail();
        javaEmail.setMailServerProperties();
        String emailSubject = "Contact Form using Java JSP GMail";
        String emailBody = "";
        if (request.getParameter("name") != null) {
            emailBody = "Sender Name: " + request.getParameter("name")
                    + "<br>";
        }
        if (request.getParameter("email") != null) {
            emailBody = emailBody + "Sender Email: "
                    + request.getParameter("email") + "<br>";
        }
        if (request.getParameter("phone") != null) {
            emailBody = emailBody + "Sender Phone: "
                    + request.getParameter("phone") + "<br>";
        }
        if (request.getParameter("message") != null) {
            emailBody = emailBody + "Message: " + request.getParameter("message")
                    + "<br>";
        }
        javaEmail.createEmailMessage(emailSubject, emailBody);
        try {
            javaEmail.sendEmail();
            status = "success";
            message = "Email sent Successfully!";
        } catch (MessagingException me) {
            status = "error";
            message = "Error in Sending Email!";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Contact Us</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/contactstyle.css" rel="stylesheet" type="text/css"/>
        <style>

            fontcolor{
                color: red;
            }
/*            body{
                background-image: url('img/plainbackground.jpg');
                height: auto;
                width: auto;

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
        </style>
    </head>
    <body >
        <div id="central">
            <div class="content  ">
                <h1 class="fontcolor">Contact Form</h1>
                <p>Send your comments through this form and we will get back to
                    you.</p>
                <div id="message">
                    <form id="frmContact" name="frmContact" action="" method="POST"
                          novalidate="novalidate">
                        <div class="label">Name:</div>
                        <div class="field">
                            <input type="text" id="pp-name" name="name"
                                   placeholder="enter your name here" title="Please enter your name"
                                   class="required" aria-required="true" required>
                        </div>
                        <div class="label">Email:</div>
                        <div class="field">
                            <input type="text" id="pp-email" name="email"
                                   placeholder="enter your email address here"
                                   title="Please enter your email address" class="required email"
                                   aria-required="true" required>
                        </div>
                        <div class="label">Phone Number:</div>
                        <div class="field">
                            <input type="text" id="pp-phone" name="phone"
                                   placeholder="enter your phone number here"
                                   title="Please enter your phone number" class="required phone"
                                   aria-required="true" required>
                        </div>
                        <div class="label">Message:</div>
                        <div class="field">
                            <textarea id="about-project" name="message"
                                      placeholder="enter your message here"></textarea>
                        </div>
                        <div id="mail-status"></div>
                        <input type="submit" name="submit" value="Send Message"
                               id="send-message" style="clear: both;">
                        <%
                            if (null != message) {
                                out.println("<div class='" + status + "'>"
                                        + message + "</div>");
                            } else {

                            }
                        %>
                    </form>
                </div>
            </div>
            <!-- content -->
        </div>
        <!-- central -->
    </body>
</html>

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");

            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFile=user.getProfile();
            user.setProfile(imageName);

            //update database
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean ans = userDao.updateUser(user);
            if (ans) {

                String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();

//                delete file code
                  String pathOldFile = request.getRealPath("/") + "pics" + File.separator + oldFile;
                  if (!oldFile.equals("default.png")){
                      Helper.deleteFile(pathOldFile);
                  }
                

                if (Helper.saveFile(part.getInputStream(), path)) {
                    out.println("Profile updated....");
                    Message msg = new Message(("Profile details updated"), "success", "alert-success");

                    s.setAttribute("msg", msg);
                } else {

                     out.println("not updates...");
                 Message msg = new Message(("Something went wrong"), "error", "alert-danger");

                    s.setAttribute("msg", msg);
                }

            } else {
                out.println("not updates...");
                 Message msg = new Message(("Something went wrong"), "error", "alert-danger");

                    s.setAttribute("msg", msg);
            }

            response.sendRedirect("profile.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if (request != null && response != null) {
                processRequest(request, response);
            }
        } catch (NullPointerException e) {
            // Handle the exception or log it
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

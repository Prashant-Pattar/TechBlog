package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            int cid = Integer.parseInt(request.getParameter("cid"));
            String pTitle = request.getParameter("pTitle");
            String pContent = request.getParameter("pContent");
            String pCode = request.getParameter("pCode");
            Part part = request.getPart("pic");
            //getting current user id
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            
//            out.println(pTitle);
//            out.println(part.getSubmittedFileName());
            
            Post p =new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cid, user.getId());
            PostDao dao=new PostDao((ConnectionProvider.getConnection()));
            if (dao.savePost(p)){
                
                
                 String path = request.getRealPath("/") + "blog_pics" + File.separator + part.getSubmittedFileName();
                 Helper.saveFile(part.getInputStream(), path);
                 out.println("done");
                
            }else{
                out.println("error");
            }
            
            
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
        processRequest(request, response);
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

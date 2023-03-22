package com.techblog.dao;

import com.techblog.entities.Category;
import com.techblog.entities.Post;
import static java.nio.file.Files.list;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import static java.util.Collections.list;
import java.util.List;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
//       
        ArrayList<Category> list = new ArrayList<>();

        try {

            String q = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(q);
            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public boolean savePost(Post p){
        boolean f = false;
        try{
            
            String q="insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();
            f=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return f;
    }
    
//    get all post function
    public List<Post> getAllPosts(){
        List<Post> list = new ArrayList<>();
        //fetch all post
        try{
            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");
            ResultSet set = p.executeQuery();
            while(set.next()){
                int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp date=set.getTimestamp("pDate");
                int catId=set.getInt("catId");
                int userId=set.getInt("userId");
                Post post= new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
//    posts by category wise
    public List<Post> getPostByCatId(int catId){
        List<Post> list = new ArrayList<>();
        //fetch post by id
        
        try{
            PreparedStatement p = con.prepareStatement("select * from posts where catId=?");
            p.setInt(1, catId);
            ResultSet set = p.executeQuery();
            while(set.next()){
                int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp date=set.getTimestamp("pDate");
                
                int userId=set.getInt("userId");
                Post post= new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    public Post getPostByPostId(int postId){
        Post post =null;
        String q="select * from posts where pid=?";
        try{
        PreparedStatement p=this.con.prepareStatement(q);
        p.setInt(1, postId);
        
        ResultSet set= p.executeQuery();
        if(set.next()){
            
             int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp date=set.getTimestamp("pDate");
                int cid = set.getInt("catId");
                
                int userId=set.getInt("userId");
                 post= new Post(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
            
        }
        
        }catch(Exception e){
            e.printStackTrace();
        }
        return post;
    }
    
}

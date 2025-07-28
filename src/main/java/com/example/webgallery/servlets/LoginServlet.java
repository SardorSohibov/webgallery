package com.example.webgallery.servlets;

import com.example.webgallery.dao.UserDao;
import com.example.webgallery.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    UserDao userDao = UserDao.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        Optional<User> user = userDao.getUser(username);
        if (user.isPresent() && user.get().getPassword().equals(password)) {
            User newUser = user.get();
            req.getSession().setAttribute("userId", newUser.getId());
            req.getSession().setAttribute("username", newUser.getUsername());
            resp.sendRedirect("/allfolders.jsp");
        } else {
            req.setAttribute("error", "invalid username or password");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}

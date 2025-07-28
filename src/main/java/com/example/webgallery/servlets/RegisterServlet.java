package com.example.webgallery.servlets;

import com.example.webgallery.dao.UserDao;
import com.example.webgallery.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Objects;
import java.util.Optional;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDao userDao = UserDao.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        Optional<User> user = userDao.getUser(username);
        if (user.isPresent()) {
            req.setAttribute("error", "username already exists");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } else if (!Objects.equals(password, confirmPassword)) {
            req.setAttribute("error", "passwords do not match");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } else {
            User newUser = new User(username, password);
            req.getSession().setAttribute("userId", newUser.getId());
            req.getSession().setAttribute("username", newUser.getUsername());
            userDao.addUser(newUser);
            resp.sendRedirect("/allfolders.jsp");
        }
    }
}

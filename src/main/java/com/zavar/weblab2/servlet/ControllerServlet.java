package com.zavar.weblab2.servlet;

import java.io.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "controller-servlet", value = "/main")
public class ControllerServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setCharacterEncoding("UTF-8");
        String x = request.getParameter("x");
        String y = request.getParameter("y");
        String r = request.getParameter("r");
        if (x == null || y == null || r == null) {
            String path = "/jsp/form.jsp";
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher(path);
            requestDispatcher.forward(request, response);
        } else {
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/areacheck-servlet");
            rd.forward(request, response);
        }
    }
}
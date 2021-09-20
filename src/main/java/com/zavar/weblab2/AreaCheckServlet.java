package com.zavar.weblab2;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "areacheck-servlet", value = "/areacheck-servlet")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String x = req.getParameter("x");
        String y = req.getParameter("y");
        String r = req.getParameter("r");
        ServletContext servletContext = getServletContext();
        if (servletContext.getAttribute("par") == null) {
            servletContext.setAttribute("par", new ArrayList<String[]>());
        }
        ArrayList<String[]> parList = (ArrayList<String[]>) servletContext.getAttribute("par");
        parList.add(new String[]{x, y, r});

        resp.getWriter().println("Результаты:");
        for (String[] pars : parList) {
            resp.getWriter().println("<br>");
            resp.getWriter().println(pars[0]);
            resp.getWriter().println(pars[1]);
            resp.getWriter().println(pars[2]);
        }
    }
}

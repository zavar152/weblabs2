package com.zavar.weblab2.servlet;

import com.zavar.weblab2.hit.HitResult;
import com.zavar.weblab2.hit.Point;

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        float x = Float.parseFloat(req.getParameter("x"));
        float y = Float.parseFloat(req.getParameter("y"));
        float r = Float.parseFloat(req.getParameter("r"));
        ServletContext servletContext = getServletContext();
        if (servletContext.getAttribute("par") == null) {
            servletContext.setAttribute("par", new ArrayList<HitResult>());
        }
        ArrayList<HitResult> resultsList = (ArrayList<HitResult>) servletContext.getAttribute("par");

        String error = "";
        if (x == -3 || x == -2 || x == -1 || x == 0 || x == 1 || x == 2 || x == 3 || x == 4 || x == 5) {
            if (y >= -3 && y <= 5) {
                if (r == 1 || r == 1.5 || r == 2 || r == 2.5 || r == 3) {
                    resultsList.add(new HitResult(new Point(x, y), r));
                } else {
                    error = "Выберите корректное значение R";
                }
            } else {
                error = "Введите корректное значение Y (-3..5)";
            }
        } else {
            error = "Выберите корректное значение X";
        }

        resp.getWriter().println("Результаты:");
        if(!error.isEmpty())
            resp.getWriter().println("<br><label class=\"error\">" + error + "</label>");
        StringBuilder table = new StringBuilder("<table border=\"1\"> <tr> <th> X </th> <th> Y </th> <th> R </th> <th> Результат </th> </tr>");
        for (HitResult hitResult : resultsList) {
            if(hitResult.getResult()) {
                table.append("<tr> <th>").append(hitResult.getX()).append("</th> <th>").append(hitResult.getY()).append("</th> <th>").append(hitResult.getR()).append("</th> <th>").append("<font color=\"chartreuse\">Да</font>").append("</th> </tr>");
            } else {
                table.append("<tr> <th>").append(hitResult.getX()).append("</th> <th>").append(hitResult.getY()).append("</th> <th>").append(hitResult.getR()).append("</th> <th>").append("<font color=\"crimson\">Нет</font>").append("</th> </tr>");
            }
        }
        table.append("</table>");
        resp.getWriter().println(table);
    }
}
<%@ page import="com.zavar.weblab2.hit.HitResult" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Web Lab 2</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css"/>
</head>
<body>
<div id="blocks">
    <div id="head">
			<span class="title">Абузов Ярослав Александрович, P3230 <br>Вариант:
				30301
			</span>
    </div>

    <div id="res">
        <%
            out.println("Результат:");
            if (application.getAttribute("par") != null) {
                ArrayList<HitResult> resultsList = (ArrayList<HitResult>) application.getAttribute("par");
                StringBuilder table = new StringBuilder();
                table.append("<table border=\"1\"> <tr> <th> X </th> <th> Y </th> <th> R </th> <th> Результат </th> </tr>");
                HitResult hitResult = resultsList.get(resultsList.size()-1);
                    if(hitResult.getResult()) {
                        table.append("<tr> <th>").append(hitResult.getX()).append("</th> <th>").append(hitResult.getY()).append("</th> <th>").append(hitResult.getR()).append("</th> <th>").append("<font color=\"chartreuse\">Да</font>").append("</th> </tr>");
                    } else {
                        table.append("<tr> <th>").append(hitResult.getX()).append("</th> <th>").append(hitResult.getY()).append("</th> <th>").append(hitResult.getR()).append("</th> <th>").append("<font color=\"crimson\">Нет</font>").append("</th> </tr>");
                    }
                table.append("</table>");
                out.println(table.toString());
            }
        %>
        <br>
        <form action="${pageContext.request.contextPath}/jsp/form.jsp">
            <button class="glow-on-hover" type="submit">Назад</button>
        </form>
    </div>

</div>
</body>
</html>

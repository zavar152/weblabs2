<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.zavar.weblab2.hit.HitResult" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Web Lab 2</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css"/>
</head>
<body>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('#calcForm').submit(function (e) {
            e.preventDefault();
            var m_method = $(this).attr('method');
            var m_action = $(this).attr('action');
            var m_data = $(this).serialize();
            $.ajax({
                type: m_method,
                url: m_action,
                data: m_data,
                success: function (result) {
                    if (result.includes('html')) {
                        document.open();
                        document.write(result);
                        document.close();
                    } else {
                        $('#result').html(result);
                    }
                }
            });
        });
    });
</script>


<div id="blocks">
    <div id="head">
			<span class="title">Абузов Ярослав Александрович, P3230 <br>Вариант:
				30301
			</span>
    </div>

    <div id="user">
        <form name="inForm" action="${pageContext.request.contextPath}/main" method="GET" id="calcForm">
            Выберите X:
            <label class="x"><input type="radio" name="x" value="-3" required>-3</label>
            <label class="x"><input type="radio" name="x" value="-2" required>-2</label>
            <label class="x"><input type="radio" name="x" value="-1" required>-1</label>
            <label class="x"><input type="radio" name="x" value="0" required>0</label>
            <label class="x"><input type="radio" name="x" value="1" required>1</label>
            <label class="x"><input type="radio" name="x" value="2" required>2</label>
            <label class="x"><input type="radio" name="x" value="3" required>3</label>
            <label class="x"><input type="radio" name="x" value="4" required>4</label>
            <label class="x"><input type="radio" name="x" value="5" required>5</label>
            <br>
            Введите Y:
            <label>
                <input type="text" class="y" placeholder="-3..5" size="2" name="y" pattern="(?=.)([+-]?(?=[\d\.])(\d*)(\.(\d+))?)" required>
            </label>
            <br>
            Выберите R:
            <label class="r"><input type="checkbox" name="r" value="1" onclick="resetCheckBox(this)">1</label>
            <label class="r"><input type="checkbox" name="r" value="1.5" onclick="resetCheckBox(this)">1.5</label>
            <label class="r"><input type="checkbox" name="r" value="2" onclick="resetCheckBox(this)">2</label>
            <label class="r"><input type="checkbox" name="r" value="2.5" onclick="resetCheckBox(this)">2.5</label>
            <label class="r"><input type="checkbox" name="r" value="3" onclick="resetCheckBox(this)">3</label>
            <br><br>
            <button class="glow-on-hover" type="submit" id="submit" onclick="return check()">Отправить</button>
            <button class="glow-on-hover" type="reset" onclick="resetArea()">Сброс формы</button>
            <button class="glow-on-hover" type="reset" onclick="resetAll()">Сброс графика</button>
            <br><br>
            <label><input type="checkbox" name="tz" checked="checked">Выполнять ТЗ</label>
        </form>
    </div>

    <div id="graphFrame">
        <div id="graphFrameInner">
            <div id="graphScroll">
                <div id="graphHeight">
                    <canvas id="graph" height="320" width="320"></canvas>
                    <canvas id="area" height="320" width="320"></canvas>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/graph.js"></script>
    <div id="resFrame">
        <div id="result">
            <script>draw();clickSetup("${pageContext.request.contextPath}");</script>
            <%
                out.println("Результаты:");
                if (application.getAttribute("par") != null) {
                    ArrayList<HitResult> resultsList = (ArrayList<HitResult>) application.getAttribute("par");
                    StringBuilder table = new StringBuilder();
                    table.append("<table border=\"1\"> <tr> <th> X </th> <th> Y </th> <th> R </th> <th> Результат </th> </tr>");
                    for (HitResult hitResult : resultsList) {
                        if(hitResult.getResult()) {
                            table.append("<tr> <th>").append(hitResult.getX()).append("</th> <th>").append(hitResult.getY()).append("</th> <th>").append(hitResult.getR()).append("</th> <th>").append("<font color=\"chartreuse\">Да</font>").append("</th> </tr>");
                        } else {
                            table.append("<tr> <th>").append(hitResult.getX()).append("</th> <th>").append(hitResult.getY()).append("</th> <th>").append(hitResult.getR()).append("</th> <th>").append("<font color=\"crimson\">Нет</font>").append("</th> </tr>");
                        }
                    }
                    table.append("</table>");
                    out.println(table.toString());
                }
            %>
            <script>
                <c:forEach items="${pageContext.servletContext.getAttribute(\"par\")}" var="results">
                    drawFromContext(${results.getX()}, ${results.getY()})
                </c:forEach>

                function drawFromContext(x, y) {
                    drawDot(x * kf + offset, -y * kf + offset, "#ce49f3", 3);
                }

            </script>
        </div>
    </div>

    <div id="footer">
			<span class="itmo">Национальный исследовательский университет
				ИТМО, 2021г</span>
    </div>
</div>

</body>
</html>
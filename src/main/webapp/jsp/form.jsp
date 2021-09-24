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
            e.preventDefault(); //отменяем стандартное действие при отправке формы
            var m_method = $(this).attr('method'); //берем из формы метод передачи данных
            var m_action = $(this).attr('action'); //получаем адрес скрипта на сервере, куда нужно отправить форму
            var m_data = $(this).serialize(); //получаем данные, введенные пользователем в формате input1=value1&input2=value2...,то есть в стандартном формате передачи данных формы
            $.ajax({
                type: m_method,
                url: m_action,
                data: m_data,
                success: function (result) {
                    $('#result').html(result);
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
                <input type="text" class="y" placeholder="-3..5" size="2" name="y" pattern="-[1-3]|0|[1-5]" required>
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
            <script>draw();clickSetup();</script>
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
                    for (HitResult hitResult : resultsList) {
                        table.append("<script type=\"text/javascript\"> drawDot(").append(hitResult.getX()).append("* kf + offset, ").append(-hitResult.getY()).append("* kf + offset, \"#ce49f3\", 3); </script>");
                    }
                    out.println(table.toString());
                }
            %>
        </div>
    </div>

    <div id="footer">
			<span class="itmo">Национальный исследовательский университет
				ИТМО, 2021г</span>
    </div>
</div>

<script>

    var request = new XMLHttpRequest();

    function drawDotAtClick(event) {
        var rect = canvas.getBoundingClientRect();
        var x = event.clientX - rect.left;
        var y = event.clientY - rect.top;

        drawDot(x, y, "#ce49f3", 3);
        let body = "x=" + (x / kf - (div / 2)) + "&y=" + -(y / kf - (div / 2)) + "&r=" + radiusGlobal;

        var m_method = "GET";
        var m_action = "${pageContext.request.contextPath}/main";
        $.ajax({
            type: m_method,
            url: m_action,
            data: body,
            success: function (result) {
                $('#result').html(result);
            }
        });
    }

</script>

</body>
</html>
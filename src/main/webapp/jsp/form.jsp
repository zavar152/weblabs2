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
<body onload="draw();">
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
            <button class="glow-on-hover" type="reset">Сброс</button>
        </form>
    </div>

    <div id="graphFrame">
        <canvas id="graph"> </canvas>
    </div>

    <div id="resFrame">
        <div id="result">
            <%
                out.println("Результаты:");
                if (application.getAttribute("par") != null) {
                    ArrayList<HitResult> resultsList = (ArrayList<HitResult>) application.getAttribute("par");
                    StringBuilder table = new StringBuilder("<table border=\"1\"> <tr> <th> X </th> <th> Y </th> <th> R </th> <th> Результат </th> </tr>");
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
        </div>
    </div>

    <div id="footer">
			<span class="itmo">Национальный исследовательский университет
				ИТМО, 2021г</span>
    </div>
</div>

<script type="text/javascript">

    function draw() {
        const canvas = document.getElementById('graph');
        canvas.height = canvas.width;
        const ctx = canvas.getContext('2d');
        ctx.strokeRect(0, 0, canvas.height, canvas.width);
        ctx.beginPath();
        ctx.moveTo(canvas.width/2, 0);
        ctx.lineTo(canvas.width/2, canvas.height);
        ctx.closePath();
        ctx.stroke();

        ctx.beginPath();
        ctx.moveTo(0, canvas.height/2);
        ctx.lineTo(canvas.width, canvas.height/2);
        ctx.closePath();
        ctx.stroke();

        $("#graph").click(function(e){
            getPosition(e);
        });

        var pointSize = 3;

        function getPosition(event){
            var rect = canvas.getBoundingClientRect();
            var x = event.clientX - rect.left;
            var y = event.clientY - rect.top;

            drawCoordinates(x*1.6,y*1.6);
        }

        function drawCoordinates(x,y){
            ctx.fillStyle = "#ff2626"; // Red color

            ctx.beginPath();
            ctx.arc(x, y, pointSize, 0, Math.PI * 2, true);
            ctx.fill();
        }
    }

    let k;

    function resetCheckBox(element) {
        document.getElementsByName('r').forEach((value) => {
            k = value.value;
            if (!value.isEqualNode(element) && value.checked) {
                value.checked = !value.checked;
            }
        });
    }

    function check() {
        const r = k;//document.forms["inForm"]["r"].value;
        const x = document.forms["inForm"]["x"].value;
        const y = document.forms["inForm"]["y"].value;

        if (!isNaN(x) && (x == -3 || x == -2 || x == -1 || x == 0 || x == 1 || x == 2 || x == 3 || x == 4 || x == 5)) {

        } else {
            alert("Выберите корректное значение X");
            return false;
        }

        if (!isNaN(y) && (y >= -3 && y <= 5)) {

        } else {
            alert("Введите корректное значение Y (-3..5)");
            return false;
        }

        if (!isNaN(r) && (r == 1 || r == 1.5 || r == 2 || r == 2.5 || r == 3)) {

        } else {
            alert("Выберите корректное значение R");
            return false;
        }

        return true;
    }
</script>

</body>
</html>
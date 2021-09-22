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
            <button class="glow-on-hover" type="reset" onclick="resetArea()">Сброс формы</button>
            <button class="glow-on-hover" type="button" onclick="resetAll()">Сброс графика</button>
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

    <div id="resFrame">
        <div id="result">
            <%
                out.println("Результаты:");
                if (application.getAttribute("par") != null) {
                    ArrayList<HitResult> resultsList = (ArrayList<HitResult>) application.getAttribute("par");
                    StringBuilder table = new StringBuilder();
                    table.append("<script type=\"text/javascript\">\n" +
                            "\n" +
                            "    let canvas = document.getElementById('graph');\n" +
                            "    let ctx = canvas.getContext('2d');\n" +
                            "    let div = 12;\n" +
                            "    let kf = canvas.height/div;\n" +
                            "    let offset = canvas.height/2;" +
                            "    function drawDot(x, y, color, size){\n" +
                            "        ctx.fillStyle = color;\n" +
                            "        console.log('x: ' + x);\n" +
                            "        console.log('y: ' + y);\n" +
                            "\n" +
                            "        console.log('true x: ' + (x/kf-(div/2)));\n" +
                            "        console.log('true y: ' + -(y/kf-(div/2)));\n" +
                            "\n" +
                            "        ctx.beginPath();\n" +
                            "        ctx.arc(x, y, size, 0, Math.PI * 2, true);\n" +
                            "        ctx.fill();\n" +
                            "    }" +
                            "</script>");
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
                        table.append("<script type=\"text/javascript\"> drawDot(" + hitResult.getX() + "* kf + offset, " + -hitResult.getY() + "* kf + offset, \"#ce49f3\", 3); </script>");
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

<script type="text/javascript">

    canvas = document.getElementById('graph');
    ctx = canvas.getContext('2d');
    div = 12;
    kf = canvas.height/div;
    offset = canvas.height/2;
    const areaCanvas = document.getElementById('area');
    const areaCtx = areaCanvas.getContext('2d');

    function resetAll() {
        resetArea();
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        draw();
    }

    function resetArea() {
        radiusGlobal = undefined;
        areaCtx.clearRect(0, 0, areaCanvas.width, areaCanvas.height);
    }

    function drawArea(r) {
        console.log('Area r: ' + r);
        areaCtx.clearRect(0, 0, areaCanvas.width, areaCanvas.height);
        areaCtx.beginPath();
        areaCtx.moveTo(areaCanvas.width/2, areaCanvas.height/2);
        areaCtx.lineTo(areaCanvas.width/2, areaCanvas.height/2 - (r*kf));
        areaCtx.lineTo(areaCanvas.width/2 + (r*kf/2), areaCanvas.height/2 - (r*kf));
        areaCtx.lineTo(areaCanvas.width/2 + (r*kf/2), areaCanvas.height/2);
        areaCtx.lineTo(areaCanvas.width/2, areaCanvas.height/2);
        areaCtx.closePath();
        areaCtx.fillStyle = "#55c3e5";
        areaCtx.fill();

        areaCtx.beginPath();
        areaCtx.moveTo(areaCanvas.width/2, areaCanvas.height/2);
        areaCtx.lineTo(areaCanvas.width/2, areaCanvas.height/2 - (r*kf/2));
        areaCtx.lineTo(areaCanvas.width/2 - (r*kf/2), areaCanvas.height/2);
        areaCtx.lineTo(areaCanvas.width/2, areaCanvas.height/2);
        areaCtx.closePath();
        areaCtx.fillStyle = "#55c3e5";
        areaCtx.fill();

        let radians = (Math.PI/180)*90;
        areaCtx.beginPath();
        areaCtx.moveTo(areaCanvas.width/2, areaCanvas.height/2);
        areaCtx.lineTo(areaCanvas.width/2, areaCanvas.height/2);
        areaCtx.arc(areaCanvas.width/2, areaCanvas.height/2, (r*kf/2), 0, radians, false);
        areaCtx.lineTo(areaCanvas.width/2, areaCanvas.height/2);
        areaCtx.closePath();
        areaCtx.fillStyle = "#55c3e5";
        areaCtx.fill();
    }

    function draw() {
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

        ctx.beginPath();
        ctx.moveTo(canvas.width/2 + kf*5, canvas.height/2 - kf*5);
        ctx.lineTo(canvas.width/2 - kf*3, canvas.height/2 - kf*5);
        ctx.lineTo(canvas.width/2 - kf*3, canvas.height/2 + kf*3);
        ctx.lineTo(canvas.width/2 + kf*5, canvas.height/2 + kf*3);
        ctx.closePath();
        ctx.strokeStyle="#d02020";
        ctx.stroke();
        ctx.strokeStyle="#000000";

        drawDot(canvas.width/2, canvas.height/2, "#000000", 5);
        drawSegmentX(0, div);
        drawSegmentY(0, div);

        $("#graph").click(function(e){
            if (radiusGlobal === undefined) {
                alert("Выберите значение R");
            } else {
                drawDotAtClick(e);
            }
        });
    }

    function drawSegmentX(beginFromX, n) {
        ctx.font = "14px serif";
        for (let i = 0; i <= n; i++) {
            ctx.beginPath();
            ctx.moveTo(beginFromX + kf*i, (canvas.height/2) + 5);
            ctx.lineTo(beginFromX + kf*i, (canvas.height/2) - 5);
            ctx.closePath();
            ctx.stroke();
            if(Math.abs(i-div/2) !== div/2) {
                if (i - div / 2 == 0)
                    ctx.fillText(i - div / 2, beginFromX + kf * i + 5, (canvas.height / 2) + 15);
                else if (i - div / 2 < 0)
                    ctx.fillText(i - div / 2, beginFromX + kf * i + 3, (canvas.height / 2) + 15);
                else if (i - div / 2 > 0)
                    ctx.fillText(i - div / 2, beginFromX + kf * i + 1, (canvas.height / 2) + 15);
            }
        }
    }

    function drawSegmentY(beginFromY, n) {
        ctx.font = "14px serif";
        for (let i = 0; i <= n; i++) {
            ctx.beginPath();
            ctx.moveTo((canvas.height/2) - 5, kf*i);
            ctx.lineTo((canvas.height/2) + 5, kf*i);
            ctx.closePath();
            ctx.stroke();
            if(Math.abs(i-div/2) !== div/2)
            {
                if(i-div/2 < 0)
                    ctx.fillText(-(i-div/2), (canvas.height/2) + 10, beginFromY + kf*i + 3);
                else if(i-div/2 > 0)
                    ctx.fillText(-(i-div/2), (canvas.height/2) - 20, beginFromY + kf*i + 3);
            }
        }
    }

    var request = new XMLHttpRequest();

    function drawDotAtClick(event){
        var rect = canvas.getBoundingClientRect();
        var x = event.clientX - rect.left;
        var y = event.clientY - rect.top;

        drawDot(x, y, "#ce49f3", 3);
        let body = "x=" + (x/kf-(div/2)) + "&y=" + -(y/kf-(div/2)) + "&r=" + radiusGlobal;

            var m_method = "GET";
            var m_action = "${pageContext.request.contextPath}/main";
            var m_data = body;
            $.ajax({
                type: m_method,
                url: m_action,
                data: m_data,
                success: function (result) {
                    $('#result').html(result);
                }
            });
    }

    function drawDot(x, y, color, size){
        ctx.fillStyle = color;
        console.log('x: ' + x);
        console.log('y: ' + y);

        console.log('true x: ' + (x/kf-(div/2)));
        console.log('true y: ' + -(y/kf-(div/2)));

        ctx.beginPath();
        ctx.arc(x, y, size, 0, Math.PI * 2, true);
        ctx.fill();
    }

    var radiusGlobal;

    function resetCheckBox(element) {
        let reset = true;
        document.getElementsByName('r').forEach((value) => {
            if (!value.isEqualNode(element) && value.checked) {
                value.checked = !value.checked;
            }
            if(value.isEqualNode(element)) {
                radiusGlobal = value.value;
                drawArea(value.value);
                if(!value.checked) {
                    radiusGlobal = undefined;
                    resetArea();
                }
            }
        });
    }

    function check() {
        const r = radiusGlobal;//document.forms["inForm"]["r"].value;
        const x = document.forms["inForm"]["x"].value;
        const y = document.forms["inForm"]["y"].value;

        console.log('Got x: ' + x);
        console.log('Got y: ' + y);
        console.log('Got r: ' + r);

        if (x !== '' && !isNaN(x) && (x >= -3 && x <= 5)) {
            if (y !== '' && !isNaN(y) && (y >= -3 && y <= 5)) {
                if (!isNaN(r) && (r == 1 || r == 1.5 || r == 2 || r == 2.5 || r == 3)) {
                    drawDot(x * kf + offset, -y * kf + offset, "#ce49f3", 3);
                    return true;
                } else {
                    alert("Выберите корректное значение R");
                    return false;
                }
            } else {
                alert("Введите корректное значение Y (-3..5)");
                return false;
            }
        } else {
            alert("Выберите корректное значение X");
            return false;
        }
    }
</script>

</body>
</html>
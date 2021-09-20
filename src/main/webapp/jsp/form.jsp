<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Web Lab 2</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>

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
        <form name="inForm" action="${pageContext.request.contextPath}/controller-servlet" method="GET" id="calcForm">
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
                <input type="text" class="y" placeholder="-5..3" size="2" name="y" pattern="-[1-5]|0|[1-3]" required>
            </label>
            <br>
            Выберите R:
            <label class="r"><input type="checkbox" name="r" value="1" onclick="resetCheckBox(this)">1</label>
            <label class="r"><input type="checkbox" name="r" value="1.5" onclick="resetCheckBox(this)">1.5</label>
            <label class="r"><input type="checkbox" name="r" value="2" onclick="resetCheckBox(this)">2</label>
            <label class="r"><input type="checkbox" name="r" value="2.5" onclick="resetCheckBox(this)">2.5</label>
            <label class="r"><input type="checkbox" name="r" value="3" onclick="resetCheckBox(this)">3</label>
            <br> <input type="submit" id="submit" onclick="return check()">
        </form>
    </div>

    <div id="resFrame">
        <div id="result">
            <%
                out.println("Результаты:");
                ServletContext servletContext = application;
                if (servletContext.getAttribute("par") != null) {
                    ArrayList<String[]> parList = (ArrayList<String[]>) servletContext.getAttribute("par");
                    for (String[] pars : parList) {
                        out.println("<br>");
                        out.println(pars[0]);
                        out.println(pars[1]);
                        out.println(pars[2]);
                    }
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

    var k;

    function resetCheckBox(element) {
        document.getElementsByName('r').forEach((value) => {
            k = value.value;
            if (!value.isEqualNode(element) && value.checked) {
                value.checked = !value.checked;
            }
        });
    }

    function check() {
        var r = k;//document.forms["inForm"]["r"].value;
        var x = document.forms["inForm"]["x"].value;
        var y = document.forms["inForm"]["y"].value;

        if (!isNaN(x) && (x == -3 || x == -2 || x == -1 || x == 0 || x == 1 || x == 2 || x == 3 || x == 4 || x == 5)) {

        } else {
            alert("Выберите корректное значение X");
            return false;
        }

        if (!isNaN(y) && (y >= -5 && y <= 3)) {

        } else {
            alert("Введите корректное значение Y");
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
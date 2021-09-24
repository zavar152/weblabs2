canvas = document.getElementById('graph');
ctx = canvas.getContext('2d');
div = 12;
kf = canvas.height / div;
offset = canvas.height / 2;
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
    areaCtx.moveTo(areaCanvas.width / 2, areaCanvas.height / 2);
    areaCtx.lineTo(areaCanvas.width / 2, areaCanvas.height / 2 - (r * kf));
    areaCtx.lineTo(areaCanvas.width / 2 + (r * kf / 2), areaCanvas.height / 2 - (r * kf));
    areaCtx.lineTo(areaCanvas.width / 2 + (r * kf / 2), areaCanvas.height / 2);
    areaCtx.lineTo(areaCanvas.width / 2, areaCanvas.height / 2);
    areaCtx.closePath();
    areaCtx.fillStyle = "#55c3e5";
    areaCtx.fill();

    areaCtx.beginPath();
    areaCtx.moveTo(areaCanvas.width / 2, areaCanvas.height / 2);
    areaCtx.lineTo(areaCanvas.width / 2, areaCanvas.height / 2 - (r * kf / 2));
    areaCtx.lineTo(areaCanvas.width / 2 - (r * kf / 2), areaCanvas.height / 2);
    areaCtx.lineTo(areaCanvas.width / 2, areaCanvas.height / 2);
    areaCtx.closePath();
    areaCtx.fillStyle = "#55c3e5";
    areaCtx.fill();

    let radians = (Math.PI / 180) * 90;
    areaCtx.beginPath();
    areaCtx.moveTo(areaCanvas.width / 2, areaCanvas.height / 2);
    areaCtx.lineTo(areaCanvas.width / 2, areaCanvas.height / 2);
    areaCtx.arc(areaCanvas.width / 2, areaCanvas.height / 2, (r * kf / 2), 0, radians, false);
    areaCtx.lineTo(areaCanvas.width / 2, areaCanvas.height / 2);
    areaCtx.closePath();
    areaCtx.fillStyle = "#55c3e5";
    areaCtx.fill();
}

function draw() {
    ctx.strokeRect(0, 0, canvas.height, canvas.width);
    ctx.beginPath();
    ctx.moveTo(canvas.width / 2, 0);
    ctx.lineTo(canvas.width / 2, canvas.height);
    ctx.closePath();
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(0, canvas.height / 2);
    ctx.lineTo(canvas.width, canvas.height / 2);
    ctx.closePath();
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(canvas.width / 2 + kf * 5, canvas.height / 2 - kf * 5);
    ctx.lineTo(canvas.width / 2 - kf * 3, canvas.height / 2 - kf * 5);
    ctx.lineTo(canvas.width / 2 - kf * 3, canvas.height / 2 + kf * 3);
    ctx.lineTo(canvas.width / 2 + kf * 5, canvas.height / 2 + kf * 3);
    ctx.closePath();
    ctx.strokeStyle = "#d02020";
    ctx.stroke();
    ctx.strokeStyle = "#000000";

    drawDot(canvas.width / 2, canvas.height / 2, "#000000", 5);
    drawSegmentX(0, div);
    drawSegmentY(0, div);
}

function clickSetup(path) {
    $("#graph").click(function (e) {
        if (radiusGlobal === undefined) {
            alert("Выберите значение R");
        } else {
            drawDotAtClick(e, path);
        }
    });
}

function drawDotAtClick(event, path) {
    var rect = canvas.getBoundingClientRect();
    var x = event.clientX - rect.left;
    var y = event.clientY - rect.top;

    drawDot(x, y, "#ce49f3", 3);
    let body = "x=" + (x / kf - (div / 2)) + "&y=" + -(y / kf - (div / 2)) + "&r=" + radiusGlobal;

    var m_method = "GET";
    var m_action = path + "/main";
    $.ajax({
        type: m_method,
        url: m_action,
        data: body,
        success: function (result) {
            $('#result').html(result);
        }
    });
}

function drawSegmentX(beginFromX, n) {
    ctx.font = "14px serif";
    for (let i = 0; i <= n; i++) {
        ctx.beginPath();
        ctx.moveTo(beginFromX + kf * i, (canvas.height / 2) + 5);
        ctx.lineTo(beginFromX + kf * i, (canvas.height / 2) - 5);
        ctx.closePath();
        ctx.stroke();
        if (Math.abs(i - div / 2) !== div / 2) {
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
        ctx.moveTo((canvas.height / 2) - 5, kf * i);
        ctx.lineTo((canvas.height / 2) + 5, kf * i);
        ctx.closePath();
        ctx.stroke();
        if (Math.abs(i - div / 2) !== div / 2) {
            if (i - div / 2 < 0)
                ctx.fillText(-(i - div / 2), (canvas.height / 2) + 10, beginFromY + kf * i + 3);
            else if (i - div / 2 > 0)
                ctx.fillText(-(i - div / 2), (canvas.height / 2) - 20, beginFromY + kf * i + 3);
        }
    }
}

function drawDot(x, y, color, size) {
    ctx.fillStyle = color;
    console.log('x: ' + x);
    console.log('y: ' + y);

    console.log('true x: ' + (x / kf - (div / 2)));
    console.log('true y: ' + -(y / kf - (div / 2)));

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
        if (value.isEqualNode(element)) {
            radiusGlobal = value.value;
            drawArea(value.value);
            if (!value.checked) {
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
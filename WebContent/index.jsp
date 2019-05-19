<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>用WebSocket实时获知比特币价格</title>
</head>
<body>
    
    	<div style="width:400px;margin:20px auto;border:1px solid lightgray;padding:20px;text-align:center;">
    		当前比特币价格：￥<span style="color:#FF7519" id="price">10000</span>
    		<div style="font-size:0.9em;margin-top:20px">查看的人数越多，价格越高, 当前总共 <span id="total">1</span> 个人在线</div>    		
    		<div style="color:silver;font-size:0.8em;margin-top:20px">以上价格纯属虚构，如有雷同，so what？</div>

    	</div>
    
</body>

<script type="text/javascript">
    var websocket = null;
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/bitcoin/ws/bitcoinServer");

        //连接成功建立的回调方法
        websocket.onopen = function () {
            websocket.send("客户端链接成功");
        }

        //接收到消息的回调方法
        websocket.onmessage = function (event) {
            setMessageInnerHTML(event.data);
        }
        
        //连接发生错误的回调方法
        websocket.onerror = function () {
            alert("WebSocket连接发生错误");
        };

       //连接关闭的回调方法
        websocket.onclose = function () {
        	alert("WebSocket连接关闭");
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            closeWebSocket();
        }
        
    }
    else {
        alert('当前浏览器 Not support websocket')
    }




    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
    	var bitcoin = eval("("+innerHTML+")");
        document.getElementById('price').innerHTML = bitcoin.price;
        document.getElementById('total').innerHTML = bitcoin.total;
    }

    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();
    }
    
</script>
</html>
package com.how2java.bitcoin;



import java.io.IOException;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 * @ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
 * 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
 */
@ServerEndpoint("/ws/bitcoinServer")
public class BitCoinServer {
	
	//与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session session;

	@OnOpen
	public void onOpen(Session session){
		this.session = session;
		ServerManager.add(this);     
	}
	
	public void sendMessage(String message) throws IOException{
		this.session.getBasicRemote().sendText(message);
	}

	@OnClose
	public void onClose(){
		ServerManager.remove(this);  
	}


	@OnMessage
	public void onMessage(String message, Session session) {
		System.out.println("来自客户端的消息:" + message);
	}

	@OnError
	public void onError(Session session, Throwable error){
		System.out.println("发生错误");
		error.printStackTrace();
	}


}

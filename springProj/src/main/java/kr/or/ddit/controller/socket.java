package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class socket extends TextWebSocketHandler {
	//소켓에 연결한 클라이언트 목록
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	//특정 사용자를 찾기 위한 map
	//특정 사용자의 id 값으로 메시지를 보내기 위해 사용된다
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	//소켓연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//소켓이 연결되면 전체 세션 리스트에 세션을 추가시킨다
		sessions.add(session);
		
		//연결하려는 클라이언트의 세션에서 id값을 불러와 map에 id값으로 세션을 담는다
		Map<String, Object> sessionGet = session.getAttributes();
		String sessionId = (String) sessionGet.get("id");
		userSessionsMap.put(sessionId,session);
		
		//소켓 연결 시 저장된 세션 확인
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println(sessions);
		System.out.println(userSessionsMap);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	
	//소켓연결 해제
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//전체 세션리스트에서 연결을 해제하려는 세션을 지운다
		sessions.remove(session);
		
		//연결을 해제하려는 세션을 id값으로 찾아 map에서 지운다
		Map<String, Object> sessionGet = session.getAttributes();
		String sessionId = (String) sessionGet.get("id");
		userSessionsMap.remove(sessionId,session);
		
		//소켓 연결 해제 시 저장된 세션 확인
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println(sessions);
		System.out.println(userSessionsMap);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	
	//메시지를 받은 후 소켓에 전달
	//특정 대상에게 메시지를 전송하려면 대상의 id값을 메시지를 보낼때 같이 보낸 뒤
	//id를 이용하여 map에서 세션을 찾아 메시지를 전송하면 된다
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//받은 메시지를 String 값으로 받는다
		String msg = message.getPayload();
		
		//메시지를 ','로 나눠준다
		String[] msgs = msg.split(",");
		
		//메시지 전송대상이 all 이면 연결된 모든 소켓에 전송
		if(msgs[1].equals("all")) {
			for(int i=0; i<sessions.size(); i++) {
				TextMessage tmsg = new TextMessage(msgs[0]);
				sessions.get(i).sendMessage(tmsg);
			}
		//메시지 전송대상이 me 이면 나에게만 전송
		}else if(msgs[1].equals("me")) {
			//메시지를 받을 세션의 id값으로 map에서 세션값을 찾아 메시지를 전송한다
			Map<String, Object> sessionGet = session.getAttributes();
			String sessionId = (String) sessionGet.get("id");
			TextMessage tmsg = new TextMessage(msgs[0]);
			userSessionsMap.get(sessionId).sendMessage(tmsg);
		}
	}
}
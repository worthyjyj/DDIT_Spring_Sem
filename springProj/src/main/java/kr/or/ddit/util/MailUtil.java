package kr.or.ddit.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class MailUtil {
	
	/** 메일 HOST **/
	private static final String HOST = "smtp.naver.com";
	/** 메일 PORT **/
	private static final String PORT = "587";
	/** 메일 ID **/
	private static final String MAIL_ID = "dudwlsvldzm@naver.com";
	/** 메일 PW **/
	private static final String MAIL_PW = "asd1578910";
	
	public static void sendNotiMail(String subejct, String body) {
		try {
			System.out.println("메일에 왔다..");
			InternetAddress[] receiverList = new InternetAddress[1];
			receiverList[0] = new InternetAddress("astrapes4125@naver.com");
			
			// SMTP 발송 Properties 설정
			Properties props = new Properties();
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", MailUtil.HOST);
			props.put("mail.smtp.port", MailUtil.PORT);
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.trust", MailUtil.HOST);
			props.put("mail.smtp.auth", "true");
			
			// SMTP Session 생성
			Session mailSession = Session.getDefaultInstance(props, new javax.mail.Authenticator(){
				protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
					return new javax.mail.PasswordAuthentication(MAIL_ID, MAIL_PW);
				}
			});
			
			mailSession.setDebug(true);  // 디버그 모드 활성화
			
			// Mail 조립
			Message mimeMessage = new MimeMessage(mailSession);
			mimeMessage.setFrom(new InternetAddress(MAIL_ID));
			mimeMessage.setRecipients(Message.RecipientType.TO, receiverList);
            		// 메일 제목
			mimeMessage.setSubject("test");
            		// 메일 본문 (.setText를 사용하면 단순 텍스트 전달 가능)
			mimeMessage.setContent("test", "text/html; charset=UTF-8");
			
			System.out.println("메일발송 직전..");
			// Mail 발송
			Transport.send(mimeMessage);
			
			System.out.println("메일보내기 성공");
			
		} catch(Exception e) {
//			Logger.getLogger(MailUtil.class).error("메일 발송 오류!!");
		}
	}
}
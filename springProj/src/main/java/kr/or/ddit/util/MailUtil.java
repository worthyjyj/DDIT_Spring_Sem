package kr.or.ddit.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
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
    private static final String MAIL_PW = "asd1578910";  // 실제 비밀번호 또는 앱 비밀번호를 사용

    public static void sendNotiMail(String subject, String body) {
        try {
            System.out.println("메일에 왔다..");
            InternetAddress[] receiverList = new InternetAddress[1];
            receiverList[0] = new InternetAddress("astrapes4125@naver.com");

            // SMTP 발송 Properties 설정
            Properties props = new Properties();
            props.put("mail.transport.protocol", "smtp");
            props.put("mail.smtp.host", HOST);
            props.put("mail.smtp.port", PORT);
            props.put("mail.smtp.user", "dudwlsvldzm@naver.com");
            props.put("mail.smtp.password", "asd1578910");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.ssl.trust", HOST);
            props.put("mail.smtp.auth", "true");

            // 세션 생성 (사용자명과 비밀번호 설정)
            Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("dudwlsvldzm@naver.com", "asd1578910"); // 앱 비밀번호 사용
                }
            });

            mailSession.setDebug(true);  // 디버그 모드 활성화

            // Mail 조립
            Message mimeMessage = new MimeMessage(mailSession);
            mimeMessage.setFrom(new InternetAddress(MAIL_ID));
            mimeMessage.setRecipients(Message.RecipientType.TO, receiverList);
            mimeMessage.setSubject(subject);  // 인자로 받은 제목 사용
            mimeMessage.setContent(body, "text/html; charset=UTF-8");  // 인자로 받은 본문 사용

            System.out.println("메일발송 직전..");
            // Mail 발송
            Transport.send(mimeMessage);

            System.out.println("메일보내기 성공");

        } catch (Exception e) {
            e.printStackTrace();  // 오류 발생 시 로그 확인
            System.out.println("메일 발송 오류");
        }
    }
}

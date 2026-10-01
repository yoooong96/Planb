package service.email;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {

	/*
	 * Gmail 주소
	 *
	 * 절대 일반 비밀번호를 넣으면 안 되고 Google 앱 비밀번호를 사용해야 합니다.
	 */
	private static final String MAIL_USERNAME = "pink092000@gmail.com";

	private static final String MAIL_PASSWORD = "epkkzsqvsmxrvzii";

	public void sendVerificationCode(String receiverEmail, String verificationCode) throws Exception {

		Properties properties = new Properties();

		properties.put("mail.smtp.auth", "true");

		properties.put("mail.smtp.starttls.enable", "true");

		properties.put("mail.smtp.host", "smtp.gmail.com");

		properties.put("mail.smtp.port", "587");

		properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

		Session session = Session.getInstance(properties,

				new Authenticator() {

					@Override
					protected PasswordAuthentication getPasswordAuthentication() {

						return new PasswordAuthentication(MAIL_USERNAME, MAIL_PASSWORD);

					}

				});

		MimeMessage message = new MimeMessage(session);

		message.setFrom(new InternetAddress(MAIL_USERNAME, "Planb", "UTF-8"));

		message.setRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmail));

		message.setSubject("[Planb] 회원가입 이메일 인증번호", "UTF-8");

		String html =

				"<div style='" + "font-family:Arial,sans-serif;" + "max-width:520px;" + "margin:0 auto;"
						+ "padding:32px;" + "border:1px solid #e5e5ea;" + "'>"

						+ "<h2 style='" + "margin:0 0 18px;" + "color:#222;" + "'>" + "Planb 이메일 인증" + "</h2>"

						+ "<p style='" + "font-size:14px;" + "color:#555;" + "line-height:1.7;" + "'>"
						+ "회원가입을 계속하려면 아래 인증번호를 입력해주세요." + "</p>"

						+ "<div style='" + "margin:28px 0;" + "padding:20px;" + "background:#f6f6ff;"
						+ "text-align:center;" + "font-size:30px;" + "font-weight:bold;" + "letter-spacing:8px;"
						+ "color:#6369D1;" + "'>"

						+ verificationCode

						+ "</div>"

						+ "<p style='" + "font-size:12px;" + "color:#999;" + "'>" + "인증번호는 5분 동안 유효합니다." + "</p>"

						+ "</div>";

		message.setContent(html, "text/html; charset=UTF-8");

		Transport.send(message);

	}

}
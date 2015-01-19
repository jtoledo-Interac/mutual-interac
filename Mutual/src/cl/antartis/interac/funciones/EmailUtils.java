package cl.antartis.interac.funciones;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtils {
	private static String user = "";
	private static String password = "";
		
	public static Boolean sendMail(String to, String subject, String body, String signature){
		String out = "avegay";
        Properties props = ConfigUtils.getEmailProperties(out);
        user = ConfigUtils.loadProperties(out+"_user");
        password = ConfigUtils.loadProperties(out+"_password");
        
        System.out.println(user+" - "+ password
				+" - "+props.getProperty("mail.smtp.port")+" - "+props.getProperty("mail.smtp.host"));
        
        String message = body+"\n-- \n"+signature;
        
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        };
 
        Session session = Session.getInstance(props, auth);
        System.out.println("obtiene session");
        
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
        try{
        	msg.setFrom(new InternetAddress(user));
	        InternetAddress[] toAddresses = { new InternetAddress(to)};
	        msg.setRecipients(Message.RecipientType.TO, toAddresses);
	        msg.setSubject(subject);
	        msg.setSentDate(new Date());
	        msg.setText(message);
	        System.out.println("settea mensaje");
        }catch(Exception e){
        	e.printStackTrace();
        	return false;
        }
        // sends the e-mail
        try {
			Transport.send(msg);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
        return true;
	}
	
	
}

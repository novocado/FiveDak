package semiproject.dak.member.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator{

	@Override
    public PasswordAuthentication getPasswordAuthentication() {
      
       // Gmail 의 경우 @gmail.com 을 제외한 아이디만 입력한다.
       return new PasswordAuthentication("",""); 
       // "" 첫번째 아이디 "" 두번째는 웹비밀번호 
    }
	
	
}

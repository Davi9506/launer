package com.ez.launer.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.launer.user.model.DriverAllVO;
import com.ez.launer.user.model.UserAllVO;
import com.ez.launer.user.model.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class JoinController {
	private static final Logger logger
	=LoggerFactory.getLogger(JoinController.class);
	
	private final UserService userService;
	
	@GetMapping("/join")
	public void join_get(Model model) {
		logger.info("회원가입 화면");

		model.addAttribute("classNo", 1);
	}
	
	@PostMapping("/join")
	public String join_post(@ModelAttribute UserAllVO vo, Model model) {
		logger.info("일반회원가입 처리, 파라미터 vo={}", vo);

		int cnt=userService.insertUser(vo);
		logger.info("일반회원가입 결과, cnt={}", cnt);
		int cnt2=userService.insertAddress(vo);
		logger.info("주소입력 결과, cnt2={}", cnt2);
		
		String msg="회원가입 실패", url="/user/join";
		if(cnt>0 && cnt2>0) {
			msg="회원가입되었습니다.";
			url="/";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		/*
		logger.info("배송기사 회원가입 처리, 파라미터 vo={}", dVo);
		
		int cnt3=userService.insertDriver(dVo);
		logger.info("배송기사 회원가입 결과, cnt3={}", cnt3);
		
		int cnt4=userService.insertAccount(dVo);
		logger.info("주소입력 결과, cnt4={}", cnt4);

		String msg2="회원가입 실패", url2="/delivery/join";
		if(cnt>0 && cnt2>0) {
			msg2="회원가입되었습니다.";
			url2="/";
		}

		model.addAttribute("msg2", msg2);
		model.addAttribute("url2", url2);
		*/
		return "/common/message";
	}
	
	@RequestMapping("/checkEmail")
	public String checkEmail(@RequestParam String email, Model model) {
		logger.info("이메일 중복확인, 파라미터 email={}", email);

		int result=0;
		if(email!=null && !email.isEmpty()) {		
			result=userService.chkEmail(email);
	
			logger.info("이메일 중복확인 결과, result={}", result);
		}

		model.addAttribute("result", result);
		model.addAttribute("USABLE_EMAIL", userService.USABLE_EMAIL);
		model.addAttribute("UNUSABLE_EMAIL", userService.UNUSABLE_EMAIL);

		return "/user/checkEmail";
	}
	@RequestMapping("/checkHp")
	public String checkHp(@RequestParam String hp, Model model) {
		logger.info("휴대전화 번호 중복확인, 파라미터 hp={}", hp);
		
		int result=0;
		if(hp!=null && !hp.isEmpty()) {		
			result=userService.chkHp(hp);
			
			logger.info("휴대전화 번호 중복확인 결과, result={}", result);
		}
		
		model.addAttribute("result", result);
		model.addAttribute("USABLE_HP", userService.USABLE_HP);
		model.addAttribute("UNUSABLE_HP", userService.UNUSABLE_HP);
		
		return "/user/checkHp";
	}
}


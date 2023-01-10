function idCheck(id){
   regFrm.idbtncheck.value="idCheck";
   console.log(id);
   if(id == ""){
      alert("아이디를 입력하세요");
      regFrm.id.focus();
      return;
   }
   url = "idCheck.jsp?id=" + id; // id input에 공백이 아니면 실행
   window.open(url, "IDCheck", "width=350, height=200");
}
   
function inputIdChk(){ // 입력하면 inUncheck로 value를 줌
    regFrm.idbtncheck.value="idUncheck";
}

function signup() {

	let idReg = /^[a-z0-9]{,15}$/;
	let pwReg = /^[a-z0-9]{,15}$/;
	let emailReg = /^[a-z0-9]+@[a-z]+\.[a-z]+(\.[a-z]+)?$/;
	let phoneReg = /^[0,1]{3}-[\d]{3,4}-[\d]{4}$/;

	if(regFrm.idbtncheck.value == "idUncheck"){
         alert("아이디 중복확인을 해 주세요");
         return;
	}
	else if(!idReg.test(regFrm.id.value)) {
	     alert("아이디를 확인 해 주세요");
	     regFrm.id.focus();
	     return;
    }
    if(regFrm.pw.value == ""){
         alert("비밀번호를 입력하세요");
         regFrm.pwd.focus();
         return;
    }
	if(!pwReg.test(pw.value)) {
	     alert("비밀번호를 확인 해 주세요");
	     regFrm.pwd.focus();
	     return;
    }
    if(regFrm.cpw.value == ""){
         alert("비밀번호를 다시 입력하세요");
         regFrm.cpw.focus();
         return;
    }
    if(regFrm.pw.value != regFrm.cpw.value){
         alert("비밀번호가 일치하지 않습니다");
         regFrm.cpw.focus();
         return;
    }
    if(regFrm.name.value == ""){
         alert("이름을 입력하세요");
         regFrm.name.focus();
         return;
	}
    if(regFrm.email.value == ""){
         alert("이메일을 입력하세요");
         regFrm.email.focus();
		 return;
	}
	else if(!emailReg.test(email.value)) {
       	 alert("유효한 이메일 주소가 아닙니다");
      	 regFrm.email.focus();
		 return;
    }
  	if(regFrm.phone.value == ""){
	     alert("연락처를 입력하세요");
	     regFrm.phone.focus();
	     return;
	}
	if(!phoneReg.test(phone.value)) {
	     alert("유효한 전화번호가 아닙니다");
	     regFrm.phone.focus();
	     return;
    }

    regFrm.submit();
}
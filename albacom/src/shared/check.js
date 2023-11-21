// 전화번호 형식 맞는지 체크해주는 함수
export const phoneCheck = (phone) => {
  phone.value = phone.value.replace(/[^0-9]/g, '').replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
  let _reg = phone.value.replace(/[^0-9]/g, '').replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");

  return _reg.test(phone);
};


// 정규식으로 이메일 형식이 맞나 체크해주는 함수
export const emailCheck = (email) => {
    let _reg = /^[0-9a-zA-Z]([-_.0-9a-zA-Z])*@[0-9a-zA-Z]([-_.0-9a-zA-z])*.([a-zA-Z])*/;
  
    return _reg.test(email);
  };
  
  // 비밀번호 체크(8자-16자)
  export const pwdCheck = (pwd) => {
    let _reg = /^[!@#-_.*a-zA-z0-9].{7,16}$/;
  
    return _reg.test(pwd);
  };
  
  // 게시글작성 제목 글자수 제한(20자)
  export const titleCheck = (title) => {
    let _reg = /^.{1,20}$/;
  
    return _reg.test(title);
  };
  
  // 게시글작성 내용 글자수 제한(150자)
  export const contentCheck = (content) => {
    let _reg = /^.{1,150}$/;
  
    return _reg.test(content);
  };
  
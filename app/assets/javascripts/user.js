$(document).ready(function(){

    var email = $('#user_email'),

        password = $('#user_password'),
        passwordConfirmation = $('#user_password_confirmation'),
        passwordInputs = $('#user_password, #user_password_confirmation'),

        emailError = $('#email_error'),

        passwordConfError = $('#password_confirmation_error'),
        passwordValidate = $('#password_validate');

    $('.error').hide(); //에러메세지가 출력되는 span태그 숨기기



    //이메일 체크 - 이메일 포커스를 벗어났을 때 유효성 체크-----------------------------------------------
    function validateEmail(){
        var emailVal = email.val();
        var e = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/;

        if(!emailVal){ //'이메일' 빈칸체크
            emailError.show().text("필수정보 입니다.").addClass('red');
            email[0].parentNode.parentNode.style.borderColor = "#ff5a5f"; //input box색상 변경 (빨)
        }else if(!e.test(emailVal)){
            emailError.show().text("이메일 형식이 맞나요?").addClass('red');
            email[0].parentNode.parentNode.style.borderColor = "#ff5a5f"; //input box색상 변경 (빨)
            return false;
        }else{
            emailError.hide();
            email[0].parentNode.parentNode.style.borderColor = "#fff"; //input box색상 (흰)
            return true;
        }
    }

    //이메일 관련 함수호출
    email.blur(function(){
        validateEmail();
    });

    email.keyup(function(){ //입력값이 들어오면 '필수정보'안내 없앰
        var emailVal = email.val();
        if(emailVal){
            emailError.hide();
        }
    });


    //비밀번호 체크 - 키보드 칠 때 동적으로 체크---------------------------------------------------------
    function validatePassword(){
        var passwordVal = password.val();
        var passwordConfVal = passwordConfirmation.val();

        //이미 '비밀번호 확인'이 작성되어 있는 경우
        if(passwordConfVal){
            if(passwordVal.length >= 8) { //'비밀번호' 길이가 8이상일 때
                if (passwordVal === passwordConfVal) { //'비밀번호 확인'과 '비밀번호'가 같은경우
                    passwordConfError.text("일치").addClass('green');
                    passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#fff";
                } else {//'비밀번호 확인'과 '비밀번호'가 같지 않은 경우
                    passwordConfError.show().text("불일치").removeClass('green').addClass('red');
                    passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
                }
            }else{ //'비밀번호' 길이가 8이상이 아닐 때
                passwordConfError.hide();//'일치', '불일치'에 대한 안내는 하지 않는다 (8이상일 때만 함!)
            }

        }

        //길이가 1이상 8보다 작은경우
        if(passwordVal.length >= 1 && passwordVal.length < 8){
            passwordConfError.hide();
            passwordValidate.show().text("조금만 더! 비밀번호는 8자 이상이에요!").addClass('red');
            password[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
            return false;
        }else{ //1보다 작거나, 8보다 큰 경우
            passwordValidate.hide(); //"조금만 더! 비밀번호는 8자 이상이에요!" 메세지 사라짐
            password[0].parentNode.parentNode.style.borderColor = "#fff"; // 선색은 흰색
            return true;
        }

    }

    //비밀번호 관련 함수호출
    password.keyup(function(){ //키보드 칠 때 동적으로 작동(상단에 위치한 함수 호출)
        validatePassword();
    });

    password.focus(function(){ //비밀번호 확인에서 거꾸로 텝으로 넘어올 때를 대비함
        passwordValidate.hide();
        password[0].parentNode.parentNode.style.borderColor = "#fff";
    });

    passwordConfirmation.focus(function(){ //'비밀번호 확인'에 포커스가 잡히면, 에러메세지를 가린다
        passwordConfError.hide();
    });

    passwordConfirmation.blur(function(){ //'비밀번호 확인'에서 포커스를 벗어나고
        var passwordVal = password.val();
        var passwordConfVal = passwordConfirmation.val();

        if(passwordVal.length >= 8) { //비밀번호 길이가 8이상일 때만 동작
            if(passwordVal && !passwordConfVal) { //'비밀번호'는 있지만, '비밀번호 확인'이 비어있는 경우
                passwordConfError.show().text("불일치").removeClass('green').addClass('red'); //불일치 띄움
                passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
            }
        }else{ //비밀번호 길이가 8보다 작을 때
            passwordConfError.hide(); //'일치', '불일치' 가림
        }
    });


    //'비밀번호'와 '비밀번호 확인' 동시에 포커스 벗어난 경우
    passwordInputs.blur(function(){
        passwordVal = password.val();
        passwordConfVal = passwordConfirmation.val();
        passwordConfError.show();

        if(!passwordVal) {
            passwordConfError.hide();
            passwordValidate.show().text("필수정보 입니다.").addClass('red');
            password[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
        }

        if(passwordVal.length >= 8) { //비밀번호가 8이상일 때
            if (passwordVal === '') { //'비밀번호'가 빈칸이면
                passwordConfError.hide(); // '일치', '불일치'에 대한 안내 안함
            }else if (passwordVal === passwordConfVal) {
                passwordConfError.text("일치").addClass('green');
                passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#fff";
            }else {
                passwordConfError.show().text("불일치").removeClass('green').addClass('red');
                passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
            }
        }else{ //비밀번호가 8보다 작을 때
            passwordConfError.hide(); //'일치', '불일치'에 대한 안내는 하지 않는다
        }
    });


    //닉네임 체크 - 키보드 칠 때 동적으로 체크---------------------------------------------------------

}); //end document ready
$(document).ready(function(){
//변수정의
    var email = $('#user_email'),

        password = $('#user_password'),
        passwordConfirmation = $('#user_password_confirmation'),
        passwordInputs = $('#user_password, #user_password_confirmation'),

        emailError = $('#email_error'),

        passwordConfError = $('#password_confirmation_error'),
        passwordValidate = $('#password_validate'),

        nickname = $('#user_nickname'),
        nicknameError = $('#nickname_error'),

        emailCheck = $('#email_check'),
        nicknameCheck = $('#nickname_check'),

        universityCheck = false,
        majorCheck = false,

        newUserForm = $('#join_btn');

//전체적으로 적용될 코드
    $('.error').hide(); //에러메세지가 출력되는 span태그 숨기기

    //input에 focus가 왔을 때, css변경 (불투명 색상)
    $('.login_input').focusin(function(){
        $(this).addClass('focus');
    }).focusout(function() {
        $(this).removeClass('focus');
    });



//여기서부터 유효성 체크 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//이메일 체크-----------------------------------------------
    //이메일 함수정의
    function validateEmail(){
        var emailVal = email.val();
        var e = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/;

        if(!emailVal){ //'이메일' 빈칸체크
            emailError.show().text("필수정보 입니다.").addClass('red');
            email[0].parentNode.parentNode.parentNode.style.borderColor = "#ff5a5f"; //input box색상 변경 (빨)
            return false;
        }else if(!e.test(emailVal)){
            emailError.show().text("이메일 형식이 맞나요?").addClass('red');
            email[0].parentNode.parentNode.parentNode.style.borderColor = "#ff5a5f"; //input box색상 변경 (빨)
            return false;
        }else{ //빈칸도 아니고, 형식에 맞다면 '중복'/'ok' 체크
            var request =  $.ajax({
                url: "/check-email",
                method: "POST",
                data: {email: emailVal},
                dataType: "json"
            });
            request.success(function (result) {
                if(result.msg == "overlap"){
                    emailCheck.show().text('중복').removeClass('green').addClass('red');
                    //console.log(result.msg);
                    return false;
                }else if(result.msg == "ok"){
                    emailError.hide();
                    email[0].parentNode.parentNode.parentNode.style.borderColor = "#fff";
                    emailCheck.show().text('ok').addClass('green');
                    //console.log(result.msg);
                    return true;
                }
            });
        }
    }//이메일 함수 끝


    //이메일 함수호출
    email.blur(function(){
        validateEmail(); //반환값이 true이면 이메일 형식에 맞는 것
    });


    //이메일 예외사항 처리
    email.focus(function(){ //입력값이 들어오면 '필수정보'안내 없앰
        emailError.hide();
        email[0].parentNode.parentNode.parentNode.style.borderColor = "#fff";
        emailCheck.hide();
    });



//비밀번호 체크 ---------------------------------------------------------
    //비밀번호 함수정의
    function validatePassword(){ //키보드 칠 때 동적으로 체크
        var passwordVal = password.val();
        var passwordConfVal = passwordConfirmation.val();

        if(passwordConfVal){ //이미 '비밀번호 확인'이 작성되어 있는 경우
            if(passwordVal.length >= 8) { //'비밀번호' 길이가 8이상일 때
                if (passwordVal === passwordConfVal) { //'비밀번호 확인'과 '비밀번호'가 같은경우
                    passwordConfError.text("일치").addClass('green');
                    passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#fff";
                    return true;
                } else { //'비밀번호 확인'과 '비밀번호'가 같지 않은 경우
                    passwordConfError.show().text("불일치").removeClass('green').addClass('red');
                    passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
                }
            }else{ //'비밀번호' 길이가 8이상이 아닐 때
                passwordConfError.hide(); //'일치', '불일치'에 대한 안내는 하지 않는다 (8이상일 때만 함!)
            }
        }
        if(passwordVal.length >= 1 && passwordVal.length < 8){ //길이가 1이상 8보다 작은경우
            passwordConfError.hide();
            passwordValidate.show().text("조금만 더! 비밀번호는 8자 이상이에요!").addClass('red');
            password[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
        }else{ //1보다 작거나, 8보다 큰 경우
            passwordValidate.hide(); //"조금만 더! 비밀번호는 8자 이상이에요!" 메세지 사라짐
            password[0].parentNode.parentNode.style.borderColor = "#fff"; // 선색은 흰색
        }
    } //비밀번호 함수 1 끝

    function validatePasswordAndPasswordConf(){ //비밀번호와 비밀번호확인 포커스 벗어났을 때
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
                passwordConfError.hide(); //'일치', '불일치'에 대한 안내 안함
            }else if (passwordVal === passwordConfVal) {
                passwordConfError.text("일치").addClass('green');
                passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#fff";
                return true;
            }else {
                passwordConfError.show().text("불일치").removeClass('green').addClass('red');
                passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
            }
        }else{ //비밀번호가 8보다 작을 때
            passwordConfError.hide(); //'일치', '불일치'에 대한 안내는 하지 않는다
        }
    }//비밀번호 함수 2 끝


    //비밀번호 관련 함수호출
    password.keyup(function(){ //키보드 칠 때 동적으로 작동(상단에 위치한 함수 호출)
        validatePassword();
    });

    passwordInputs.blur(function(){ //'비밀번호'와 '비밀번호 확인' 동시에 포커스 벗어난 경우
        validatePasswordAndPasswordConf();
    });


    //비밀번호 예외사항 처리
    password.focus(function(){ //비밀번호에 포커스가 잡히면 에러메세지 없앰, 흰색 (비밀번호에서 거꾸로 탭할때의 버그 없애기 위함
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



//닉네임 체크--------------------------------------------------------
    //닉네임 함수정의
    function checkNickname(){ //포커스 벗어났을 때
        var nicknameVal = nickname.val();

        if(!nicknameVal){
            nicknameError.show().text("필수정보 입니다.").addClass('red');
            nickname[0].parentNode.parentNode.parentNode.style.borderColor = "#ff5a5f";
            return false;
        }else if(nicknameVal.length < 2 || nicknameVal.length > 8){
            nicknameError.show().text("닉네임은 2자 이상, 8자 이하에요!").addClass('red');
            nickname[0].parentNode.parentNode.parentNode.style.borderColor = "#ff5a5f";
            return false;
        }else{ //빈칸도 아니고, 닉네임의 길이 제한도 넘어간 경우 '중복'/'ok' 체크
            var request =  $.ajax({
                url: "/check-nickname",
                method: "POST",
                data: {nickname: nicknameVal},
                dataType: "json"
            });
            request.success(function (result) {
                if(result.msg == "overlap"){
                    nicknameCheck.show().text('중복').removeClass('green').addClass('red');
                    //console.log(result.msg);
                    return false;
                }else if(result.msg == "ok"){
                    nicknameError.hide();
                    nickname[0].parentNode.parentNode.parentNode.style.borderColor = "#fff";
                    nicknameCheck.show().text('ok').addClass('green');
                    //console.log(result.msg);
                    return true;
                }
            });
        }
    }//닉네임 함수 끝


    //닉네임 관련 함수 호출
    nickname.blur(function(){ //포커스를 벗어나면, 상단의 함수 실행
        checkNickname();
    });


    //닉네임 예외사항 처리
    nickname.focus(function(){ //input에 포커스가 잡히면 '필수정보입니다' 안내 보여주지 않기
        nicknameError.hide();
        nickname[0].parentNode.parentNode.parentNode.style.borderColor = "#fff";
        nicknameCheck.hide();

    });

    nickname.keyup(function(){ //입력값이 들어오면, 중복검사 메세지 삭제
        var nicknameVal = nickname.val();
        if(!nicknameVal) {
            nicknameError.hide();
            nickname[0].parentNode.parentNode.parentNode.style.borderColor = "#fff";
        }
    });



//대학교 및 전공 체크--------------------------------------------------------
    $('#user_university_id').change(function() { //대학교 체크여부 확인
        universityCheck = true;
        alert('대학선택!');
    });

    $('#user_major_id').change(function(){ //학과 체크여부 확인
        majorCheck = true;
        alert('전공선택!');
    });



//빈칸없이, 모든 유효조건이 맞는지 체크--------------------------------------------------------
    newUserForm.submit(function(){
        if(2>3){ //함수로 변경후 여기 조건 바꾸기
            return true;
        }else{
            return false;
        }
    });
}); //end document ready
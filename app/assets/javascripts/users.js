$(function() {
    //변수 설정
    var email = $('#user_email'),
        emailError = $('#email_error'),
        emailCheck = $('#email_check'),

        password = $('#user_password'),
        passwordConfirmation = $('#user_password_confirmation'),

        passwordCheck = $('#password_check'),
        passwordError = $('#password_error'),
        passwordInputs = $('#user_password, #user_password_confirmation'),

        nickname = $('#user_nickname'),
        nicknameError = $('#nickname_error'),
        nicknameCheck = $('#nickname_check'),

        university = $('#user_university_id'),
        univError = $('#university_error');

    //input에 focus가 왔을 때, css변경 (불투명 색상)
    $('.login_input').focusin(function(){
        $(this).addClass('focus');
    }).focusout(function() {
        $(this).removeClass('focus');
    });

    //이메일 중복확인-----------------------------------------
   email.focusout(function() {
        $.ajax({
          headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          },
          url: '/check_email',
          method: 'post',
          dataType: 'json',
          data: { email: email.val() },
          success: function(e){
              emailError.hide();
              emailCheck.show();
              emailCheck.text(e.message).removeClass('red').addClass('green');
              email[0].parentNode.parentNode.style.borderColor = "#fff";
          },
          error: function(e){
              emailCheck.hide();
              emailError.show();
              emailError.text(e.responseJSON.message).removeClass('green').addClass('red');
              email[0].parentNode.parentNode.style.borderColor = "#ff5a5f"; //input box색상 변경 (빨)
          }
        });
    });

    //비밀번호-----------------------------------------
    passwordInputs.focusout(function(){
        $.ajax({
            headers: {
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            url: '/check_password',
            method: 'post',
            data: { password: password.val(), password_confirmation: passwordConfirmation.val() },
            success: function(e){
                passwordError.hide();
                passwordCheck.show();
                password[0].parentNode.parentNode.style.borderColor = "#fff";
                passwordCheck.text(e.message).removeClass('red').addClass('green');
            },
            error: function(e){
                passwordCheck.hide();
                passwordError.show();
                passwordError.text(e.responseJSON.message).removeClass('green').addClass('red');
                password[0].parentNode.parentNode.style.borderColor = "#ff5a5f"; //input box색상 변경 (빨)
            }
        });
    });

    //닉네임 중복확인-----------------------------------------
    nickname.focusout(function(){
        $.ajax({
          headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          },
          url: '/check_nickname',
          method: 'post',
          data: { nickname: nickname.val() },
          success: function(e){
              nicknameError.hide();
              nicknameCheck.show();
              nickname[0].parentNode.parentNode.style.borderColor = "#fff";
              nicknameCheck.text(e.message).removeClass('red').addClass('green');
          },
          error: function(e){
              nicknameCheck.hide();
              nicknameError.show();
              nickname[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
              nicknameError.text(e.responseJSON.message).removeClass('green').addClass('red');
          }
        });
    });

    //대학교 체크--------------------------------------------------------
    //대학교 함수정의
    function validateUniversity(){
        if(university.val() === ""){
            univError.show().text("대학 선택해주세요.").addClass('red');
            university[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
        }else{//뭔가 선택되었다!
            univError.hide();
            university[0].parentNode.parentNode.style.borderColor = "#fff";
            return true;
        }
    }

    //대학교 함수실행
    university.blur(function(){
        validateUniversity();
    });

    //대학교 예외처리
    university.change(function() { //대학교 체크여부 확인
        univError.hide();
        university[0].parentNode.parentNode.style.borderColor = "#fff";
    });

});


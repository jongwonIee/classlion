$(function() {
    //변수 설정
    var email = $('#user_email'),
        emailError = $('#email_error'),
        emailCheck = $('#email_check'),



        password = $('#user_password'),
        passwordConfirmation = $('#user_password_confirmation'),

        passwordLengthError = $('#password_length_error'),
        passwordCheck = $('#password_check'),
        passwordError = $('#password_error'),
        passwordInputs = $('#user_password, #user_password_confirmation'),

        nickname = $('#user_nickname'),
        nicknameError = $('#nickname_error'),
        nicknameCheck = $('#nickname_check');

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
              email[0].parentNode.parentNode.style.borderColor = "#fff";
              emailCheck.text(e.message).removeClass('red').addClass('green');
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
            data: { password: password.val() },
            success: function(e){
                password[0].parentNode.parentNode.style.borderColor = "#fff";
                passwordCheck.text(e.message).removeClass('red').addClass('green');
                passwordError.hide();
            },
            error: function(e){
                passwordError.text(e.responseJSON.message).removeClass('green').addClass('red');
                password[0].parentNode.parentNode.style.borderColor = "#ff5a5f"; //input box색상 변경 (빨)
            }
        });
    });
    //일치여부
    // passwordConfirmation.focusout(function(){
    //     $.ajax({
    //         headers: {
    //             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    //         },
    //         url: '/check_pw_same',
    //         method: 'post',
    //         data: { password: password.val(), password_confirmation: passwordConfirmation.val() },
    //         success: function(e){
    //             passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#fff";
    //             passwordCheck.text(e.message)
    //         },
    //         error: function(e){
    //             passwordConfirmation[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
    //             passwordSameError.text(e.responseJSON.message).removeClass('green').addClass('red');
    //         }
    //     });
    // });

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
              nickname[0].parentNode.parentNode.style.borderColor = "#fff";
              nicknameCheck.text(e.message).removeClass('red').addClass('green');
          },
          error: function(e){
              nicknameCheck.hide();
              nickname[0].parentNode.parentNode.style.borderColor = "#ff5a5f";
              nicknameError.text(e.responseJSON.message).removeClass('green').addClass('red');
          }
        });
    });

});

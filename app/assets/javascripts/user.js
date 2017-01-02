$(document).ready(function(){
    var email = $('#user_email'),

        password = $('#user_password'),
        passwordConfirmation = $('#user_password_confirmation'),
        passwordInputs = $('#user_password, #user_password_confirmation'),

        emailError = $('#email_error'),

        passwordError = $('#password_error'),
        passwordConfError = $('#password_confirmation_error')

    $('span.error').hide(); //에러메세지가 출력되는 span태그 숨기기

    //이메일 체크
    function validateEmail(){
        var emailVal = email.val();
        var e = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/;
        if(!e.test(emailVal)){
            emailError.show().addClass('red');
            return false;
        }else{
            emailError.hide();
            return true;
        }
    }

    //비밀번호 체크
    function validatePassword(){
        var passwordVal = password.val();
        if(passwordVal.length < 8 || passwordVal.length > 32){
            passwordError.show().text("비밀번호는 8자 이상, 32자 이하 입니다").addClass('red');
            return false;
        }else{
            passwordError.hide();
            passwordConfError.hide();
            return true;
        }
    }

    //Validate input formats on Blur <<이거뭐징
    email.blur(function(){
        validateEmail();
    });

    password.blur(function(){
        validatePassword();
    });


    //password confirmation validation on Keyup and Blur
    passwordInputs.keyup(function(){
        passwordConfVal = passwordConfirmation.val();
        passwordVal = password.val();
        passwordConfError.show();
        if(passwordVal===''||passwordConfVal===''){
            passwordConfError.hide();
        }else if(passwordVal === passwordConfVal){
            passwordConfError.text("비번 일치!").addClass('green');
        }else{
            passwordConfError.hide();
            passwordConfError.text("비번 불일치!").removeClass('green').addClass('red');
            passwordConfError.show();
        }
    });

    passwordConfirmation.blur(function(){
        passwordConfVal = passwordConfirmation.val();
        passwordVal = password.val();
        passwordConfError.show().addClass('red');
        if(passwordVal===''||passwordConfVal===''){
            passwordConfError.hide();
        }else if(passwordVal === passwordConfVal){
            passwordConfError.text("비번 일치!").addClass('green');
        }
    });
}); //end document ready
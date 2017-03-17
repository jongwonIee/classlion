$(document).ready(function(){
    var sessionEmail = $('#session_email'),
        sessionPassword = $('#session_password');

//전체적으로 적용될 코드
    //input에 focus가 왔을 때, css변경 (불투명 색상)
    $('.login_input').focusin(function(){
        $(this).addClass('focus');
        //focus가 오면 error메세지를 가리고, 선색은 흰색
        $('#session_error_div div').hide();
        $('.remember_div').show(); //로그인 상태 유지 보이기
        sessionEmail[0].parentNode.parentNode.style.borderColor = "#fff";
        sessionPassword[0].parentNode.parentNode.style.borderColor = "#fff";

    }).focusout(function() {
        $(this).removeClass('focus');
    });
});
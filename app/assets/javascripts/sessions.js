$(document).ready(function(){

//전체적으로 적용될 코드
    //input에 focus가 왔을 때, css변경 (불투명 색상)
    $('.login_input').focusin(function(){
        $(this).addClass('focus');
    }).focusout(function() {
        $(this).removeClass('focus');
    });
});
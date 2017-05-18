$(function() {

  $("#user_email").focusout(function() {
    $.ajax({
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      url: '/check_email',
      method: 'post',
      dataType: 'json',
      data: { email: $("#user_email").val() },
      success: function(e){
        $("#email_error").text(e.message);
      },
      error: function(e){
        $("#email_error").text(e.responseJSON.message);
      }
    });
  });

  //요 아래는 user_email 보고 수정하셈ㅋ
  $("#user_nickname").focusout(function(){
    $.ajax({
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      url: '/check_nickname',
      method: 'post',
      data: { nickname: $("#user_nickname").val() },
      success: function(e){
        $("#email_error").text(e.message);
      },
      error: function(e){
        $("#email_error").text(e.responseJSON.message);
      }
    });
  });

});

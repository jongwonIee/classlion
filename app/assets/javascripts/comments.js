
$(function(){
    $('.reply_write_btn').click(function(){
        var eval_id = this.value;
        var comment_body = $('#comment_body' + eval_id);
        var comment_count = $('#comment_count' + eval_id);
        var list =  $('#comment_list'+eval_id);
        $.ajax({
            headers: {
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            url: '/evaluations/'+eval_id+'/comments',
            method: 'post',
            dataType: 'json',
            data: { body: comment_body.val(), evaluation_id: eval_id },
            success: function(e){
                // 댓글 달기
                var str =
                "<div class='bubble_content' id='comment_list_child" + e.comment + "'>" + e.nickname +
                "<span class='bubble_top_right'> 방금 전 " +
                "<span class='spot'>·</span><a href='#'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>" +
                "<span class='spot'>·</span> <a href='#'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" +
                "</span><br><p>" + e.body + "<br> </p> </div>";
                $('#comment_list'+eval_id).prepend(str);

                //댓글수 증가
                $(comment_count).html(parseInt($(comment_count).html(), 10)+1);

                //댓글창 지우고, 포커스 주기
                $(comment_body).focus();
                $(comment_body).val(' ');
            },
            error: function(e){
                alert(e.message);
            }
        });
        return false; //기존의 form_for submit을 막는 역할 없으면 두번 동작하므로 꼭 필요
    });
});

$(function(){
    $('.reply_write_btn').click(function(){
        var eval_id = this.value;
        var comment_body = $('#comment_body' + eval_id);
        var comment_count = $('#comment_count' + eval_id);

        $.ajax({
            headers: {
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            url: '/evaluations/'+eval_id+'/comments',
            method: 'post',
            dataType: 'json',
            data: { body: comment_body.val(), evaluation_id: eval_id },
            success: function(e){
                //댓글 달기가 여기서 이루워 지면 될 것 같고요
                // $("<%= escape_javascript(render @comment) %>").appendTo("#reply_list"+eval_id);
                $(comment_count).html(parseInt($(comment_count).html(), 10)+1);//댓글수 증가
                $(comment_body).focus();
                $(comment_body).val(' ');
                alert('hello');
            },
            error: function(e){
                alert('error');
            }
        });
        return false; //기존의 form_for submit을 막는 역할 없으면 두번 동작하므로 꼭 필요
    });
});
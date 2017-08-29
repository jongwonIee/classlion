
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
                "<div class='bubble_content' id='comment_list_child" + e.comment + "'>" + 
                "<div class='bubble_top'>" + 
                "<span class='bubble_top_left'>" + e.nickname + "</span>" +  
                "<span class='bubble_top_right'> 방금 전 " +
                "<span class='spot'>·</span> <a href='#'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" +
                "</span></div><p>" + e.body + "</p></div>";
                $('#comment_list_div'+eval_id).append(str);

                //댓글수 증가
                $(comment_count).html(parseInt($(comment_count).html(), 10)+1);

                //댓글창 지우고, 포커스 주기
                $(comment_body).focus();
                $(comment_body).val(' ');

                //댓글창이 접혀있을때는 펴주기
                var $target = $('#comment_list'+eval_id);
                if ($target.is(':visible') == false) {
                    $target.slideToggle(200, function () {
                        $target.show();
                    });
                }
            },
            error: function(e){
                alert(e.message);
            }
        });
        return false; //기존의 form_for submit을 막는 역할 없으면 두번 동작하므로 꼭 필요
    });

    //댓글리스트 보였다 안보였다
    $(".reply_btn").click(function(){
        var id = $(this).attr('id');
        var $target = $('#comment_list'+id);

        $target.slideToggle( 200, function () {
            $target.is(':visible') ? 'Hide' : 'Show';
        });
    });
});
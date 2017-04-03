$(document).ready(function(){

    function validNum(){
        var numVal = $('#order_credit_card_number').val();
        var number = numVal.replace(/[- ]/g, "");
        var total = 0;

        if(!numVal){ //값이 없을 때
            $("#credit_card_number_error").text("필수정보입니다.").addClass('red');
            return false;
        }else {
            for (var i = number.length - 1; i >= 0; i--) {
                var n = +number[i];
                if ((i + number.length) % 2 == 0) {
                    n = n * 2 > 9 ? n * 2 - 9 : n * 2;
                }
                total += n;
            };
            if(total % 10 == 0){
                $("#credit_card_number_error").text("");
                return true;
            }else{
                $("#credit_card_number_error").text("유효한 신용카드번호가 아닙니다!").addClass('red');
                return false;
            }
        }
    }

    $("#order_credit_card_number").keyup(function(){
        validNum();
    });

    // $("#order_credit_card_number").blur(function(){
    //     validNum();
    // });

    $('#new_order').submit(function(){
        if(validNum()){
            console.log('true');
            return true;
        }else{
            console.log('false');
            return false;
        }
    });
});
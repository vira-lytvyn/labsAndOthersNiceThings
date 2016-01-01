$(document).ready(function(){
    $("#resolve_btn").click(CalculateResult);
    $('.content input').keyup(CheckCorrectInputedNumber);
    $('#num').bind('input', function(){ShowInputs()});
});
function PossibilityForMultiplication(){
    var n1 = $("#n1").val();
    var n2 = $("#n2").val();
    if ((n1 !="") && (n2 !="") && n1 != n2){
        alert("Операція множення є неможливою");
        return false;
    }
    else {
        return true;
    }
}
function CheckCorrectInputedNumber(){
    var text = $(this).val();
    if ((text !="") && (!$.isNumeric(text))){
        alert("Введено некоректні дані");
    }
    else{
        if(text.indexOf(".") >= 0){
            alert("Розмірність матриці задається цілим числом");
        }
    }
    if (text == "0"){
        alert("Розмірність не може бути нульовою");
    }
}
function CalculateCountOfOperations(){

}
function CalculateResult(){
    if (($("#m").val()=="") || ($("#n1").val()=="") || ($("#n2").val()=="") || ($("#l").val()=="")){
        console.log("test");
        alert("Не введено розмірність матриці");
        return;
    }
    else{
        if (PossibilityForMultiplication()){
            $('#result_block').css('display', 'block');
            CalculateCountOfOperations();
        }
    }
}
var min_val = 2;
function ShowInputs(){
    var numerous = $('#num').val();
    if (numerous < min_val){
        $("#matrixs_block").appendChild("div").attr("id", 'matrix' + numerous);

        $("#matrixs_block").append('<div id="'+ 'matrix_' + numerous + '"><label>A"' + numerous + '"</label><input type="text" id="' + 'm_' + numerous + '"><input type="text" id="'+'n_' + numerous + '"></div>');
        min_val = numerous;
    }
    if (numerous > min_val){
        $("#matrixs_block").remove('<div id="'+ 'matrix_' + numerous + '"><label>A"' + numerous + '"</label><input type="text" id="' + 'm_' + numerous + '"><input type="text" id="'+'n_' + numerous + '"></div>');
        min_val = numerous;
    }
}
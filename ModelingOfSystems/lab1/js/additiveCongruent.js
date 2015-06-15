function additiveCongruent(c, b, count){
    var m = Math.pow(2, b);
    var result = [];
    result[0] = 0;
    result[1] = 1;
    for(var i = 2; i < count; i++){
        result[i] = (result[i-2] + result[i-1]) * c / m;
    }
    return result;
}
var additiveCongruentArray = additiveCongruent(7, 4, 200);

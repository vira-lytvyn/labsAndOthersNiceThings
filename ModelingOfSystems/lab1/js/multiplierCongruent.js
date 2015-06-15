function multiplierCongruent(a, b, x0, count){
    var m=Math.pow(2, b);
    var start = [],
        result = [],
        xArr = [];
    start[0] = (a * x0).toString(2);
    xArr[0] = start[0].substr(b, b);
    result[0] = parseInt(xArr[0], 2) / m;
    for(var i = 1; i < count; i++){
        start[i] = (a * ( parseInt( xArr[i-1], 2 ) ) ).toString(2);
        xArr[i] = start[i].substr(( start[i].length - b), b);
        result[i] = parseInt( xArr[i], 2) / m;
    }
    return result;
}
var multiplierCongruentArray = multiplierCongruent(5, 4, 7, 200);

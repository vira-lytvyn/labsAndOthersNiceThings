function mediumSquare(number, count){
    var n = number.toString().length;
    var randomValues = [];
    randomValues[0] = '' + number;
    var powValue;
    for (var i = 1; i < count; i++)
    {
        powValue = number * number;
        powValue = powValue.toString().length % 2 === 0 ? powValue = '' + powValue : powValue = '0' + powValue;
        randomValues[i] = ''+powValue.substr(n/2, n);
        number=powValue.substr(n/2,n);
    }
    return randomValues;
}
var mediumSquareArray = mediumSquare(10133, 200);


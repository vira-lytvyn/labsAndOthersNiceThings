function defaultRandom(count){
    var result = [];
    for(var i = 0; i < count; i++){
        result[i] = Math.random();
    }
    return result;
}
var defaultRandomArray = defaultRandom(200);

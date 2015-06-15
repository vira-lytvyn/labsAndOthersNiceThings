function squareCheck(counts, name, sizeOfSample, x2Ideal){
    var countOfIntervals = counts.length;
    var sampleFriquency = sizeOfSample / countOfIntervals;
    var x2Current = 0;
    for(var j = 0; j < 10; j++){
        if (counts[j] >=5 ) {
            x2Current += (Math.pow(counts[j] - sampleFriquency, 2) / sampleFriquency);
        } else {
            console.log('Sorry, square criteria could not be applied to ' + name + ' method.');
            return;
        }
    }
    console.log('Ho hypothesis ' + (x2Current > x2Ideal ? 'is rejected' : 'is confirmed') + ' for ' + name + ' method.');
}
var tableValue = 21.67;

function normalize(arr, countOfIntervals){
    var normalizedArray = [];
    var arrayOfCounts = [];
    var sortedArr = arr.slice(0, arr.length).sort();
    var min = sortedArr[0];
    var max = sortedArr[sortedArr.length-1];
    var intervalSize = (max - min) / countOfIntervals;
    for(var j = 1; j <= countOfIntervals; j++){
        var count = 0;
        for (var i = 0; i < arr.length; i++){
            if ((arr[i] > intervalSize * (j - 1)) && (arr[i] <= intervalSize * j)){
                count++;
            }
        }
        arrayOfCounts.push(count);
        normalizedArray.push((count/arr.length).toFixed(2));
    }
    console.log("Array of probability\n");
    console.log(normalizedArray);
    return arrayOfCounts;
}

console.log("Now we'll print data for building diagrams: \n");
console.log("\tAdditive Congruent\n");
console.log("Generated pseudo random values\n");
console.log(additiveCongruentArray);
var additiveCongruentFrequencies = normalize(additiveCongruentArray, 10);
squareCheck(additiveCongruentFrequencies, 'Additive Congruent', 200, tableValue);

console.log("\n\tDefault Random\n");
console.log("Generated pseudo random values\n");
console.log(defaultRandomArray);
var defaultRandomFrequencies = normalize(defaultRandomArray, 10);
squareCheck(defaultRandomFrequencies, 'Default Random', 200, tableValue);

console.log("\n\tMedium Square\n");
console.log("Generated pseudo random values\n");
console.log(mediumSquareArray);
var mediumSquareFrequencies = normalize(mediumSquareArray, 10);
squareCheck(mediumSquareFrequencies, 'Medium Square', 200, tableValue);

console.log("\n\tMixed Congruent\n");
console.log("Generated pseudo random values\n");
console.log(mixedCongruentArray);
var mixedCongruentFrequencies = normalize(mixedCongruentArray, 10);
squareCheck(mixedCongruentFrequencies, 'Mixed Congruent', 200, tableValue);


console.log("\n\tMultiplier Congruent\n");
console.log("Generated pseudo random values\n");
console.log(multiplierCongruentArray);
var multiplierCongruentFrequencies = normalize(multiplierCongruentArray, 10);
squareCheck(multiplierCongruentFrequencies, 'Multiplier Congruent', 200, tableValue);


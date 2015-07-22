var notAlphabeticalSymbol = '';

function cryptByVigenere(openString, codeString){
    openString = openString.replace(/\s+/g, "");
    codeString = codeString.replace(/\s+/g, "");
    if (openString.length !== codeString.length){
        codeString = improveKeyword(codeString, openString.length);
    }
    var result = "";
    var lOpenStr = openString.toLowerCase();
    var lCodeSrt = codeString.toLowerCase();
    var vMatrix = CreateVigenerMatrix(alphabet);
    for (var literalIndex = 0; literalIndex < codeString.length; literalIndex++){
        if ((alphabet.indexOf(lOpenStr.charAt(literalIndex)) < 0) && 
            (alphabet.indexOf(lCodeSrt.charAt(literalIndex)) < 0 )){
            result += notAlphabeticalSymbol;
            continue;
        }
        result += vMatrix[getIndex(lOpenStr[literalIndex])][getIndex(lCodeSrt[literalIndex])];
    }
    return result;
}

function decryptByVigenere(encryptedString, codeString){
    encryptedString = encryptedString.replace(/\s+/g, "");
    codeString = codeString.replace(/\s+/g, "");
    if (encryptedString.length !== codeString.length){
        codeString = improveKeyword(codeString, encryptedString.length);
    }
    var result = '';
    var lEncrStr = encryptedString.toLowerCase();
    var lCodeSrt = codeString.toLowerCase();
    var vMatrix = CreateVigenerMatrix(alphabet);
    for (var literalIndex = 0; literalIndex < codeString.length; literalIndex++){
        if ((alphabet.indexOf(lEncrStr.charAt(literalIndex)) < 0) &&
            (alphabet.indexOf(lCodeSrt.charAt(literalIndex)) < 0 )){
            result += notAlphabeticalSymbol;
            continue;
        }
        result += findStrFromCode(lEncrStr[literalIndex], getIndex(lCodeSrt[literalIndex]), vMatrix);
    }
    return result;
}

function CreateVigenerMatrix(alphabet){
    var limit = alphabet.length;
    var vigenerMatrix = [];
    for (var i = 0; i < limit; i++){
        var row = [];
        for (var j = 0; j < limit; j++){
            var index = j + i;
            if (index > limit - 1){
                index = index - limit;
            }
            row.push(alphabet[index]);
        }
        vigenerMatrix.push(row);
        console.log(row);
    }
    return vigenerMatrix;
}

function getIndex(literal){
    for(var i = 0; i < limit; i++){
        if (alphabet[i] === literal){
            return i;
        }
    }
}

function findStrFromCode(codedLiteral, codeIndex, vigenerMatrix){
    var result = '';
    for (var i = 0; i < limit; i++){
        if (vigenerMatrix[i][codeIndex] === codedLiteral){
            result = vigenerMatrix[i][0];
        }
    }
    return result;
}

function improveKeyword(key, length) {
    var keyLength = key.length;
    if (keyLength < length){
        while (keyLength < length){
            key += key;
            keyLength = key.length;
        }
        return key.substring(0, length);
    } else if (keyLength > length){
        return key.substring(0, length);
    }
}
//cryptByVigenere('this is test text', 'qwer yu opas fghj');
//decryptByVigenere('jdmjgmhtslykec', 'qwer yu opas fghj');
//cryptByVigenere('this is test text test test test text text text text text dsff s fsdg sfdg dfgsdfgd dfgfdgtrfgtfgdt', 'test word');
//decryptByVigenere('mlalegkhlxlxthkhlxlxohkhlxlxthkhqxlxthkhqxlxthuvyjkyorxvyhywbujgykvwbuwgzxjychwjw', 'test word');   mlalswragkwxbl
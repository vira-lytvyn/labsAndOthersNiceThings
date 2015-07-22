function cryptByTsezar(text, key){
    var encrypted = '',
        index = 0;
    text = text.toLowerCase();
    for(var i = 0; i < text.length; i++){
        index = alphabet.indexOf(text.charAt(i));
        if(index < 0){
            encrypted += notAlphabeticalSymbol;
            continue;
        }
        var newIndex = index + key;
        if (newIndex >= limit){
            newIndex -= limit;
        }
        encrypted += alphabet.charAt(newIndex);
    }
    return encrypted;
}
//console.log(cryptByTsezar('this is some TexT, just For Example', 0));
//console.log(cryptByTsezar('Examplea', 26));
//console.log(cryptByTsezar('vira', 3)); //ylud

function decryptByTsezar(text, key){
    var decrypted = '',
        index = 0;
    text = text.toLowerCase();
    for(var i = 0; i < text.length; i++){
        index = alphabet.indexOf(text.charAt(i));
        if(index < 0){
            decrypted += notAlphabeticalSymbol;
            continue;
        }
        var newIndex = index - key;
        if (newIndex >= limit){
            newIndex += limit;
        }
        decrypted += alphabet.charAt(newIndex);
    }
    return decrypted;
}
//console.log(decryptByTsezar('ylud', 3)); //vira
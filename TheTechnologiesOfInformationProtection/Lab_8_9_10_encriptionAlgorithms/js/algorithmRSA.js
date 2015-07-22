var alphabet = 'abcdefghijklmnopqrstuvwxyz';

function encryptTextByRSA(pPrime, qPrime, enterText){
    var result = [];
    var text = convertTextToCode(enterText);
    for (var i = 0; i < text.length; i++){
        result.push(encryptByRSA(pPrime, qPrime, text[i]));
    }
    return convertCodeToText(result);
}

function convertTextToCode(text){
    var code = [];
    for (var i = 0; i < text.length; i++){
        code.push(alphabet.indexOf(text.charAt(i))+1);
    }
    return code;
}
function convertCodeToText(code){
    var text = '';
    for (var i = 0; i < code.length; i++){
        text += alphabet.charAt(code[i] - 1);
    }
    return text;
}

function decryptTextByRSA(encryptedText, computedN, privateKey){
    var text = convertTextToCode(encryptedText);
    var result = [];
    for (var i = 0; i < text.length; i++){
        result.push(decryptByRSA(text[i], computedN, privateKey));
    }
    return convertCodeToText(result);
}
function encryptByRSA(pPrime, qPrime, enterText){
    var computedN = computeN(pPrime, qPrime);
    var fi  = computeFi(pPrime, qPrime);
    var openKey = getCoPrimeNumber(fi);
    var privateKey = getPrivateKey(openKey, fi);
    console.log("Private pair is ( ", privateKey, ', ', computedN, ' )');
    var cryptedText = expMod(enterText, openKey, computedN);
    return cryptedText;
}

function decryptByRSA(encryptedText, computedN, privateKey){
    var decryptedText = expMod(parseInt(encryptedText), privateKey, computedN);
    return decryptedText;
}

function computeN(q,p){
    return q * p;
}

function computeFi(q, p){
    return (p - 1) * (q - 1);
}

function getCoPrimeNumber(fi){
    for (var i = 2; i <= fi; i++){
        if (isPrime(i) && (fi % i !== 0)){
            return i;
        }
    }
    return 1;
}

function isPrime(num){
    if ((num === 1) || (num === 2)) {
        return true;
    }
    for (var i = 2; i < num; i++){
        if (num % i === 0){
            return false;
        }
    }
    return true;
}

function getPrivateKey(openKey, fi){
    var result = 0,
        founded = false,
        maxValue = (fi * openKey) + 1,
        i = 1;
    while ( !founded && i <= maxValue){
        if ( i >= maxValue) {
            result = maxValue;
            break;
        }
        if ( (i * openKey) % fi === 1) {
            founded = true;
            result = i;
            break;
        } else {
            i++;
        }
    }
    return result;
}

function expMod( base, exp, mod ){
    if (exp === 0) return 1;
    return Math.pow(base, exp) % mod;
}
//encryptByRSA(3557, 2579, 111111);
//console.log(encryptByRSA(3, 13, 4));
//console.log(decryptByRSA(10, 39, 5));
//console.log(encryptTextByRSA(3, 7, 'this is test message'));   thrjrjtqjtmqjjagq
//console.log(decryptTextByRSA('thrjrjtqjtmqjjagq', 21, 5));
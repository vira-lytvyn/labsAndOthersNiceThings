var operation =  prompt('Please, enter the code of action, you would like to do:' +
    '\n \t 1 - encrypt some text;\n \t 2 - decrypt some text;');
var method = prompt('Please, enter the code of algorithm, you would like to use:' +
    '\n \t 1 - Algorithm of Tzezar;\n \t 2 - Algorithm of Vijener;\n \t 3 - RSA');
var result = '';

var alphabet = 'abcdefghijklmnopqrstuvwxyz';
var notAlphabeticalSymbol = '*';

var limit = alphabet.length;

if (operation === '1' ){
    var text = prompt('Please enter the text for encryption');
    if (method === '1'){
        var key = parseInt(prompt('Please, enter the size of key to encrypt text with Tsezar algorithm.'));
        result = cryptByTsezar(text, key);
    }else if (method === '2'){
        var key = prompt('Please, enter the keyword to encrypt text with Vigenere algorithm.');
        result = cryptByVigenere(text, key);
    }else if (method === '3'){
        var p = prompt('Please, enter the prime number P to generate keys and encrypt text with RSA algorithm.');
        var q = prompt('Please, enter the prime number Q to generate keys and encrypt text with RSA algorithm.');
        result = encryptTextByRSA(p, q, text);
    }else{
        alert("Sorry, You enter an incorrect code of method. \n Please, reload this page to try again.");
    }
}else if (operation === '2'){
    var text = prompt('Please enter the text for decryption');
    if (method === '1'){
        var key = parseInt(prompt('Please, enter the size of key to decrypt text with Tsezar algorithm.'));
        result = decryptByTsezar(text, key);
    }else if (method === '2'){
        var key = prompt('Please, enter the keyword to decrypt text with Vigenere algorithm.');
        result = decryptByVigenere(text, key);
    }else if (method === '3'){
        var N = prompt('Please, enter the public part of secret key to decrypt text with RSA algorithm.');
        var privateKey = prompt('Please, enter the private part of secret key to decrypt text with RSA algorithm.');
        result = decryptTextByRSA(text, N, privateKey);
    }else{
        alert("Sorry, You enter an incorrect code of method. \n Please, reload this page to try again.");
    }
}else{
    alert("Sorry, You enter an incorrect code of operation. \n Please, reload this page to try again.");
}
alert('Result is : \n \n' + result);
console.log('Result is : \n \n' + result);
result = '';
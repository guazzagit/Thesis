
fs = require('fs');
var argument = process.argv
var Input=parseInt(argument[2]);
var Output=parseInt(argument[3]);
const lineReader = require('line-reader');
console.log("Reorder data...");
var fd = fs.openSync(Output,'a'); //per valore completto Dns23848289 per
console.log("Opening a new file..");
console.log("Start append");


lineReader.eachLine(Input, function(line,last) {
	var value = line.replace(/[\[\]]+/g,'');  //remove brackets
	//var value = line.replace(/[\]]+/g,',').replace(/[\[]+/g,'')  //remove brackets
	var stringArray = value.split(",{"); // divide 
	let text = stringArray.join('\n{')+"\n"; // new line and add the lost bracket
	console.log(text);
	fs.appendFile(fd, text, function(err) {

		if(err) {
		    return console.log(err);
		}
	});

});
//problema dell'ultima riga che non adnava a capo risolto conun \n messo strategico a linea 15

// altra versione tutta in sync

/*
fs = require('fs');
const readEachLineSync = require('read-each-line-sync')
const lineReader = require('line-reader');
console.log("Reorder data...");
var fd = fs.openSync("./data1Puliti.json",'a');
console.log("Opening a new file..");
console.log("Start append");
readEachLineSync('data1.json', function(line,last) {
	//var value = line.replace(/[\]]+/g,',').replace(/[\[]+/g,'')  //remove brackets
	var stringArray = line.split(",{"); // divide 
	let text = stringArray.join('\n{'); // new line and add the lost bracket

	fs.appendFileSync(fd, text, function(err) {

		if(err) {
		    return console.log(err);
		}
	});

});

*/
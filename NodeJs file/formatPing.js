
fs = require('fs');

const lineReader = require('line-reader');
console.log("Reorder data...");
var fd = fs.openSync("C:/Users/guazz/Desktop/provaprogramma/Ping/24104774_ping_2020_format.json",'a'); //per valore completto Dns23848289 per
console.log("Opening a new file..");
console.log("Start append");


lineReader.eachLine('C:/Users/guazz/Desktop/provaprogramma/Ping/24104774_ping_2020.json', function(line,last) {
	//var value = line.replace(/^\[([^]*)]$/,'');  //remove brackets
	var value = line.substring(1, line.length-1);
	//var value = line.replace(/[\]]+/g,',').replace(/[\[]+/g,'')  //remove brackets
	var value2= value.replace(/\},\{"rtt"+/g,'}{"rtt"')
	var value3= value2.replace(/\},\{"x"+/g,'}{"x"')
	var value3= value3.replace(/\},\{"dup"+/g,'}{"dup"')
	var value3= value3.replace(/\},\{"error"+/g,'}{"error"')
	var stringArray = value3.split(",{"); // divide 
	var text = stringArray.join('\n{')+"\n"; // new line and add the lost bracket
	console.log(text);
	var text2=text.replace(/}{/g,'},{')
	fs.appendFile(fd, text2, function(err) {

		if(err) {
		    return console.log(err);
		}
	});

});
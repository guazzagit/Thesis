
fs = require('fs');
var argument = process.argv
var Input=argument[2];
var Output=argument[3];
const lineReader = require('line-reader');
console.log("Reorder data...");
var fd = fs.openSync(Output,'a'); //per valore completto Dns23848289 per
console.log("Opening a new file..");
console.log("Start append");
// c'è il campo resultset devi sta attento a quello qua 

lineReader.eachLine(Input, function(line,last) {
	//var value = line.replace(/[\[\]]+/g,'');  //remove brackets
	var value = line.substring(1, line.length-1);
	//var value = line.replace(/[\]]+/g,',').replace(/[\[]+/g,'')  //remove brackets
	var value2= value.replace(/\},\{"af"+/g,'}{"af"')
	var value3= value2.replace(/\},\{"dst_name"+/g,'}{"dst_name"')
	var value4= value3.replace(/\},\{"time"+/g,'}{"time"')
	var stringArray = value4.split(",{"); // divide 
	let text = stringArray.join('\n{')+"\n"; // new line and add the lost bracket
	var text2=text.replace(/\}\{+/g,'},{')
	console.log(text2);
	fs.appendFile(fd, text2, function(err) {

		if(err) {
		    return console.log(err);
		}
	});

});

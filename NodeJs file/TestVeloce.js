
fs = require('fs');
var argument = process.argv
var Input=argument[2];
var Output=argument[3];
const lineReader = require('line-reader');
console.log("Reorder data...");
console.log(Input)
var fd = fs.openSync(Output,'a'); //per valore completto Dns23848289 per
console.log("Opening a new file..");
console.log("Start append");
// c'è il campo resultset devi sta attento a quello qua 
var str = fs.readFileSync(Input, 'utf8'); // This will block the event loop, not recommended for non-cli programs.
//console.log('result read: ' + str);


//lineReader.eachLine(Input, function(line,last) {
	//var value = line.replace(/[\[\]]+/g,'');  //remove brackets
	//var value = line.substring(1, line.length-1);
	//var value = line.replace(/[\]]+/g,',').replace(/[\[]+/g,'')  //remove brackets
	var value2= str.replace(/\},\{"af"+/g,'}{"af"')
	var value3= value2.replace(/\},\{"dst_name"+/g,'}{"dst_name"')
	var value4= value3.replace(/\},\{"time"+/g,'}{"time"')
	var stringArray = value4.split(",{"); // divide 
	let text = stringArray.join('\n{')+"\n"; // new line and add the lost bracket
	var text2=text.replace(/\}\{+/g,'},{')
	console.log(text2);
	var value = text2.substring(1, text2.length-1);
	fs.appendFile(fd, value, function(err) {

	    return console.log(err);
		}
	);

//});

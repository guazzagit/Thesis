
fs = require('fs');
const editJsonFile = require("edit-json-file");
var dateFormat = require("dateformat");
// If the file doesn't exist, the content will be an empty object by default.

const lineReader = require('line-reader');
console.log("Reorder data...");
var fd = fs.openSync("./12001626_quad1_2019_formattato_dataCambiata.json",'a'); //per valore completto Dns23848289 per test = testdata1
console.log("Opening a new file..");
console.log("Start append");


lineReader.eachLine('12001626_quad1_2019_formattato.json', function(line,last) {
	
	var obj = JSON.parse(line);
	//console.log(obj.timestamp);
	var milliseconds = obj.timestamp * 1000;
	var dateObject = new Date(milliseconds)
	//var humanDateFormat = dateObject.toLocaleString('en-GB') //2019-12-9 10:30:15
	//console.log(humanDateFormat)
	//obj.timestamp = humanDateFormat;
	var appo = dateFormat(dateObject, "yyyy-mm-dd HH:MM:ss");
	obj.timestamp =appo;
	//console.log(appo);
	//console.log(obj.timestamp);
	var med = JSON.stringify(obj);

	//console.log(med);
	//var stringArray = med.split("}{"); // divide 
	//console.log(stringArray);
	//let text = stringArray.join() +"\n"; // new line and add the lost bracket
	var text = med +"\n"; // non va bene se lo porti in stringa poi da problemi per plottarli
	fs.appendFile(fd, text, function(err) {

		if(err) {
		    return console.log(err);
		}
	});

});
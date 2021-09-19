
fs = require('fs');
var argument = process.argv
var Input=argument[2];
var Output=argument[3];
const editJsonFile = require("edit-json-file");
const readline = require('readline');
var dateFormat = require("dateformat");
// 

const lineReader = require('line-reader');
console.log("Reorder data...");
var fd = fs.openSync(Output,'a'); 
console.log("Opening a new file..");
console.log("Start append");

    const rl = readline.createInterface({
      input: fs.createReadStream(Input),
      crlfDelay: Infinity,
    });
    writer=fs.createWriteStream(Output);
    rl.on('line', (line) => {
      // Gets line and splits it by " - " where the ip is the first value
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
		var text = med +"\n"; // 
			
      	const result = {
// object with data inside
      };
      writer.write(text)
      //console.log("write")
    });

    rl.on('close', () => {
      writer.end()
    });

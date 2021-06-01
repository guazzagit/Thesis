
fs = require('fs');
es= require('event-stream')
var argument = process.argv
const readline = require('readline');
var Input=argument[2];
var Output=argument[3];
const lineReader = require('line-reader');
console.log("Reorder data...");
console.log(Input)
var fd = fs.openSync(Output,'a'); //per valore completto Dns23848289 per
console.log("Opening a new file..");
console.log("Start append");


    const rl = readline.createInterface({
      input: fs.createReadStream(Input),
      crlfDelay: Infinity,
    });
    writer=fs.createWriteStream(Output);
    rl.on('line', (line) => {
      // Gets line and splits it by " - " where the ip is the first value
		var value2= line.toString().replace(/\},\{"af"+/g,'}{"af"')
		var value3= value2.replace(/\},\{"dst_name"+/g,'}{"dst_name"')
		var value4= value3.replace(/\},\{"time"+/g,'}{"time"')
		var stringArray = value4.split(",{"); // divide 
		let text = stringArray.join('\n{')+"\n"; // new line and add the lost bracket
		var text2=text.replace(/\}\{+/g,'},{')
		//console.log(text2);
		var value = text2.substring(1, text2.length-1);
		var valueA = value.substring(0, value.length-1);
      	const result = {
// object with data inside
      };
      writer.write(valueA)
    });

    rl.on('close', () => {
      writer.end()
    });

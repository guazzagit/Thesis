fs = require('fs');
var argument = process.argv
var Input=argument[2];
var Output=argument[3];
var Discrim=argument[4]
const editJsonFile = require("edit-json-file");

const readline = require('readline');
var dateFormat = require("dateformat");
const lineReader = require('line-reader');
console.log("DATA SELECTION");


var fd_error = fs.openSync(Output,'a');
//var fd_Probe = fs.openSync("./Dns23848289_PRobe_52741_noError.json",'a');
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
		// per la versione completa senza errori o solo error
			if(Discrim=='OK'){
				if(obj.resultset.result){
					
					var med = JSON.stringify(obj);
					var text = med +"\n"; // non va bene se lo porti in stringa poi da problemi per plottarli
					writer.write(text)
					}
			}
			if(Discrim!='OK'){
				if(!obj.resultset.result){
					
					var med = JSON.stringify(obj);
					var text = med +"\n"; // non va bene se lo porti in stringa poi da problemi per plottarli
					writer.write(text)
					}	
			}
      //writer.write(text)
      //console.log("write")
    });

    rl.on('close', () => {
      writer.end()
    });
	
	
	// singole probe. automatizza poi per far prima.	
/*	if(obj.result && obj.prb_id == ProbeId[9]){
		var med = JSON.stringify(obj);
		var text = med +"\n"; // non va bene se lo porti in stringa poi da problemi per plottarli
		fs.appendFile(fd_Probe, text, function(err) {

			if(err) {
			    return console.log(err);
			}
		});
		}*/
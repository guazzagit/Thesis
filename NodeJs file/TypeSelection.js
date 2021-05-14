fs = require('fs');
const editJsonFile = require("edit-json-file");
var dateFormat = require("dateformat");
const lineReader = require('line-reader');
console.log("DATA SELECTION");

ProbeId = [2256,3131,3178,16100,25438,32880,50218,52490,54377,52741]

var fd_error = fs.openSync("./12001626_quad1_2019_formattato_dataCambiata_OnlyERROR.json",'a');
var fd_Probe = fs.openSync("./Dns23848289_PRobe_52741_noError.json",'a');
console.log("Opening a new file..");
console.log("Start append");


lineReader.eachLine('12001626_quad1_2019_formattato_dataCambiata.json', function(line,last) {
	
	var obj = JSON.parse(line);
// per la versione completa senza errori o solo error
	if(!obj.result){
		var med = JSON.stringify(obj);
		var text = med +"\n"; // non va bene se lo porti in stringa poi da problemi per plottarli
		fs.appendFile(fd_error, text, function(err) {

			if(err) {
			    return console.log(err);
			}
		});
		}
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

});
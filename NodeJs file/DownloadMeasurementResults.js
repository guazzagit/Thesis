const fetch = require("node-fetch");
const batchPromises = require("batch-promises");
const { URL, URLSearchParams } = require('url');
const axios = require("axios");
const https = require("https");
const batchRequest = require('batch-request-js')
const dash = require("lodash");
// Parallel requests in batches
// 1546300800  1546304400 1577829600
//
//generete urls for batchpromises
function querygen(){
	var url = 'https://atlas.ripe.net/api/v2/measurements/'+msm_id+'/results';
	//var url2 = 'https://atlas.ripe.net/api/v2/measurements/23848289';
	queries =[];
	var startTime = StrTime;
	var stopTime = parseInt(startTime)+3600;  //1h = 1579296737 2h=1579300337
	console.log(stopTime)
	while (stopTime <=parseInt(StpTime)) // data messa quando ho scritto il codice1617870958   questo è tipo 2 sole query= 1579300337
	{ 
		var increment=3600;  //2h diff=7200 1h difference=3600
		var NewUrl = '/?start='+startTime+'&stop='+stopTime;
		var item = url.concat(NewUrl);
		queries.push(item);
		startTime = stopTime;
		stopTime = stopTime + increment;	
	}
	//console.log(queries)
	return queries;

}

function checkResponseStatus(res) {
    if(res.ok){
        return res
    } else {
        throw new Error(`The HTTP status of the reponse: ${res.status} (${res.statusText})`);
    }
}

//_________

var fs = require('fs');
var argument = process.argv
var msm_id=argument[2];
var StrTime=argument[3];
var StpTime=argument[4];
var PercorsoOut=argument[5];
console.log(msm_id)
console.log(StrTime)
console.log(StpTime)
console.log(PercorsoOut)
const urls = querygen();
console.log(urls)
const inParallel = 5;
//console.log(urls); //check

//fetch on each urls. inParall num of request in a batch. Urls array of items


var logstream = fs.createWriteStream(PercorsoOut,{flag: 'a'});

batchPromises(inParallel, urls, i => 
      fetch(i) 
          .then(res => res.text())
          .then(res => {
                logstream.write(res);
                logstream.write("\n");
                console.log("scritto qualcosa");
            })
           .catch(console.log))
     .then(() => console.log("Finish"));

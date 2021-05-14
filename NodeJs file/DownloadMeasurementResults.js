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
	var url = 'https://atlas.ripe.net/api/v2/measurements/12001626/results';
	//var url2 = 'https://atlas.ripe.net/api/v2/measurements/23848289';
	queries =[];
	var startTime = 1546300800;
	var stopTime = 1546304400;  //1h = 1579296737 2h=1579300337
	while (stopTime <=1577829600) // data messa quando ho scritto il codice1617870958   questo è tipo 2 sole query= 1579300337
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

const urls = querygen();
console.log(urls)
const inParallel = 5;
//console.log(urls); //check

//fetch on each urls. inParall num of request in a batch. Urls array of items


var logstream = fs.createWriteStream('12001626_quad1_2019.json',{flag: 'a'});

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

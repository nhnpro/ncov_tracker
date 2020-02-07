
const functions = require('firebase-functions');

//const csv = require('csv-parser')
var https = require('https');
const results = [];

//https://docs.google.com/spreadsheets/d/1ZJCEHKijIMVSJvH74C-LIUJb7BAHqj6b/gviz/tq?tqx=out:csv&sheet=recovered
exports.helloWorld = functions.https.onRequest((request, response) => {
	
		var request = https.get("https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query?f=json&where=1%3D1&returnGeometry=false&outFields=*&spatialRel=esriSpatialRelIntersects&outStatistics=[{\"statisticType\":\"sum\",onStatisticField\":\"Confirmed\",\"outStatisticFieldName\":\"value\"}]&cacheHint=true",
		function(response) 
		{
			response
			.pipe(csv())
			.on('data', (data) => results.push(data))
			.on('end', () => {
				console.log(results);
				response.send(results);
			  });
			;
		}
	);

  
});

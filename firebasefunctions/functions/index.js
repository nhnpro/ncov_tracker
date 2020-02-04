const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//

const csv = require('csv-parser')
var https = require('https');
const results = [];


exports.helloWorld = functions.https.onRequest((request, response) => {
		var request = https.get("https://docs.google.com/spreadsheets/d/1ZJCEHKijIMVSJvH74C-LIUJb7BAHqj6b/export?format=csv",
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

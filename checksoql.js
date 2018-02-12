fs = require('fs')

var filedir = 'soqlresults.json';
if (process.argv.length > 2) {
  filedir = process.argv[2];
}

// get the test id
fs.readFile(filedir, 'utf8', function (err,data) {
  if (err) {
    console.log(err);

    process.exit(1);

    return;
  }

  var results = JSON.parse(data);

  console.log(JSON.stringify(results));


  processSoqlResults(results, function () {
  });
});

function processSoqlResults(results) {
  if (results.status != 0 || results.result.totalSize > 0) {
    process.exit(1);
  } 
}

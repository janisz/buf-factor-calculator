var data = require('./data/data.json')
var dict = require('./dict.json')

var arr =[];
for( var name in data ) {
    if (data.hasOwnProperty(name)){
       arr.push({"name": name, "imports": data[name]});
    }
}

var myData = arr.map(function(e) {
  var imports = e.imports.map(function(i) {
    return dict[i];
  });
  return {
    "name": dict[e.name], "imports": imports
  };
})

var fs = require('fs');

var outputFilename = '/tmp/my.json';

fs.writeFile(outputFilename, JSON.stringify(myData, null, 4), function(err) {
    if(err) {
      console.log(err);
    } else {
      console.log("JSON saved to " + outputFilename);
    }
});

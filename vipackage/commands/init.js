var fs = require('fs.extra');
var utils = require('../utils');

module.exports.run = function(args) {
  fs.copy(utils.lodir('logo.png'), 'logo.png', function(err) {
    if (err) console.log('Error: It looks like this directory has already been initialized.'.red);
    else {
      fs.copy(utils.lodir('template.js'), 'extension.js', function(err) {
        if (err) console.log('Error: It looks like this directory has already been initialized.'.red);
        else {
          console.log(('Initialized empty Vi extension in ' + process.cwd()).green);
        }
      });
    }
  });
}

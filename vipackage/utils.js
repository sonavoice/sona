var fs       = require('fs.extra');
var path     = require('path');
var _        = require('lodash');
var archiver = require('archiver');

var lodir = function(dir) {
  var newArgs = [__dirname];
  var args = Array.prototype.slice.call(arguments);
  newArgs = newArgs.concat(args);

  return path.join.apply(this, newArgs);
};

var getHome = function() {
  return process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];
};

var getConfig = function() {
  var config;
  try {
    config = JSON.parse(fs.readFileSync(getHome() + "/.vi.json"));
  } catch (e) {
    config = {
      email: null
    };
    fs.writeFileSync(getHome() + "/.vi.json", JSON.stringify(config, null, 2));
  }
  return config;
};

var zip = function(dir, name, cb) {
  var output = fs.createWriteStream(lodir(name + ".zip"));
  var archive = archiver('zip');

  output.on('close', function() {
    //console.log(archive.pointer() + ' total bytes');
    //console.log('archiver has been finalized and the output file descriptor has closed.');
    cb();
  });

  archive.on('error', function(err) {
    throw err;
  });

  archive.pipe(output);

  archive.directory(dir, name);

  archive.finalize();
};

module.exports.lodir = lodir;
module.exports.getConfig = getConfig;
module.exports.getHome = getHome;
module.exports.zip = zip;
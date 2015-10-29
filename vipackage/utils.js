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

module.exports.lodir = lodir;
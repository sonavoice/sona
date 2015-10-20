#! /usr/bin/env node

var shell = require("shelljs");
var yargs = require("yargs");

var argv = yargs.usage("$0 command -n [msg]")
  .command("create", "create a new vi application")
  .demand(1, 'must provide a valid command')
  .argv

shell.mkdir("-p", argv.n);
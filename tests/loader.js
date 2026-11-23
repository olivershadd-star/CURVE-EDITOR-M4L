// Charge les fichiers src/*.js comme le fait Max : concatenes dans un seul contexte global.
"use strict";
const fs = require("fs");
const path = require("path");
const vm = require("vm");

function load(files, globals) {
    const code = files.map((f) => fs.readFileSync(path.join(__dirname, "..", "src", f), "utf8")).join("\n");
    const sandbox = Object.assign({ console, Math, JSON, Date, Object, Array, String, Number, isFinite, parseInt,
        encodeURIComponent, decodeURIComponent, RegExp, Error }, globals || {});
    vm.createContext(sandbox);
    vm.runInContext(code, sandbox, { filename: files.join("+") });
    return sandbox;
}
module.exports = { load };

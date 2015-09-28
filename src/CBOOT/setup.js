/** When we receive a message, kick off main */
onmessage = function (e) {
  console.log("Message received from the main script.");
  /** e.data holds the information */
  var action = e.data["action"];
  var program = e.data["program"];
  
  var srcpath = "/pats/file.dats";
  
  FS.writeFile(srcpath, program, {encoding:"utf8"});
  
  console.log("Calling main function");
  preRun();
  preMain();
  Module['callMain'](['-tc', '-d', srcpath]);
  console.log("returned");
};

if (typeof(Module) == "undefined") {
  Module = {};
}

Module['preRun'].push(function () {
    ENV.PATSHOME = '/pats/';
    ENV.PATSHOMERELOC = '/pats/';
});

Module['print'] = function(text) {
    postMessage({"type": "stdout",
                             "data": text});
};

Module['printErr'] = function(text) {
    postMessage({"type": "stderr",
                             "data": text});
};

Module['noInitialRun'] = true;
Module['TOTAL_MEMORY'] = 268435456;
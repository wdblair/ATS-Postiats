/** When we receive a message, kick off main */
onmessage = function (e) {
  console.log("Message received from the main script.");
  
  if (runDependencies > 0) {
    return;
  } else {
    postMessage({type: "ctl", msg: "running"});
  }
  /** e.data holds the information */
  var action = e.data.action;
  var program = e.data.program;
  
  var srcpath = "/pats/file.dats";
  
  FS.writeFile(srcpath, program, {encoding:"utf8"});
  
  var args = [];
  
  switch(action) {
  	case "typecheck":
  		args.push("-tc");
  		break;
  };
  args.push("-d");
  args.push(srcpath);
  
  preRun();
  preMain();
  console.log("Calling main function");
  Module['callMain'](args);
  postMessage({type: "ctl", msg: "exit", status: EXITSTATUS});
};

if (typeof(Module) == "undefined") {
  Module = {};
}

Module['preRun'].push(function () {
    ENV.PATSHOME = '/pats/';
    ENV.PATSHOMERELOC = '/pats/';
});

Module['print'] = function(text) {
    postMessage({type: "stdout",
                             msg: text});
};

Module['printErr'] = function(text) {
    postMessage({type: "stderr",
                             msg: text});
};

Module['noInitialRun'] = true;
Module['TOTAL_MEMORY'] = 268435456;
var readyScript = {};

function readyRun () {
  var statrTime;
  $.each(readyScript,function (name,script) {
    statrTime = new Date().getTime();
    script();
    console.log('run ' + name + ':' + (new Date().getTime() - statrTime) / 1000 + 's');
  })
}
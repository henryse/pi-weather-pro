$(document).foundation();


function loadDoc() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
      var text = xhttp.responseText;
      var obj = JSON.parse(text);
      document.getElementById("demo").innerHTML = obj.results[0].Altitude;
    }
  };
  xhttp.open("GET", "/data/Altitude/1", true);
  xhttp.send();
}
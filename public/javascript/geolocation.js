navigator.geolocation.getCurrentPosition(
 function(position) {
   console.log("You were last spotted at (" + position.coords.latitude +
    "," + position.coords.longitude + ")");
   var lat1 = position.coords.latitude.toString().replace('.', 'x');
   var long1 = position.coords.longitude.toString().replace('.', 'x');
   // console.log(lat1 + " " + long1);

$(document).ready(function () {
    // Handler for .ready() called.
    window.setTimeout(function () {
        location.href = "/location/"+ lat1 + "/" + long1;
    }, 0)
});
});
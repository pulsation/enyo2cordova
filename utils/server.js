/**
 * This quick code can be run with node, once the 
 * project is deployed, so that the ripple cordova
 * emulator can access it.
 */
var connect = require('connect');
connect.createServer(
        connect.static("projects/android/assets/www/")
).listen(8080);


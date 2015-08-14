(function() {
  var net, server, status;

  net = require('net');

  status = '';

  server = net.createServer(function(socket) {
    console.log('Client Connected...');
    return socket.on('data', function(data) {
      console.log(data.toString());
      if (data.toString().trim().toLowerCase() === 'play') {
        status = 'Playing';
        console.log('PLAY\x1F\r\n');
        return socket.write('STATUS: \x1FPlaying \x1F00:00:00\x1F-00:21:22\r\nTITLE: \x1FBojack Horseman\x1F\r\n');
      } else if (data.toString().trim().toLowerCase() === 'pause') {
        return socket.write('STATUS: \x1FPaused \x1F at 00:14:52\x1F-00:21:22\r\nTITLE: \x1FBojack Horseman\x1F\r\n');
      } else if (data.toString().trim().toLowerCase() === 'stop') {
        return socket.write('STATUS: \x1FStopped\r\nReturning to Main Menu\x1F\r\n');
      } else if (data.toString().trim().toLowerCase() === 'exit' || 'goodbye') {
        socket.write('Diconnecting now...\r\n');
        return socket.destroy();
      }
    });
  });

  server.listen(50000, "162.198.129.216", function() {
    return console.log('Server started...');
  });

}).call(this);

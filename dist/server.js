(function() {
  var net, server;

  net = require('net');

  server = net.createServer(function(socket) {
    console.log('Client Connected...');
    return socket.on('data', function(data) {
      console.log(data.toString());
      if (data.toString().trim().toLowerCase() === 'play') {
        return socket.write('Now Playing...\r\n');
      } else if (data.toString().trim().toLowerCase() === 'pause') {
        return socket.write('Paused...\r\n');
      } else if (data.toString().trim().toLowerCase() === 'stop') {
        return socket.write('Stopped Playing...\r\n');
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

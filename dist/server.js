(function() {
  var net, server;

  net = require('net');

  server = net.createServer(function(socket) {
    console.log('Client Connected...');
    socket.write('Connection Established\r\n');
    socket.on('data', function(data) {
      var text;
      text = data.toString().trim().toLowerCase();
      console.log(text);
      switch (text) {
        case 'play':
          return socket.write('STATUS: \x1FPlaying \x1F00:00:00\x1F-00:21:22\r\nTITLE: \x1FBojack Horseman\x1F\r\n');
        case 'pause':
          return socket.write('STATUS: \x1FPaused \x1F at 00:14:52\x1F-00:21:22\r\nTITLE: \x1FBojack Horseman\x1F\r\n');
        case 'stop':
          return socket.write('STATUS: \x1FStopped\r\nReturning to Main Menu\x1F\r\n');
        case 'exit':
        case 'goodbye':
        case 'quit':
          socket.write('Diconnecting now...\r\n');
          return socket.destroy();
        default:
          return socket.write("Invalid command. Valid commands: 'Play', 'Pause', 'Stop', and 'Exit'/'Goodbye'.\r\n");
      }
    });
    return process.on('SIGINT', function() {
      socket.close();
      process.exit();
      return socket.destroy();
    });
  });

  server.listen(50000, '', function() {
    return console.log('Server started...');
  });

}).call(this);

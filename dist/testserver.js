(function() {
  var Server, net, server,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  net = require('net');

  Server = (function() {
    function Server() {
      this.server = net.createServer(function(client) {
        return new Server.Listener(client);
      });
    }

    Server.prototype.listen = function() {
      this.server.listen(50000, '162.198.129.216', function() {});
      return console.log('Server Started');
    };


    /*stop: ->
      server.close()
      socket.destroy()
     */

    return Server;

  })();

  Server.Listener = (function() {
    function Listener() {
      this.close = bind(this.close, this);
      this.send = bind(this.send, this);
      this.receive = bind(this.receive, this);
      console.log('Client Connected');
      socket.write('Connection Established');
      this.client.on('data', this.receive);
      this.client.on('end', function() {
        return console.log('Client Disconnected...');
      });
    }

    Listener.prototype.receive = function(data) {
      var text;
      text = data.toString();
      console.log(text);
      switch (text.trim().toLowerCase()) {
        case 'play':
          this.send('STATUS', 'Playing', '00:00:00', '00:21:22');
          return this.send('TITLE', 'Bojack Horseman');
        case 'pause':
          this.send('STATUS', 'Paused', '00:14:52', '00:21:22');
          return this.send('TITLE', 'Bojack Horseman');
        case 'stop':
          this.send('STATUS', 'Stopped');
          return this.send('Returning to Main Menu');
        case 'exit':
        case 'quit':
        case 'goodbye':
          return this.send('Disconnecting now...');
        default:
          return this.send('ERROR', 'Unknown Command', text);
      }
    };

    Listener.prototype.send = function() {
      var text;
      text = args.join('\x1F');
      return this.client.write(text + "\r\n");
    };

    Listener.prototype.close = function() {
      return socket.destroy();
    };

    return Listener;

  })();

  server = new Server();

  server.listen;

}).call(this);

net = require('net')

class Server
  constructor: ->
    @server = net.createServer (client) ->
      new Server.Listener client

  listen: ->
    @server.listen 50000, '162.198.129.216', ->
    console.log 'Server Started'

  ###stop: ->
    server.close()
    socket.destroy()###

class Server.Listener
  constructor: ->
    console.log 'Client Connected'
    socket.write('Connection Established')

    @client.on 'data', @receive
    @client.on 'end', ->
      console.log('Client Disconnected...')

  receive: (data) =>
    text = data.toString()

    console.log text

    switch text.trim().toLowerCase()
      when 'play'
        @send 'STATUS', 'Playing', '00:00:00', '00:21:22'
        @send 'TITLE', 'Bojack Horseman'
      
      when 'pause'
        @send 'STATUS', 'Paused', '00:14:52', '00:21:22'
        @send 'TITLE', 'Bojack Horseman'
      
      when 'stop'
        @send 'STATUS', 'Stopped'
        @send 'Returning to Main Menu'
      
      when 'exit', 'quit', 'goodbye'
        @send 'Disconnecting now...'

      else
        @send 'ERROR', 'Unknown Command', text

  send: () =>
    text = args.join '\x1F'

    @client.write "#{text}\r\n"

  close: =>
    socket.destroy()

server = new Server()
server.listen
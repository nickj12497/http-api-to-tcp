# Notes
# Following Ruby/CoffeeScript convention, use two spaces instead of tabs.
# Do not use parentheses unless they are required.
# Do not use double quotes unless the string uses interpolation.
# Organize code classically for greater maintainability.

net = require('net')

class Server
  constructor: ->
    @server = net.createServer (client) ->
      new Server.Listener client

  listen: =>
    # FIXME: accept variable host and port
    @server.listen 50000, '162.198.129.216', ->
      console.log 'Server started...'

  stop: =>
    @server.close()

    # TODO: destroy clients and clear clients list

class Server.Listener
  constructor: (@client) ->
    console.log 'Client Connected...'

    # TODO: register instance in clients list

    @client.on 'data', @receive
    @client.on 'end', ->
      console.log 'Client Disconnected...'

  receive: (data) =>
    text = data.toString()

    console.log text

    # TODO: use commands to change status, asynchronously update clients with status changes
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

  send: (args...) =>
    text = args.join '\x1F'

    @client.write "#{text}\r\n"

  close: =>
    # TODO: destroy client and remove from clients list

# Runtime
server = new Server()
server.listen()

net = require('net')

server = net.createServer (socket) ->
  console.log 'Client Connected...'
  socket.write('Connection Established\r\n')

  socket.on 'data', (data) ->
    text = data.toString().trim().toLowerCase()
    console.log(text)
    switch text 
      when 'play'
        socket.write 'STATUS: \x1FPlaying \x1F00:00:00\x1F-00:21:22\r\nTITLE: \x1FBojack Horseman\x1F\r\n'
      when 'pause'
        socket.write 'STATUS: \x1FPaused \x1F at 00:14:52\x1F-00:21:22\r\nTITLE: \x1FBojack Horseman\x1F\r\n'
      when 'stop'
        socket.write 'STATUS: \x1FStopped\r\nReturning to Main Menu\x1F\r\n'
      when 'exit', 'goodbye', 'quit'
        socket.write 'Diconnecting now...\r\n'
        socket.destroy()
      else 
        socket.write "Invalid command. Valid commands: 'Play', 'Pause', 'Stop', and 'Exit'/'Goodbye'.\r\n"

  process.on 'SIGINT', ->
    socket.close()
    process.exit()
    socket.destroy()

server.listen 50000, '', ->
  console.log 'Server started...'
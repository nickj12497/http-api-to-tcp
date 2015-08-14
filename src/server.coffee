net = require('net')
status = ''
server = net.createServer (socket) ->
	console.log('Client Connected...')

	socket.on('data', (data) ->
		console.log(data.toString())
		if data.toString().trim().toLowerCase() is 'play'
			status = 'Playing'
			console.log('PLAY\x1F\r\n')
			socket.write('STATUS: \x1FPlaying \x1F00:00:00\x1F-00:21:22\r\nTITLE: \x1FBojack Horseman\x1F\r\n')
		else if data.toString().trim().toLowerCase() is 'pause'
			socket.write('STATUS: \x1FPaused \x1F at 00:14:52\x1F-00:21:22\r\nTITLE: \x1FBojack Horseman\x1F\r\n')
		else if data.toString().trim().toLowerCase() is 'stop'
			socket.write('STATUS: \x1FStopped\r\nReturning to Main Menu\x1F\r\n')
		else if data.toString().trim().toLowerCase() is 'exit' or 'goodbye'
			socket.write('Diconnecting now...\r\n')
			socket.destroy()
		)

server.listen(50000, "162.198.129.216", ->
	console.log('Server started...')
	)
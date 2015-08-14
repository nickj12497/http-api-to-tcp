net = require('net')

server = net.createServer (socket) ->
	console.log('Client Connected...')

	socket.on('data', (data) ->
		console.log(data.toString())
		if data.toString().trim().toLowerCase() is 'play'
			socket.write('Now Playing...\r\n')
		else if data.toString().trim().toLowerCase() is 'pause'
			socket.write('Paused...\r\n')
		else if data.toString().trim().toLowerCase() is 'stop'
			socket.write('Stopped Playing...\r\n')
		else if data.toString().trim().toLowerCase() is 'exit' or 'goodbye'
			socket.write('Diconnecting now...\r\n')
			socket.destroy()
		)

server.listen(50000, "162.198.129.216", ->
	console.log('Server started...')
	)
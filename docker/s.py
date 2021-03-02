import socket
tcpServerSocket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
address = ('0.0.0.0',8080)
tcpServerSocket.bind(address)
tcpServerSocket.listen(5)
while True:
    newServerSocket,destAddr = tcpServerSocket.accept()
    while True: 
        newServerSocket.send('thanks!')
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# host 
# port 

try:
    s.connect((host, 12345))
except:
    print("Nije moguce uspostaviti konekciju")

msg = s.recv(1024) #moguce je da ovde stvarno puca 
print(msg.decode("utf-8"))

# client side for socket programming
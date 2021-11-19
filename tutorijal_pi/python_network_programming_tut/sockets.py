import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
host = '192.168.0.106'

def take_user_input():
    user_input = bytes(input("Unesi sta zelis da se posalje na server: "))
    # s.encode()
    s.send(user_input.encode("utf-8"))
    return user_input


try:
    s.connect((host, 12345))
except:
    print("Nije moguce uspostaviti konekciju")

while True:
    tmp_input_val = take_user_input()
    if tmp_input_val == "Stop":
        break
    msg = s.recv(1024) #moguce je da ovde stvarno puca 
    print(msg.decode("utf-8"))


# client side for socket programming
import asyncio, os
# import websocket
from websockets import serve
import time
from adafruit_servokit import ServoKit
import dc_rework
import cv2, time, picamera

speed = 100 # za sada je ovako staticka brzina
# TODO: skloniti prom, prihvatati zeljenu brzinu od korisnika
dc_rework.setup()

def robot_init():
    kit.servo[1].angle = 0 #u redu
    kit.servo[2].angle = 150 #u redu
    kit.servo[3].angle = 0 # u redu
    kit.servo[4].angle = 0

def movement(message):
    #TODO: implement better movement logic

    if message == "w": #napred
        dc_rework.motor_forward(speed)
    elif message == "s": #nazad
        dc_rework.motor_backward(speed)
    elif message == "a":
        dc_rework.motor_turn_left_forward(speed)
    elif message == "d":
        dc_rework.motor_turn_right_forward(speed)

def servo_to_be_used(input_string):

    servo_index = ""
    angle_val = ""

    for x in range(1, len(input_string)):
        angle_val += input_string[x]

    servo_index = input_string[0] 

    return servo_index, angle_val


kit = ServoKit(channels = 16)

def cameraInit():
    camera = picamera.PiCamera()
    camera.resolution = (640, 480)
    camera.framerate = 23
    camera.start_preview()
    time.sleep(2)

    return camera

# stream = BytesIO()
# kit.servo[4].angle = 0

async def echo(websocket):

    # if KeyboardInterrupt:
    #     # websockets.close()
    #     serve.close()
    

    if websocket:
        print("Povezao se " + str(websocket))
        robot_init()
        # os.system("$sudo uv4l --auto-video_nr --driver raspicam --encoding h264 --width 640 --height 480 --framerate 20 --server-option '--port=9090' --server-option '--max-queued-connections=30' --server-option '--max-streams=25' --server-option '--max-threads=29'")
    # else:
        # os.system("sudo pkill uv4l")

    async for message in websocket:
        
        await websocket.send(message)
        
        if message == "stop":
            # websocket.close()
            robot_init()
            break

        dc_motor = message
        # if (ord(message) >= 48 and ord(message) <= 57):
        [tmp_servo, tmp_angle] = servo_to_be_used(message)
        servo_index = int(float(tmp_servo)) #conversion is needed from tuple to int
        angle_val = int(float(tmp_angle))
        # logika za prva cetiri servo motora
        # TODO: implementirati dinamicniji pristup, imas 16 kanala, ne mora da znaci da ce 
        # biti tacno na prvih 4 kanala povezani servo motori (tb 21/11/2021)
        if servo_index == 0:
            kit.servo[servo_index].angle = angle_val
        elif servo_index == 1:
            kit.servo[servo_index].angle = angle_val
        elif servo_index == 2:
            kit.servo[servo_index].angle = angle_val
        elif servo_index == 3:
            kit.servo[servo_index].angle = angle_val
        elif servo_index == 4:
            kit.servo[servo_index].angle = angle_val

        # movement(dc_motor)

        # dc_rework.destroy()


async def main():
    # robot_init()
    try:
        os.system("$sudo uv4l --auto-video_nr --driver raspicam --encoding h264 --width 640 --height 480 --framerate 20 --server-option '--port=9090' --server-option '--max-queued-connections=30' --server-option '--max-streams=25' --server-option '--max-threads=29'")
        
        async with serve(echo, "192.168.0.106", 1258):
        # client_socket, addr = server_socket.accept()
            await asyncio.Future()  # run forever
    except KeyboardInterrupt:
        os.sytem("$sudo pkill uv4l")


asyncio.run(main())
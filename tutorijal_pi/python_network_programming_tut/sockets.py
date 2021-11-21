import asyncio
from websockets import serve
import time
from adafruit_servokit import ServoKit

def servo_to_be_used(input_string):

    servo_index = ""
    angle_val = ""

    for x in range(1, len(input_string)):
        angle_val += input_string[x]

    servo_index = input_string[0] 

    return servo_index, angle_val


kit = ServoKit(channels = 16)

async def echo(websocket):
    async for message in websocket:
        await websocket.send(message)
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


async def main():
    async with serve(echo, "192.168.0.106", 12346):
        await asyncio.Future()  # run forever

asyncio.run(main())
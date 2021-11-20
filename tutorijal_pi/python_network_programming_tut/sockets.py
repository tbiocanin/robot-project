import asyncio
from websockets import serve
import time
from adafruit_servokit import ServoKit

kit = ServoKit(channels = 16)

async def echo(websocket):
    async for message in websocket:
        await websocket.send(message)
        print(type(message))
        angle_curr = int(float(message))
        print(angle_curr)
        kit.servo[0].angle = angle_curr

async def main():
    async with serve(echo, "192.168.0.106", 12346):
        await asyncio.Future()  # run forever

asyncio.run(main())
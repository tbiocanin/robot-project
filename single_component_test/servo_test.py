# uvoz funkcije za adeept
import Adafruit_PCA9685
from adafruit_servokit import ServoKit
import time

kit = ServoKit(channels=16)

while True:
    kit.servo[1].angle = 180
    time.sleep(1)
    kit.servo[1].angle = 0


# if __name__ == "__main__":
#     pass
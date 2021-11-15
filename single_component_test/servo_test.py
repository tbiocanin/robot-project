# uvoz funkcije za adeept
import Adafruit_PCA9685
from adafruit_servokit import ServoKit
import time

kit = ServoKit(channels=16)

while True:
    kit.servo[1].angle = 180
    print("Dosao sam do 180 stepeni!")
    time.sleep(1)
    print("Vratio sam se na pocetak!")
    kit.servo[1].angle = 0


# if __name__ == "__main__":
#     pass
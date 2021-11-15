# test to see if multiple servos work at the same time
import time
from adafruit_servokit import ServoKit 

kit = ServoKit(channels = 16)

while True:
    tmp_servo = input('Koji motor zelis da koristis sada? ')
    tmp_servo2 = input('Za koliko zelis da me zarotiras? ')
    kit.servo[int(tmp_servo)].angle = int(tmp_servo2)
    time.sleep(1)
    print("Komande su uspesno odradjene! Naredna iteracija za 3 sekunde pocinje.")
    time.sleep(3)
# uvoz funkcije za adeept
import Adafruit_PCA9685
import time

init_position = 300
max_position = 600
min_position = 100

pwm = Adafruit_PCA9685.PCA9685()
pwm.set_pwm_freq(50)
# servo.set_pwm(0, 0, 300)
while True:
    pwm.set_pwm(0, 0, init_position)
    time.sleep(1)
    pwm.set_pwm(0, 0, max_position)
    time.sleep(1)
    pwm.set_pwm(0, 0, min_position)
    time.sleep(1)
# servo_motor = Adafruit_PCA9685.Servos()

# if __name__ == "__main__":
#     pass
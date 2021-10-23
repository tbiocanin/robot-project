# This is a script used in the first tutorial and that will be fully commented so that it serves as a template
# for future usage. Teodor (23.10.2021.)

""" 
terminal commands

pwd -> printuje gde sam u direktorijumu

cd -> promena direktorijuma

ls -> prikazi mi sta ima u tom folderu gde sam

cd .. -> vrati me korak gore

mkdir -> pravi direktorijum

nano [IME_FAJLA.py] -> ubaci te u nano editor i napravi ti novi fajl

wget [LINK] -> skini nesto sa neta

git clone [URL] -> klonira repozitorijum sa github-a u trenutni lokalni direktorijum

rm [IME_FAJLA] -> brisi neki fajl

rm * -> brisi sve

rmdir [IME_FOLDERA] -> brisanje direktorijuma

rm -r  [IME_FOLDERA] -> rekurzivno brisi stvari sa foldera

ls help -> daje ti dokumentaciju za ovu fju

sudo apt-get upgrade ili update

sudo shutdown -h now

itd..

"""

# za sada prve verzije koda ce ici na nano

import picamera # instaliraj paket da bi bio vidljiv u ovom okruzenju
import time

camera = picamera.PiCamera()

# camera.vflip = True
# camera.capture('example.jpg')

# camera.start_recording('example.h264')
# time.sleep(5)
# camera.stop_recording

###################### Drugi primer #######################
# camera.start_preview()

# time.sleep(10)

# camera.stop_preview
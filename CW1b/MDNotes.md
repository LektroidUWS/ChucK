# CW1b

## Sound1.ck

Seven saw oscillators are used, each slightly detuned, the initial intent was to give the effect of Roland's "supersaw" oscillator, although the effect appears to sound more like PWM as it hits the zero point. This was used for the melody

## Sound2.ck

A basic filtered squarewave was used in this patch, which worked well for the bass sound.

## mdvPlayerbass.ck

Two functions are used, one for reading the MDV notation, which includes pitch, duration and velocity from the converted ABC file. The other function for the sound playback

## mdvPlayermelody.ck

as with mdvPlayerbass.ck, the same functions were used to take care of the note information and sound source.
# CW1c

## Sound1.ck

This is an advancement of Sound1.ck as used for the melody in CW1b. The addition of continuous controller information was added in order to control the ADSR envelope generator by means of sliders 1,2,3,4.

## Sound2.ck

As per Sound1.ck, a further four sliders (5,6,7,8) were used to control the ADSR. Both Sound1.ck and Sound2.ck use the same raw sound as used in CW1b

## MidiHandler.ck

This code interfaces between the physical MIDI controller device and the parameters set by the files. For example, parameters in the Sound*.ck files can be used to control various aspects of the sound, whereas parameters in the SamplePlayer.ck control MIDI channel and pitch data.

## Polyplayer

This uses the Spork function to allow simultaneous files to play synchroniously together.

## SamplePlayer.ck

This file accesses the 19 LinnDrum samples found in the /audio folder. These are then mapped to the physical keyboard. Additional sliders were implemented to control pitch down, pitch up and reverb level.


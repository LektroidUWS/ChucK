// This will play the whole Amen break,
// then randomly select 16th slices of the break until the end of time.

// load sound file into buffer
me.dir()  + "AMEN/" + "AmenMain_L+R.WAV" => string filename;
SndBuf buf => dac;
filename => buf.read;

// how many samples are in a 16th (slice) of the buffer
buf.samples()/16 => int sliceSize;

// sample playback rate 1 = normal, 2 = double speed...
1.3 => float rate;
// rateScale is used to scale wait times
1/rate => float rateScale;

// play buffer from start
0 => buf.pos;
// set buffer playback rate
rate => buf.rate;
// wait until buffer has fully played
buf.samples()*rateScale::samp => now;


// infinite loop
while( true )
{
    // randomly choose a number between 0 and 15
    // multiply number by slice size (in samples)
    // use value to move to slice position in buffer
    sliceSize * Math.random2(0, 15) => buf.pos;

    // wait for a slice amount of samples to pass and then loop
    sliceSize*rateScale::samp => now;
}
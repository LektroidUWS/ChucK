// sound file
me.dir()  + "AMEN/" + "AmenMain_L+R.WAV" => string filename;
if( me.args() ) me.arg(0) => filename;

// the patch 
SndBuf buf => dac;
// load the file
filename => buf.read;

buf.samples()/16 => int sliceSize;

// time loop
while( true )
{
    sliceSize * Math.random2(0, 15) => buf.pos;
    sliceSize::samp => now;
}
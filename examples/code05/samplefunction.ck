// load array of sounds using a function
// chuck samplefunction.ck

// load the files and route to samples gain element
"../Amen/" => string samplepath;
["AmenMain_L+R.WAV"] @=> string samplefiles[];
samplefiles << "crash01.wav";
samplefiles << "crashLong.WAV";
samplefiles << "dbKick01.WAV";
samplefiles << "dbKick02.WAV";
samplefiles << "dbKick03.WAV";
samplefiles << "hat01.WAV";
samplefiles << "hat02.WAV";
samplefiles << "hat03.WAV";
samplefiles << "kick02.WAV";
samplefiles << "kick03.WAV";
samplefiles << "kick04.WAV";
samplefiles << "shuff01.WAV";
samplefiles << "shuff02.WAV";
samplefiles << "shuff03.WAV";
samplefiles << "shuff04.WAV";
samplefiles << "shuff05.WAV";
samplefiles << "smallSnare01.WAV";
samplefiles << "snare01.WAV";
samplefiles << "snare02.WAV";
samplefiles << "snare03.WAV";
samplefiles << "snare04.WAV";
samplefiles << "snare05.WAV";
samplefiles << "snare06.WAV";
samplefiles << "snare07.WAV";
samplefiles << "snare08.WAV";
SndBuf buffers[samplefiles.cap()];

0 => int buf;

// the patch 
Gain samples => dac;
0.8 => samples.gain;

loadSamples (samplepath, samplefiles, buffers, samples);

// test sounds
for (0 => int i; i < buffers.cap(); i++){
    0 => buffers[i].pos;
    500::ms => now;
}

// time loop
while( true )
{
    Math.random2(0,4) => buf;
    0 => buffers[buf].pos;
    Math.random2f(.2,.5) => buffers[buf].gain;
    Math.random2f(.5,1.5) => buffers[buf].rate;
    100::ms => now;
}

/*--------------------- functions ----------------------------*/

function void loadSamples (string path, string filenames[], SndBuf sounds[], Gain target){
    // load samples defined by path + filename into buffer array and route to target
    "null" =>  string filename;

    for (0 => int i;  i < filenames.cap(); i++){
        me.dir() + path + filenames[i]  =>    filename;
        filename => sounds[i].read;
        sounds[i] => target;
    }    
}




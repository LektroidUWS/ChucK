// load array of sounds using a function
// chuck samplefunctionpattern.ck

120 => float tempo;
60/(tempo * 192) => float tick;

// 384 * tick :: second => dur minim;
// 288 * tick :: second => dur crotchetD;
// 192 * tick :: second => dur crotchet;
// 96  * tick :: second => dur quaver;

// define as many patterns as you like
[ 0,  1,   3,   4,   5,   6,   7,   8,   9,   10,   11,   12,   13,   14,   15] @=> int bufs1[];
[192, 192, 192, 192, 192,  192, 192, 192, 192, 192,  192, 192, 192, 192,  192] @=>int myDurs1[];
[1.0, 1.0, 0.5, 1.0, 1.0, 0.5, 1.0, 1.0, 0.5, 1.0, 1.0, 0.7, 1.0, 1.0, 1.0] @=> float myVelocities1[];

[ 3,  3,   3,   3,   3,   3,   3,   3,   3,   1,   1,   1,   3,   3,   4] @=> int bufs2[];
[ 96,  96,  96,  96, 96,  192, 192, 288, 192, 96,   96,  96, 288, 96,   96] @=>int myDurs2[];
[1.0, 1.0, 0.5, 1.0, 1.0, 0.5, 1.0, 1.0, 0.5, 1.0, 1.0, 0.7, 1.0, 1.0, 1.0] @=> float myVelocities2[];


SndBuf buffers[25];

me.dir() + "Amen/crash01.wav"  => buffers[0].read;
me.dir() + "Amen/crashLong.WAV" => buffers[1].read;
me.dir() + "Amen/dbKick01.wav" => buffers[2].read;
me.dir() + "Amen/dbKick02.wav" => buffers[3].read;
me.dir() + "Amen/dbKick03.wav" => buffers[4].read;
me.dir() + "Amen/hat01.wav" => buffers[5].read;
me.dir() + "Amen/hat02.wav" => buffers[6].read;
me.dir() + "Amen/hat03.wav" => buffers[7].read;
me.dir() + "Amen/kick02.wav" => buffers[8].read;
me.dir() + "Amen/kick03.wav" => buffers[9].read;
me.dir() + "Amen/kick04.wav" => buffers[10].read;
me.dir() + "Amen/shuff01.wav" => buffers[11].read;
me.dir() + "Amen/shuff02.wav" => buffers[12].read;
me.dir() + "Amen/shuff03.wav" => buffers[13].read;
me.dir() + "Amen/shuff04.wav" => buffers[14].read;
me.dir() + "Amen/shuff05.wav" => buffers[15].read;
me.dir() + "Amen/smallSnare01.wav" => buffers[16].read;
me.dir() + "Amen/snare01.wav" => buffers[17].read;
me.dir() + "Amen/snare02.wav" => buffers[18].read;
me.dir() + "Amen/snare03.wav" => buffers[19].read;
me.dir() + "Amen/snare04.wav" => buffers[20].read;
me.dir() + "Amen/snare05.wav" => buffers[21].read;
me.dir() + "Amen/snare06.wav" => buffers[22].read;
me.dir() + "Amen/snare07.wav" => buffers[23].read;
me.dir() + "Amen/snare08.AIF" => buffers[24].read;



/*
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
samplefiles << "snare08.AIF";

*/

//SndBuf buffers[samplefiles.cap()];

0 => int buf;

// the patch 
Gain samples => dac;
0.8 => samples.gain;


//loadSamples (samplepath, samplefiles, buffers, samples);
playPattern(bufs1, myDurs1, myVelocities1);
//playPattern(bufs2, myDurs2, myVelocities2);
//playPattern(bufs2, myDurs2, myVelocities2);
playPattern(bufs1, myDurs1, myVelocities1);



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

function void playPattern (int myBufs[], int myDurs[]  ,float myVelocities[]){
    for (0 =>int index; index < myBufs.cap(); index ++){ //for each element of the array

        if (index >0){
            

            //<<<  buffers[1].samples()     >>>;
            <<<  buffers[myBufs[index - 1]].samples()     >>>;
        
        buffers[myBufs[index - 1]].samples() => buffers[myBufs[index - 1]].pos;
        }

        0 => buffers[myBufs[index]].pos;
        0.5 => buffers[myBufs[index]].rate;
        myVelocities[index]   * 0.2    => buffers[myBufs[index]].gain;
        myDurs[index] * tick :: second => now;
    }
}
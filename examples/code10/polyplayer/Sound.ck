public class Sound extends Chubgraph
{
   TriOsc piano => Gain AM => Chorus chor => ADSR env => Gain velocity => outlet;
   SinOsc mod => Gain modamp => AM;
   
    AM.op(3);// multiply inputs

    //adsr initial values
    0.005 => float a;
    0.02 => float d;
    0.5 => float s;
    0.1 => float r;
   
   // min max values for ADSR
    0.005 => float amin;
    3.0 => float amax;
    0.02 => float dmin;
    1.0 => float dmax;
    0.1 => float smin;
    1.0 => float smax;
    0.1 => float rmin;
    3.0 => float rmax;
    
    // min-max values for mamp
    0.0 => float modampgainmin;
    1.2 => float modampgainmax; 

    400 => float pianofreq;
    5.0 => float modfreq;
    
    // min max values for mod frequency (small range gives tremelo)
    0.0 => float modfreqmin;
    5.0 => float modfreqmax;
    
    0.0 => float detune;
    0.0 => float derate;
    0.8 => float deratemax;
    1.2 => float deratemin;
    0.995 => float detunemax;
    1.005 => float detunemin;

    //initial state
    env.set(a :: second, d :: second, s, r :: second);
    modfreq => mod.freq;
    pianofreq => piano.freq;
    0.5 => modamp.gain;

    //initial chorus
    0.25 => chor.modFreq;
    0.5 => chor.modDepth;
    0.5 => chor.mix;
    60 :: ms => chor.baseDelay;
    
    // max min chorus
    0.01 => float chorfreqmin;
    1.0 => float chorfreqmax;
    0.0 => float chordepthmin;
    1.0 => float chordepthmax;
    0.0 => float chormixmin;
    1.0 => float chormixmax;

   function void noteOn(float vel ){
       Math.random2f(deratemin, deratemax) => derate;
       modfreq * derate => mod.freq;
       Math.random2f(detunemin, detunemax) => detune;
       pianofreq * detune => piano.freq;
       vel => velocity.gain;
       1 => env.keyOn;}// vel = 0 - 1
   
   function void noteOff(float vel){1 => env.keyOff;}
   
   function void setFreq(float Hz){Hz => pianofreq;}
   
   // name controllable elements of sound
   ["Attack","Decay","Sustain","Release","control2","mix"] @=> string controls[];    
     
   // define control functions specific to instrument
   function void soundControl(int index, float value){  // value 0 - 127
       if(index == 0){amin +((value/127)*(amax - amin)) => a; env.set(a :: second, d :: second, s, r :: second);} //a
       if(index == 1){amin +((value/127)*(amax - dmin)) => d; env.set(a :: second, d :: second, s, r :: second);} //d
       if(index == 2){amin +((value/127)*(amax - smin)) => s; env.set(a :: second, d :: second, s, r :: second);} //s
       if(index == 3){amin +((value/127)*(amax - rmin)) => r; env.set(a :: second, d :: second, s, r :: second);} //r
       if(index == 4){modfreqmin + ((value/127)*(modfreqmax - modfreqmin)) => modfreq;} // modfreq
       if(index == 5){modampgainmin + ((value/127)*(modampgainmax - modampgainmin)) => modamp.gain;} // modfreq
       if(index == 6){chorfreqmin + ((value/127)*(chorfreqmax - chorfreqmin)) => chor.modFreq;} // modfreq
       if(index == 7){chordepthmin + ((value/127)*(chordepthmax - chordepthmin)) => chor.modDepth;} // modfreq
       if(index == 8){chormixmin + ((value/127)*(chormixmax - chormixmin)) => chor.mix;} // modfreq
       
   }
   
   
}
public class Sound1 extends Chubgraph
{
// preset starting values
   0.001 => float attack; // time in seconds
   0.3 => float decay;  // time in seconds
   0.2 => float sustain;// level 0-1
   0.3 => float release;// time in seconds

//variables for sliders

0.0 => float attackMin;
1.0 => float attackMax;
0.0 => float decayMin;
1.0 => float decayMax;
0.0 => float sustainMin;
1.0 => float sustainMax;
0.0 => float releaseMin;
1.0 => float releaseMax;

// sound patch 
   ADSR env => Gain gn => Chorus cho => NRev rev => outlet;

   gn.gain(0.05);
   
   SawOsc saw[7];
   
   for (0 => int i; i < saw.cap(); i++)
   {
      saw[i] => env;
   }


    env.set(attack :: second, decay :: second, sustain, release :: second);
 
 //chorus & reverb arguments
   cho.mix(0.5);
   cho.modFreq(2.0);
   cho.modDepth(0.05);

   rev.mix(0.05);

// note on/off functions
   function void noteOn(float vel ){  
      env.keyOn();

   }

   function void noteOff(float vel){
      env.keyOff();   
   }
   
   function void setFreq(float Hz){
      for (0 => int i; i < saw.cap(); i++)
      {
         ((0.988 + i*0.004)*(Hz))/4 => saw[i].freq;
      }
   }

// value to set ADSR
  function void oscSlider(int sliderNo, float value)
  { 
   if(sliderNo == 0){attackMin + (attackMax-attackMin)*value/127 => attack;
    env.attackTime(attack::second);}
   if(sliderNo == 1){decayMin + (decayMax-decayMin)*value/127 => decay;
   env.decayTime(decay::second);}
   if(sliderNo == 2){sustainMin + (sustainMax-attackMin)*value/127 => sustain;
    env.sustainLevel(sustain);}
   if(sliderNo == 3){releaseMin + (releaseMax-releaseMin)*value/127 => release;
   env.releaseTime(release::second);}
}
}
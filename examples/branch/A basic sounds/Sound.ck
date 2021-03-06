public class Sound extends Chubgraph
{
   1.00 => float a1;  
   0.50 => float a2;
   0.30 => float a3;
   0.25 => float a4;
   0.20 => float a5;
   0.67 => float a6;
   0.14 => float a7;
   0.42 => float a8;
   0.10 => float a9;



   SinOsc osc1 => Gain g => Envelope env => outlet;
   SinOsc osc2 => g;
   SinOsc osc3 => g;
   SinOsc osc4 => g;
   SinOsc osc5 => g;
   SinOsc osc6 => g;
   SinOsc osc7 => g;
   SinOsc osc8 => g;
   SinOsc osc9 => g;

   a1 => osc1.gain;
   a2 => osc2.gain;
   a3 => osc3.gain;
   a4 => osc4.gain;
   a5 => osc5.gain;
   a6 => osc6.gain;
   a7 => osc7.gain;
   a8 => osc8.gain;
   a9 => osc9.gain;
      
   env.keyOff();
   0.3 => g.gain;
   
   function void noteOn(float vel ){
      env.time(Math.random2f(0.01, 0.1));
      env.keyOn();
   }
   
   function void noteOff(float vel){
      env.keyOff();
   }
   
   function void setFreq(float Hz){
      Hz     => osc1.freq;
      Hz * 11 => osc2.freq;
      Hz * -3.1 => osc3.freq;
      Hz * 4.2 => osc4.freq;
      Hz * -5.3 => osc5.freq;
      Hz * 6.4 => osc6.freq;
      Hz * 7.5 => osc7.freq;
      Hz * 8.6 => osc8.freq;
      Hz * -29.7 => osc9.freq;
   } 
}




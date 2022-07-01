public class SamplePlayer extends Chubgraph
{

 
    // setup and play 16 samples with control from controllers 21 - 28
 
    ["bass1","bass6","cbsa1","cga2","clap","claps",
     "cowbel","crsh1","hihat1","ride1","shake","snap101",
     "snar23","snare","sstk1","tamb","tom1","tom6","tom7"] @=>string fileNames [];

    // patch
    Gain percGain => JCRev rev => outlet;
    
    // preset
    0.8 => percGain.gain;
    0.1 => rev.mix;

    //dial variables
    0.1 => float lowerMin;
    1.0 => float lowerMax;
    1.0 => float upperMin;
    5.0 => float upperMax;
    0.0 => float revMin;
    1.0 => float revMax;

    SndBuf buffers[19];
    int    sampleLengths[19];

    for (0 => int i; i< fileNames.cap(); i ++){
         me.sourceDir() + "/audio/" + fileNames[i] + ".wav" => buffers[i].read;   
         buffers[i].rate(1);
         buffers[i].samples() => sampleLengths[i];
         buffers[i].pos(sampleLengths[i]-1);
         0=>buffers[0].pos;
         buffers[i] => percGain;
    }
    
    function void playsound(int sampleNo , int vel){
        vel/127.0 => buffers[sampleNo].gain;
        0 => buffers[sampleNo].pos;
        <<<fileNames[sampleNo], sampleLengths[sampleNo],sampleNo, vel>>>;
        sampleLengths[sampleNo] :: samp => now;
    }
    
    function void play(int sampleNo , int vel){
         <<<"play: ",sampleNo, vel>>>;
        spork ~ playsound(sampleNo, vel);     
    }
    
    
    // name controllable elements of sound
    ["lower pitch", "upper pitch", "reverb"] @=> string controls[];    
    
    // define control functions specific to instrument
    function void soundControl(int index, float value){      // value 0 - 127
        if(index == 0)
        {
            for(0=>int i; i<buffers.cap();i++)
            {
                lowerMax-(lowerMax-lowerMin)*value/127 => buffers[i].rate;
            }
        }
        if(index == 1)
        {
            for(0=>int i; i<buffers.cap();i++)
            {
                upperMin+(upperMax-upperMin)*value/127 => buffers[i].rate;
            }
        }
        if(index == 2)
        {
            (revMin+(revMax-revMin)*value/127) => rev.mix;
        }
    }
}    
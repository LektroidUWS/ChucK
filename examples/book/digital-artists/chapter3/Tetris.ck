// Tetris Theme with text

// by Richard Elliott 2021

// two oscillators, melody and harmony
SinOsc s => Pan2 mpan => dac;       // (1) SinOsc through Pan2 for melody
TriOsc t => dac;                    // (2) TriOsc fixed at center for harmony

// we will use these to separate notes later
0.5 => float onGain;                // (3) Note on/off gains
0.0 => float offGain;

// declare and initialize our arrays of MIDI note #s
[76, 71, 72, 74, 72, 71, 69,               // (4) Melody (int) MIDI note array
69, 72, 76, 74, 72, 71, 71, 72, 74, 76, 72, 69, 69, 24, 74, 74, 77, 81, 79, 77, 76, 72, 76, 74, 72, 71, 71, 72, 74, 76, 72, 69, 69 ] @=> int melNotes[];
[59, 52, 59, 64, 52, 59, 45,               // (5) Harmony (int) MIDI note array
52, 45, 52, 45, 52, 59, 52, 59, 52, 59, 45, 52, 45, 50, 57, 50, 57, 50, 57, 50, 48, 55, 48, 55, 48, 52, 59, 52, 59, 52, 57, 52, 57 ] @=> int harmNotes[];

// quarter note and half note (6) Duration (dur) array
0.2 :: second => dur q;
0.4 :: second => dur h;
0.6 :: second => dur i;
0.8 :: second => dur j;
[ h, q, q, h, q, q, h, q, q, h, q, q, h, q, q, h, h, h, h, j, q, q, q, q, h, q, q, i, q, h, q, q, h, q, q, h, h, h, h, i ] @=> dur myDurs[];

// make one more array to hold the words
[" "," T"," E"," T"," R"," I"," S"," ", // (7) Lyrics (string) array
" T", " H","E","M","E"," ","T","U","N","E"," "," "," ","B","Y"," ","R","I","C","H","A","R","D"," ","E","L","L","I","O","T","T"," "] @=> string words[];

// loop over all the arrays
// (make sure they're the same length!!)
for (0 => int i; i < melNotes.cap(); i++) // (8) Plays through all 
{                                         //     notes in array
    // (9) print out index, MIDI notes, and words from arrays
    <<< i, melNotes[i], harmNotes[i], words[i] >>>;

    // set melody and harmony from arrays
    Std.mtof(harmNotes[i]) => s.freq;    // (10) Sets frequencies from
    Std.mtof(melNotes[i]) => t.freq;     //      array MIDI notes

    // melody has a random pan for each note
    Math.random2f(-1.0,1.0) => mpan.pan; // (11) Random pan for melody oscillator

    // notes are on for 70% of duration from array
    onGain => s.gain => t.gain;          // (12) Turns on both oscillators
    0.9*myDurs[i] => now;                // (13) 70% of array duration is note on time

    // space between notes is 30% of array duration
    offGain => s.gain => t.gain;
    0.1*myDurs[i] => now;                // (14) 30% of array duration is off time
}

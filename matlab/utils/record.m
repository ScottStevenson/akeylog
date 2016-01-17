r = audiorecorder(44100,16,1);
pause(0.5); 
display('press a key!'); 
record(r); 
pause(2); 
stop(r);
rec = getaudiodata(r, 'double');
plot(rec);
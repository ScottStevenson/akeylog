pause(2);
display(sprintf('Get Ready...', j, i));
display(sprintf('+++ START RECORDING TEST SAMPLE +++', j, i));
record(r);
pause(sampleLength);
stop(r);
display(sprintf('--- STOP RECORDING TEST SAMPLE ---', j, i));
testSample = getaudiodata(r, 'double');
plot(testSample);

testSampleFFT = abs(fft(testSample,N));
sim(net, testSampleFFT)

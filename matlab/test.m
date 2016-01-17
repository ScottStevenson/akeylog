pause(2);
display(sprintf('Get Ready...', j, i));
display(sprintf('+++ START RECORDING TEST SAMPLE +++', j, i));
record(r);
pause(sampleLength);
stop(r);
display(sprintf('--- STOP RECORDING TEST SAMPLE ---', j, i));
testSample = getaudiodata(r, 'double');
[M I] = max(testSample);
testSample = testSample(I:min(I+6000, sampleLength*44100/2));
plot(testSample);

testSampleFFT = abs(fft(testSample,N));
result = sim(net, testSampleFFT)
[maxValue, maxIndex] = max(result);
result = keyArray{maxIndex};

display(sprintf('RESULT\nKey was most likely: %s', result));

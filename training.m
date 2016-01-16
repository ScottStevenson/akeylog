% Prompt for user's training parameters
numKeys = input('Train for how many keys? ');
numIterations = input('How many training recordings per key? ');
sampleLength = input('How long should each recording be? ');

% Initialize recorder
r = audiorecorder(44100,16,1);

% Training loop
trainingData = cell(numKeys, numIterations);
for i = 1:numKeys
    for j = 1:numIterations
        display(sprintf('+++ START RECORDING %i FOR KEY %i +++', j, i));
        record(r);
        pause(sampleLength);
        stop(r);
        display(sprintf('--- STOP RECORDING ---', j, i));
        trainingData{i,j} = getaudiodata(r, 'double');
        
        [M I] = max(trainingData{i,j});
        trainingData{i,j} = trainingData{i,j}(I:I+6000);
        
        plot(trainingData{i,j});
    end
end

N = 512;
netInputs = zeros(N, numIterations * numKeys);
netOutputs = zeros(1, numIterations * numKeys);
for i = 1:numKeys
    for j = 1:numIterations
        index = j + (i-1)*numIterations;
        netInputs(:, index) = abs(fft(trainingData{i,j},N));
        netOutputs(index) = i-1;
    end
end

%net = newpr(netInputs, netOutputs, 20);
%net = train(net, netInputs, netOutputs);
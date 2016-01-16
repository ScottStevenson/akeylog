
netInputs = zeros(N, numIterations * numKeys);
netOutputs = zeros(1, numIterations * numKeys);
for i = 1:numKeys
    for j = 1:numIterations
        index = j + (i-1)*numIterations;
        netInputs(:, index) = abs(fft(trainingData{i,j},N));
        netOutputs(index) = i-1;
    end
end

net = newpr(netInputs, netOutputs, 20);
net = train(net, netInputs, netOutputs);
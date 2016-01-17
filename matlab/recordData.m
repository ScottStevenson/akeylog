% Prompt for user's training parameters
numKeys = input('Train for how many keys? ');
numIterations = input('How many training recordings per key? ');
sampleLength = input('How long should each recording be? ');

% Ask user for an identifier for each key that will be pressed
keyArray = cell(1,numKeys);
for i = 1:numKeys
    display(sprintf('What will key #%i be?', i));
    keyArray{i} = input('', 's');
end

% Initialize recorder
r = audiorecorder(44100,16,1);

% Loop for recording and cropping all training data
% display(sprintf('Get Ready...'));
% pause(2);
trainingData = cell(numKeys, numIterations);
for i = 1:numKeys
    display(sprintf('Get Ready to push: %s', keyArray{i}));
    pause(2);
    for j = 1:numIterations
        % Prompt and record
        display(sprintf('+++ START RECORDING %i FOR KEY %s +++', j, keyArray{i}));
        recordblocking(r,sampleLength);
        display(sprintf('--- STOP RECORDING ---', j, i));
        trainingData{i,j} = getaudiodata(r, 'double');
        
        % Crop out from maximum amplitude to +6000 samples
        % TODO: This should be separated out into processing stage 
        % if this project is expanded
        [M I] = max(trainingData{i,j});
        %trainingData{i,j} = trainingData{i,j}(I:min(I+6000, sampleLength*44100/2));
        trainingData{i,j} = trainingData{i,j}(I:I+6000);
        
        % Plot recording so that problems can be spotted
        plot(trainingData{i,j});
    end
end

% Produce array of FFTs and targets to be used for training
N = 512;
netInputs = zeros(N, numIterations * numKeys);
netOutputs = zeros(numKeys, numIterations * numKeys);
for i = 1:numKeys
     for j = 1:numIterations
         index = j + (i-1)*numIterations;
         netInputs(:, index) = abs(fft(trainingData{i,j},N));
         netOutputs(i, index) = 1;
     end
end

% Old two character version
% Produce array of FFTs and targets to be used for training
% N = 512;
% netInputs = zeros(N, numIterations * numKeys);
% netOutputs = zeros(1, numIterations * numKeys);
% for i = 1:numKeys
%     for j = 1:numIterations
%         index = j + (i-1)*numIterations;
%         netInputs(:, index) = abs(fft(trainingData{i,j},N));
%         netOutputs(index) = i-1;
%     end
% end

%net = newpr(netInputs, netOutputs, 20);
%net = train(net, netInputs, netOutputs);
selectNum = input('Training method: \n[1] NPRTool \n[2] Auto \n');

if selectNum == 2
    net = newpr(netInputs, netOutputs, 1);
    net = train(net, netInputs, netOutputs);
else 
    net = nprtool;
end
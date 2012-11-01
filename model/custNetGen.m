function net = custNetGen(lmSw)

%% custom neural network
% bias is built in to the transfer function logsiga
numLayers =3;
% initialize the network
net = network;
net.numInputs = 1;
net.inputs{1}.size = 3;

net.numLayers = numLayers+1;
net.layers{1}.size = 3;
net.layers{2}.size = 3;
net.layers{3}.size = 3;
net.layers{4}.size = 1;

net.inputConnect(1) = 1;
net.layerConnect = [   0     0     0     0;
                       1     0     0     0;
                       0     1     0     0;
                       0     0     1     0];

%net.layerConnect(2, 1) = 1;
%net.layerConnect(3, 2) = 1;
%net.layerConnect(4, 3) = 1;

net.outputConnect = [0 0 0 1];

transferFunc = 'logsiga'; % logsig (0,1) or tansig (-1,1)
net.layers{1}.transferFcn = transferFunc;
net.layers{2}.transferFcn = transferFunc;
net.layers{3}.transferFcn = transferFunc;
net.layers{4}.transferFcn = transferFunc;

net.biasConnect = [0; 0; 0; 0];

net.initFcn = 'initlay';
net.layers{1}.initFcn = 'initnw';
net.layers{2}.initFcn = 'initnw';
net.layers{3}.initFcn = 'initnw';
net.layers{4}.initFcn = 'initnw';

net.performFcn = 'mse';

if lmSw;
    net.trainFcn = 'trainlm';
else
    net.trainFcn = 'traingdm';
    net.trainParam.lr = 0.02;
    net.trainParam.mc = 0.9;
end

net.trainParam.min_grad = 1e-10;
net.trainParam.max_fail = 50;

net.trainParam.epochs = 200;
net.trainParam.show = 50;

net.trainParam.showWindow = 0;
net.trainParam.showCommandLine = 1;

% Setup Division of Data for Training, Validation, Testing
net.derivFcn = 'defaultderiv';
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% initialize the network
net = init(net);

end
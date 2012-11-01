%% and/or model
% helpful tutorial http://web.eecs.umich.edu/~someshs/nn/matlab_nn_starter.htm
% requires neural network toolbox

function [net,performance,fh,outputs,errors] = andorhybrid(inputs,targets,custSw,lmSw,plotSw)
%
% [inputs,targets]=trainDatGen();
% andorhybrid(inputs,targets,1,1,0)
%
%clear; close all;

if nargin < 3
    custSw = 1;
elseif nargin <4
    lmSw = 1;
elseif nargin <5
    plotSw = 0;
else
end

if custSw

    net = custNetGen(lmSw);

    % Train the Network
    [net,tr] = train(net,inputs,targets);
    
    % Test the Network
    outputs = net(inputs);
    errors = gsubtract(targets,outputs);
    performance = perform(net,targets,outputs)
    
    % View the Network
    %view(net)
    
    % Plot the Hinton diagram of the weight matrices
    if plotSw        
        fh=plotwb(net);
        set(fh,'Color','w');        
        % Uncomment these lines to enable various plots.
        %     figure, plotperform(tr)
        %     figure, plottrainstate(tr)
        %     figure, plotconfusion(targets,outputs)
        %     figure, ploterrhist(errors)
    else
        fh=0;
    end

else
%% built-in feedforward or cascadeforward network generation
hiddenLayerSize = repmat(3, 1, numLayers);
net = feedforwardnet(hiddenLayerSize);

%turn off bias
%net.biasConnect = [0; 0; 0; 0];
transferFunc = 'logsiga'; % logsig (0,1) or tansig (-1,1)

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)


% View the Network
%view(net)

% Plot the Hinton diagram of the weight matrices
if plotSw
    plotwb(net);

    % Uncomment these lines to enable various plots.
    %figure, plotperform(tr)
    %figure, plottrainstate(tr)
    %figure, plotconfusion(targets,outputs)
    %figure, ploterrhist(errors)
end

end

end
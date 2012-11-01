function [inputs,targets] = trainDatGen()

%% define parameters
% define inputs and outputs for an and/or gate combination with binary
% switch
inputs = [0 0;
          0 1;
          1 0;
          1 1];
andOut = [0;
          0;
          0;
          1];
orOut = [0;
         1;
         1;
         1];
andSwitch = 1;
orSwitch = 0;

% total number of samples in the "training set" will be 8*nS
nS = 100;

trainIn = [repmat(andSwitch, 4*nS, 1) repmat(inputs,nS,1);
           repmat(orSwitch , 4*nS, 1) repmat(inputs,nS,1)];

trainOut = [repmat(andOut, nS, 1);
            repmat(orOut , nS, 1)];

%   trainIn - input data.
%   trainOut - target data.

inputs = trainIn';
targets = trainOut';
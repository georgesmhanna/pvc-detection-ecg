function [pvc_locations] = GetPVCLocations(record, fs)

%% Read text file, transform it into a vector, and get QRS Locations using the Pan-Tompkins algorithm
[qrs_pos,int_data] = readTextFile(record, fs);

for i=1:length(qrs_pos)
     sample_nb = qrs_pos(i);
     if(sample_nb-99>0 && sample_nb+100<numel(int_data))
     vec(:,i) = int_data(sample_nb-99:sample_nb+100);
     
     end
end

%% Get Feature Vector already saved on the server:
load('fv.mat');
load('labels.mat');

%% Initialize neural network settings:
% Create a Pattern Recognition Network
hiddenLayerSize = 10;
% net = patternnet(hiddenLayerSize);
% 
% 
% % Setup Division of Data for Training, Validation, Testing
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% 
% 
% % Train the Network
% [net,tr] = train(net,D,E);
load('network.mat');

% IW = net.IW{1};
% b1 = net.b{1};
% LW = net.LW{2};
% b2 = net.b{2};
% 
% %vec=vec';
% disp(size(IW,1));
% disp(size(IW,2));
% disp(size(vec,1));
% disp(size(vec,2));
% disp(size(b1,1));
% disp(size(b1,2));
% IW
% b1
% y1 = satlin (IW * vec' + b1 );
% y2 = tansig (LW * y1 + b2 );
% 
% y = y2;
[y,~,~] = NeuralNetworkFunction(vec);
%% Get the output:
%y = net(vec);
z = round(y);

%% Get the PVC Locations:
pvc_locations = find(z==0);
 



function classifier = one_layer_classifier(P1);

%target matrix T for classifier is identity matrix Q times

[~,Q]=size(P1);
T = eye(10);
Target = T;
for i=20:10:Q
    Target = [Target T];
end
numInputs = 1;
numLayers = 1;

%network architecture
net = network(numInputs,numLayers);
net.layers{1}.dimensions = 10;
net.biasConnect = [1];
net.layerConnect = [0];
net.inputConnect = [1];
net.outputConnect = [1];
net.inputs{1}.size = 256;

%net = configure(net, P1, Target);

%initialization
W = rand(10,256);
b = rand(10,1);
net.b{1,1} = b;
net.IW{1,1} = W;

%network functions
% net.layers{1}.transferFcn = 'hardlim';
net.trainFcn='trainc'; 
net.adaptFcn='learnpn';
% net.layers{1}.transferFcn = 'purelin';
% net.trainFcn = 'trainb';
% net.trainFcn = 'traingd';
% net.layers{1}.transferFcn = 'logsig';

net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.85;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0;


net.performParam.lr = 0.6; % learning rate
net.trainParam.epochs = 300; % maximum epochs
net.trainParam.max_fail = 10; %default is 6
net.performFcn = 'sse'; % criterion

%stats
net.plotFcns = {'plotperform', 'plottrainstate','plotconfusion'};

net = train(net,P1,Target);

view(net)

save('one_layer_linear.mat','net')
a = sim(net,P1)
end
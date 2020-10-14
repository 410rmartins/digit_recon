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

%network functions
net.layers{1}.transferFcn = 'hardlim';
net.trainFcn='trainc'; 
net.adaptFcn='learnp';
% net.layers{1}.transferFcn = 'purelin';
% net.layers{1}.transferFcn = 'logsig';
% net.trainFcn = 'trainb';
% net.adaptFcn = 'traingd';


%initialization
W = rand(10,256);
b = rand(10,1);
net.b{1,1} = b;
net.IW{1,1} = W;

net.divideFcn = 'divideind';
train_ind = round(Q * 0.8);
validation_ind = train_ind + 1;

[trainInd,valInd,testInd] = divideind(Q,1:train_ind,validation_ind: Q, Q);

net.performParam.lr = 0.5; % learning rate
net.trainParam.epochs = 1000; % maximum epochs
net.trainParam.show = 35; % show
net.performFcn = 'sse'; % criterion

net = train(net,P1,Target);

view(net)

save('one_layer_linear.mat','net')

end
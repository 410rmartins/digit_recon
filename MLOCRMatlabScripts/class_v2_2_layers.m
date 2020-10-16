function P2 = class_v2_2_layers(P1);

[~,Q]=size(P1);
T = eye(10);
Target = T;

for i=20:10:Q
    Target = [Target T];
end

net = patternnet(40);
net = configure(net,P1,Target);
% net.inputConnect(2,1) = 1;
% 
% W = -1 + (1+1)*rand(10,256);
b =-1 + (1+1)* rand(10,1);
net.b{2,1} = b;
% net.IW{2,1} = W;

%network functions
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';
net.trainFcn = 'traingd';
net.adaptFcn = 'traingd';


net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.85;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0;

net.performParam.lr = 0.8; % learning rate
net.trainParam.epochs = 2000; % maximum epochs
net.trainParam.max_fail = 6; %default is 6
net.performFcn = 'mse'; % criterion
net = train(net, P1, Target);

save('layer2_purelin_logsig_800','net')

end
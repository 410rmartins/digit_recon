function P2 = class_v2(P1);

[~,Q]=size(P1);
T = eye(10);
Target = T;
for i=20:10:Q
    Target = [Target T];
end

net = perceptron;
net = configure(net,P1,Target);

W = rand(10,256);
b = rand(10,1);
net.b{1,1} = b;
net.IW{1,1} = W;

%network functions
% net.layers{1}.transferFcn = 'hardlim';
% net.trainFcn='trainc'; 
% net.adaptFcn='learnp';
% net.layers{1}.transferFcn = 'purelin';
net.layers{1}.transferFcn = 'logsig';
net.trainFcn = 'trainc';
net.adaptFcn = 'learngd';

net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.85;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0;

net.performParam.lr = 0.6; % learning rate
net.trainParam.epochs = 30; % maximum epochs
net.trainParam.max_fail = 10; %default is 6
net.performFcn = 'sse'; % criterion
net.trainParam.goal = 1e-6; % goal=objective

net = train(net,P1,Target);


save('layer1_class_logsig.mat','net')

end
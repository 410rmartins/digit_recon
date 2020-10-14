function P2 = class_v2_2_layers(P1);

[~,Q]=size(P1);
T = eye(10);
Target = T;

for i=20:10:Q
    Target = [Target T];
end

net = patternnet(20);
net = configure(net,P1,Target);

%network functions
net.layers{1}.transferFcn = 'purelin';
net.layers{2}.transferFcn = 'purelin';
net.trainFcn = 'traingd';
% net.adaptFcn = 'traingd';


net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.85;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0;

net.performParam.lr = 0.6; % learning rate
net.trainParam.epochs = 100; % maximum epochs
net.trainParam.max_fail = 100; %default is 6
net.performFcn = 'sse'; % criterion
net = train(net, P1, Target);

save('layer2_logsig_purelin.mat','net')

end
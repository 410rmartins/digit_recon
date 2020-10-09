function classifier = one_layer_classifier(P1);

%target matrix T for classifier is identity matrix Q times

[~,Q]=size(P1);
T = eye(Q);

numInputs = 1;
numLayers = 1;

net = network(numInputs,numLayers);
net.layers{1}.size = 10;

net.biasConnect = [1];
net.layerConnect = [0];
net.inputConnect = ones(1,numInputs);
net.outputConnect = [1];

W = rand(10,256);
b = rand(10,1);
net.b{1,1} = b;
net.IW{1,1} = W;
configure(net,P1,T);


end
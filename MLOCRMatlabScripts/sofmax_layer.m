function sofmax_layer(P1)
    
    Targe
    net = perceptron;
    net = configure(net,P1,Target);
    
    net.layers{1}.transferFcn = 'softmax'; 
end
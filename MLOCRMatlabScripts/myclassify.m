function out = myclassify(data,filled_inx);
    Input = data(:,filled_inx);
    load 'layer1_class.mat';
    res = sim(net, Input);
    [~,c] = size(filled_inx);
    out = zeros(size(filled_inx));
    for i= 1:c
       [~,out(i)] = max(res(:,i)); 
    end
end
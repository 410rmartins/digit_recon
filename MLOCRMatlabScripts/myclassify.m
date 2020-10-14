function out = myclassify(data,filled_inx);

    Input = data(:,filled_inx);
   %%choose filter(only 1 at a time)
   
    %To use percptron filter uncomment the following lines 
%     filter = struct2array(load('perceptron_filter.mat'));
%     Input = filter(Input);


    %To use associative memory as filter uncomment the following lines
%     filter = struct2array(load('am_filter.mat'));
%     Input = filter * Input;
    
 %%choose classifier method
    load 'layer2_logsig_logsig_40.mat';
    res = sim(net, Input);
    [~,c] = size(filled_inx);
    out = zeros(size(filled_inx));
    for i= 1:c
       [~,out(i)] = max(res(:,i)); 
    end
end
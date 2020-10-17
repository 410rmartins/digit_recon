function out = myclassify(data,filled_inx);

    class = interface;
    Input = data(:,filled_inx);
    if strcmp(class,'Filter+classifier') == 1
   
        filter = struct2array(load('perceptron_filter.mat'));
        Input = filter(Input);
        load 'layer2_logsig_logsig_40'
        res = sim(net, Input);
        [~,c] = size(filled_inx);
        out = zeros(size(filled_inx));
        for i= 1:c
           [~,out(i)] = max(res(:,i)); 
        end

    else if strcmp(class,'One Layer Classifier')== 1 | strcmp(class,'Second Best')== 1
        
        load 'layer1_class_logsig.mat'
            
    else
        load 'layer2_logsig_logsig_40'
    end
    
    res = sim(net, Input);
    [~,c] = size(filled_inx);
    out = zeros(size(filled_inx));
    for i= 1:c
       [~,out(i)] = max(res(:,i)); 
    end
end
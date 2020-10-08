function filtered_matrix = perceptron_filter(P);

%P is the input matrix
%T is the target matrix in this case perfectArial.mat
%net is the network for the perceptron

T = cell2mat(struct2cell(load('PerfectArial.mat'))); % load perfect arial as matrix
%Resize target matrix
[~,Q]=size(P);
t_size = 10;
temp_T = T;temp_T

if t_size > Q
    %make target matrix smaller
    temp_T = T(:,1:Q);
else 
    %make target matrix bigger
    while t_size < Q
        if Q-t_size >= 10
            %concatenate T with itself
            temp_T = [temp_T T]
            t_size = t_size + 10
        else
            %concatenate T with a partition of itself
            temp_T = [temp_T T(:,1:Q-t_size)]
            t_size = t_size + Q-t_size
        end
    end
end
T = temp_T;


net = perceptron;
net.trainParam.epochs = 2;
net.trainFcn = 'trainc';
net.adaptFcn = 'learnp';
net = train(net,P,T);
view(net)

save net
filtered_matrix = net(P);
return
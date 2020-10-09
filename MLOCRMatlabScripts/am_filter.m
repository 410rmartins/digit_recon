function P2 = am_filter(P1);
%P1 is the input vector with the dimensions (256,Q)
%P2 is the output vector with the dimensions (256,Q)
%Wp is the matrix with the computed weights
%T is the target (PerfectArial.mat)

%P1 = rand(256,5);% generates matrix 256x10 random in (0 1) testing only
T = cell2mat(struct2cell(load('PerfectArial.mat'))); % load perfect arial as matrix

%Resize target matrix
[~,Q]=size(P1);
t_size = 10;
temp_T = T;

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

Wp = T*pinv(P1);

save('am_filter','Wp');

P2 = Wp * P1;
return
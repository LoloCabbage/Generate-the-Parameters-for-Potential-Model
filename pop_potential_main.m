tic
% % % population in 2010 and 2020
path1 = 'pop5km/2000/';
path2 = 'pop5km/2010/';
ext = '*.xls';

dataset1 = dir([path1 ext]);
dataset2 = dir([path2 ext]);
n = length(dataset1);

results = [];
error = zeros(n,2);

for k = 1:n
    tic
    filepath1 = [path1,dataset1(k).name];
    filepath2 = [path2,dataset2(k).name];
    
    data_t1 = importdata(filepath1);
    data_t2 = importdata(filepath2);

    %prepare parameters
    global pop_t1
    pop_t1 = data_t1(:,3);%P
    
    pop_t2 = data_t2(:,3);
    lat = data_t1(:,1);
    lon = data_t1(:,2);
    
    global GridNum
    GridNum = length(data_t1);
    %population variation
    v = pop_t2-pop_t1; %distance
 
    %remove the negative value
    for i = 1:GridNum
        if v(i) < 0
            v(i) = 0;
        end
    end
   
    %distance metrix
    Grid_distance = distance_metrix(lat,lon);
    x = exp(-Grid_distance)-eye(GridNum);
    
    beta0 = 1;
    [beta_ghs,R_ghs] = nlinfit(x,v,'potential_GHS',beta0);
    
    v_t1_2 = potential_GHS(beta_ghs,x); %predicted v with beta
    pop_hat_t2 = pop_t1 + v_t1_2; %predicted population with v
    
    %scaling process
    scale_para = sum(pop_t2)/sum(pop_hat_t2);
    pop_pre_t2 = pop_hat_t2.*scale_para;
    
    rela_error = norm(v_t1_2 - v)/norm(v);
    rela_error1 = norm(pop_hat_t2 - pop_t2)/norm(pop_t2);
    rela_error2 = norm(pop_pre_t2 - pop_t2)/norm(pop_t2);
   
    results(k) = beta_ghs;
    error(k,1) = rela_error1;
    error(k,2) = rela_error2;
    toc
end
results = results';
toc
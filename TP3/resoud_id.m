function resoud_id();
load("base.mat");
N=length(data);
phat=[rand(), rand(),rand(),rand(),rand(),rand(),rand(),rand(),rand(),rand()]
J = [];
ERROR = zeros(N,3);
for iter=1:20
    for i=(1:N)
        th=data(i).theta';
        x=data(i).cartesien';
        error=(x-mod_geom(th,phat))';
        Jj=jacobien(th,phat);
    end
    J=[J,Jj];
    ERROR=[ERROR,error];
    dp = pinv(J) * ERROR;
    phat=phat+dp; % a revoir 
    disp(iter);
    disp(phat);
end
end
function resoud_id();
load("base.mat");
N=length(data);
phat=[rand(), rand(),rand(),rand(),rand(),rand(),rand(),rand(),rand(),rand()]
test_ligne=0:0.01:1;
J = [zeros(length(phat),length(test_ligne))];
for phat(1)=test_ligne
    ERROR = zeros(N,3);
    for i=(1:N)
        th=data(i).theta';
        x=data(i).cartesien';
        disp(i)
        disp(th);
        disp(x);
        ERROR(i,:)=(x-mod_geom(th,phat))';
        disp(ERROR(i,:));
    end
    J(1,) = sum(ERROR.^2)/N;
end

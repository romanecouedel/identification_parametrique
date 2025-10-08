function J = jacobien(theta,p)
l0=p(1);
l1=p(2);
l2=p(3);
l3=p(4);
t01=p(5);
t02=p(6);
t03=p(7);
xc=p(8);
yc=p(9);
ac=p(10);
t1=theta(1)+t01;
t2=theta(2)+t02;
t3=theta(3)+t03;
R=[cos(ac) -sin(ac) 0;sin(ac) cos(ac) 0 ; 0 0 1];
J1=R*[0;1;0];
J2=R*[cos(t1);sin(t1);0];
J3=R*[cos(t1+t2) ; sin(t2+t1) ; 0]
J4=R*[cos(t1+t2+t3) ; sin(t1+t2+t3); 0]
J5=R*[-l1*sin(t1)-l2*sin(t2+t1)-l3*sin(t1+t2+t3);l1*cos(t1)+l2*cos(t1+t2)+l3*cos(t1+t2+t3);1];
J6=R*[-l2*sin(t1+t2)-l3*sin(t1+t2+t2);l2*cos(t1+t2)+l3*cos(t1+t2+t3);1];
J7=R*[-l3*sin(t1+t2+t3);l3*cos(t1+t2+t3);1]
J8=R*[1;0;0];
J9=R*[0;1;0];
J10=R*[0;0;1];
J=[J1 J2 J3 J4 J5 J6 J7 J8 J9 J10];

end


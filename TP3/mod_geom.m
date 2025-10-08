function  X=modele_geom(theta,p)
    %%% p=[l0,l1,l2,l3,theta1_offset, theta2_offset, theta3_offset,xc,yc,alphac]
    %%% theta=[theta1, theta2, theta3]
    %disp(p);
    %disp(theta)
    theta1=p(5)+theta(1);
    theta2=p(6)+theta(2);
    theta3=p(7)+theta(3);
    l0=p(1);
    l1=p(2);
    l2=p(3);
    l3=p(4);
    xc=p(8);
    yc=p(9);
    alphac=p(10);
    M=[l3*cos(theta1+theta2+theta3)+l2*cos(theta1+theta2)+l1*cos(theta1);
        l3*sin(theta1+theta2+theta3)+l2*sin(theta1+theta2)+l1*sin(theta1)+l0;
        0];
    M=M-[xc;yc;alphac];
    C=[cos(alphac), -sin(alphac), 0;
        sin(alphac), cos(alphac), 0;
        0,0,1];
    X=inv(C)*M;
end
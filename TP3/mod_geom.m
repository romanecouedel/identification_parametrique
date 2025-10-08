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
    
    C=[cos(alphac), sin(alphac), 0;
        -sin(alphac), cos(alphac), 0;
        0,0,1];

    O0=[0,0,0];
    O1=[0,l0,theta1];
    O2=O1+[l1*cos(O1(3)), l1*sin(O1(3)), theta2];
    O3=O2+[l2*cos(O2(3)), l2*sin(O2(3)), theta3];
    Ot=O3+[l3*cos(O3(3)), l3*sin(O3(3)), -pi/2];
    Oc=[xc, yc, alphac];
    X= C*(Ot-Oc)' ;
end
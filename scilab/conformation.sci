//cas N = 4

function [conf]=conf(x)
    x1x2=norm([x(1)+x(4),x(2)+x(5),x(3)+x(6)]);
    x2x3=norm([x(4)+x(7),x(5)+x(8),x(6)+x(9)]);
    x3x4=norm([x(7)+x(10),x(8)+x(11),x(9)+x(12)]);
    f=4*x1x2^(-12)-4*x1x2^(-6)+4*x2x3^(-12)-4*x2x3^(-6)+4*x3x4^(-12)-4*x3x4^(-6);
endfunction

function [gradconf]=gradconf(x)
    x1x2=norm([x(1)+x(4),x(2)+x(5),x(3)+x(6)]);
    x2x3=norm([x(4)+x(7),x(5)+x(8),x(6)+x(9)]);
    x3x4=norm([x(7)+x(10),x(8)+x(11),x(9)+x(12)]);
    
    g=[(x(1)/x1x2)*-48*x1x2^(-13)+(x(1)/x1x2)*24*x1x2^(-7);
    (x(2)/x1x2)*-48*x1x2^(-13)+(x(12)/x1x2)*24*x1x2^(-7);
    (x(3)/x1x2)*-48*x1x2^(-13)+(x(3)/x1x2)*24*x1x2^(-7);
    (x(4)/x1x2)*-48*x1x2^(-13)+(x(4)/x1x2)*24*x1x2^(-7)+(x(4)/x2x3)*48*x2x3^(-13)+(x(4)/x2x3)*24*x2x3^(-7);
    (x(5)/x1x2)*-48*x1x2^(-13)+(x(5)/x1x2)*24*x1x2^(-7)+(x(5)/x2x3)*48*x2x3^(-13)+(x(5)/x2x3)*24*x2x3^(-7);
    (x(6)/x1x2)*-48*x1x2^(-13)+(x(6)/x1x2)*24*x1x2^(-7)+(x(6)/x2x3)*48*x2x3^(-13)+(x(6)/x2x3)*24*x2x3^(-7);
    (x(7)/x2x3)*48*x2x3^(-13)+(x(7)/x2x3)*24*x2x3^(-7)+(x(7)/x3x4)*48*x3x4^(-13)+(x(7)/x3x4)*24*x3x4^(-7);
    (x(8)/x2x3)*48*x2x3^(-13)+(x(8)/x2x3)*24*x2x3^(-7)+(x(8)/x3x4)*48*x3x4^(-13)+(x(8)/x3x4)*24*x3x4^(-7);
    (x(9)/x2x3)*48*x2x3^(-13)+(x(9)/x2x3)*24*x2x3^(-7)+(x(9)/x3x4)*48*x3x4^(-13)+(x(9)/x3x4)*24*x3x4^(-7);
    (x(10)/x3x4)*48*x3x4^(-13)+(x(10)/x3x4)*24*x3x4^(-7);
    (x(11)/x3x4)*48*x3x4^(-13)+(x(11)/x3x4)*24*x3x4^(-7);
    (x(12)/x3x4)*48*x3x4^(-13)+(x(12)/x3x4)*24*x3x4^(-7)];

endfunction


x0=[0;0;0;1;0;0;0;1;0;0;0;1];
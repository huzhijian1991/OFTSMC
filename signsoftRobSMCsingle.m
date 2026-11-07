function dx=signsoftRobSMCsingle(t,x)%先用二个变量测试下，也就是论文中的单段

m=0.5;l1=0.25;k=0.05;d=0.01;fai=0;g=9.8;
theta=x(1);
dtheta=x(2);

M=m*l1^2/20*20/3*(theta^3+6*theta-12*sin(theta)+6*theta*cos(theta))/theta^2;
C=-m*l1^2/3*((12*theta-30*sin(theta)+3*theta^2*sin(theta)+18*theta*cos(theta)+theta^3)/theta^6)*dtheta^2;
G=-m*g*l1*((2*cos(theta-fai)-cos(fai))/theta^3+(sin(theta-fai)-sin(fai))/theta^3);
K=k*theta;
D=d*dtheta;
f=(-C-G-K-D)/M;



x1d=5.*(t>=0&t<8)+(-2).*(t>8&t<=14)+2.*(t>14);
x1dd=0;
x1ddd=0;

a=5;
b=7;
l=9;
h=7;

e=x(1)-x1d;
ed=x(2)-x1dd;
a1=5;b1=5;a2=5;b2=5;
p1=5/7;p2=5/7;
q1=9/7;q2=9/7;%p1+q1=2
xi=0.001;
alpha=1;
miu=1;
kk=4;
rou1=1;
rou2=0.01;
f1=(2-p1)*xi^(p1-1);
f2=(p1-1)*xi^(p1-2);
if norm(e)>xi
s=ed+alpha*e+b1*abs(e)^(q1)*sign(e)+a1*abs(e)^(p1)*sign(e);
else 
s=ed+alpha*e+b1*abs(e)^(q1)*sign(e)+f1*e+f2*e^2*sign(e);
end

dd=sin(t).*(t>=0&t<2*pi)+(sin(t)+0.5).*(t>2*pi&t<=4*pi)+sin(t).*(t>4*pi);

lamt1=10;%
lamt5=280;%100

lamt2=81.2409;%
lamt3=1650;%
lamt6=2;%2
lamt4=5;%6
lamt7=3;%3

% E=[4.05 -1;4.1 0]
%E=[41.02 -1;420.5 0] 20.1099
%Q=[81.2409 -1;1650 0] 40.4757
if norm(e)>xi
ut=x1ddd-f-b1*(l/h)*abs(e)^((l/h)-1)*ed-a1*(a/b)*abs(e)^(a/b-1)*ed-alpha*ed-((abs(e))^2+miu)*sign(s)-kk*rou1/(rou2+abs(e))*s-a2*abs(s)^(p2)*sign(s)-b2*abs(s)^(q2)*sign(s)-x(4);
else
ut=x1ddd-f-b1*q1*abs(e)^(q1-1)*ed-f1*ed-f2*2*e*ed*sign(e)-((abs(e))^2+miu)*sign(s)-kk*rou1/(rou2+abs(e))*s-a2*abs(s)^(p2)*sign(s)-b2*abs(s)^(q2)*sign(s)-x(4);
end
%x是两个变量，扩展状态空间
x1dot=x(2);
x2dot=f+ut+dd;
% dx=[x1dot;x2dot];
%观测器的x2^=x(3),d^=x(4)
dx3=f+ut+x(4)-lamt1*sign(x(3)-x(2))-lamt2*(x(3)-x(2));
dx4=-lamt3*(x(3)-x(2))-lamt7*abs(lamt1*sign(x(3)-x(2)))^(a/b)*sign(lamt1*sign(x(3)-x(2)))-lamt4*abs(lamt1*sign(x(3)-x(2)))^(l/h)*sign(lamt1*sign(x(3)-x(2)))-lamt6*lamt1*sign(x(3)-x(2))-lamt5*sign(lamt1*sign(x(3)-x(2)));
dx=[x1dot;x2dot;dx3;dx4];
end


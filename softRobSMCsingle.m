function dx=softRobSMCsingle(t,x)%先用二个变量测试下，也就是论文中的单段

% m=0.5;l1=0.25;k=0.05;d=0.01;fai=0;g=9.8;
theta=x(1);
fai=x(2);
dtheta=x(3);
dfai=x(4);

% M=m*l1^2/20*20/3*(theta^3+6*theta-12*sin(theta)+6*theta*cos(theta))/theta^2;
% C=-m*l1^2/3*((12*theta-30*sin(theta)+3*theta^2*sin(theta)+18*theta*cos(theta)+theta^3)/theta^6)*dtheta^2;
% G=-m*g*l1*((2*cos(theta-fai)-cos(fai))/theta^3+(sin(theta-fai)-sin(fai))/theta^3);
% K=k*theta;
% D=d*dtheta;
% f=(-C-G-K-D)/M;

K=0.5;
M=1;
L=5;
G=9.8;
J=100;
B=1;

f1=K/(M*L^2)*x(2)+(1+0.1*sin(t))*(-1/(M*L^2)*cos(x(3))-K/(M*L^2)*x(1)-G/L*sin(x(1)));
f2=(1+0.1*cos(t))*(-B/J*x(4)-K/J*(x(2)-x(1)));
f=[f1;f2];

dd=[0.5*cos(t);0.2*sin(t)];
x1d=5.*(t>=0&t<8)+(-2).*(t>8&t<=14)+2.*(t>14);
x1dd=0;
x1ddd=0;
% x1d=[sin(t);cos(t)];
% x1dd=[cos(t);-sin(t)];
% x1ddd=[-sin(t);-cos(t)];
% x1d=[5;2];
% x1dd=[0;0];
% x1ddd=[0;0];

a=5;
b=7;
l=9;
h=7;

e=[x(1);x(2)]-x1d;
ed=[x(3);x(4)]-x1dd;
a1=0.5;b1=0.5;a2=0.5;b2=0.5;
p1=5/7;p2=5/7;
q1=9/7;q2=9/7;%p1+q1=2
xi=0.001;
alpha=0.01*eye(2);
miu=0.01*eye(2);
kk=0.1*eye(2);
rou1=0.01*eye(2);
rou2=0.01*eye(2);
f11=((2-p1)*xi^(p1-1));
f22=(p1-1)*xi^(p1-2);
if norm(e)>xi
s=ed+alpha*e+[b1*abs(e(1,1))^(q1)*sign(e(1,1));b1*abs(e(2,1))^(q1)*sign(e(2,1))]+[a1*abs(e(1,1))^(p1)*sign(e(1,1));a1*abs(e(2,1))^(p1)*sign(e(2,1))];
else 
s=ed+alpha*e+[b1*abs(e(1,1))^(q1)*sign(e(1,1));b1*abs(e(2,1))^(q1)*sign(e(2,1))]+f11*e+[f22*e(1,1)^2*sign(e(1,1));f22*e(2,1)^2*sign(e(2,1))];
end

% dd=(sin(t)).*(t>=0&t<2*pi)+(sin(t)+0.5).*(t>2*pi&t<=4*pi)+sin(t).*(t>4*pi);
% dd=[sin(t);sin(t)+1];
lamt1=10;%
lamt5=200;%100

lamt2=81.2409;%
lamt3=1650;%
lamt6=2;%2
lamt4=6;%6
lamt7=3;%3

% E=[4.05 -1;4.1 0]
%E=[41.02 -1;420.5 0] 20.1099
%Q=[81.2409 -1;1650 0] 40.4757
if norm(e)>xi
ut=x1ddd-f-[b1*(l/h)*abs(e(1,1))^((l/h)-1)*ed(1,1);b1*(l/h)*abs(e(2,1))^((l/h)-1)*ed(2,1)]-[a1*(a/b)*abs(e(1,1))^(a/b-1)*ed(1,1);a1*(a/b)*abs(e(2,1))^(a/b-1)*ed(2,1)]-alpha*ed-((norm(e))^2+miu)*sign(s)-kk*rou1/(rou2+norm(e))*s-[a2*abs(s(1,1))^(p2)*sign(s(1,1));a2*abs(s(2,1))^(p2)*sign(s(2,1))]-[b2*abs(s(1,1))^(q2)*sign(s(1,1));b2*abs(s(2,1))^(q2)*sign(s(2,1))];
else
ut=x1ddd-f-[b1*q1*abs(e(1,1))^(q1-1)*ed(1,1);b1*q1*abs(e(2,1))^(q1-1)*ed(2,1)]-f11*ed-[f22*2*e(1,1)*ed(1,1)*sign(e(1,1));f22*2*e(2,1)*ed(2,1)*sign(e(2,1))]-((norm(e))^2+miu)*sign(s)-kk*rou1/(rou2+norm(e))*s-[a2*abs(s(1,1))^(p2)*sign(s(1,1));a2*abs(s(2,1))^(p2)*sign(s(2,1))]-[b2*abs(s(1,1))^(q2)*sign(s(1,1));b2*abs(s(2,1))^(q2)*sign(s(2,1))];
end
%x是两个变量，扩展状态空间
% x1dot=x(2);
% x2dot=f+ut+dd;
x1dot=x(3);
x2dot=x(4);
% x3dot(1)=f1;
% x3dot(2)=f2+ut(2);
x3dot=f1;
x4dot=ut(2)+f2;
dx=[x1dot;x2dot;x3dot;x4dot];
%观测器
% dx3=f+ut+x(4)-lamt1*sign(x(3)-x(2))-lamt2*(x(3)-x(2));
% dx4=-lamt3*(x(3)-x(2))-lamt7*abs(lamt1*sign(x(3)-x(2)))^(a/b)*sign(lamt1*sign(x(3)-x(2)))-lamt4*abs(lamt1*sign(x(3)-x(2)))^(l/h)*sign(lamt1*sign(x(3)-x(2)))-lamt6*lamt1*sign(x(3)-x(2))-lamt5*sign(lamt1*sign(x(3)-x(2)));
% dx=[x1dot;x2dot;dx3;dx4];
end


function dx=PID_softRobSMCsingle(t,x)%先用二个变量测试下，也就是论文中的单段

m=0.5;l1=0.25;k=0.05;d=0.01;fai=0;g=9.8;
itheta=x(1);
theta=x(2);
dtheta=x(3);

M=m*l1^2/20*20/3*(theta^3+6*theta-12*sin(theta)+6*theta*cos(theta))/theta^2;
C=-m*l1^2/3*((12*theta-30*sin(theta)+3*theta^2*sin(theta)+18*theta*cos(theta)+theta^3)/theta^6)*dtheta^2;
G=-m*g*l1*((2*cos(theta-fai)-cos(fai))/theta^3+(sin(theta-fai)-sin(fai))/theta^3);
K=k*theta;
D=d*dtheta;
f=(-C-G-K-D)/M;
gx=1/M;

x0d=(5*t).*(t>=0&t<8)+(-2*t).*(t>8&t<=14)+(2*t).*(t>14);
x1d=5.*(t>=0&t<8)+(-2).*(t>8&t<=14)+2.*(t>14);
x1dd=0;
x1ddd=0;

% a=3;
% b=9;
% l=15;
% h=9;
% 
% e=x(1)-x1d;
% ed=x(2)-x1dd;
% a1=5;b1=5;a2=5;b2=5;
% p1=3/9;p2=3/9;
% q1=15/9;q2=15/9;%p1+q1=2
% xi=0.001;
% alpha=1;
% miu=1;
% kk=1;
% rou1=1;
% rou2=0.01;
% f1=(2-p1)*xi^(p1-1);
% f2=(p1-1)*xi^(p1-2);%忽略k1/Tc1
% if norm(e)>xi
% s=ed+alpha*e+b1*abs(e)^(q1)*sign(e)+a1*abs(e)^(p1)*sign(e);
% else 
% s=ed+alpha*e+b1*abs(e)^(q1)*sign(e)+f1*e+f2*e^2*sign(e);
% end
% 
dd=sin(t).*(t>=0&t<2*pi)+(sin(t)+0.5).*(t>2*pi&t<=4*pi)+sin(t).*(t>4*pi);
% % dd=sin(0.5*t)+0.1;
% % s=ed+alpha*e+a1*Re(e,p1,lmt,r1,r2)+b1*abs(e)^q1*sign(e);
% ds=-((abs(e))^2+miu)*sign(s)-kk*rou1/(rou2+abs(e))*s-a2*abs(s)^(p2)*sign(s)-b2*abs(s)^(q2)*sign(s)+x(4)-dd;
% %  ds=-miu*sign(s)-kk*s-a1*abs(s)^(p2)*sign(s)-b1*abs(s)^(q2)*sign(s);
% % ueq=-M*(a1*Red(e,ed,p1,xi,f1,f2)+a1*q1*abs(e)^(q1-1)*ed+alpha*e+C+G+K+D+M*x1ddd);
% % ur=M*(zeta*norm(e)^2*sign(s)+k*rou1/(rou2+norm(e))*s+a2*abs(s)^p2*sign(s)+b2*abs(s)^q2*sign(s));
% % u=ueq+ur;
% % if t>=0&t<8||t>14
% % dd=sin(0.1*t);
% % else 
% %   dd=sin(0.1*t)+0.5;
% % end
% dd=sin(t).*(t>=0&t<8)+(sin(t)+0.5).*(t>8&t<=14)+sin(t).*(t>14);
% % dd=sin(0.5*t)+0.1;
% %观测器的增益
% lamt1=12;%700
% lamt4=7;%30
% lamt5=0.5;%10
% 
% lamt2=2;%2
% lamt3=1;%1
% lamt6=0.01;%0.45
% lamt7=1;%1
% lamt8=1;%1
% Q=[2 -1;1 -0.01];%0.8949

% if norm(e)>xi
% ut=x1ddd-f-b1*(l/h)*abs(e)^((l/h)-1)*ed-a1*(a/b)*abs(e)^(a/b-1)*ed-alpha*ed-((abs(e))^2+miu)*sign(s)-kk*rou1/(rou2+abs(e))*s-a2*abs(s)^(p2)*sign(s)-b2*abs(s)^(q2)*sign(s)-x(4);
% else
% ut=x1ddd-f-b1*q1*abs(e)^(q1-1)*ed-f1*ed-f2*2*e*ed*sign(e)-((abs(e))^2+miu)*sign(s)-kk*rou1/(rou2+abs(e))*s-a2*abs(s)^(p2)*sign(s)-b2*abs(s)^(q2)*sign(s)-x(4);
% end
%x是两个变量，扩展状态空间
kp=25;
ki=0.005;
kd=3.75;
% s=(dtheta-x1dd)+k1*(theta-x1d)+k2*(itheta-x0d);
% ut=-f+x1dd-k1*(theta-x1d)-k2*(itheta-x0d)-miu*sign(s);
ut=-f+x1ddd+kp*(x1d-theta)+ki*(x0d-itheta)+kd*(x1dd-dtheta);
x0dot=x(2);
x1dot=x(3);
x2dot=f+ut+dd;
% dx=[x1dot;x2dot];
%观测器的x2^=x(3),d^=x(4)
% dx3=f+ut+x(4)-lamt1*sign(x(3)-x(2))-lamt2*(x(3)-x(2));
% dx4=-lamt3*(x(3)-x(2))-lamt4*abs(x(4)-dd)^(a/b)*sign(x(4)-dd)-lamt5*abs(x(4)-dd)^(l/h)*sign(x(4)-dd)+lamt6*(x(4)-dd)-lamt7*abs(x(3)-x(2))^(a/b)*sign(x(3)-x(2))-lamt8*abs(x(3)-x(2))^(l/h)*sign(x(3)-x(2));
% dx=[x1dot;x2dot;dx3;dx4];
dx=[x0dot;x1dot;x2dot];
end


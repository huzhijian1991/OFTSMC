close all;
clc;
%参数定义
m=0.5;l1=0.25;k=0.05;d=0.01;fai=0;g=9.8;
Ts=0.001;
Tend=20;
Tsegend=0:Ts:Tend;
x=zeros(length(Tsegend),2);
x(1,1)=0.5;%初始条件
x(1,2)=0;
t=zeros(2000,1);
Iq=0.01;
Error = 0;  %当前偏差
ErrorLast = 0;
ErrorSum = 0;       %累积偏差
KK=1;
DD=5;
for i=1:length(Tsegend)
    theta=x(i,1);
     dtheta=x(i,2);
  M=m*l1^2/20*20/3*(theta^3+6*theta-12*sin(theta)+6*theta*cos(theta))/theta^2;  
  C=-m*l1^2/3*((12*theta-30*sin(theta)+3*theta^2*sin(theta)+18*theta*cos(theta)+theta^3)/theta^6)*dtheta^2;
   G=-m*g*l1*((2*cos(theta-fai)-cos(fai))/theta^3+(sin(theta-fai)-sin(fai))/theta^3);
    K=k*theta;
   D=d*dtheta;
   f=(-C-G-K-D)/M;
   gx=1/M;
   t(i)=(i-1)*Ts;
   if t(i)>=0&&t(i)<8
       x1d=5;
     else if t(i)>8&&t(i)<=14
           x1d=-2;
       else if t(i)>14
            x1d=2;
           end
       end
   end 
%    if t(i)>=0&&t(i)<2*pi
%        dd(i)=sin(t(i));
%      else if t(i)>2*pi&&t(i)<=4*pi
%            dd(i)=sin(t(i))+0.5;
%        else if t(i)>4*pi
%             dd(i)=sin(t(i));
%            end
%        end
%    end 
x1dd=0;
x1ddd=0;
Error(i)=x(i,1)-x1d;
miu=0.01;
k1=10000;
k2=0.001;
s(i)=(Error(i)-ErrorLast)/Ts+k1*Error(i)+k2*ErrorSum;
ut(i)=-f+x1dd-k1*Error(i)-k2*ErrorSum-miu*sign(s(i));
ErrorSum=ErrorSum+Error(i);
ErrorLast=Error(i);
i=i+1;
x(i,1)=x(i-1,1)+Ts*(x(i-1,2));
x(i,2)=x(i-1,2)+Ts*(f+ut(i-1));

end

figure(1)
plot(t(:),x(1:length(t),1)-x1d,'Linewidth',1.3)
grid on
xl=xlabel('Time [s]');
y=ylabel('Tracking error [rad]');
set(xl,'Interpreter','latex');
set(y,'Interpreter','latex');
hh = legend('$e$');
set(hh, 'Interpreter','latex','FontSize',15,'FontWeight','normal');
% 
% figure(7)
% plot(t(:),dd(:),'Linewidth',1.5);
% grid on
% xl=xlabel('Time [s]');
% y=ylabel('Uncertainty and uncertainty estimation');
% set(xl,'Interpreter','latex');
% set(y,'Interpreter','latex');
% hh1 = legend('$d$','$\hat{d}$');
% set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 



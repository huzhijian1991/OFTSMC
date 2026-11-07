clc;clear all;
 dt=0.01;
[t,x]=ode45(@softRobSMCsingle,[0:dt:20],[ 0.5 0 0.1 0.2]);

x1d=5.*(t>=0&t<8)+(-2).*(t>8&t<=14)+2.*(t>14);
x1dd=0;
x1ddd=0;

% x1d=[sin(t);cos(t)];
% x1dd=[cos(t);-sin(t)];
% x1ddd=[-sin(t);-cos(t)];
% x1d=[5;2];
% x1dd=[0;0];
% x1ddd=[0;0];
K=0.5;
M=1;
L=5;
G=9.8;
J=100;
B=1;

f1=K/(M*L^2)*x(2)+(1+0.1*sin(t))*(-1/(M*L^2)*cos(x(3))-K/(M*L^2)*x(1)-G/L*sin(x(1)));
f2=(1+0.1*cos(t))*(-B/J*x(4)-K/J*(x(2)-x(1)));


% a=5;
% b=7;
% l=9;
% h=7;
% 
% a1=5;b1=5;a2=5;b2=5;
% p1=5/7;p2=5/7;
% q1=9/7;q2=9/7;%p1+q1=2
% xi=0.001;
% alpha=1;
% miu=1;
% kk=4;
% rou1=1;
% rou2=0.01;
% f1=(2-p1)*xi^(p1-1);
% f2=(p1-1)*xi^(p1-2);
% 
% for i=1:length(t)
%     e=x(i,1)-x1d(i);
%    ed=x(i,2)-x1dd;
% if norm(e)>xi
% s(i)=ed+alpha*e+b1*abs(e)^(q1)*sat(e)+a1*abs(e)^(p1)*sat(e);
% else 
% s(i)=ed+alpha*e+b1*abs(e)^(q1)*sat(e)+f1*e+f2*e^2*sat(e);
% end
% 
% m=0.5;l1=0.25;k=0.05;d=0.01;fai=0;g=9.8;
% theta=x(i,1);
% dtheta=x(i,2);
% 
% M(i)=m*l1^2/20*20/3*(theta^3+6*theta-12*sin(theta)+6*theta*cos(theta))/theta^2;
% C(i)=-m*l1^2/3*((12*theta-30*sin(theta)+3*theta^2*sin(theta)+18*theta*cos(theta)+theta^3)/theta^6)*dtheta^2;
% G(i)=-m*g*l1*((2*cos(theta-fai)-cos(fai))/theta^3+(sin(theta-fai)-sin(fai))/theta^3);
% K(i)=k*theta;
% D(i)=d*dtheta;
% f(i)=(-C-G-K-D)/M;
% gx=1/M;

%  dd(i)=sin(0.5*i*dt)+0.1;
% ds(i)=-(abs(e)^2+miu)*sat(s(i))-kk*rou1/(rou2+abs(e))*s(i)-a2*abs(s(i))^(p2)*sat(s(i))-b2*abs(s(i))^(q2)*sat(s(i));
% if norm(e)>xi
% ut=x1ddd-f-b1*q1*abs(e)^((l/h)-1)*ed-a1*(a/b)*abs(e)^((a/b)-1)*ed-alpha*ed-(abs(e)^2+miu)*sat(s(i))-kk*rou1/(rou2+abs(e))*s(i)-a2*abs(s(i))^(p2)*sat(s(i))-b2*abs(s(i))^(q2)*sat(s(i))-x(i,4);
% % ueq=x1ddd-f-b1*q1*abs(e)^((l/h)-1)*ed-a1*p1*abs(e)^((a/b)-1)*ed-alpha*ed;
% else
% ut=x1ddd-f-b1*q1*abs(e)^(q1-1)*ed-f1*ed-f2*2*e*ed*sat(e)-(abs(e)^2+miu)*sat(s(i))-kk*rou1/(rou2+abs(e))*s(i)-a2*abs(s(i))^(p2)*sat(s(i))-b2*abs(s(i))^(q2)*sat(s(i))-x(i,4);
% ueq=x1ddd-f-b1*q1*abs(e)^(q1-1)*ed-f1*ed-f2*2*e*ed*sat(e);
% end
% figure(1)
% plot(t,x(:,1)-x1d,'Linewidth',1.3)
% grid on
% xl=xlabel('Time [s]');
% y=ylabel('Tracking error e-OFTSMC [rad]');
% set(xl,'Interpreter','latex');
% set(y,'Interpreter','latex');
% % hh = legend('$e$');
% % set( hh, 'Interpreter','latex','FontSize',15,'FontWeight','normal');
%  
% figure(20)
% plot(t,f(:))
% 
%% %常规图像
% figure(3)
% plot(t,x(:,1),'-b',t,x1d(1:length(x1d)/2,1),'r--','Linewidth',1.5)
% grid on
% xl=xlabel('Time [s]');
% y=ylabel('Curvature tracking-OFTSMC [rad]');
% set(xl,'Interpreter','latex');
% set(y,'Interpreter','latex');
% hh = legend('$x_{1}$','${x}_{d}$');
% set(hh, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal');  
% figure(311)
% plot(t,x(:,2),'-b',t,x1d(length(x1d)/2+1:length(x1d),1),'r--','Linewidth',1.5)
% grid on
% xl=xlabel('Time [s]');
% y=ylabel('Curvature tracking-OFTSMC [rad]');
% set(xl,'Interpreter','latex');
% set(y,'Interpreter','latex');
% hh = legend('$x_{1}$','${x}_{d}$');
% set(hh, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal');  
% 
% 
% % save('C:\\Users\\Administrator\\Desktop\\11\\x1d.mat', 'x1d');
% % xx=x1d(:,1:3);
% % save('C:\\Users\\Administrator\\Desktop\\11\\x1.mat', 'xx');
% % % 
% %  figure(4)
% %  plot(t,s,'Linewidth',1.5)
% %  grid on
% %  xl=xlabel('Time [s]');
% %  y=ylabel('Sliding mode surface s');
% %  set(xl,'Interpreter','latex');
% %  set(y,'Interpreter','latex');
% % %  hh = legend('$s$');
% %  set(hh, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal');  
% % 
% % 
% % dd=(sin(t)).*(t>=0&t<2*pi)+(sin(t)+0.5).*(t>2*pi&t<=4*pi)+sin(t).*(t>4*pi);% dd=sin(t).*(t>=0&t<8)+(sin(t)+0.5).*(t>8&t<=14)+sin(t).*(t>14);
% % %  dd=sin(0.5*t)+0.1;
% % 
% % figure(7)
% % plot(t,dd,'-m',t,x(:,4),'--g','Linewidth',1.5);
% % grid on
% % xl=xlabel('Time [s]');
% % y=ylabel('Uncertainty and uncertainty estimation');
% % set(xl,'Interpreter','latex');
% % set(y,'Interpreter','latex');
% % hh1 = legend('$d$','$\hat{d}$');
% % set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 
% % 
% % figure(9)
% % plot(t,x(:,4)-dd,'Linewidth',1.3);
% % grid on
% % xl=xlabel('Time [s]');
% % y=ylabel('Uncertainty estimation error ${\rm e}_{2}$');
% % set(xl,'Interpreter','latex');
% % set(y,'Interpreter','latex');
% % % hh1 = legend('$e_{2}$');
% % set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 
% % 
% % figure(10)
% % plot(t,x(:,2),'-c',t,x(:,3),'--r','Linewidth',1.5);
% % grid on
% % xl=xlabel('Time [s]');
% % y=ylabel('Curvature derivative and its estimation [rad/s]');
% % set(xl,'Interpreter','latex');
% % set(y,'Interpreter','latex');
% % hh1 = legend('${x}_{2}$','$\hat{x}_{2}$');
% % set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 
% % figure(8)
% % plot(t,x(:,2)-x(:,3),'Linewidth',1.5);
% % grid on
% % xl=xlabel('Time [s]');
% % y=ylabel('Curvature derivative estimation error ${\rm e}_{1}$ [rad/s]');
% % set(xl,'Interpreter','latex');
% % set(y,'Interpreter','latex');
% % % hh1 = legend('${e}_{1}$');
% % set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 

%%
%专利图像
figure(1)
plot(t,x(:,1)-x1d(1:length(x1d),1),'k','Linewidth',1.3)
grid on
xl=xlabel('时间 (s)');
y=ylabel('曲率轨迹跟踪误差 ${\rm e}$ (rad)');
set(xl,'Interpreter');
set(y,'Interpreter');
hh = legend('$e$');
set( hh, 'Interpreter','latex','FontSize',15,'FontWeight','normal');
 
figure(3)
plot(t,x(:,1),'k',t,x1d,'k--','Linewidth',1.3)
grid on
xl=xlabel('时间 (s)');
y=ylabel('曲率与期望曲率 (rad)');
set(xl,'Interpreter');
set(y,'Interpreter');
hh = legend('$x_{1}$','${x}_{d}$');
set(hh, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal');  
% 
%  figure(4)
%  plot(t,s,'k','Linewidth',1.3)
%  grid on
%  xl=xlabel('时间 (s)');
%  y=ylabel('滑模面 ${\rm s}$');
%  set(xl,'Interpreter');
%  set(y,'Interpreter');
% %  hh = legend('$s$');
% %  set(hh, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal');  

%  figure(41)
%  plot(s(:), ds(:));
%  grid on
%  xl=xlabel('Time [s]');
%  y=ylabel('Sliding mode');
%  set(xl,'Interpreter','latex');
%  set(y,'Interpreter','latex');
%  hh = legend('$s$');
%  set(hh, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 

dd=sin(t).*(t>=0&t<2*pi)+(sin(t)+0.5).*(t>2*pi&t<=4*pi)+sin(t).*(t>4*pi);% dd=sin(t).*(t>=0&t<8)+(sin(t)+0.5).*(t>8&t<=14)+sin(t).*(t>14);
%  dd=sin(0.5*t)+0.1;

figure(7)
plot(t,dd,'--k',t,x(:,4),'k:','Linewidth',1.3);
grid on
xl=xlabel('时间 (s)');
y=ylabel('不确定性与不确定性估计值');
set(xl,'Interpreter');
set(y,'Interpreter');
hh1 = legend('$d$','$\hat{d}$');
set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 

figure(9)
plot(t,x(:,4)-dd,'k','Linewidth',1.3);
grid on
xl=xlabel('时间 (s)');
y=ylabel('不确定性估计误差 ${\rm e}_{2}$');
set(xl,'Interpreter');
set(y,'Interpreter');
% hh1 = legend('$e_{2}$');
% set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 

figure(10)
plot(t,x(:,2),'k--',t,x(:,3),'k:','Linewidth',1.3);
grid on
xl=xlabel('时间 (s)');
y=ylabel('曲率导数与曲率导数估计值 (rad/s)');
set(xl,'Interpreter');
set(y,'Interpreter');
hh1 = legend('${x}_{2}$','$\hat{x}_{2}$');
set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 

figure(8)
plot(t,x(:,2)-x(:,3),'k','Linewidth',1.3);
grid on
xl=xlabel('时间 (s)');
y=ylabel('曲率导数估计误差 ${\rm e}_{1}$(rad/s)');
set(xl,'Interpreter');
set(y,'Interpreter');
% hh1 = legend('${e}_{1}$');
set(hh1, 'Interpreter', 'latex','FontSize',15,'FontWeight','normal'); 







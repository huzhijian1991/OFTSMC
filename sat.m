function y=sat(x)
p=0.05;
if x>p
    y=1;
elseif abs(x)<=p
    y=(1/p)*x;
elseif x<-1*p
    y=-1;
end
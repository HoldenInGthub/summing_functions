clc
clear all
close all


%%
t1=-100:0.01:100;
t2=t1-50;
x1=sin(t1);
x2=sin(t2);
[t,x]=summing_functions(t1,x1,t2,x2);
plot(t,x);
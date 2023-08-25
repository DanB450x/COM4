clear; clc;
x=5;
n= 0:1:x-1;
y=(~n~=0);
subplot(1,1,1);
stem(n,y,'r', 'LineWidth',2);
title('impulso unitario centrado en n=0');
xlabel('n');
ylabel('y[n]');

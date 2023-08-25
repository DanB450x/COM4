clear; clc;
x = 5;
n= -x:1:x;
y=n>=0;
subplot(2,1,2);
stem(n,y,'g','LineWidth',2);
title('Escalon en n=0');
xlabel('n');
ylabel('y[n]');

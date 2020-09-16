clear;
close all;
clc;

n = 100;
lin = 1:n;
invlin = ones(1,n)./lin;
x = zeros(1,n);
for i = lin
    x(1,i:n) = x(1,i:n) + 1/i;
end
x = x.*lin;

plot(lin, x); hold on;
plot(lin, lin.*log(lin)+1,"r");
plot(lin, lin.*log2(lin)+1,"g");
legend('E(X^{(n)})', 'n log_2(n) +1', 'n log_e(n) +1', 'Location','northwest');
saveas(gca,'q1.png');

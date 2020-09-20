clear;
close all;
clc;

n = 100; % Range n - can be changed
lin = 1:n; % 1 to n
E = zeros(1,n); % 0
for i = lin % Looping over n
    E(1,i:n) = E(1,i:n) + 1/i; % 1/i is part of summation from k=1 to k=j for all j>i
end
E = E.*lin; % Expectation is n*summation(1/i) for i in 1 to n

plot(lin, E); hold on; % Plot Expectation
plot(lin, lin.*log(lin)+1,"r"); % Plot n log_e(n) + 1
plot(lin, lin.*log2(lin)+1,"g"); % Plot n log_2(n) + 1
legend('f(n) = E(X^{(n)})', 'f(n) = n log_2(n) +1', 'f(n) = n log_e(n) +1', 'Location','northwest'); % Legend
xlabel('n'); % X-axis Label
ylabel('f(n)'); % Y-axis Label
saveas(gca,'q1.png'); % Save figure

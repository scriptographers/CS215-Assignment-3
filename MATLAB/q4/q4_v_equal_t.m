clc;
clear;
close all;
rng(42); % Seed for reproducible results

% Part (a)
N = 1000;
X = normrnd(0, 4, [N 1]); % Note: it's mu, sigma and not mu, sigma^2
% Train-Test split
n = 750;
T = X(1:n); % Test set

% Part (e)
V = T;
m = length(V);

% Part (c): Subpart I
sigmas = [0.001 0.1 0.2 0.9 1 2 3 5 10 20 100];
ll = zeros(1, length(sigmas));
for s = 1:length(sigmas)
    sum_1 = 0;
    for j = 1:m
        numerator   = -((T - V(j)).^2);
        denominator = 2*(sigmas(s)^2);
        term_1 = exp(numerator ./ denominator);
        sum_1 = sum_1 + log(sum(term_1));
    end
    ll(s) = sum_1 - m*log(n*sigmas(s)*sqrt(2*pi));
end

% Compute the maximum:
ll_max = max(ll);
sigma_best_1 = sigmas(ll == ll_max);

% Printing
fprintf("Best sigma that maximizes the LL:  %.4f\n", sigma_best_1);

% Plotting
figure;
plot(log(sigmas), ll);
hold on;
point = plot(log(sigma_best_1), ll_max, "ro");
set(point, 'MarkerFaceColor', get(point,'Color')); % fills the dot
xline(log(sigma_best_1), "--");
yline(ll_max, "--");
xlabel("log(\sigma)");
ylabel("log-likelihood");
ylim([min(ll)-100 max(ll)+100]);
title("log-likelihood vs log(\sigma)");
hold off;

% Part (c): Subpart II
x = -8:0.1:8;
estimates = zeros(1, length(x));
for i = 1:length(x)
    numerator   = -((T-x(i)).^2);
    denominator = 2*(sigma_best_1^2);
    estimates(i) = (1/(n*sigma_best_1*sqrt(2*pi)))*sum(exp(numerator ./ denominator));
end
actual = normpdf(x, 0, 4);

% Plotting
figure;
plot(x, estimates);
hold on;
plot(x, actual, "r");
xlabel("$x$", "Interpreter", "Latex");
ylabel("$\hat{p_n}(x; \sigma)$", "Interpreter", "Latex");
ylim([min(min(actual), min(estimates))-0.02 max(max(actual), max(estimates))+0.02]);
title("$\hat{p_n}(x; \sigma)$ vs x", "Interpreter", "Latex");
lgd = legend(sprintf("Estimate for sigma = %.4f", sigma_best_1), "True PDF");
lgd.FontSize = 9;
hold off;

% Part (d): Subpart I
p_x = normpdf(V, 0, 4);
D = zeros(1, length(sigmas));
for s = 1:length(sigmas)
    sum_1 = 0;
    for j = 1:m
        numerator   = -((T - V(j)).^2);
        denominator = 2*(sigmas(s)^2);
        d = (1/(n*sigmas(s)*sqrt(2*pi)))*sum(exp(numerator ./ denominator));
        sum_1 = sum_1 + (p_x(j) - d).^2;
    end
    D(s) = sum_1;
end

min_D = min(D);
sigma_best_2 = sigmas(D == min_D);
fprintf("Best sigma that minimizes D:  %.4f\n", sigma_best_2);
fprintf("The value of D at this sigma(= %.4f) is:  %.4f\n", sigma_best_2, min_D);
fprintf("D value for the sigma parameter that yielded the best LL:  %.4f\n", D(sigmas == sigma_best_1));

figure;
plot(log(sigmas), D);
hold on;
point = plot(log(sigma_best_2), min_D, "ro");
set(point, 'MarkerFaceColor', get(point,'Color')); % fills the dot
xline(log(sigma_best_2), "--");
yline(min_D, "--");
ylim([min(D)-1, max(D)+1]);
xlabel("$\log(\sigma)$", "Interpreter", "Latex");
ylabel("D", "Interpreter", "Latex");
title("D vs $log(\sigma)$", "Interpreter", "Latex");
hold off;

% Part (d): Subpart II
x = -8:0.1:8;
estimates_2 = zeros(1, length(x));
for i = 1:length(x)
    numerator   = -((T-x(i)).^2);
    denominator = 2*(sigma_best_2^2);
    estimates_2(i) = (1/(n*sigma_best_2*sqrt(2*pi)))*sum(exp(numerator ./ denominator));
end

% Plotting
figure;
plot(x, estimates_2);
hold on;
plot(x, actual, "r");
xlabel("$x$", "Interpreter", "Latex");
ylabel("$\hat{p_n}(x; \sigma)$", "Interpreter", "Latex");
ylim([min(min(actual), min(estimates_2))-0.02 max(max(actual), max(estimates_2))+0.02]);
title("$\hat{p_n}(x; \sigma)$ vs x", "Interpreter", "Latex");
lgd = legend(sprintf("Estimate for sigma = %.4f", sigma_best_2), "True PDF");
lgd.FontSize = 9;
hold off;
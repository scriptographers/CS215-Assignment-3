clc;
clear;

% Part (a)
N = 1000;
X = normrnd(0, 4, [N 1]); % Note: it's mu, sigma and not mu, sigma^2
% Train-Test split
rng(10); % Seed for reproducible results
random_indices = randperm(N);
n = 750;
T = X(random_indices(1:n)); % Test set
m = 250;
V = X(random_indices(n+1:end)); % Validation set

% Part (c)
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
sigma_max = sigmas(ll == ll_max);

% Printing
fprintf("%.4f\n", sigma_max);

% Plotting
plot(log(sigmas), ll);
hold on;
point = plot(log(sigma_max), ll_max, "ro");
set(point, 'MarkerFaceColor', get(point,'Color')); % fills the dot
xline(log(sigma_max), "--");
yline(ll_max, "--");
xlabel("log(\sigma)");
ylabel("log-likelihood");
ylim([min(ll)-100 max(ll)+100]);
title("log-likelihood vs log(\sigma)");

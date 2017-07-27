% Venkatraman Renganathan
% W_MSR Code studying the spoofing attack in a stochastic manner
% Input initial conditions of node values
% See the consensus converging despite having F malicious nodes
clear all; close all; clc;
m = 8;
F = 1;
delay = 10;
time_span = 50;
repeats = 1000; % Monte-carlo Simulation
mean_x = zeros(repeats, 1);
diff_mean = zeros(repeats, 1);
delay = 0;
threshold_vector = 0:0.1:1;
diff_mean_estimate = zeros(length(threshold_vector),1);
x_0 = [50 51 52 53 54 55 300 300];
legit_mean_x0 = mean(x_0(1:end-2));
%%%%%%%%%%%%% Spoofing 1 Node %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for z = 1:length(threshold_vector)    
    for i = 1:repeats        
        x = stochastic_wmsr(m, F, time_span, delay, threshold_vector(z), x_0);
        [x_row,x_col] = size(x);
        if(x_row == 8)
            mean_x(i) = mean(x(1:end-2,end));
        else
            mean_x(i) = mean(x(1:end-1,end));
        end
        diff_mean(i) = mean_x(i) - legit_mean_x0;
    end
    diff_mean_estimate(z) = mean(diff_mean);    
end
% Monte-carlo estimate to find probability of attack being detected will
% affect the final consensus. In short, we will find out the estimated
% probability of spoofing attack being detected and mitigated using our
% algorithm.

figure;
plot(threshold_vector, diff_mean_estimate);
title('Difference Between MC Estimate & Initial Consensus vs Spoofing Threshold');
xlabel('Spoofing Threshold');
ylabel('Difference in Consensus Value');
a = findobj(gcf, 'type', 'axes');
h = findobj(gcf, 'type', 'line');
set(h, 'linewidth', 5);
set(a, 'linewidth', 4);
set(a, 'FontSize', 24);
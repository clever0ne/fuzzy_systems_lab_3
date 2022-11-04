clc; clear; close all;

g = 9.81;
time = 100;
hmin = 0;
hmax = 100;

s_tank = 8.0;
k_gate = 0.8;
k_flow = 0.2;

n = 21;
x1min = -1;
x1max =  1;
x2min = -0.2;
x2max =  0.2;
ymin  = -1.5;
ymax  =  1.5;

k1 = 0.8;
k2 = 1.2;
k3 = 0.4;
k4 = 1.6;

x1 = linspace(x1min, x1max, n);
x2 = linspace(x2min, x2max, n);
y = linspace(ymin, ymax, n);
x = reshape(cat(3, repmat(x1, length(x2), 1)', ...
                   repmat(x2, length(x1), 1)), [], 2, 1);

fis1 = readfis('../model/mamdani_trimf_3in_trimf_5out.fis');
fis2 = readfis('../model/mamdani_trimf_3in_gaussmf_5out.fis');
fis3 = readfis('../model/mamdani_gaussmf_3in_trimf_5out.fis');
fis4 = readfis('../model/mamdani_gaussmf_3in_gaussmf_5out.fis');
system = '../system/liquid_level_control.slx';

print_membership_functions_plot('error', x1, 3, 'trimf', 'Triangle MF', 'error_trimf_3in.emf');
print_membership_functions_plot('rate',  x2, 3, 'trimf', 'Triangle MF', 'rate_trimf_3in.emf' );
print_membership_functions_plot('speed', y,  5, 'trimf', 'Triangle MF', 'speed_trimf_5in.emf');

print_membership_functions_plot('error', x1, 3, 'gaussmf', 'Gauss MF', 'error_gaussmf_3in.emf');
print_membership_functions_plot('rate',  x2, 3, 'gaussmf', 'Gauss MF', 'rate_gaussmf_3in.emf' );
print_membership_functions_plot('speed', y,  5, 'gaussmf', 'Gauss MF', 'speed_gaussmf_5in.emf');

y1 = reshape(evalfis(fis1, x), length(x1), length(x2))';
print_surface_plot(x1, x2, y1, 'Mamdani Triangle MF System', ...
                   'mamdani_trimf_3in_trimf_5out_surface');

Stank = s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Mamdani Triangle MF System Step Response', ...
                         'mamdani_trimf_3in_trimf_5out_step_response');

y2 = reshape(evalfis(fis2, x), length(x1), length(x2))';
print_surface_plot(x1, x2, y2, 'Mamdani Triangle-Gauss MF System', ...
                   'mamdani_trimf_3in_gaussmf_5out_surface');

Stank = s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis2;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Mamdani Triangle-Gauss MF System Step Response', ...
                         'mamdani_trimf_3in_gaussmf_5out_step_response');

y3 = reshape(evalfis(fis3, x), length(x1), length(x2))';
print_surface_plot(x1, x2, y3, 'Mamdani Gauss-Triangle MF System', ...
                   'mamdani_gaussmf_3in_trimf_5out_surface');

Stank = s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis3;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Mamdani Gauss-Triangle MF System Step Response', ...
                         'mamdani_gaussmf_3in_trimf_5out_step_response');

y4 = reshape(evalfis(fis4, x), length(x1), length(x2))';
print_surface_plot(x1, x2, y4, 'Mamdani Gauss MF System', ...
                   'mamdani_gaussmf_3in_gaussmf_5out_surface');

Stank = s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis4;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Mamdani Gauss MF System Step Response', ...
                         'mamdani_gaussmf_3in_gaussmf_5out_step_response');

Stank = s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, '', 'mamdani_3in_5out_step_response');

Stank = k1 * s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 1st Parameter –20 %', ...
                         'mamdani_3in_5out_stank_k1_step_response');

Stank = k2 * s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 1st Parameter +20 %', ... 
                         'mamdani_3in_5out_stank_k2_step_response');

Stank = k3 * s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 1st Parameter –60 %', ...
                         'mamdani_3in_5out_stank_k3_step_response');

Stank = k4 * s_tank; Kgate = k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 1st Parameter +60 %', ...
                         'mamdani_3in_5out_stank_k4_step_response');

Stank = s_tank; Kgate = k1 * k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 2nd Parameter –20 %', ...
                         'mamdani_3in_5out_kgate_k1_step_response');

Stank = s_tank; Kgate = k2 * k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 2nd Parameter +20 %', ...
                         'mamdani_3in_5out_kgate_k2_step_response');

Stank = s_tank; Kgate = k3 * k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 2nd Parameter –60 %', ...
                         'mamdani_3in_5out_kgate_k3_step_response');

Stank = s_tank; Kgate = k4 * k_gate; Kflow = k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 2nd Parameter +60 %', ...
                         'mamdani_3in_5out_kgate_k4_step_response');

Stank = s_tank; Kgate = k_gate; Kflow = k1 * k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 3rd Parameter –20 %', ...
                         'mamdani_3in_5out_kflow_k1_step_response');

Stank = s_tank; Kgate = k_gate; Kflow = k2 * k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 3rd Parameter +20 %', ...
                         'mamdani_3in_5out_kflow_k2_step_response');

Stank = s_tank; Kgate = k_gate; Kflow = k3 * k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 3rd Parameter –60 %', ...
                         'mamdani_3in_5out_kflow_k3_step_response');

Stank = s_tank; Kgate = k_gate; Kflow = k4 * k_flow; fis = fis1;
sim(system, time);
t = data(:, 1); hd = data(:, 2); h = data(:, 3);
print_step_response_plot(t, hd, h, 'Step Response 3rd Parameter +60 %', ...
                         'mamdani_3in_5out_kflow_k4_step_response');

print_membership_functions_plot('error', x1, 3, 'trimf', '', 'error_3in.emf');
print_membership_functions_plot('rate',  x2, 3, 'trimf', '', 'rate_3in.emf' );
print_membership_functions_plot('speed', y,  5, 'trimf', '', 'speed_5in.emf');
print_surface_plot(x1, x2, y1, '', 'mamdani_3in_5out_surface');

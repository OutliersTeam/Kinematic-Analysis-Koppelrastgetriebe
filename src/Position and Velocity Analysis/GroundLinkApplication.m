clear all;
clc; clf;

origin = [0 0];
radius = 0.5;
side_len = 5;
N = 15;
dash_len = 0.5;
linewidth = 1;

figure(1)
hold on
GroundLink(origin, radius, side_len , N, dash_len, linewidth)
axis([-1 1 -1 1]*5)
hold off
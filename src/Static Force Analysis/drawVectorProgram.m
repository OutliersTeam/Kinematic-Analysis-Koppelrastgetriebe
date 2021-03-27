clc; clear all;

hold on;
pointA0 = [0 0];
pointA1 = [5.0473 5.0473];
Dir_A0A1 = findDirection(pointA0, pointA1);
point_a0 = [0,0]
a0a1 = 7.138;
% a0a1 is perpendicular to A0A1
point_a1 = point_a0 + a0a1*[Dir_A0A1(2), -Dir_A0A1(1)]

axis([-10 10 -10 10])
drawVector(point_a0,point_a1,'#EA4335',1)
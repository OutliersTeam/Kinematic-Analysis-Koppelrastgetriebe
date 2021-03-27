function GroundLink(origin, radius, side_len , N, dash_len, linewidth)

% function parameters :-
% origin   : input coordinates
% radius   : radius of the circle
% side_len : length of sides of the triangle
% N        : no of dashes for the ground
% dash_len : length of dash line
% linewidth: width of the plotted line

% circle plots
% angle = linspace(0,2*pi,360);
% plot(radius*cos(angle)+origin(1), radius*sin(angle)+origin(2),...
%     ,'k','LineWidth',0);

% plots triangle
conv_rad = @(deg) deg*(pi/180.0); % inline function to convert deg to rad
pointA = origin + side_len*[cos(conv_rad(300)) sin(conv_rad(300))];
pointB = origin + side_len*[cos(conv_rad(240)) sin(conv_rad(240))];

plot([origin(1) pointA(1)], [origin(2) pointA(2)],...
    'k','LineWidth',linewidth);
plot([origin(1) pointB(1)], [origin(2) pointB(2)],...
    'k','LineWidth',linewidth);
plot([pointA(1) pointB(1)], [pointA(2) pointB(2)],...
    'k','LineWidth',linewidth);

slices = linspace(pointA(1) , pointB(1), N); % slices into N no of x-values.

for index = 1:length(slices)
    pointC = [slices(index) pointA(2)] + dash_len*([cos(conv_rad(45)) -sin(conv_rad(45))]);
    plot([slices(index) pointC(1)] , [pointA(2) pointC(2)] ,...
    'k','LineWidth',2);
end

end











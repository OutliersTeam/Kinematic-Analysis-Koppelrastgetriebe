function Rectangle(origin, rec_len, rec_height , N, dash_len, linewidth)

% rec_origin : for rectangle origin
% rec_len    : length of rectangle
% rec_height : height of rectangle
% N          : no of dashes to ground link
% dash_len   : length of each dash
% linewidth  : width of each dash

rectangle('Position',[origin(1) origin(2) rec_len rec_height],...
    'EdgeColor','k','LineWidth',linewidth);

slices = linspace(origin(1) , origin(1)+rec_len, N); % slices into N no of x-values.
conv_rad = @(deg) deg*(pi/180.0);

for index = 1:length(slices)
    pointC = [slices(index) origin(2)] + dash_len*([cos(conv_rad(45)) -sin(conv_rad(45))]);
    plot([slices(index) pointC(1)], [origin(2) pointC(2)] ,...
    'k','LineWidth',linewidth);
end
axis([-1 1 -1 1]*25)
axis equal

end
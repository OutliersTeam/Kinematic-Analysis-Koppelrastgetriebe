clear all;                                                          
clc; clf;
%% Traced Values with same ratios as the image on the website 
pointA0 = [0 0]; % Origin
A0A1 = 7.138;    % Crank
A1B1 = 21.354;   % ConnectingRod
C1A1 = 12.354;   % ConnectingRod Extenstion
pointD0 = -[30.464, 20.972]; % [30 20];
D0D = 22.198;    % Follower
DC1 = 18.011;    % Follower
dirSliding = [1 0]; % direction of sliding

LinkWidth = 3;
MarkerSize = 5;
thetaSliding = atan2(dirSliding(2),dirSliding(1));

%% Position Analysis - Calculations 

% Position Analysis :-
% Line-Circle Intersection @ A1B1
% Circle-Circle Intersection @ D0D1 & @ DC1

angle_offset = 50; % it is used to give a offset in angle below the x-axis.

% It creates an array of elements to make proper 360 degree rotation by taking angle_offset as input
angleA0degArray = [45]; %[((360-angle_offset):-1:0) , (360:-1:(360-angle_offset))]; 

figure(1)
grid on
subplot(121)

for index = 1:length(angleA0degArray) % Iterates through all the indexes in the angleA0degArray
    angleA0rad = angleA0degArray(index)*(pi/180.0); % converting degrees to radians of input angle
    
    pointA1 = pointA0 + A0A1*([cos(angleA0rad) sin(angleA0rad)]); % finds pointA1

    SlidingLineStart = pointA0 - 500*dirSliding; % start of slider's sliding region
    SlidingLineEnd   = pointA0 + 500*dirSliding; % end of slider's sliding region
    
    % For point B1, It will return two values, but we take first value as that is
    % required to our problem
    [pointB1, temp] = LineCircleIntersection(SlidingLineStart, SlidingLineEnd, pointA1, A1B1);

    % if the pointB1 is not a point then the program should terminate
    if (length(pointB1) ~= 2) 
       return; 
    end
    
    lengthA1B1 = norm(pointA1-pointB1); % stores the length between pointA1 and pointB1
    dirA1B1 = (pointA1 - pointB1)/lengthA1B1; % stores direction of pointA1 and pointB1

    pointC1 = pointA1 + dirA1B1*C1A1; % Calculates and stores pointC1
    
    %For point D, It will return two values, but we take first value as that is
    % required to our problem
    [pointD, temp1] = CircleCircleIntersection(pointD0, D0D, pointC1, DC1);
    %[D1, temp2] = LineCircleIntersection(SlidingLineStart, SlidingLineEnd, pointC1, DC1)
    
    plot(pointA0(1), pointA0(2),'r-.');
    hold on
    %GroundLink(origin, radius, side_len , N, dash_len, linewidth)
    GroundLink(pointA0, 2, 3, 4, 1, 1.5) % pointA0 Ground Link
    GroundLink(pointD0, 2, 3, 4, 1, 1.5) % pointD0 Ground Link
    
    Rectangle([10.5 -2.75], 22, 5.5 , 10, 2, 2) % draws a slider shell
    plot(pointA0(1), pointA0(2),'r-.');
    
    % plot a slide along sliding direction
    plot([SlidingLineStart(1) SlidingLineEnd(1)], [SlidingLineStart(2) SlidingLineEnd(2)], 'k-.');
    
    % Plots Link A0A1
    plot([pointA0(1) pointA1(1)], [pointA0(2) pointA1(2)],...
        'Color','#EA4335',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)% link A0A1

    % Plots Link A1B1
    plot([pointA1(1) pointB1(1)], [pointA1(2) pointB1(2)],...
        'Color','#FBBC05',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)% link A0A1

    % Plots Link A1C1
    plot([pointA1(1) pointC1(1)], [pointA1(2) pointC1(2)],...
        'Color','#FBBC05',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)

    % Plots Link D1C1
    plot([pointC1(1) pointD(1)], [pointC1(2) pointD(2)],...
        'Color','#4285F4',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)

    % Plots Link D0D1
    plot([pointD0(1) pointD(1)], [pointD0(2) pointD(2)],...
        'Color','#34A853',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)
    
    SliderShape(6,4, pointB1(1), pointB1(2),thetaSliding); % plots slider 
    
    title('Position Analysis');
    axis([-40 40 -30 20]);
    hold off;
    drawnow();
    %pause(0.0000009);
end

% this below code is used to specify the points, titles, scale, omega and links
title('Position Analysis');
text(pointD0(1)+3, pointD0(2), 'D0');
text(pointD(1) , pointD(2)+3,  'D' );
text(pointC1(1)-1, pointC1(2)-3, 'C1');
text(pointB1(1), pointB1(2)+5, 'B1');
if angleA0degArray(index) >=90 && angleA0degArray(index) <=180
    text(pointA0(1)-5, pointA0(2)-2, 'A0');
    text(pointA1(1)-1, pointA1(2)+4, 'A1');
else
    text(pointA0(1)-2, pointA0(2)+3, 'A0');
    text(pointA1(1)-1, pointA1(2)-2, 'A1');
end

legend_data = sprintf('Scale: 1mm = 1mm\nomega = 1 rad/s CW');
text(20,15, legend_data)


%% Determining the Direction of each link(Unit Vector)

Dir_A0A1 = findDirection(pointA0, pointA1);
Dir_A1B1 = findDirection(pointA1, pointB1);
Dir_D0D  = findDirection(pointD0, pointD);
Dir_DC1  = findDirection(pointD, pointC1);
%% Velocity Polygon

omega = 1; %rad/s
anim = 0; % 0-No animation, 1- animation
subplot(122);
title('Velocity Analysis')
point_a0 = [0,0];
a0a1 = A0A1*omega;

axis([-10 10 -15 10]);
hold on;
grid on;

%Determining all the points in the Velocity Polygon
point_a1 = point_a0 + a0a1*[Dir_A0A1(2), -Dir_A0A1(1)];
point_b1 = LinesIntersection(point_a0, [1 0], point_a1,[Dir_A1B1(2), -Dir_A1B1(1)] );

VelB1wrtA1 = point_b1 - point_a1;
VelC1wrtA1 = norm(VelB1wrtA1) * (C1A1/A1B1);
point_c1 = point_a1 + VelC1wrtA1*[Dir_A1B1(2), -Dir_A1B1(1)];
point_d = LinesIntersection(point_a0, [Dir_D0D(2), -Dir_D0D(1)], point_c1, [Dir_DC1(2), -Dir_DC1(1)])

%Plotting point a1
text(point_a0(1), point_a0(2)+0.5, 'a0, d0');
drawVector(point_a0,point_a1,'#EA4335',2,anim);
text(point_a1(1)+0.5, point_a1(2), 'a1');

%Plotting point b1
ContructionLineAnimation(point_a0,[1 0],'#000000',anim);
ContructionLineAnimation(point_a1,[Dir_A1B1(2), -Dir_A1B1(1)],'#FBBC05',anim);
text(point_b1(1)+0.5, point_b1(2)-0.5, 'b1');
drawVector(point_a0,point_b1,'#000000',2,anim);
if angleA0degArray(index) ~= 180
    drawVector(point_a1,point_b1,'#FBBC05',2,anim);
end

% Plotting point a1
plot(point_a1(1),point_a1(2),...
        'Color','#000000',...
        'Marker','o',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 0 0],...
        'MarkerSize',4);

%Plotting point c1
drawVector(point_a1,point_c1,'#FBBC05',2,anim);
text(point_c1(1)+0.5, point_c1(2)+1,'c1');
plot(point_a1(1),point_a1(2),...
        'Color','#000000',...
        'Marker','o',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 0 0],...
        'MarkerSize',4);

%Obtaining point d
ContructionLineAnimation(point_a0,[Dir_D0D(2), -Dir_D0D(1)],'#34A853',anim);
ContructionLineAnimation(point_c1,[Dir_DC1(2), -Dir_DC1(1)],'#4285F4',anim);
text(point_d(1)-0.5, point_d(2)-0.5, 'd');
if angleA0degArray(index) ~= 180
    drawVector(point_a0,point_d,'#34A853',1,anim);
end
drawVector(point_c1,point_d,'#4285F4',1,anim);

plot(point_a0(1),point_a0(2),...
        'Color','#000000',...
        'Marker','o',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 0 0],...
        'MarkerSize',4)
plot(point_a1(1),point_a1(2),...
        'Color','#000000',...
        'Marker','o',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 0 0],...
        'MarkerSize',4)
plot(point_b1(1),point_b1(2),...
        'Color','#000000',...
        'Marker','o',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 0 0],...
        'MarkerSize',4)
plot(point_c1(1),point_c1(2),...
        'Color','#000000',...
        'Marker','o',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 0 0],...
        'MarkerSize',4)
plot(point_d(1),point_d(2),...
        'Color','#000000',...
        'Marker','o',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 0 0],...
        'MarkerSize',4)
    
legend_data = sprintf('Scale: 1mm = 1mm/s');
text(4,9, legend_data)

hold off

%Displaying final results:
fprintf('Absolute Velocities: \n');
fprintf('Velocity of a1 wrt a0 = %.4f mm/s\n',norm(point_a0-point_a1));
fprintf('Velocity of b1 wrt a0 = %.4 mm/s\n',norm(point_a0-point_b1));
fprintf('Velocity of c1 wrt a0 = %.4 mm/s\n',norm(point_a0-point_c1));
fprintf('Velocity of d wrt a0 = %.4f mm/s\n\n',norm(point_a0-point_d));

fprintf('Relative Velocities: \n');
fprintf('Velocity of b1 wrt a1 = %.4f mm/s\n',norm(point_a1-point_b1));
fprintf('Velocity of c1 wrt a1 = %.4f mm/s\n',norm(point_a1-point_c1));
fprintf('Velocity of d wrt c1 = %.4f mm/s\n',norm(point_c1-point_d));

fprintf('Angular Velocities: \n');
fprintf('omega of A0A1 = %.4f rad/s CW\n',1);
fprintf('omega of B1C1 = %.4f rad/s ACW\n',(norm(point_a0-point_b1)/A1B1));
fprintf('omega of DC1 = %.4f rad/s CW\n',(norm(point_a0-point_d)/DC1));
fprintf('omega of DD0 = %.4f rad/s CW\n',(norm(point_a0-point_d)/D0D));
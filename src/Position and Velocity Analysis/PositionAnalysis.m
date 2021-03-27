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
angleA0degArray = [((360-angle_offset):-1:0) , (360:-1:(360-angle_offset))]; 

figure(1)

% We are allocating the size of these array's to zeros to increase
% processing speed in for loop.
pointA1TraceXArray = zeros([1 length(angleA0degArray)]);
pointA1TraceYArray = zeros([1 length(angleA0degArray)]);
pointC1TraceXArray = zeros([1 length(angleA0degArray)]);
pointC1TraceYArray = zeros([1 length(angleA0degArray)]);
pointDTraceXArray  = zeros([1 length(angleA0degArray)]);
pointDTraceYArray  = zeros([1 length(angleA0degArray)]);
pointB1TraceXArray = zeros([1 length(angleA0degArray)]);
pointB1TraceYArray = zeros([1 length(angleA0degArray)]);

for index = 1:length(angleA0degArray) % Iterates through all the indexes in the angleA0degArray
    angleA0rad = angleA0degArray(index)*(pi/180.0); % converting degrees to radians of input angle
    
    pointA1 = pointA0 + A0A1*([cos(angleA0rad) sin(angleA0rad)]); % finds pointA1

    SlidingLineStart = pointA0 - 500*dirSliding; % start of slider's sliding region
    SlidingLineEnd   = pointA0 + 500*dirSliding; % end of slider's sliding region
    
    % For point B1, It will return two values, but we take first value as that is
    % required to our problem
    [pointB1, ~] = LineCircleIntersection(SlidingLineStart, SlidingLineEnd, pointA1, A1B1);

    % if the pointB1 is not a point then the program should terminate
    if (length(pointB1) ~= 2) 
       return; 
    end
    
    lengthA1B1 = norm(pointA1-pointB1); % stores the length between pointA1 and pointB1
    dirA1B1 = (pointA1 - pointB1)/lengthA1B1; % stores direction of pointA1 and pointB1

    pointC1 = pointA1 + dirA1B1*C1A1; % Calculates and stores pointC1
    
    %For point D, It will return two values, but we take first value as that is
    % required to our problem
    [pointD, ~] = CircleCircleIntersection(pointD0, D0D, pointC1, DC1);

    % adding present values to the Trace arrays.
    pointA1TraceXArray(index) = pointA1(1);
    pointA1TraceYArray(index) = pointA1(2);
    pointC1TraceXArray(index) = pointC1(1);
    pointC1TraceYArray(index) = pointC1(2);
    pointDTraceXArray(index)  = pointD(1);
    pointDTraceYArray(index)  = pointD(2);
    pointB1TraceXArray(index) = pointB1(1);
    pointB1TraceYArray(index) = pointB1(2);
    
    plot(pointA0(1), pointA0(2),'r-.');
    hold on
    %GroundLink(origin, radius, side_len , N, dash_len, linewidth) - function parameters
    GroundLink(pointA0, 2, 3, 4, 1, 1.5) % pointA0 Ground Link
    GroundLink(pointD0, 2, 3, 4, 1, 1.5) % pointD0 Ground Link
    
    Rectangle([10.5 -2.75], 22, 5.5 , 10, 2, 2) % draws a slider shell
    plot(pointA0(1), pointA0(2),'r-.');
    
    % plot a slide along sliding direction
    plot([SlidingLineStart(1) SlidingLineEnd(1)], [SlidingLineStart(2) SlidingLineEnd(2)], 'k-.');
    
    % Plots Link A0A1
    plot([pointA0(1) pointA1(1)], [pointA0(2) pointA1(2)],'-ro',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)% link A0A1

    % Plots Link A1B1
    plot([pointA1(1) pointB1(1)], [pointA1(2) pointB1(2)],'-ko',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)% link A0A1

    % Plots Link A1C1
    plot([pointA1(1) pointC1(1)], [pointA1(2) pointC1(2)],'-ko',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)

    % Plots Link D1C1
    plot([pointC1(1) pointD(1)], [pointC1(2) pointD(2)],'-ko',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)

    % Plots Link D0D1
    plot([pointD0(1) pointD(1)], [pointD0(2) pointD(2)],'-go',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)
    
    % Plots Trace of A1, C1, D1, B1
    plot(pointA1TraceXArray(:,(1:index)), pointA1TraceYArray(:,(1:index)), 'r-.');
    plot(pointC1TraceXArray(:,(1:index)), pointC1TraceYArray(:,(1:index)), 'b-.');
    plot(pointDTraceXArray(:,(1:index)),  pointDTraceYArray(:,(1:index)),  'g-.');
    plot(pointB1TraceXArray(:,(1:index)), pointB1TraceYArray(:,(1:index)),...
        'Color','#c2c0c0','LineStyle','-.','LineWidth',2);
    
    SliderShape(6,4, pointB1(1), pointB1(2),thetaSliding); % plots slider 
    
    axis(40*[-1 1 -1 1]);
    title('Position Analysis')
    hold off;
    drawnow();
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

legend_data = sprintf('Scale: 1mm = 1mm\nomega = 1 rad/s CW\nLinks:\n#1 - A0,D0\n#2 - A0A1\n#3 - C1B1\n#4 - B1\n#5 - DC1\n#6 - D0D');
text(20,25, legend_data)
axis equal
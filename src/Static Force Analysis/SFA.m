clc;clear all ;clf;
%% Exact Calculated values with same ratios as 
pointA0 = [0 0]; % Origin
A0A1 = 7.138;    % Crank
A1B1 = 21.354;   % ConnectingRod
C1A1 = 12.354;   % ConnectingRod Extenstion
pointD0 = -[30.464, 20.972]; % [30 20];
D0D = 22.198;    % Follower
DC1 = 18.011;    % Follower
dirSliding = [1 0]; % direction of sliding
% Line-Circle Intersection @ A1B1
% Circle-Circle Intersection @ D0D1 & @ DC1
theta_force=0;% angle at which force ia acting
Force_extapplied=10;% magnitude of the force
LinkWidth = 3;
MarkerSize = 5;
thetaSliding = atan2(dirSliding(2),dirSliding(1));
%% Actual Calculations 

angle_offset = 30;
angleA0degArray = [-50]; %[((360-angle_offset):-1:0) , (360:-1:(360-angle_offset))]; % 360:-1:0; %0:1:360;

figure(1)
grid on
subplot(131)

for index = 1:length(angleA0degArray)
    angleA0rad = angleA0degArray(index)*(pi/180.0); % converting degrees to radians
    
    pointA1 = pointA0 + A0A1*([cos(angleA0rad) sin(angleA0rad)]);
    
    SlidingLineStart = pointA0 - 500*dirSliding;
    SlidingLineEnd   = pointA0 + 500*dirSliding;
    [pointB1, temp] = LineCircleIntersection(SlidingLineStart, SlidingLineEnd, pointA1, A1B1);

    % if the pointB1 is not a point then the program should terminate
    if (length(pointB1) ~= 2) 
       return; 
    end
    
    lengthA1B1 = norm(pointA1-pointB1);
    dirA1B1 = (pointA1 - pointB1)/lengthA1B1;

    pointC1 = pointA1 + dirA1B1*C1A1;
    %For point D
    [pointD, temp1] = CircleCircleIntersection(pointD0, D0D, pointC1, DC1);
    %[D1, temp2] = LineCircleIntersection(SlidingLineStart, SlidingLineEnd, pointC1, DC1)
    
    plot(pointA0(1), pointA0(2),'r-.');
    hold on
    %GroundLink(origin, radius, side_len , N, dash_len, linewidth)
    GroundLink(pointA0, 2, 5 , 5, 2, 2)
    GroundLink(pointD0, 2, 5 , 5, 2, 2)
    
    Rectangle([10.5 -2.75], 22, 5.5 , 10, 2, 2)
    plot(pointA0(1), pointA0(2),'r-.');
    plot([SlidingLineStart(1) SlidingLineEnd(1)], [SlidingLineStart(2) SlidingLineEnd(2)], 'k-.');
    % Link A0A1
    plot([pointA0(1) pointA1(1)], [pointA0(2) pointA1(2)],...
        'Color','#EA4335',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)% link A0A1

    % Link A1B1
    plot([pointA1(1) pointB1(1)], [pointA1(2) pointB1(2)],...
        'Color','#FBBC05',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)% link A0A1

    % Link A1C1
    plot([pointA1(1) pointC1(1)], [pointA1(2) pointC1(2)],...
        'Color','#FBBC05',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)

    % Link D1C1
    plot([pointC1(1) pointD(1)], [pointC1(2) pointD(2)],...
        'Color','#4285F4',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)

    % Link D0D1
    plot([pointD0(1) pointD(1)], [pointD0(2) pointD(2)],...
        'Color','#34A853',...
        'LineStyle','-',...
        'Marker','o',...
        'LineWidth',LinkWidth,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 1 1],...
        'MarkerSize',MarkerSize)
    
    SliderShape(6,4, pointB1(1), pointB1(2),thetaSliding);
    
    midpoint_D0D=[(pointD0(1)+pointD(1))/2 (pointD0(2)+pointD(2))/2];
    tail_forceExt=midpoint_D0D - Force_extapplied*([cosd(theta_force) sind(theta_force)]);
    drawVector(tail_forceExt,midpoint_D0D,'g',3,0);
    
    axis([-40 40 -30 20]);
    %axis equal
    hold off;
    drawnow();
    %pause(0.0000009);
end
title('Position Analysis  (Scale: 1mm = 1mm)');
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
%% Determining the Direction of each link(Unit Vector)
Dir_A0A1 = findDirection(pointA0, pointA1);
Dir_A1B1 = findDirection(pointA1, pointB1);
Dir_D0D  = findDirection(pointD0, pointD);
Dir_DC1  = findDirection(pointD, pointC1)
Dir_C1D  = findDirection(pointC1, pointD)
%% SFA

anim = 0
Force_ext=tail_forceExt+Force_extapplied*([cosd(theta_force) sind(theta_force)]);%point where the 
% force is acting on DD0
Dir_Force_ext=findDirection(tail_forceExt,Force_ext);%direction of the applied force acting on the 
% link DD0
point1=LinesIntersection(Force_ext,Dir_Force_ext,pointD,Dir_DC1);% point of intersection of the 
% Applied force and reaction force from the free body diagram for finding
% the direction of the reaction force of ground acting on DD0 which make
% the force polygon to a closed polygon. 
Dir_g6=findDirection(point1,pointD0);% Direction of the reaction force of ground acting on DD0 
point2=LinesIntersection(Force_ext,Dir_DC1,tail_forceExt,Dir_g6);%intersection point 
%where the reaction forces form a closed polygon
 
mag_rf56=norm(Force_ext - point2);%magnitude of reaction force on DD0 by DC1
rf_5=pointA1+mag_rf56*(Dir_DC1);%for drawing the reaction force vector of DC1 on C1B1
Dir_rf43=[dirSliding(2) -dirSliding(1)];%direction for reaction force of slider on C1B1
point3=LinesIntersection(pointC1,Dir_C1D,pointB1,Dir_rf43);% point of intersection of the 
% reaction force by slider and reaction force of C1D on C1B1 from the free body diagram for finding
% the direction of the reaction force of A0A1 acting on C1B1 which make
% the force polygon to a closed polygon. 
Dir_rf23=findDirection(pointA1,point3);%direction of the reaction force of A0A1 on C1B1
point4=LinesIntersection(rf_5,Dir_rf43,pointA1,Dir_rf23);% point of intersection of reaction forces

CosTheta = (dot(Dir_rf23,Dir_A0A1) / (norm(Dir_rf23)*norm(Dir_A0A1)));
ThetaInDegrees = real(acosd(CosTheta));% angle between the reaction force acting on A0A1;
moment_A0A1=-norm(pointA1-point4)*A0A1*sind(ThetaInDegrees);%moment on A0A1 due to other reaction forces

fprintf('The applied external force on DD0 is: %.2f N\n',Force_extapplied);
fprintf('The reaction force of C1D on DD0 is: %.4f N\n',norm(Force_ext - point2));
fprintf('The reaction force of ground on DD0 is: %.4f N\n',norm(point2-tail_forceExt));
fprintf('The reaction force of C1D on C1B1 is: %.4f N\n',norm(Force_ext-point2));
fprintf('The reaction force of slider on C1B1 is: %.4f N\n',norm(rf_5-point4));
fprintf('The reaction force of A0A1 on C1B1 is: %.4f N\n',norm(pointA1-point4));
fprintf('The reaction force of C1B1 on A0A1 is: %.4f N\n',norm(pointA1-point4));
fprintf('The moment acting on A0A1 is: %4f Nm in Clockwise sense.\n',moment_A0A1);
fprintf('We need to apply a moment of %4f Nm in Anti-Clockwise sense on A0A1 to keep the mechanism in Static Force Equillibrium\n',-moment_A0A1);

subplot(132);
title('Force Polygon for DD0(Scale: 1N = 1mm; Fext =10N)');
grid on
axis([-60 0 -15 0])
hold on
drawVector(tail_forceExt,Force_ext,'g',2,anim);
text(tail_forceExt(1)+2 , tail_forceExt(2)-1,'Fext' );

ContructionLineAnimation(Force_ext,Dir_DC1,'b',anim);
ContructionLineAnimation(tail_forceExt,Dir_g6,'k',anim);
drawVector(Force_ext,point2,'b',2,anim);
text(point2(1)+3 , point2(2)-1,'F-DC1 on DD0' );

drawVector(point2,tail_forceExt,'k',2,anim);
text(point2(1)-27 , point2(2)-1,'F-ground on DD0' );
hold off



subplot(133);
title('Force Polygon for C1B1(Scale: 1N = 1mm)');
grid on
axis([-10 20 -15 0])
hold on
drawVector(pointA1,rf_5,'b',2,anim);
text(pointA1(1)+3, pointA1(2)-1,'F-DC1 on C1B1' );

ContructionLineAnimation(rf_5,Dir_rf43,'g',anim);
ContructionLineAnimation(pointA1,Dir_rf23,'r',anim);

drawVector(rf_5,point4,'g',2,anim);
text(point4(1)+2 , point4(2),'F-slider on C1B1' );

drawVector(point4,pointA1,'r',2,anim);
text(point4(1)-15, point4(2)+1,'F-crank on C1B1' );
hold off
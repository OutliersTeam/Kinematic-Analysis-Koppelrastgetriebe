%Construction Lines App
function drawVector(point1,point2,color,size,anim)

    % point1 :tail of vector to be drawn
    % point2 :head of vector to be drawn
    % color  :color of the vector
    % size   :takes two values (1 or 2) 2- big arrow head, 1- small arrow head
    % anim   :draw the vector with(=1) or without(=0) animation
    
    startPoint = point1;
    endPoint = point2;
    dir = findDirection(startPoint, endPoint);
    LenOfLine = norm(endPoint - startPoint);
    magVector = linspace(0,LenOfLine,100);
    
    if (norm(point1) ~= norm(point2)) %&& (round(norm(point2),3)>0)
        if(anim==1)
            pointsXArray = zeros(1,100);
            pointsYArray = zeros(1,100);
            for i=1:100
                temp = startPoint + dir*magVector(i);
                pointsXArray(i) = temp(1);
                pointsYArray(i) = temp(2);

                plot(pointsXArray(:,(1:i)), pointsYArray(:,(1:i)),...
                'Color',color,...
                'LineStyle','-',...
                'LineWidth',3);
                drawnow();
                pause(0.01);
            end
        else
            endPointVec = startPoint + dir*LenOfLine;
            plot([startPoint(1) endPointVec(1)],[startPoint(2) endPointVec(2)],...
                'Color',color,...
                'LineStyle','-',...
                'LineWidth',3);
        end

        %drawing the arrow head
        %drawing the arrow head
        if size == 2
            heightArrow = 0.5;
            baseArrow = 0.2;
        elseif size == 1
            heightArrow = 0.1;
            baseArrow = 0.05;
        elseif size == 3
            heightArrow = 0.8;
            baseArrow = 0.4;
        end


    %              1
    %             /\
    %            /  \
    %           /    \
    %          /______\
    %         4    3   2
        arrowPoint1 = point2;
        arrowPoint3 = arrowPoint1 - heightArrow*dir;
        arrowPoint2 = arrowPoint3 + baseArrow*[dir(2),-dir(1)];
        arrowPoint4 = arrowPoint3 - baseArrow*[dir(2),-dir(1)];
        plot([arrowPoint1(1),arrowPoint2(1),arrowPoint3(1),arrowPoint4(1),arrowPoint1(1)],...
             [arrowPoint1(2),arrowPoint2(2),arrowPoint3(2),arrowPoint4(2),arrowPoint1(2)],...
            'Color',color,...
            'LineStyle','-',...
            'LineWidth',3);
    % else
    %     plot(startPoint(1),startPoint(2),'-*',...
    %             'LineWidth',2,...
    %             'MarkerEdgeColor',color,...
    %             'MarkerFaceColor',color,...
    %             'MarkerSize',10);
    end

end
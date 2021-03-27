%Construction Lines App
function ContructionLine(point1,dir1,color,anim)
    startPoint = point1 - 22*dir1;
    endPoint = point1 + 22*dir1;
    dir = findDirection(startPoint, endPoint);
    LenOfLine = norm(endPoint - startPoint);
    magVector = linspace(0,LenOfLine,100);
    
    if anim == 1
        pointsXArray = zeros(1,100);
        pointsYArray = zeros(1,100);
        for i=1:100
            temp = startPoint + dir*magVector(i);
            pointsXArray(i) = temp(1);
            pointsYArray(i) = temp(2);

            plot(pointsXArray(:,(1:i)), pointsYArray(:,(1:i)),...
            'Color',color,...
            'LineStyle','-.',...
            'LineWidth',1);
            drawnow();
            pause(0.01);

        end
    else
        endPointC = startPoint + dir*LenOfLine;
        plot([startPoint(1) endPointC(1)],[startPoint(2) endPointC(2)],...
            'Color',color,...
            'LineStyle','-.',...
            'LineWidth',1);
    end
        
        
end




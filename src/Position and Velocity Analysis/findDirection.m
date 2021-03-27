function dir = findDirection(point1, point2)
    deltaLVector = point2 - point1; 
    lengthLVector = norm(deltaLVector);
    dir = deltaLVector/lengthLVector;
end
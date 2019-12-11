function [xPath,yPath] = makePaths(I, currentXPath, currentYPath, xScale, yScale)
    xPath = currentXPath;
    yPath = currentYPath;
    
    for row=1:size(I,1)
        for col=1:size(I,2)   
            if I(row, col) == 0
                startX = col * xScale;
                startY = row * yScale;
                lastX = startX;
                lastY = startY;
                xPath = [xPath; startX];
                yPath = [yPath; startY];
                I(row, col) = 0;
                [nextY, nextX] = findNeighborInv(I, col, row);
                while nextX ~= -1 && nextY ~= -1
                    I(nextY, nextX) = 1;
                    xPath = [xPath; nextX * xScale];
                    yPath = [yPath; nextY * yScale];
                    lastX = nextX;
                    lastY = nextY;
                    [nextY, nextX] = findNeighborInv(I, nextX, nextY);
                end
                for localRow=-2:2
                    for localCol=-2:2
                        if lastX + localCol == startX && lastY + localRow == startY
                            xPath = [xPath; startX];
                            yPath = [yPath; startY];
                        end
                    end
                end
                xPath = [xPath; 255+255];
                yPath = [yPath; 255+255];
            end
        end
    end

end


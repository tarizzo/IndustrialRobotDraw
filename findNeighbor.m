function [row, col] = findNeighbor(BWimage, x, y)
    row = -1;
    col = -1;
    for i=-1:1
        for j=-1:1
            if (i+x > 0) && (i+x <= size(BWimage, 2)) && (j+y > 0) && (j+y <= size(BWimage, 1))   
                if BWimage(y+j, x+i) == 1
                    col = x+i;
                    row = y+j;
                end
            end
        end
    end
    if row == -1 && col == -1
        for i=-2:2
            for j=-2:2
                if (i+x > 0) && (i+x <= size(BWimage, 2)) && (j+y > 0) && (j+y <= size(BWimage, 1))   
                    if BWimage(y+j, x+i) == 1
                        col = x+i;
                        row = y+j;
                    end
                end
            end
        end
    end
end


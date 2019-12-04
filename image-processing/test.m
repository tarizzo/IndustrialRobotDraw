close all
clear

I = imread('shapes.PNG');

I = histeq(rgb2gray(I));

BW = edge(I, 'Sobel');

flippedBW = zeros(size(BW));

x = [];
y = [];

%invert BW matrix
for row=0:(size(BW,1) - 1)
    for col=0:(size(BW,2) - 1)
        flippedBW(row+1, col+1) = BW((size(BW,1)-row), col+1);
    end
end

%Find all edges and get x,y coordinates
for col=1:size(flippedBW,2)
    for row=1:size(flippedBW,1)
        if flippedBW(row,col) == 1
            x = [col; x];
            y = [row; y];
        end
    end
end

%scale to 8 1/2 x 11
xScale = 279.4 / size(BW, 2);  %279.4mm (11 in)
yScale = 215.9 / size(BW, 1); %215.9mm (8.5 in)

if xScale < yScale
    xScaled = x * xScale;
    yScaled = y * xScale;
else
    xScaled = x * yScale;
    yScaled = y * yScale;
end

xPath = [];
yPath = [];

%make paths
%TODO scale paths
%TODO add start point as last point
for row=1:size(flippedBW,1)
    for col=1:size(flippedBW,2)   
        if flippedBW(row, col) == 1
            startX = col * xScale;
            startY = row * yScale;
            xPath = [xPath; startX];
            yPath = [yPath; startY];
            flippedBW(row, col) = 0;
            [nextY, nextX] = findNeighbor(flippedBW, col, row);
            while nextX ~= -1 && nextY ~= -1
                flippedBW(nextY, nextX) = 0;
                xPath = [xPath; nextX * xScale];
                yPath = [yPath; nextY * yScale];
                [nextY, nextX] = findNeighbor(flippedBW, nextX, nextY);
            end
            xPath = [xPath; -1];
            yPath = [yPath; -1];
        end
    end
end

%for plotting only
xPathPlot = [];
yPathPlot = [];
for i=1:size(xPath)
    if xPath(i) ~= -1
        xPathPlot = [xPathPlot, xPath(i)];
    end
end
for i=1:size(yPath)
    if yPath(i) ~= -1
        yPathPlot = [yPathPlot, yPath(i)];
    end
end

plot(xPathPlot, yPathPlot);
axis([0, 279.4, 0, 215.9]);
axis equal
figure();

scatter(xScaled, yScaled, 1);
axis([0, 279.4, 0, 215.9]);
axis equal
figure();

imshow(BW);

 
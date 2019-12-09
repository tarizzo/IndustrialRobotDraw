close all
clear

%Image Processing
I = imread('shapes.PNG');

I = histeq(rgb2gray(I));
BW = edge(I, 'Sobel');

flippedBW = zeros(size(BW));
%invert BW matrix
for row=0:(size(BW,1) - 1)
    for col=0:(size(BW,2) - 1)
        flippedBW(row+1, col+1) = BW((size(BW,1)-row), col+1);
    end
end

%scale to 8 1/2 x 11
xScale = 279.4 / size(BW, 2);  %279.4mm (11 in)
yScale = 215.9 / size(BW, 1); %215.9mm (8.5 in)

xPath = [];
yPath = [];

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
            xPath = [xPath; 255+255];
            yPath = [yPath; 255+255];
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

% Set up the socket
tc=tcpip('127.0.0.1',55000, 'Timeout', 60);

% Open the comms
fopen(tc);

% Send a message to the robot
fwrite(tc, 'Hello RobotStudio from MATLAB!');

for i = 1:length(xPath)
    writeInt(tc, int32(xPath(i)), int32(yPath(i)));
end
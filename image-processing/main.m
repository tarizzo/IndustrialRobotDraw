close all
clear

%Image Processing
% I = imread('apple-rainbow.jpg');
%I = imread('shapes.png');
I = imread('putnam.PNG');

%I = histeq(rgb2gray(I));
I = rgb2gray(I);
% BW = edge(I, 'Sobel');
BW = edge(I, 'Canny', [0.1, 0.125]); %putnam

flippedBW = BW;
% flippedBW = zeros(size(BW));
%invert BW matrix
% for row=0:(size(BW,1) - 1)
%     for col=0:(size(BW,2) - 1)
%         flippedBW(row+1, col+1) = BW((size(BW,1)-row), col+1);
%     end
% end

%scale to 8 1/2 x 11
%xScale = 279.4 / size(BW, 2);  %279.4mm (11 in)
xScale = 215.9 / size(BW, 2);  %279.4mm (11 in)
yScale = 215.9 / size(BW, 2); %215.9mm (8.5 in)

xPath = [];
yPath = [];

xPath = [xPath; 255+255];
yPath = [yPath; 255+255];

for row=1:size(flippedBW,1)
    for col=1:size(flippedBW,2)   
        if flippedBW(row, col) == 1
            startX = col * xScale;
            startY = row * yScale;
            lastX = startX;
            lastY = startY;
            xPath = [xPath; startX];
            yPath = [yPath; startY];
            flippedBW(row, col) = 0;
            [nextY, nextX] = findNeighbor(flippedBW, col, row);
            while nextX ~= -1 && nextY ~= -1
                flippedBW(nextY, nextX) = 0;
                xPath = [xPath; nextX * xScale];
                yPath = [yPath; nextY * yScale];
                lastX = nextX;
                lastY = nextY;
                [nextY, nextX] = findNeighbor(flippedBW, nextX, nextY);
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
xPath = [xPath; 0];
yPath = [yPath; 0];

%for plotting only
figure()
plot(xPath, yPath);
% axis([0, 279.4, 0, 279.4]); %215.9
axis equal
drawnow

% Set up the socket
!tc=tcpip('127.0.0.1',55000, 'Timeout', 60);
tc=tcpip('192.168.100.100',55000, 'Timeout', 60);

% Open the comms
fopen(tc);

% Send a message to the robot
% fwrite(tc, 'Hello RobotStudio from MATLAB!');

for i = 1:length(xPath)
    fread(tc, 1, 'uint8');
    writeInt(tc, int32(xPath(i)), int32(yPath(i)));
    disp([num2str(i), '/', num2str(length(xPath))])
end
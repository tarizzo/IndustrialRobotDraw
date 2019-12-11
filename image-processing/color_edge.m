close all
clear

%Image Processing
 I = imread('apple-rainbow.jpg');
%I = imread('mickey.PNG');
J1 = fspecial('disk', 2);

%scale to 8 1/2 x 11
%xScale = 279.4 / size(BW, 2);  %279.4mm (11 in)
xScale = 215.9 / size(I, 2);  %279.4mm (11 in)
yScale = 215.9 / size(I, 2); %215.9mm (8.5 in)

%Start Path
xPath = [];
yPath = [];

xPath = [xPath; 255+255];
yPath = [yPath; 255+255];
%%
%Red
red = redMask(I);
red = imfilter(red,J1,'replicate');
redEdge = ~edge(red);

[xPath, yPath] = makePaths(redEdge, xPath, yPath, xScale, yScale);

%change marker
xPath = [xPath; 255 + 254]; 
yPath = [yPath; 255 + 254];
%%
%Orange
orange = orangeMask(I);
orange = imfilter(orange,J1,'replicate');
orangeEdge = ~edge(orange);

[xPath, yPath] = makePaths(orangeEdge, xPath, yPath, xScale, yScale);

%change marker
xPath = [xPath; 255 + 254]; 
yPath = [yPath; 255 + 254];
%%
%Yellow
yellow = yellowMask(I);
yellow = imfilter(yellow,J1,'replicate');
yellowEdge = ~edge(yellow);

[xPath, yPath] = makePaths(yellowEdge, xPath, yPath, xScale, yScale);

%change marker
xPath = [xPath; 255 + 254]; 
yPath = [yPath; 255 + 254];
%%
%Green
green = greenMask(I);
green = imfilter(green,J1,'replicate');
greenEdge = ~edge(green);

[xPath, yPath] = makePaths(greenEdge, xPath, yPath, xScale, yScale);

%change marker
xPath = [xPath; 255 + 254]; 
yPath = [yPath; 255 + 254];
%%
%Blue
blue = blueMask(I);
blue = imfilter(blue,J1,'replicate');
blueEdge = ~edge(blue);

[xPath, yPath] = makePaths(blueEdge, xPath, yPath, xScale, yScale);

%change marker
xPath = [xPath; 255 + 254]; 
yPath = [yPath; 255 + 254];
%%
%Purple
purple = purpleMask(I);
purple = imfilter(purple,J1,'replicate');
purpleEdge = ~edge(purple);

[xPath, yPath] = makePaths(purpleEdge, xPath, yPath, xScale, yScale);


%change marker
xPath = [xPath; 255 + 254]; 
yPath = [yPath; 255 + 254];
%%
%Brown
brown = brownMask(I);
brown = imfilter(brown,J1,'replicate');
brownEdge = ~edge(brown);

[xPath, yPath] = makePaths(brownEdge, xPath, yPath, xScale, yScale);

%change marker
xPath = [xPath; 255 + 254]; 
yPath = [yPath; 255 + 254];
%%
%Black
black = blackMask(I);
black = imfilter(black,J1,'replicate');
blackEdge = ~edge(black);

[xPath, yPath] = makePaths(blackEdge, xPath, yPath, xScale, yScale);

%change marker
xPath = [xPath; 255 + 254]; 
yPath = [yPath; 255 + 254];
%%
%End Program
xPath = [xPath; 0];
yPath = [yPath; 0];
%%
%for plotting only
figure()
plot(xPath, yPath);
% axis([0, 279.4, 0, 279.4]); %215.9
axis equal
drawnow
%%
% Set up the socket
tc=tcpip('127.0.0.1',55000, 'Timeout', 60);
%tc=tcpip('192.168.100.100',55000, 'Timeout', 60);

% Open the comms
fopen(tc);

for i = 1:length(xPath)
    fread(tc, 1, 'uint8');
    writeInt(tc, int32(xPath(i)), int32(yPath(i)));
    disp([num2str(i), '/', num2str(length(xPath))])
end
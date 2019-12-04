close all
clear

%I = imread('apple-rainbow.jpg');
I = imread('putnam.png');
imshow(I);

[red, foo] = redMask(I);
figure();
imshow(red);

[orange, foo] = orangeMask(I);
figure();
imshow(orange);

[yellow, foo] = yellowMask(I);
figure();
imshow(yellow);

[green, foo] = greenMask(I);
figure();
imshow(green);

[blue, foo] = blueMask(I);
figure();
imshow(blue);

[purple, foo] = purpleMask(I);
figure();
imshow(purple);

[black, foo] = blackMask(I);
figure();
imshow(black);

[brown, foo] = brownMask(I);
figure();
imshow(brown);

%%Test Filters%%
% J1 = fspecial('disk', 2);
% K1 = imfilter(yellow,J1,'replicate')
% edged = edge(K1, 'Sobel');
% figure();
% imshow(edged);

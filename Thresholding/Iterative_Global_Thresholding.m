clear all;
close all;
img = imread('coloredchips.png');
A = rgb2gray(img); %Converting Image to gray scale.

%% Iterative Global Thresholding
T= input("Enter the initial threshold value of T: ");
delta_T= input("Enter the value of delta_T: ");
dTn=1;
l=1;m=1;n=1;
[x,y]=size(A);
while(dTn>delta_T)
     for i = 1:x
         for j= 1:y
           if(T>A(i,j))
               G1(l)=A(i,j); % G1 contains group of pixels greater than T
               l=l+1;
           else
               G2(m)=A(i,j); % G2 contains group of pixels greater than T
               m=m+1;
         end     
       end
    end
    m1= mean(G1);  % Mean of G1
    m2 = mean(G2); % Mean of G2
    nT= (m1+m2)/2; % New Threshold
    dTn=nT-T;
    T=nT;
    n=n+1;
end
%% Segmenting Using Final Threshold value
for i = 1:x
        for j= 1:y
            if(A(i,j)>T)
                r(i,j)=255;
            else 
                r(i,j)=0;
            end
        end
end
%% Displaying Segmented Image
subplot(121)
imshow(A)
title('Input Image')
subplot(122)
imshow(r)
title('Iterative Global Thresholding with T='+ string(T))





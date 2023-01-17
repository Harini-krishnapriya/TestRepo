clear all;
close all;
A = imread('cameraman.tif');
[x,y]=size(A);

%%  Segmentation Using Otsu's Method
Aeq=histeq(A);
B= imhist(Aeq);
B=B';
pdf = B/sum(B);
cdf=zeros(1,length(pdf));
cdf(1)=pdf(1);
mk(1)=pdf(1);
for k=2:length(pdf)
    cdf(k)=cdf(k-1)+pdf(k);
    mk(k)=mk(k-1)+(k*pdf(k));
end
mg=0;
for i=1:256
    mg=mg+i*pdf(i);
end
for i=1:256
    s(i)= ((mg*cdf(i)-mk(i))^2)/(cdf(i)*(1-cdf(i)));
end
max_value=s(1);
max_value_index=1;
for i=2:256
    if(s(i)>max_value)
        max_value=s(i);
        max_value_index=i;
    end 
end
T=max_value_index;
for i = 1:x
    for j= 1:y
        if(Aeq(i,j)>T)
           fimg(i,j)=1;
        else 
           fimg(i,j)=0;
        end
   end
end

%% %% Displaying Segmented Image
subplot(121)
imshow(A)
title('Input Image')
subplot(122)
imshow(fimg)
title('Otsu Global Thresholding with T='+ string(T))





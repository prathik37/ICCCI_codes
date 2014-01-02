%Consider the watermark database
clc
clear all
close all

%%
g_best=[false	false	true	false	true	false	true	false	false	true	true	false	false	false	false	false	true	true	true	false	true	true	false	false	true	false	false	false	true	false	false	true	false	true	true	false	false	true	false	false	true	false	false	true	true	false	false	false	false	true	false	true	true	true	false	true	false	true	false	true	true	false	false	true	false	false	false	true	false	true	true	false	true	true	true	false	true	false	false	false	true	true	false	true	false	false	false	false	true	true	false	true	true	false	true	false	false	false	true	false	true	true	false	false	false	false	false	true	false	false	false	false	false	true	false	false	false	false	false	false	false	false	true	false	false	false	false	false	false	false	false	true	true	false	false	false	false	false	false	false	false	false	false	true	false	false	false	true	false	false	false	false	false	false	false	true	false	false	true	true	false	false	false	false	true	true	true	false	false	false	true	false	true	false	false	false	false	false	false	false	true	false	false	false	false	false	false	true	false	false	false	false	false	false	true	false	true	false	true	false	false	false	true	false	false	false	true	true	false	false	true	false	true	true	false	false	false	false	false	false	true	false	true	false	false	true	false	true	true	false	true	true	true	false	false	false	false	true	false	false	false	true	true	false	true	false	false	false	false	false	false	true	true	true	false	false	true	false	false	true	false	true	false	true	false	false	true	true	false	false	false	true	true	false	false	false	false	false	false	false	true	true	false	true	false	true	false	false	false	false	true	true	true	true	true	false	false	false	false	false	true	false	true	true	false	false	false	true	false	false	true	false	true	false	false	true	false	true	false	false	true	true	false	true	false
];
ind = find(g_best,115,'first');
[row1 col1]=size(ind);

%%
m=1;
for k=1:col1
   
   img = imread(strcat(num2str(ind(k)),'.jpeg')); 
   img = rgb2ycbcr(img); 
   back_img = img;  
   y=img(:,:,1);
   [ll lh hl hh]=dwt2(y,'haar');
   
   %% for hh component
[u s v] = svd(hh);
j=0;
for i=1:4
    if(ceil(s(j+3,j+3)) <= ceil(0.5*(s(j+2,j+2)+s(j+4,j+4))))
    re_wm(i)=0;
    else
    re_wm(i)=1;
    end
    j=j+2;
end

%% for lh component
[u s v]= svd(lh);
j=0;
for i=1:4
    if(ceil(s(j+3,j+3)) <= ceil(0.5*(s(j+2,j+2)+s(j+4,j+4))))
    re_wm(4+i)=0;
    else
    re_wm(4+i)=1;
    end
    j=j+2;
end

%% for hl component

[u s v]= svd(hl);
j=0;
for i=1:4
    if(ceil(s(j+3,j+3)) <= ceil(0.5*(s(j+2,j+2)+s(j+4,j+4))))
    re_wm(8+i)=0;
    else
    re_wm(8+i)=1;
    end
    j=j+2;
end
extracted_wm(m:m+11)=re_wm;
m=m+12;
    
end

%% Trimming the extracted watermark and getting it back

extracted_wm=extracted_wm(1:(36*36));
extracted_wm=reshape(extracted_wm,36,36);

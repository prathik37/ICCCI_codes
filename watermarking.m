function [re_wm] = watermarking(img,wm,index)


img = rgb2ycbcr(img);
%wm = (rand(3,4))>0.5;
wm = reshape(wm,1,[]);
intensity=0.48;
y=img(:,:,1);
y1=y;

[ll lh hl hh]=dwt2(y,'haar');

 %% for hh
[u s v]=svd(hh);
s1=s;
j=0;
for i=1:4
    s(j+3,j+3)= 0.5*((s(j+2,j+2)+s(j+4,j+4)) + (0.48*wm(i)*(s(j+2,j+2)-s(j+4,j+4))));
    j=j+2;
end
hh= u*s*v';

%% for lh component
[u s v]=svd(lh);
j=0;
for i=1:4
    s(j+3,j+3)= 0.5*((s(j+2,j+2)+s(j+4,j+4)) + (0.48*wm(4+i)*(s(j+2,j+2)-s(j+4,j+4))));
    j=j+2;
end
lh= u*s*v';
%% for hl component
[u s v]=svd(hl);
j=0;
for i=1:4
    s(j+3,j+3)= 0.5*((s(j+2,j+2)+s(j+4,j+4)) + (0.48*wm(8+i)*(s(j+2,j+2)-s(j+4,j+4))));
    j=j+2;
end
hl= u*s*v';
%%

y=idwt2(ll,lh,hl,hh,'haar');

mse=sum(sum((y-double(y1)).^2))/(512*512);
psnr=10*log10(255^2/mse);
% 
% %% Reconstructing watermark

%[ll lh hl hh]=dwt2(y,'haar');
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
end


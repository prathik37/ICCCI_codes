%current folder should be the watermarked database
clc
clear all
close all

n = 325;

for i=1:n
    multi_img(:,:,:,i)= imread(strcat(num2str(i),'.jpeg'));
end

mov = immovie(multi_img);

movie2avi(mov, 'wm.avi', 'compression', 'None');
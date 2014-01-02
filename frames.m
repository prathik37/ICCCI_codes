% function [ frame ] = readFrames( vid )

readerobj = mmreader('Fire_720p.mp4');
vidFrames = read(readerobj);
numFrames = get(readerobj, 'numberOfFrames');
for k = 1 : numFrames
mov(k).cdata = vidFrames(:,:,:,k);
mov(k).colormap = [];
%imshow(mov(k).cdata);
imagename=strcat(int2str(k), '.jpeg');
imwrite(mov(k).cdata, strcat('C:\Users\Prathik\Desktop\watermarking\Databases\Fire\Original database\',imagename));
%extractComponents(mov(k).cdata);

end
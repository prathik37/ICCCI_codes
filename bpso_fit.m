function [y] = bpso_fit (x)

global Imil Imol n


Imil_p=Imil.*x;


ffs=0;

%scatter index is used as the fitness function
for i=1:n
ffs=ffs+((Imil_p(i)-Imol)*((Imil_p(i)-Imol))');
end

y=sqrt(ffs);
return
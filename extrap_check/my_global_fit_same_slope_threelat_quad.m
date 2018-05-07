function [b] = my_global_fit_same_slope_threelat_quad(asqr_1, x1, cy1, ey1, asqr_2, x2, cy2, ey2, asqr_3, x3, cy3, ey3)

nmass1 = length(x1);
nmass2 = length(x2);
nmass3 = length(x3);

asqr = [asqr_1 asqr_2 asqr_3];

indx=1;

clear cy dy yr my_am

for im=1:nmass1
    my_am(indx,2)=x1(im); %  + mpi^2 first set of mass
	my_am(indx,3)=x1(im)^2; %  + mpi^4 first set of mass
    my_am(indx,4)=asqr(1); %  a^2 % comment out if you don't want this term
    cy(indx) = cy1(im);
    dy(indx) = ey1(im);
    indx=indx+1;
end

for im=1:nmass2 
    my_am(indx,2)=x2(im); 
    my_am(indx,3)=x2(im)^2;      %  + mpi^2 second set of mass   
	my_am(indx,4)=asqr(2); %  a^2 % comment out if you don't want this term
    cy(indx) = cy2(im);
    dy(indx) = ey2(im);
    indx=indx+1;
end

for im=1:nmass3 
    my_am(indx,2)=x3(im); 
    my_am(indx,3)=x3(im)^2;      %  + mpi^2 third set of mass   
    my_am(indx,4)=asqr(3); %  a^2 % comment out if you don't want this term 
    cy(indx) = cy3(im);
    dy(indx) = ey3(im);
    indx=indx+1;
end

nndx=indx-1; % total number of points

for indx=1:nndx
    my_am(indx,1) = 1; % y0
end


for indx=1:nndx
    my_am(indx,:)=my_am(indx,:)./dy(indx);

end

cy=cy(:);
dy=dy(:);
yr=cy./dy;
my_am = inv(my_am'*my_am)*my_am';
b = my_am*yr;
%b


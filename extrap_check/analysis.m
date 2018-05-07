clear all

mpi_phi = 0.13957; % GeV
fpi_phi = 0.0922; % GeV
eps_phi = mpi_phi / (4*pi*fpi_phi);

% (w_0 \sim 0.17 fm)
% 1 / w_0 = 0.197327 / (0.1714 +/- 0.0015)
w0inv_GeV = 0.197327 / 0.1714;


filename = 'data/hisq_params.csv';
data = csvread(filename,1,1);
a_w0 = squeeze(data(:,1)); 
clear data

filename = 'data/n0bb_v3.csv';
data = csvread(filename,1,2);
size(data);

nens=10; % number of ensembles
nfit=3;
nboot=200;
nop =5 ; % five operators LR, S, V, LR_mix, S_mix 


n1=nop*(nboot+1)*nens*nfit;
data_op = data(1:n1,3);

n2 = (nboot+1)*nens*nfit;
data_eps =  data(n1+1: n1+n2,3);

n3 = (nboot+1)*(nens-1)*nfit;
data_fpi =  data(n1+n2+1:n1+n2+n3,3); 

data_op  = reshape(data_op,[nfit,nboot+1,nop,nens]);
data_eps = reshape(data_eps,[nfit,nboot+1,nens]);
data_fpi = reshape(data_fpi,[nfit,nboot+1,nens-1]);

data_op  = squeeze(data_op( 1,:,:,:));
data_eps = squeeze(data_eps(1,:,:,:));
data_fpi = squeeze(data_fpi(1,:,:,:));

inew =  [1 2 5 4 3 6 9 10 7 8];
for i=1:10
	data_opnew( :,:,inew(i)) = squeeze(data_op( :,:,i));
end
%
clear data_op
data_op = data_opnew; 
clear data_opnew

iopnew = [1 3 5 2 4];
for i=1:nop
	data_opnew( :,iopnew(i),:) = squeeze(data_op( :,i,:));
end

% now epsilon
inew =  [9 10 1 2 5 4 3 6 7 8];
for i=1:10
	data_epsnew(:,inew(i)) = squeeze(data_eps(:,i));
end

% clear data_eps
% put the central value at the beginning
beps(2:nboot+1,:) = squeeze(data_epsnew(1:nboot,:));
beps(1,:) = squeeze(data_epsnew(nboot+1,:));


% beps=data_epsnew;
ceps = beps(1,:);
for i = 1:nens
	eeps(i) = std(squeeze(beps(2:nboot+1,i)));
end


% ---- now fpi
% 9 ensembles for fpi
% nens=9;
inew =  [9 10 1 2 5 4 6 7 8];
for i=1:9
	data_fpinew(:,inew(i)) = squeeze(data_fpi(:,i));
end
clear data_fpi

% put the central value at the beginning
bfpi_inv(2:nboot+1,:) = squeeze(data_fpinew(1:nboot,:));
bfpi_inv(1,:) = squeeze(data_fpinew(nboot+1,:));


for iboot=1:nboot+1
	bfpi_GeV(iboot,:) = 1./squeeze(bfpi_inv(iboot,:))' .* (w0inv_GeV./a_w0);
	bafpi(iboot,:) = 1./squeeze(bfpi_inv(iboot,:))';
end

cfpi_GeV = squeeze(bfpi_GeV(1,:));
cafpi = squeeze(bafpi(1,:));
for i=1:nens
	efpi_GeV(i) = std(squeeze(bfpi_GeV(2:nboot+1,i)));
	eafpi(i) = std(squeeze(bafpi(2:nboot+1,i)));
end


% mpi in GeV -> epsilon = (mpi / (4*pi*fpi) )

for iboot=1:nboot+1
	bmpi_GeV(iboot,:) = 4*pi*squeeze(beps(iboot,:)) .* squeeze(bfpi_GeV(iboot,:));
	bampi(iboot,:) = 4*pi*squeeze(beps(iboot,:)) .* squeeze(bafpi(iboot,:));
end

cmpi_GeV = squeeze(bmpi_GeV(1,:));
campi = squeeze(bampi(1,:));
for i=1:nens
	empi_GeV(i) = std(squeeze(bmpi_GeV(2:nboot+1,i)));
	eampi(i) = std(squeeze(bampi(2:nboot+1,i)));
end

% % order of the ensembles
% 1   %1.  a15m310 
% 2   %2.  a15m220
% 3   %5.  a15m130

% 4   %4.  a12m310
% 5   %3.  a12m220S
% 6   %6.  a12m220
% 7   %8.  a12m220L
% 8   %9.  a12m130

% 9   %7.  a09m310
% 10  %10. a09m220

nens=10;
for iboot=1:nboot+1
	for iop=1:5
		for iens=1:nens
			bOp_bare(iboot, iop,iens) = data_opnew(iboot,iop,iens) ;
		end 
	end
end

% order of op is 
% 1=LR 2=LRmix  called O1 and O1'
% 3=S  4=Smix   called O2 and O2'
% 5=V           called O3
% epi
for iop=1:5
% 	bOp(:,iop,:)=squeeze(Op(:,iop,:));
	cOp_bare(iop,:) = squeeze(bOp_bare(1,iop,:));
	for i = 1:nens
		eOp_bare(iop,i) = std(squeeze(bOp_bare(2:nboot+1,i)));
	end
end

% iic = [1 2 3] ; % coarse
iic = [1 2] ; % coarse
iim = [4 5 6 7 8]; % medium
iif = [9 10]; % fine


ii=1:10;


% Z factors in the renorm. basis
Zr_15 = [0.9407  0        0       0       0 
        0       0.9835  -0.0106  0       0 
		0      -0.0369   1.0519  0       0 
		0       0        0       1.020  -0.0356
        0       0        0      -0.0485  0.9519 ];

Zr_12  = [0.9117 0        0       0       0 
        0       0.9535  -0.0130  0       0 
        0      -0.0284   0.9922  0       0
        0       0        0       0.9656 -0.0275
		0       0        0      -0.0360  0.9270 ];

Zr_09 = [0.9017  0       0       0       0
       0        0.9483 -0.0269  0       0
       0       -0.0236  0.9369  0       0
       0        0       0       0.9209 -0.0224
       0        0       0      -0.0230  0.9332 ];
% change of basis
T = [ 
	0 1 0 0 0
	0 0 1 0 0
	0 0 0 1 0
    0 0 0 0 1
	1 0 0 0 0];

Z_15 = T * Zr_15*inv(T);
Z_12 = T * Zr_12*inv(T);
Z_09 = T * Zr_09*inv(T);

% now multiply the bare by the Z factors
for iboot=1:nboot+1
	for iens=iic
		v = squeeze(bOp_bare(iboot,:,iens))';
		R = Z_15*v;
		bOp(iboot,:,iens)  = -R;
	end
	for iens=iim
		v = squeeze(bOp_bare(iboot,:,iens))';
		R = Z_12*v;
		bOp(iboot,:,iens)  = -R;
	end
	for iens=iif
		v = squeeze(bOp_bare(iboot,:,iens))';
		R = Z_09*v;
		bOp(iboot,:,iens)  = -R;
	end
end


% operators in GeV
for iop=1:5
	for iboot=1:nboot+1
	bOp_GeV(iboot,iop,:) = squeeze(bOp(iboot,iop,:)) .* (w0inv_GeV./a_w0).^4 ;
	
	end
	cOp_GeV(iop,:) = squeeze(bOp_GeV(1,iop,:) );
	for iens=1:nens
		eOp_GeV(iop,iens) = std(squeeze(bOp_GeV(1:nboot,iop,iens) ));
	end
end

% B_pi
for iboot=1:nboot+1
	bBpi(iboot,:) = squeeze(bOp(iboot,5,:)) ./...
		(8/3* (squeeze(bafpi(iboot,:)) .* squeeze(bampi(iboot,:))).^2 )'; 
end

cBpi = squeeze(bBpi(1,:) );
for iens=1:nens
	eBpi(iens) = std(squeeze(bBpi(1:nboot,iens) ));
end

% Ratios 
for iop=1:5
	for iboot=1:nboot+1
		bR(iboot,iop,:) = squeeze(bOp(iboot,iop,:)) ./ squeeze(bOp(iboot,5,:)) ...
 			.* ( squeeze(bampi(iboot,:)) ./ squeeze(bafpi(iboot,:)))' .^2 ...
 			.* (fpi_phi/mpi_phi)^2 ; 
	end
	cR(iop,:) = squeeze(bR(1,iop,:) );
	for iens=1:nens
		eR(iop,iens) = std(squeeze(bR(1:nboot,iop,iens) ));
	end
end

%---- global fit

% Matrix elements
%global_fit_ME_lin
global_fit_ME_quad
% Bpi
global_fit_bpi_lin;
global_fit_bpi_quad;
% Ratios
global_fit_R_lin;
global_fit_quad_R;







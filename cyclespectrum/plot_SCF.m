function plot_SCF(avx,fvx,scf,DM,FLAGs)

% function plot_SCF(avx,fvx,scf,DM,FLAGs)
%
% avx: cycle frequency vector
% fvx: frequency vector
% scf: Spectral Correlation function
% DM: Dynamic Margin (dB) (20 dB default)
% FLAGs: 
%      [1] flag to plot in linear scale (if =1)
%      [2] flag to plot with High Contrast

if nargin<4 | isempty(DM)
    DM = 20;
end
if nargin<5 | ~FLAGs(1)
    scf = 10*log10(abs(scf));
    MINSCF = max(scf(:))-DM;
else
    scf = abs(scf);
    MINSCF = max(scf(:))*10^(-DM/10);
end

scf = max(scf,MINSCF);

fvx = fvx(:);
avx = avx(:);

S = size(scf);
% rows are Fourier transforms of cyclic correlation functions
if length(fvx) ~= S(2)
    scf = scf.';
    S = size(scf);
end

figure,hold on
colors = jet(S(1));
if nargin >= 5 & FLAGs(2)
    index([1:4:S(1),3:4:S(1),2:4:S(1),4:4:S(1)]) = ...
        [1:length(1:4:S(1)),ceil(S(1)/2)+[1:length(3:4:S(1))],...
        S(1)+[1:length(2:4:S(1))],floor(3*S(1)/2)+[1:length(4:4:S(1))]];
    colors = jet(2*S(1));
    colors = colors(index,:);
end
for ai = 1:S(1)
    patch([fvx;flipud(fvx)],repmat(avx(ai),2*S(2),1),...
        [scf(ai,:).';repmat(MINSCF,S(2),1)],colors(ai,:));
end
view(157,54)
axis tight
set(gca,'xdir','reverse')
xlabel('frequency','fontsize',13)
ylabel('cycle frequency','fontsize',13)
 
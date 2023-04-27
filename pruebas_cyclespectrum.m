l_s = 1500;
snr = 20;
i_train=1;
cAl=1;
nPSK_k = 2;
k = 1;
codPSK = [];
%%
fs = 1;
nPSK_k = 2;
vs_k=30;
ns_k=1000/vs_k; % NÃºmero de muestras por sÃ­mbolo
ns_k=round(ns_k);
T_k = l_s;
numSimbolos_k=ceil(T_k/ns_k);
fo_k = 0.25;
Roff = [];
codPSK=[];
%%
ns= ns_k;
[p,q]=rat(ns_k);
ns2=max([p,8]);
ns2=min([ns2,round(2*ns)]);
ns2=max([ns2,50]);
fs2=(ns2/ns)*fs;
M=2;
cod=(2*pi/M)*floor((M-1e-12)*rand(1,numSimbolos_k));
dCod=diff(cod);
T_total= numSimbolos_k*ns2;
while (length(find(dCod~=0))<2)||(min(diff(find(dCod~=0)))>1)||(min(abs(dCod(dCod~=0)))>(2*pi/M)),
cod=(2*pi/M)*floor((M-1e-12)*rand(1,numSimbolos));
dCod=diff(cod);
end
%codigo=exp(j*cod);
codigoP=repmat(cod,ns2,1);
display(size(codigoP))
smpsk=reshape(codigoP,1,T_total);
%%
figure()
plot(0:1:(length(smpsk)-1), smpsk)
%%
psk = zeros(1,1500);
%%
for i=1:T_total,
    psk(i) = cos(2*pi*fo_k*i + smpsk(i));
end
%%
bpsk = zeros(1,1500);
%%
for i=1:T_k,
    bpsk(i) = cos(2*pi*fo_k*i + randsrc*pi);
end
%%
figure()
t = 0:1:T_k-1;
display(size(t))
display(size(psk))
plot(t,psk(1:T_k))
%%
display(psk(1:10))
%%
SCF_conj = get_SCF_comp_conj(bpsk, 32);

%%
alphas = 0:1/(length(SCF_conj)-1):1;
freq = -0.5:1/63:0.5;
disp(length(alphas))
disp(length(SCF_conj))
disp(length(freq))
%%
length(SCF_comp)
length(SCF_conj)
%%
plot_SCF(alphas, freq, SCF_conj)
title('PSK compleja conjugada full')
% plot_SCF(0:1:(length(SCF_comp)-1), 0:1:63, SCF_comp)
% title('QPSK compleja')
%%
fs = 1;
nPSK_k = 2;
vs_k=40;
ns_k=1000/vs_k; % NÃºmero de muestras por sÃ­mbolo
ns_k=round(ns_k);
T_k = l_s;
numSimbolos_k=ceil(T_k/ns_k);
fo_k = 0.25;
Roff = [];
codPSK=[];
%%
ns= ns_k;
[p,q]=rat(ns_k);
ns2=max([p,8]);
ns2=min([ns2,round(2*ns)]);
ns2=max([ns2,30]);
fs2=(ns2/ns)*fs;
M=4;
cod=(2*pi/M)*floor((M-1e-12)*rand(1,numSimbolos_k));
dCod=diff(cod);
T_total= numSimbolos_k*ns2;
while (length(find(dCod~=0))<2)||(min(diff(find(dCod~=0)))>1)||(min(abs(dCod(dCod~=0)))>(2*pi/M)),
cod=(2*pi/M)*floor((M-1e-12)*rand(1,numSimbolos));
dCod=diff(cod);
end
%codigo=exp(j*cod);
codigo = cod;
codigoP=repmat(codigo,ns2,1);
display(size(codigoP))
smpsk=reshape(codigoP,1,T_total);

%%
figure()
plot(1:1:T_total,smpsk)
%%
qpsk = zeros(1,1500);
for i=1:T_total,
    qpsk(i) = cos(2*pi*fo_k*i + randsrc*pi) + sin(2*pi*fo_k*i + randsrc*pi);
end
%%
SCF_conj2 = get_SCF_comp_conj(qpsk, 32);
% SCF_comp2 = get_SCF_comp(x2, 32);
%%
alphas = 0:1/(length(SCF_conj2)-1):1;
freq = -0.5:1/63:0.5;
%%
plot_SCF(alphas, freq, SCF_conj2)
title('QPSK compleja conjugada')

%%
alphas = 0:1/(length(SCF_conj2_full)-1):1;
freq = -0.5:1/63:0.5;
plot_SCF(alphas, freq, SCF_conj2_full)
title('QPSK compleja conjugada')
% plot_SCF(0:1:(length(SCF_comp2)-1), 0:1:63, SCF_comp2,)
% title('BPSK compleja')
%%
%%% Ahora un tono
fo_k = 0.234;
T_k=round(T_k); % Longitud de bloque en muestras
x=exp(j*2*pi*(fo_k*(0:T_k-1)+rand(1)));
%%
NM_conj = get_SCF_comp_conj(x,32);
NM_conj_full = get_SCF_comp_conj_full(x, 32);
%%
plot_SCF(0:1:(length(SCF_conj_full)-1), 0:1:63, NM_conj_full)
title('NM compleja conjugada full')
plot_SCF(0:1:(length(NM_conj)-1), 0:1:63, NM_conj)
title('NM compleja conjugada')
%%
T_k = 1000;
 [codPSK,errorC] = codigoBarker(13); % ONLY BARKER CODE OF LENGTH 13
codPSK= codPSK(1,:);
numSimbolos_k = length(codPSK);
ns_k = round(T_k/numSimbolos_k);
nPSK_k = 1;
[x,t,codigo,error]=m_psk(1,fo_k,ns_k,numSimbolos_k,1,0,codPSK,nPSK_k,T_k,1,Roff,0);
%%
Barker_conj = get_SCF_comp_conj(x,32);
Barker_conj_full = get_SCF_comp_conj_full(x, 32);
%%
plot_SCF(0:1:(length(Barker_conj_full)-1), 0:1:63, Barker_conj_full)
title('Barker compleja conjugada full')
plot_SCF(0:1:(length(Barker_conj)-1), 0:1:63, Barker_conj)
title('Barker compleja conjugada')

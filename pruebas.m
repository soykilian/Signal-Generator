%%

fs = 1;
nFSK_k=1;
T_k = 1024;
                    
vs_k=2;
fo_k = [fs*0.03, fs*0.3]; 
fo = fo_k(1) + (fo_k(2)-fo_k(1))*rand(1)
fo=0.15
% NÃºmero de muestras por sÃ­mbolo                   
Df_k=randsrc(1,1,[0.15 0.20 0.25 0.3]) * fo;
len_p = [3,4,5,6];
ran = randsrc(1,1,[1:length(len_p)]);
len = len_p(ran);
[codFSK,errorC]= codigoCostas(len);
%[codPSK,errorC]=codigoFrank(len);
%[codPSK,errorC]=codigoP1(len);
%  [codFSK,errorC]= codigoBarker(13);
codFSK = codFSK(1,:);
numSimbolos_k=length(codFSK);
ns_k = T_k/numSimbolos_k;
[s,t,codigo,error]=m_fsk(1,fo,Df_k,ns_k,numSimbolos_k,0,0,codFSK,nFSK_k,T_k,1,1,[],1);
[B, lags] = xcorr(s);
real(B)

subplot(2,1,1)
plot(lags,B)
subplot(2,1,2)
plot(t, s)
title('Signal in time')
%%

nFSK_k=1;
T_k = 1024;
fs = 100;
    
%     fo=[fs/8,3*fs/8]; % Frecuencia de portadora (MHz)
fo = [-fs/4, fs/4];        
vs_k=2; 
fo = fo(1) + (fo(2)-fo(1))*rand(1);
% NÃºmero de muestras por sÃ­mbolo    
vsFSK = [1 2 5 10];
vs_k=vsFSK(randsrc(1,1,[1:length(vsFSK)]));
ns_k=fs/vs_k;
Df_k=1/ns_k;
len_p = [3,4,5,6];
ran = randsrc(1,1,[1:length(len_p)]);
len = len_p(ran);
[codFSK,errorC]= codigoCostas(len);
%[codPSK,errorC]=codigoFrank(len);
%[codPSK,errorC]=codigoP1(len);
%  [codFSK,errorC]= codigoBarker(13);
codFSK = codFSK(1,:);
numSimbolos_k=length(codFSK);
ns_k = T_k/numSimbolos_k;
[s,t,codigo,error]=m_fsk(1,fo,Df_k,ns_k,numSimbolos_k,0,0,codFSK,nFSK_k,T_k,1,1,[],1);
[B, lags] = xcorr(s);
real(B)

subplot(2,1,1)
plot(lags,B)
subplot(2,1,2)
plot(t, s)
title('Signal in time')

%%

fs = 100;
nPSK_k=1;
T_k = 1024;
                    
vs_k=20;
ns_k=fs/vs_k; % NÃºmero de muestras por sÃ­mbolo                   

[codPSK,errorC]=codigoBarker(13);

%[codPSK,errorC]=codigoFrank(len);
%[codPSK,errorC]=codigoP1(len);
numSimbolos_k=length(codPSK);
ns_k = round(T_k /numSimbolos_k);
codPSK = codPSK(1,:)
[x,t,codigo, error]=m_psk(1,0.095,ns_k,numSimbolos_k,1,0,codPSK,nPSK_k,T_k,1,[],1);
[S1,t,f] = tfrstft(x.',1:length(x), 256);
 plot(t,x)
 title('Signal')
length(f)
length(S1)
%%plot(B)
% 
% figure(2)
% subplot(3,2,3);
% [S1,t,f] = tfrcw(x.',1:length(x), 128, hamming(17),hamming(16+1));
% surf(t,f,S1,'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 1024 0 0.5])
% title('STFT Smoothing 16 Hamming 16 ')
% 
% figure(2)
% subplot(3,2,4);
% [Sx,t,f] = tfrcw(x.',1:8:length(x), 128, hamming(17),hamming(16+1));
% surf(t,f,Sx,'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 1024 0 0.5])
% title('STFT Smoothing 16 Hamming 16 decimated')
% 
% figure(2)
% subplot(3,2,1);
% [S1,t,f] = tfrcw(x.',1:length(x), 128, hamming(17),hamming(8+1));
% surf(t,f,S1,'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 1024 0 0.5])
% title('STFT Smoothing 16 Hamming 8 ')
% 
% 
% figure(2)
% subplot(3,2,2);
% [S1,t,f] = tfrcw(x.',1:8:length(x), 128, hamming(17),hamming(8+1));
% surf(t,f,S1,'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 1024 0 0.5])
% title('STFT Smoothing 16  Hamming 8 decimated')
% 
% figure(2)
% subplot(3,2,5);
% [S1,t,f] = tfrcw(x.',1:length(x), 128, hamming(17),hamming(32+1));
% surf(t,f,S1,'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 1024 0 0.5])
% title('STFT Smoothing 16 Hamming 32')
% 
% figure(2)
% subplot(3,2,6);
% [S1,t,f] = tfrcw(x.',1:8:length(x), 128, hamming(17),hamming(32+1));
% surf(t,f,S1,'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 1024 0 0.5])
% title('STFT Smoothing 16 Hamming 32 decimated')
%%
fs = 100;
nPSK_k=1;
T_k = 1024;
                    
vs_k=20;
ns_k=fs/vs_k; % NÃºmero de muestras por sÃ­mbolo                   
%numSimbolos_k=ceil(T_k/ns_k);

[codPSK,errorC]=codigoBarker(13);
%[codPSK,errorC]=codigoFrank(len);
%[codPSK,errorC]=codigoP1(len);

T_k=round(ns_k*length(codPSK));
numSimbolos_k=length(codPSK);
[x,t,codigo,error]=m_psk(1,0.25,ns_k,numSimbolos_k,1,0,codPSK,nPSK_k,T_k,1,[],2);
  [B, lags] = xcorr(x);
  ampl = sqrt(real(B).^2 + imag(B).^2);
  phase = atan(imag(B)./ real(B));
  subplot(2,1,1)
  plot(lags, ampl)
  title('Amplitude')
  subplot(2,1,2)
  plot(lags, phase)
  title('Phase')
%  
% % sgtitle('Without Time Decimation')
% % subplot(3,1,1);
% % [S1,t,f] = tfrstft(x.',1:length(x), 256);
% % surf(t,f(1:128),abs(S1(1:128,:)),'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 1024 0 0.5])
% % title('STFT')
% % 
% % figure(1)
% % subplot(3,1,2);
% % [S2,t,f] = tfrwv(x.',1:length(x), 128);
% % surf(t,f,S2, 'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 1024 0 0.5])
% % title('WVD')
% % 
% % figure(1)
% % subplot(3,1,3);
% % [S3,t,f] = tfrcw(x.',1:length(x), 128);
% % surf(t,f,S3, 'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 1024 0 0.5])
% % title('CWD')
% % 
% % figure(2)
% % sgtitle('First samples')
% % subplot(3,1,1);
% % surf(t(1:128), f(1:128)*2,abs(S1(1:128,1:128)),'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 64 0 0.5])
% % title('STFT')
% % 
% % figure(2)
% % subplot(3,1,2);
% % surf(t(1:128),f,S2(:,1:128), 'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 128 0 0.5])
% % title('WVD')
% % 
% % figure(2)
% % subplot(3,1,3);
% % surf(t(1:128),f,S3(:,1:128), 'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 128 0 0.5])
% % title('CWD')
% % 
% % S1 = S1(1:128,:);
% % ss = size(S1);
% % 
% % [X,Y] = meshgrid(linspace(1,ss(2),ss(2)), linspace(1,ss(1),ss(1)));
% % 
% % [Xq,Yq] = meshgrid(linspace(1,ss(2),128), linspace(1,ss(1),128));
% % 
% % S1 = interp2(X,Y,abs(S1),Xq,Yq,'cubic');
% % 
% % ss = size(S2);
% % 
% % [X,Y] = meshgrid(linspace(1,ss(2),ss(2)), linspace(1,ss(1),ss(1)));
% % 
% % [Xq,Yq] = meshgrid(linspace(1,ss(2),128), linspace(1,ss(1),128));
% % 
% % S2 = interp2(X,Y,S2,Xq,Yq,'cubic');
% % S3 = interp2(X,Y,S3,Xq,Yq,'cubic');
% % 
% % 
% % figure(3)
% % sgtitle('Cubid decimation over image')
% % subplot(3,1,1);
% % surf(1:128, linspace(0,0.5,128),abs(S1),'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 128 0 0.5])
% % title('STFT')
% % 
% % figure(3)
% % subplot(3,1,2);
% % surf(1:128, linspace(0,0.5,128),S2, 'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 128 0 0.5])
% % title('WVD')
% % 
% % figure(3)
% % subplot(3,1,3);
% % surf(1:128, linspace(0,0.5,128),S3, 'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 128 0 0.5])
% % title('CWD')
% % 
% % 
% % figure(4)
% % sgtitle('Decimation in time-frequency distribution')
% % subplot(3,1,1);
% % %tfrstft(x');
% % [S1,t,f] = tfrstft(x.',1:8:length(x), 256);
% % surf(t,f(1:128),abs(S1(1:128,:)),'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 1024 0 0.5])
% % title('STFT')
% % 
% % figure(4)
% % subplot(3,1,2);
% % [S2,t,f] = tfrwv(x.',1:8:length(x), 128);
% % surf(t,f,S2, 'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 1024 0 0.5])
% % title('WVD')
% % 
% % figure(4)
% % subplot(3,1,3);
% % [S3,t,f] = tfrcw(x.',1:8:length(x), 128);
% % surf(t,f,S3, 'edgecolor', 'none')
% % view(2)
% % ylabel('Normalized frequency')
% % xlabel('Time (samples)')
% % axis([1 1024 0 0.5])
% % title('CWD')



%%
fs = 100;
T_k = 1024;
vs_k = 1;

%%
fs = 100;
nPSK_k=1;
T_k = 1024;
                    
vs_k=1;
ns_k=fs/vs_k; % NÃºmero de muestras por sÃ­mbolo                   
numSimbolos_k=ceil(T_k/ns_k);

[codPSK,errorC]=codigoBarker(13);
%[codPSK,errorC]=codigoFrank(len);
%[codPSK,errorC]=codigoP1(len);

T_k=round(ns_k*length(codPSK));
numSimbolos_k=length(codPSK);


[x,t,codigo,error]=m_psk(1,0.25,ns_k,numSimbolos_k,1,0,codPSK,nPSK_k,T_k,1,[],2);

 [B, lags] = xcorr(x);
 length(B)
 length(lags)
 subplot(2,1,1)
 plot(lags,B)
 title('Autocorr')
% % 

% % %surf(t,s,abs(S1),'edgecolor', 'none')
  subplot(2,1,2)
 plot(t,x)
 title('Signal')

% figure(1)
% sgtitle('Original')
% subplot(3,1,1);
% [S1,t,f] = tfrstft(x.',1:length(x), 128);
% surf(t,f(1:64),abs(S1(1:64,:)),'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 length(t) 0 0.5])
% title('STFT')

% figure(1)
% subplot(3,1,2);
% [S2,t,f] = tfrwv(x.',1:length(x), 128);
% surf(t,f,S2, 'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 length(t) 0 0.5])
% title('WVD')
% 
% figure(1)
% subplot(3,1,3);
% [S3,t,f] = tfrcw(x.',1:length(x), 128);
% surf(t,f,S3, 'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 length(t) 0 0.5])
% title('CWD')
% 
% S1 = S1(1:64,:);
% ss = size(S1);
% 
% [X,Y] = meshgrid(linspace(1,ss(2),ss(2)), linspace(1,ss(1),ss(1)));
% 
% [Xq,Yq] = meshgrid(linspace(1,ss(2),64), linspace(1,ss(1),64));
% 
% S1 = interp2(X,Y,abs(S1),Xq,Yq,'cubic');
% 
% ss = size(S2);
% 
% [X,Y] = meshgrid(linspace(1,ss(2),ss(2)), linspace(1,ss(1),ss(1)));
% 
% [Xq,Yq] = meshgrid(linspace(1,ss(2),128), linspace(1,ss(1),128));
% 
% S2 = interp2(X,Y,S2,Xq,Yq,'cubic');
% S3 = interp2(X,Y,S3,Xq,Yq,'cubic');
% 
% 
% figure(3)
% sgtitle('Cubid interpolation over image')
% subplot(3,1,1);
% surf(1:64, linspace(0,0.5,64),abs(S1),'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 64 0 0.5])
% title('STFT')
% 
% figure(3)
% subplot(3,1,2);
% surf(1:128, linspace(0,0.5,128),S2, 'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 128 0 0.5])
% title('WVD')
% 
% figure(3)
% subplot(3,1,3);
% surf(1:128, linspace(0,0.5,128),S3, 'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 128 0 0.5])
% title('CWD')


%%
% x = exp(1j*2*pi*(0.4*(0:1024-1)));
fo = 0.15;
B = 0.25;
[s,t,error]=lfm(1,fo,1,1024,1,B/1024, B);
%  [B, lags] = xcorr(s);
%  subplot(2,1,1)
%  plot(lags,B)
%  title('Autocorr')
% % 
[S1,t2,f] = tfrstft(s.',1:length(s),256);
size(f)
size(S1)
subplot(2,1,1)
surf(t2,f(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
view(2)
% % %surf(t,s,abs(S1),'edgecolor', 'none')
 subplot(2,1,2)
%  plot(t,s)
 title('Signal')
 phase = angle(S1(1:256, :));
surf(t2,phase(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
view(2)
% 
% ttt = 1:length(s);
% [S1,t,f] = tfrstft(s.',ttt, 256, hamming(32+1));
% [S2,t2,f2] = tfrwv(s.',ttt, 128);
% [S3,t3,f3] = tfrcw(s.',ttt, 128, hamming(16+1),hamming(32+1));
% 
% subplot(3,1,1);
% surf(t,f,abs(S1),'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 length(t) -0.5 0.5])
% title('STFT')
% 
% subplot(3,1,2);
% surf(t2,f2,S2,'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 length(t) 0 0.5])
% title('WV')
% 
% subplot(3,1,3);
% surf(t3,f3,S3,'edgecolor', 'none')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 length(t) 0 0.5])
% title('CW')
%%
fo = 0.15;
Bc = fo*0.3;
Tr = 0.20;

[s,t,error]= lfm_esc(1, fo, 1, 1024, 0.20, 256, 1024/256, 1, Bc/1024, [], Bc, [], 1);
%  [B, lags] = xcorr(s);
[S1,t2,f] = tfrstft(s.',1:length(s),256);
% size(f)
% size(S1)
subplot(2,1,1)
surf(t2,f(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
view(2)
subplot(2,1,2)
plot(t, s)
title('Signal in time')
%%
[s,t,error] = m_ask(1, 0.25, 80, 10, 0, 1, [], 1, 1024, 1, []);
%ttt = 1:length(s);
%[S1,t,f] = tfrstft(s.',ttt, 256, hamming(32+1));
  [B, lags] = xcorr(s);
  ampl = sqrt(real(B).^2 + imag(B).^2);
  phase = atan(imag(B)./ real(B));
  subplot(2,1,1)
  plot(lags, ampl)
  title('Amplitude')
  subplot(2,1,2)
  plot(lags, phase)
  title('Phase')
% view(2)
% ylabel('Normalized frequency')
% xlabel('Time (samples)')
% axis([1 length(t) -0.5 0.5])
% title('STFT')
%%
fo_k = 0.25;
T_k = 1024;
A = rand(1);
t = 1:1:1024;
x=A*exp(j*2*pi*(fo_k*(0:T_k-1)+rand(1)));
%  [B, lags] = xcorr(x);
%  subplot(2,1,1)
%  plot(lags,B)
%  title('Autocorr')
% % 

% % %surf(t,s,abs(S1),'edgecolor', 'none')
%   subplot(2,1,2)
 plot(t,x)
 title('Signal')
 %% 
fo = 0.13;
Bc = fo*0.3;
[s, t, error] = nlfm(1, fo,0.015, Bc, 0, 1024,1,0);
[S1,t2,f] = tfrstft(s.',1:length(s),256);
% size(f)
% size(S1)
subplot(2,1,1)
surf(t2,f(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
view(2)
subplot(2,1,2)
plot(t, s)
title('Signal in time')
% [B, lags] = xcorr(s);
% subplot(2,1,2)
%  plot(lags,B)
%  title('Autocorr')
%%      
T_k = 1024;
BWc = [0.25 0.30];
fo_k = 0.27;
pAl = 1;


                   ns_k = randsrc(1,1,[4, 8]);
                   Tc_k = 1024/ns_k;
                   T_k=T_k; %Duración del pulso en muestras
                   Tc_k=Tc_k; %Duración del pulso en muestras
                   Tr = randsrc(1,1,[0.15, 0.20, 0.25, 0.30]);
                   BWc_k=(BWc(1)+(BWc(2)-BWc(1))*rand(1))*fo_k;
                   pendiente_k=randsrc(1,1,[1,-1]);
                   clas_Sig = 5;                    
                   [x,t,error]=lfm_esc(1,fo_k,pAl,T_k,Tr,Tc_k,ns_k,1,1,BWc_k/T_k,BWc_k,[],pendiente_k);
                   plot(t, x)
                        
%% v
vsQAM = [1, 1/2, 1/4, 1/6];
fs = 1000;
fo_k = 0.25;
pAl = 1;
nASK = 1;
T_k = 1024;
                   nASK = 1;
                    [codBASK,errorC] = codigoBarker(13);
                    if errorC
                        display("Could not generate code")
                        return
                    end
                    codBASK= codBASK(1,:);
                    numSimbolos_k = length(codBASK);
                    ns_k = round(T_k/numSimbolos_k)
                    clas_Sig = 8;
                    [x,t,codigo,error]=m_ask(1, fo_k, ns_k, numSimbolos_k, pAl, 0, codBASK,nASK, T_k, 1,  [], 0);
                    plot(t,x)
%%
X_train = load('Dataset/X_train.mat', '-mat')

%%
BWc= [1/4, 0.3];
    fs = 1;
 fo = [fs*0.03, fs*0.3]; 
fo_k= (fo(1)+(fo(2)-fo(1))*rand(1));
T_k = 1024;
BWc_k=(BWc(1)+(BWc(2)-BWc(1))*rand(1))*fo_k;
%BWc_k=BWc(randsrc(1,1,[1:length(BWc)])); %Ancho de banda en MHz
                                       
datosSig(k,i,4)=BWc_k; %Se almacena el ancho de banda de la seÃ±al LFM que se va a generar
                    
T_k=round(T_k*fs); %DuraciÃ³n del pulso en muestras %Ancho de banda normalizado de la fs
                    
pendiente_k=randsrc; %Se elije aleaotiamente pendiente ascendente(1) o descendente(-1)


cr_k=(BWc_k/T_k)*pendiente_k; %chirp rate
                    
[x,t,error]=lfm(1,fo_k,1,T_k,1,cr_k);
plot(t,x)
clas_Sig = 1;
%%
l_s = 1024;
snr = 20;
i_train=1;
cAl=0;
nPSK_k = 4;
k = 1;

%% 
[X1,Y1,lbl1] = signal_generator(20,1,[l_s, l_s],1,[1/4, 0.3],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[],j,1,0,[],[],[],[]);
%%
[X1,Y1,lbl1] = signal_generator(20,1,[l_s, l_s],2,[1/4, 0.3],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],1,[],0,1,0,[],[],[],[]);
%%
l_s = 1024;
 [X1,Y1,lbl1] = signal_generator(4,1,[l_s, l_s],3,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],1,[2,5, 10, 15, 20],1,1,0,[],[],[],[]);
 %%
[X1,Y1,lbl1] = signal_generator(4,1,[l_s, l_s],5,[1/4, 0.3],[],[],[],[],[],0,[],0,1,0,[],[],[],[]);
%%
[X1,Y1,lbl1] = signal_generator(4,1,[l_s, l_s],6,[1/4, 0.3],[],[],[],[],[],0,[20],0,1,0,[],[],[],[]);
%%
[X1,Y1,lbl1] = signal_generator(0,1,[l_s, l_s],7,[1/4, 0.3],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],0,[20],0,1,0,[],[],[],[]);
%%
[X1,Y1,lbl1] = signal_generator(-6,1,[l_s, l_s],8,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],0,[20],0,1,0,[],[],[1, 1/2, 1/4, 1/6],[]);
%%
[X1,Y1,lbl1] = signal_generator2(20,1,[1024, 1024],1,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,0,[],[],[],[]);
%%
[X1,Y1,lbl1] = signal_generator2(20,1,[l_s, l_s],2,[1/20, 1/4],[],[],[],[1, 2, 5, 10],[1/100, 1/20],1,[20],1,0,0,[],[],[],[]);
%%
[X1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],3,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],1,[2,5, 10, 15, 20],nPSK_k,1,0,10,[],[],[]);
%%
[X1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],3,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],1,[2,5, 10, 15, 20],nPSK_k,1,0,13,[],[],[]);
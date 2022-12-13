%
% Ejemplo
% T=(4*1024)/700;fcM=0;tic;dibujaEstadisticos_TTD('TZ',40,1e3,fcM,5,0.1,1,32,T,[2,3,6,7],[10],700./[70,50,35,20],[0.5],700./[70,50,35,20],700./[70,50,35,20],700./[70,50,35,20],0.3);toc
%
% T=1024/700;foMax=2.7;tic;dibujaEstadisticos_Articulo('TZ',15,1e4,foMax,5,0.1,1,32,T,[1,2,3,4],[0.5,1,2,5,10,50]*T,[10,20,40,60],[0.5,1],[10,20,40,60],[10,20,40,60],[10,20,40,60],[]);toc
%


function [X, Xcorr, Y,lbl]=signal_generator(SNR,iteraciones,T,rTipoSig,BWc,T1_rel,Tcesc,Dfesc,vsFSK,Dffsk,nFSK,vsPSK,nPSK,pAl,cAl,cod,vsASK,vsQAM,Roff)
    

    % Crea la carpeta para almacenar los vectores de señal resultantes
    %[status,msg,msgID] = mkdir(directorio);

    % Frecuencia de muestreo en MHz
%     fs = 6500;
    fs = 1000;
    
%     fo=[fs/8,3*fs/8]; % Frecuencia de portadora (MHz)
    fo = [fs*0.03, fs*0.3]; 
    fm = [1, 10];
    % MASK
    nASK=1;

    
    % NLFM
    nNLFM=4;
    kNLFM=0.015;
    clas_Sig=0;
    %Salidas:
    X = zeros(length(SNR)*iteraciones,1024,2);
    Xcorr = zeros(length(SNR)*iteraciones,1024,2);
    Y = zeros(length(SNR)*iteraciones, 8);
    lbl = zeros(length(SNR)*iteraciones, 6);
   % corr = zeros(length(SNR)*iteraciones,1024,2);
    
    ik = 1;
    
    for i=1:length(SNR)
        
        snr_i=10^(SNR(i)/10);

        for k=1:iteraciones,
            
            % frecuencia de portadora aleatoria entre fo(1) y fo(2) normalizada respecto de fs
            fo_k= (fo(1)+(fo(2)-fo(1))*rand(1))/fs;
            % fo_k= 200/fs;
            T_k = 1024;
            
          for l=1:length(rTipoSig)  
            
              tipoSig=rTipoSig(l); 
            
            % Tipos de señal generados
            % 1 - LFM
            % 2 - BFSK
            % 3 - BPSK
            % 4 - NM
            % 5 - SFW
            % 6 - SIN
            % 7 - EXP
            % 8 - BASK
            
            switch tipoSig,
                case 1, % LFM 
                    
                    BWc_k=(BWc(1)+(BWc(2)-BWc(1))*rand(1))*fo_k;
                    %BWc_k=BWc(randsrc(1,1,[1:length(BWc)])); %Ancho de banda en MHz
                                       
                    datosSig(k,i,4)=BWc_k; %Se almacena el ancho de banda de la señal LFM que se va a generar
                    
                    T_k=round(T_k); %Duración del pulso en muestras %Ancho de banda normalizado de la fs
                    
                    pendiente_k=randsrc; %Se elije aleaotiamente pendiente ascendente(1) o descendente(-1)
%                   pendiente_k=1;

                    cr_k=(BWc_k/T_k)*pendiente_k; %chirp rate
                    
                    [x,t,error]=lfm(1,fo_k,pAl,T_k,1,cr_k);
%                     subplot(3,1,1)
%                     plot(t,x)
                    datosSig(k,i,5)=pendiente_k;
                    clas_Sig = 1;
%                     subplot(2,1,1)
%                     plot(t,x)
%                     title('Time Sequence')
%                     [S1,t2,f] = tfrstft(x.',1:length(x),256);
%                     subplot(2,1,2)
%                     surf(t2,f(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
%                     view(2)
% %                         
%                     title('Frequency')
                    
                case 2, % MFSK
                    nFSK_k = 1;
                    vs_k=vsFSK(randsrc(1,1,[1:length(vsFSK)]));
                    ns_k=fs/vs_k; % Número de muestras por símbolo
                    Df_k=randsrc(1,1,[0.15 0.20 0.25 0.3]) * fo_k;
%                   Df_k=Dffsk(randsrc(1,1,[1:length(Dffsk)]));
                    faseContinua=0;
                    clas_Sig = 2;
                    codFSK = [];
                    errorC = 0;
                    if (cAl == 0)          
                        [codFSK,errorC]= codigoBarker(13);
                        codFSK = codFSK(1,:);
                        numSimbolos_k=length(codFSK);
                        ns_k = round(T_k/numSimbolos_k);
                    end
                    if errorC,
                        disp('Error al generar el c�digo costas.')
                        return
                    end
                    [x,t,codigo,error]=m_fsk(1,fo_k,Df_k,ns_k,numSimbolos_k,pAl,cAl,codFSK,nFSK_k,T_k,1,faseContinua,[],0);
%                     subplot(3,1,1)
%                     plot(t,x)
                    datosSig(k,i,4)=vs_k;
                    datosSig(k,i,5)=nFSK_k;
                    datosSig(k,i,6)=Df_k;
%                     subplot(2,1,1)
%                     plot(t,x)
%                     title('Time Sequence')
%                     [S1,t2,f] = tfrstft(x.',1:length(x),256);
%                     subplot(2,1,2)
%                     surf(t2,f(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
%                     view(2)
% %                         
%                     title('Frequency')
%                                         
                case 3, % MPSK
                    nPSK_k = 1;
                    vs_k=vsPSK(randsrc(1,1,[1:length(vsPSK)]));
                    ns_k=fs/vs_k; % Número de muestras por símbolo
                    ns_k=round(ns_k);
                    numSimbolos_k=ceil(T_k/ns_k);
                    clas_Sig = 3;
                    errorC = 0;
                    Roff = [];
                    if cAl == 0,
                        [codPSK,errorC] = codigoBarker(13); % ONLY BARKER CODE OF LENGTH 13
                        codPSK= codPSK(1,:);
                        numSimbolos_k = length(codPSK);
                        ns_k = round(T_k/numSimbolos_k);
                        if errorC,
                            disp('Error al generar el c�digo radar.')
                            return
                        end
                    end
%                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    [x,t,codigo,error]=m_psk(1,fo_k,ns_k,numSimbolos_k,0,cAl,codPSK,nPSK_k,T_k,1,Roff,0);
%                     subplot(2,1,1)
%                     plot(t,x)
%                     title('Time Sequence')
%                     [S1,t2,f] = tfrstft(x.',1:length(x),256);
%                     phase = angle(S1(1:256, :));
%                     subplot(2,1,2)
%                     surf(t2,phase(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
%                     view(2)
%                     title('Phase')
                    datosSig(k,i,4)=vs_k;
                    datosSig(k,i,5)=nPSK_k;                      
                case 4, % NM
                    T_k=round(T_k); % Longitud de bloque en muestras
                    x=exp(j*2*pi*(fo_k*(0:T_k-1)+rand(1)));
                    clas_Sig = 4;
                case 5, % LFM esc
                   ns_k = randsrc(1,1,[4, 8]);
                   Tc_k = T_k/ns_k;
                    %Duraci�n del pulso en muestras
                   Tc_k=Tc_k; %Duraci�n del pulso en muestras
                   Tr = randsrc(1,1,[0.15, 0.20, 0.25, 0.30]);
                   BWc_k=(BWc(1)+(BWc(2)-BWc(1))*rand(1))*fo_k;
                   pendiente_k=randsrc(1,1,[1,-1]);
                   clas_Sig = 5;                    
                   [x,t,error]=lfm_esc(1,fo_k,pAl,T_k,Tr,Tc_k,ns_k,1,1,BWc_k/T_k,BWc_k,[],pendiente_k);
%                     subplot(2,1,1)
%                     plot(t,x)
%                     title('Time Sequence')
%                     [S1,t2,f] = tfrstft(x.',1:length(x),256);
%                     subplot(2,1,2)
%                     surf(t2,f(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
%                     view(2)
% %                         
%                     title('Frequency')
                case 6, %% Sinusoidal NLFM

                    BWc_k=(BWc(1)+(BWc(2)-BWc(1))*rand(1))*fo_k;
                    fm_k = (fm(1)+(fm(2)-fm(1))*rand(1))/fs;
                    [x,t,error]=nlfm(1,fo_k,fm_k,BWc_k, pAl,T_k,1,1);
                    clas_Sig = 6;
%                     subplot(2,1,1)
%                     plot(t,x)
%                     title('Time Sequence')
%                     [S1,t2,f] = tfrstft(x.',1:length(x),256);
%                     subplot(2,1,2)
%                     surf(t2,f(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
%                     view(2)
% %                         
%                     title('Frequency')
%                     subplot(3,1,1)
%                     plot(t,x)
                case 7, %%Exponential NLFM
                    BWc_k=(BWc(1)+(BWc(2)-BWc(1))*rand(1))*fo_k; %Duración del pulso en muestras
                    [x,t,error]=nlfm(1,fo_k,[], BWc_k, pAl,T_k,1,0);
                    clas_Sig = 7;
%                     subplot(2,1,1)
%                     plot(t,x)
%                     title('Time Sequence')
%                     [S1,t2,f] = tfrstft(x.',1:length(x),256);
%                     subplot(2,1,2)
%                     surf(t2,f(1:256),abs(S1(1:256,:)),'edgecolor', 'none')
%                     view(2)
% %                         
%                     title('Frequency')
%                     subplot(3,1,1)
%                     plot(t,x)
                case 8, %% BASK
                    nASK = 1;
                    [codBASK,errorC] = codigoBarker(13);
                    if errorC
                        display("Could not generate code")
                        return
                    end
                    codBASK= codBASK(1,:);
                    numSimbolos_k = length(codBASK);
                    ns_k = round(T_k/numSimbolos_k);
                    
                    clas_Sig = 8;
                    [x,t,codigo,error]=m_ask(1, fo_k, ns_k, numSimbolos_k, pAl, 0, codBASK,nASK, T_k, 1,  [], 0);
%                     subplot(3,1,1)
%                     plot(t,x)
            end
            
            datosSig(k,i,1)=clas_Sig;
            datosSig(k,i,2)=SNR(i);
            datosSig(k,i,3)=T_k;
            datosSig(k,i,7) = fo_k;
            
            
          % Amplitud del ruido
           
           ampR = 1; % Amplitud fija de ruido
           ampS=sqrt(2*snr_i*ampR^2); % Amplitud de se�al depende del ruido fijado y de la SNR  
                  
           r = ampR*(randn(1,length(x)) + 1j*randn(1,length(x))); %Ruido aleatorio gaussiano 
            
           s = ampS*x+r;
           s = s / max(abs(s)) ;
           
           m_s = min([length(s), T(2)]);
           s = s(1:m_s);
%            subplot(3,1,2)
%            plot(0:1023, s)
           [B, lags] = xcorr(s);
           I = real(s);
           Q = imag(s);
           corr = B(1024:end);
           Xcorr_real = real(corr);
           Xcorr_imag = imag(corr);

           %r2 = ampR*(randn(1,T(2)-length(I)) + 1j*randn(1,T(2)-length(Q)));
           
           %I = [I r2];
           %Q = [Q r2];
           
           t1 = linspace(1,length(I),length(I)); 
           t2 = linspace(1,length(I),T(2)); 
           I = interp1(t1,I,t2);
           Q = interp1(t1,Q,t2);

           X(ik,:,1) = I;
           X(ik,:,2) = Q;
           Xcorr(ik, :, 1) = Xcorr_real;
           Xcorr(ik, :, 2)= Xcorr_imag;
           out = [datosSig(k,i,1), datosSig(k,i,2), datosSig(k,i,3),datosSig(k,i,7), datosSig(k,i,4), datosSig(k,i,6)];
           
           lbl(ik,:) = out;
           Y(ik,datosSig(k,i,1)) = 1;
           
           ik = ik+1;
           
% mod: datosSig(k,i,1)= clas_Sig
% classes = ['LFM','2FSK','4FSK','8FSK', 'Costas','2PSK','4PSK','8PSK',
% 'Barker','Huffman','Frank','P1','P2','P3','P4','Px','Zadoff-Chu','T1',
% 'T2','T3','T4','NM','ruido']
% PARAMS: Pendiente por definir !!      
%             datosSig(k,i,2) =  SNR (dB)
%             datosSig(k,i,3) =  T_k (muestras)
%             datosSig(k,i,4)    LFM: BW    FSK: vs     PSK: vs     QAM: vs
%             datosSig(k,i,5)    LFM: alpha FSK: n      PSK: n      QAM: n
%             datosSig(k,i,6)               FSK: Df
%             datosSig(k,i,7) = fo

     
     
     %       s=ampS*x;              
     %       s= real(s);       
     %       r = real(r);      
     %       N = 256;          
     %       S  =   acondicionamientoSTFT(s, OL, Lfft);
                         
          end
     end

end
end

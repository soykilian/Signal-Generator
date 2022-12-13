
%
% Genera un pulso de una señal LFM a partir de sus características.
%   Parámetros de entrada:
%       fs: Frecuencia de muestreo en Hz.
%       fo: Frecuencia de la portadora normalizada por fs.
%       pAl: 1 Si la fase de la portadora es aleatoria, 0 si no lo es.
%       T: Duración del pulso chirp.
%       TOA: Tiempo de llegada de la señal (muestras o segundos).
%       Tsecuencia: Número de muestras (tiempo) de la señal generada.
%       muestras: 1 si los tiempos introducidos son en muestras, 0 si son en segundos.
%       alfa: Pendiente de la señal (normalizada de fs) 
%       ascend: Pendiente positiva (1) o negativa (0).
%           frecuencia instantánea: fi(n)
%               fi(TOA)=fo, fi(TOA+T)=fo+alfa en pendiente positiva.
%               fi(TOA+T)=fo+alfa, fi(T)=fo en pendiente negativa.
%
%
%
%   Parámetros de salida:
%       s: Señal generada.
%       t: Vector de tiempos.
%       error: Indica si ha habido un error (1) o no (0).
%
%
%

function [s,t,error]=nlfm(fs,fo,fm, Bc,pAl,Tsecuencia,muestras, e)

    error=0;
    s=0;
    t=0;
    
    
    if isempty(fs)|isempty(fo)|isempty(Bc)|isempty(pAl)|isempty(Tsecuencia)|isempty(muestras),
        disp('Faltan parámetros')
        error=1;
        return
    end
    if isempty(fm) && e ==1
        disp('Cannot generate sinusoidal frequency without fm')
        error=1;
        return
    end

     if muestras==0,
        Tsecuencia=floor(Tsecuencia*fs);
    else,
        Tsecuencia=floor(Tsecuencia);
    end
    % Número de muestras sin señal al final de la secuencia
%    E=Tsecuencia-(TOA+T);
    
%     if E<0,
%     end
    
%     if T/2==round(T/2),
%         T=T+1;
%     else,
%         
%     end
    Ts=1/fs;
    n=0:Ts:Tsecuencia-Ts;
    
%     r=1.05ñ
   Am = rand(1);
 if e == 1
     beta = Bc/(2*fm);
     fi = beta*sin(2*pi*fm.*n);
     slfm1=Am*exp(j*(2*pi*fo.*n + fi));
 else
     delta_f = Bc;
     f_0 = fo - (delta_f);
     f_1 = fo + (delta_f);
     k = (f_1/f_0)^(1/(Tsecuencia));
     fi = f_0*(k.^n);
     slfm1=Am*exp(j*(2*pi*fi.*n));
%  fi = exp(n + rand(1));
 end

% 
%    subplot(2,1,1)
%    plot(fi);
   % fi=sqrt(r-1)*((n2*Bc)/T2)./(sqrt(r-(4*n2.^2/T2^2)));
   
   

%     figure
%     plot(n,fi)
   
        
    % Cogemos el número de muestras pedidas
    
    s=slfm1;
    s=s(1:Tsecuencia);
    t=0:Ts:(Tsecuencia-1)*Ts;
    
    % Normalizamos la potencia
    
    potS=sum(abs(s).^2)/length(s);
    s=s/sqrt(potS);
    
    % Lo llevamos a fo
    
   %s=s.*exp(j*2*pi*fo*[0:length(s)-1]);
%    subplot(2,1,2)
%    plot(t,s)
    % Le damos fase aleatoria si se pide
    
    if pAl==1,
        s=s*exp(j*2*pi*rand(1));
    end
    
end


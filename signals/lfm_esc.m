%
% Genera un pulso de una se√±al escalonada en frecuencia a partir de sus caracter√≠sticas.
%   Par√°metros de entrada:
%       fs: Frecuencia de muestreo en Hz.
%       fo: Frecuencia de la portadora normalizada por fs.
%       pAl: 1 Si la fase de la portadora es aleatoria, 0 si no lo es.
%       T: Duraci√≥n del pulso chirp.
%		Tc: Tiempo de chip (periodo de cada escal√≥n).
%		Nc: N√∫mero de chips en el pulso (escalones).
%		CP: de fase continua (1) o salto de fase (0).
%       muestras: 1 si los tiempos introducidos son en muestras, 0 si son en segundos.
%       k: chirp rate (normalizado de fs).
%       B: Ancho de banda (normalizado de fs).
%		Df: Excursion en frecuencia entre dos chips consecutivos (normalizado de fs).
%       ascend: Pendiente positiva (1) o negativa (-1).
%           Es posible introducir el chirp rate (k) o bien el ancho de
%           banda de la se√±al (B) y la pendiente, de tal forma que 
%           k=ascend*(B/T).
%
%   Par√°metros de salida:
%       s: Se√±al generada.
%       t: Vector de tiempos.
%       error: Indica si ha habido un error (1) o no (0).
%
%
% THIS IS NO LONGER A STEP LFM, BUT A STEP FREQUENCY WAVE 

function [s,t,error]=lfm_esc(fs,fo,pAl,T, Tr_k, Tc,Nc,muestras,CP,k,B,Df,ascend)

    error=0;
    s=0;
    t=0;
    if nargin<10
        disp('Faltan par·metros')
        error = 1;
        return
    end

    if isempty(fs)||isempty(fo)||isempty(pAl)||isempty(muestras) || isempty(Tr_k)
        disp('Faltan par·metros')
        error = 1;
        return
    end

    if isempty(k)&&(isempty(B)||isempty(ascend)),
        disp('Faltan par·metros');
        error=1;
        return
    end
    
    if isempty(Tc)&&isempty(Nc)
        disp('Faltan par·metros');
        error=1;
        return
    end
    
    if isempty(Df)&&isempty(B)&&isempty(Nc)
        disp('Faltan par·metros');
        error=1;
        return
    end
    %%%%%%%%%%%%% Se determinan los par·metros de generaciÛn de seÒal %%%%%%%%%%%%%%%

    % Diferentes modos de generaciÛn de seÒal en funcion de los par·metros que se proporcionan
    % Solo se puede dejar vacÌo uno de estos tres par·metros --> Nc,Tc,T
    if isempty(Nc),
    	% Modo Tc, T --> Se determina el n√∫mero de chip que entran en T
    	Nc = floor((T*fs)/(Tc*fs))+1;
    elseif isempty(Tc),
    	% Modo Nc, T --> Se determina el periodo de chip
    	Tc = T/Nc;
    end
    % Tiempo total ajustado al periodo y n√∫mero de chips
    T2 = Nc*Tc;
    % Modo Nc,
    % Tc --> T = T2
    if isempty(T),
        T = T2;
    end
    if isempty(ascend)
        p = [1, -1];
        ascend = p(randsrc(1,1,1:length([1,-1])));
    end
    % Solo se puede dejar vacÌo Df o B. Solo se puede dejar vacÌo ambos par·metros si se ha introducido el chirp rate
    if isempty(Df),
    	% Modo B --> Se determina la excursiÛn en frecuencia entre chips consecutivos
    	if isempty(B),
    		% Si tampoco se proporciona el ancho de banda
    		B = k*T;
    	end
    	Df = B/(Nc-1);
    end
    	% Modo Df --> no se hace nada
   
    % Ancho de banda total ajustado al n˙mero de chips y la excursiÛn en frecuencia 
    B = Df*(Nc-1);
    if muestras==0,
        Tsecuencia=floor(T*fs);
    else,
        Tsecuencia=floor(T);
    end

    % Generamos el vector de tiempos
    Ts=1/fs;
    n=0:Ts:(T2)-Ts;
    % Se selecciona la frecuencia inicial dependiendo de la pendiente
    if ascend==1,
        fc=B/2;
    else,
        fc=-B/2;
    end
    
    %%freq = (fo-fc):(ascend*1/1024):(fo+fc);
    freq = (fo-fc):(ascend*Df):(fo+fc);
    freq = repmat(freq,ceil(Tc*fs),1);
    freq = reshape(freq,1,T2*fs);
    Tr = Tr_k*Tc;
    p = zeros(1,Tc*Nc);
    for i=0:Nc-1
        for k=1:Tr
            p(i*Tc + k) = 1;
        end
    end
    if CP,
    	slfm=p.*exp(j*2*pi*cumsum(freq));
    else
    	slfm=p.*exp(j*2*pi*freq.*n);
    end
    % Cogemos el n˙mero de muestras pedidas
    s=slfm;
    s=s(1:Tsecuencia);
    Ts=1/fs;
    t=0:Ts:(Tsecuencia-1)*Ts;
    
    % Normalizamos la potencia
    
    potS=sum(abs(s).^2)/length(s);
    s=s/sqrt(potS);
    % Le damos fase aleatoria si se pide
    if pAl==1,
        s=s*exp(j*2*pi*rand(1));
    end
end


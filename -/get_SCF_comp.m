function [SCF,error] = get_SCF_comp(x,K);
%%% 
% K == duración de la ventana de hamming
% L == diezmado utilizado en la STFT
% N = duración de la señal

x = x(:);
N = length(x);
error=0;
if nargin<2,
        disp('Faltan parámetros');
        error=1;
        return
    end
    
    if isempty(x)|isempty(K),
        disp('Faltan parámetros')
        error=1;
        return
    end

L = K/4;
a = hamming(2*K);
a = a(:);
a = a(end:-1:1)/sqrt(sum(abs(a).^2));
P = floor((N-length(a))/L)+1;
display(P);
P = floor(P/4)*4; % Múltiplo de 4
%%% M == duracion de los periodogramas 
M = P*L;
display(L);
display(M)
%g = ones(P,1)/P;
%g = sparse(diag(g));

X_f = zeros(2*K,P);
% Filtramos y diezmamos
for Li=1:L:M
	X_f(:,(Li-1)/L+1) = fftshift(fft(x(Li:Li+2*K-1).*a));
end

X_f(:,:) = X_f.*exp(fftshift(((-j*pi*L/K)*[0:2*K-1].'))*[0:P-1]);

gX_f = conj(X_f)/P;

SCF = zeros(M,2*K);

df_da = M/K;

indices = mod([-df_da/2+1:df_da/2],P)+1;

for ci=1:K
	for fi=1:2*K-(ci-1)*2
		aux = fft(gX_f(fi,:).*X_f(fi+(ci-1)*2,:));
		SCF(mod((ci-3/2)*df_da+1:(ci-1/2)*df_da,M)+1,fi+ci-1) = aux(indices);
	end
end

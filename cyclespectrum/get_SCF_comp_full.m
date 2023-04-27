function [SCF] = get_SCF_comp_full(x,K);

x = x(:);
%%% N == tiempo de observacion delta t
N = length(x);

%%% L numero de valores para el diezmado temporal del resultado de la STFT
L = K/4;

%%% a[n] == ventana de hamming (de longitud N de la tesis) muestras para el calculo de
%%% STFT

a = hamming(2*K);
a = a(:);
a = a(end:-1:1)/sqrt(sum(abs(a).^2));

%%% P == numero de salidas de la STFT promediadas
P = floor((N-length(a))/L)+1;
P = floor(P/8)*8; % Múltiplo de 4
%%% M == spectral resolution 
M = P*L

disp(['Resolución cicloespectral: 1/',num2str(M)])
disp(['Resolución espectral: 1/',num2str(2*K)])

%g = ones(P,1)/P;
%g = sparse(diag(g));

X_f = zeros(2*K,P);
% Filtramos y diezmamos
for Li=1:L:M
	X_f(:,(Li-1)/L+1) = fftshift(fft(x(Li:Li+2*K-1).*a));
end
%%% To this point the X[nL,k1] and X[nL,k2] have been computed 
%%% q = P/2N from the thesis
%%% exp(-j*2*pi*q*n/M)
X_f(:,:) = X_f.*exp(fftshift(((-j*pi*L/K)*[0:2*K-1].'))*[0:P-1]);

%%% Now their frequencies and cyclefrequencies have been translated to
%%% f = k1+k2/2length(a) 
%%% alpha = k1-k2/N + q/P

%%% The complex conjugate of the signal is computed and promediada
gX_f = conj(X_f)/P;

SCF = zeros(M,2*K);
%%% temporal resolution delta f X
df_da = M/K;

indices = mod([-df_da/2+1:df_da/2],P)+1;

for ci=1:K
	for fi=1:2*K-(ci-1)*2
		aux = fft(gX_f(fi,:).*X_f(fi+(ci-1)*2,:));
		c_ind = mod((ci-3/2)*df_da+1:(ci-1/2)*df_da,M)+1;
		f_ind = fi+ci-1; 
		SCF(c_ind,f_ind) = aux(indices);
		if ci~=1
			f_ind = mod(f_ind+K-1,2*K)+1;
			c_ind = P*L-c_ind+2;
			SCF(c_ind,f_ind) = conj(aux(indices));
		end
	end
end
SCF(end-df_da/2-3:end,:) = fftshift(SCF(end-df_da/2-3:end,:),2);

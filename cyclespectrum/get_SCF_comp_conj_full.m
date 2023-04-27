function [SCF] = get_SCF_conj_full(x,K);

x = x(:);
N = length(x);


L = K/4;

a = hamming(2*K);
a = a(:);
a = a(end:-1:1)/sqrt(sum(abs(a).^2));

P = floor((N-length(a))/L)+1;
P = floor(P/8)*8;
M = P*L;

disp(['Resolución cicloespectral: 1/',num2str(M)])
disp(['Resolución espectral: 1/',num2str(2*K)])

%g = ones(P,1)/P;
%g = sparse(diag(g));

X_f = zeros(2*K,P);
% Filtramos y diezmamos
for Li=1:L:M
	X_f(:,(Li-1)/L+1) = fftshift(fft(x(Li:Li+2*K-1).*a));
end

X_f(:,:) = X_f.*exp(fftshift(((-j*pi*L/K)*[0:2*K-1].'))*[0:P-1]);

gX_f = X_f([1,end:-1:2],:)/P;
(2-1/K)/2*P*L+1,2*K
SCF = zeros((2-1/K)/2*P*L+1,2*K);

df_da = P*L/K;

indices = mod([-df_da/2+1:df_da/2],P)+1;

ci=1; % Solo cojemos la mitad de ciclofrecuencias
for fi=1:2*K
	aux = fft(gX_f(fi,:).*X_f(fi,:));
	SCF(1:df_da/2+1,fi) = aux(indices(df_da/2:end));
end
					
for ci=2:K
	for fi=1:2*K-(ci-1)*2
		aux = fft(gX_f(fi,:).*X_f(fi+(ci-1)*2,:));
		c_ind = (ci-3/2)*df_da+2:(ci-1/2)*df_da+1;
		f_ind = fi+ci-1; 
		SCF(c_ind,f_ind) = aux(indices);
        %%% What does this do????
		f_ind = mod(f_ind+K-1,2*K)+1;
		c_ind = P*L-c_ind+2;
		SCF(c_ind,f_ind) = conj(aux(indices));
	end
end


function [SCF] = get_SCF(x,K);

x = x(:);
N = length(x);


L = K/4;

a = hamming(2*K);
a = a(:);
a = a(end:-1:1)/sqrt(sum(abs(a).^2));

P = floor((N-length(a))/L)+1;
P = floor(P/8)*8; % Múltiplo de 4
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

gX_f = conj(X_f)/P;

SCF = zeros(M,2*K);

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

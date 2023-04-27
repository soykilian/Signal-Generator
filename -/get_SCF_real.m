function [SCF] = get_SCF_real(x,K);

x = x(:);
N = length(x);


L = max(K/4,1);

a = hamming(2*K);
a = a(:);
a = a(end:-1:1)/sqrt(sum(abs(a).^2));

P = floor((N-length(a))/L)+1;

%g = ones(P,1)/P;
%g = sparse(diag(g));

X_f = zeros(2*K,P);
% Filtramos y diezmamos
for Li=1:L:N-2*K+1
	X_f(:,(Li-1)/L+1) = fftshift(fft(x(Li:Li+2*K-1).*a));
end

X_f(:,:) = X_f.*exp(fftshift(((-j*pi*L/K)*[0:2*K-1].'))*[0:P-1]);

gX_f = conj(X_f)/P;

SCF = zeros((2-1/K)/2*P*L+1,K+1);

df_da = P*L/K;

indices = mod([-df_da/2+1:df_da/2],P)+1;

ci=1; % Solo cojemos la mitad de ciclofrecuencias
for fi=1:K+1
	aux = fft(gX_f(fi,:).*X_f(fi,:));
	SCF(1:df_da/2+1,fi) = aux(indices(df_da/2:end));
end
					
for ci=2:K
	for fi=1:K+2-ci
		aux = fft(gX_f(fi,:).*X_f(fi+(ci-1)*2,:));
		SCF((ci-3/2)*df_da+2:(ci-1/2)*df_da+1,fi+ci-1) = aux(indices);
	end
end

% if nargin < 3 | any(size(s2_local)~=[df_da/2+1,3])
% 	s2_local = zeros(df_da/2+2,3);
% 	s2_local(:,1) = local_th(a,full(diag(g)),L,5/K,-5/K); % f={0,0.5} (Primera y última)
% 	s2_local(:,2) = local_th(a,full(diag(g)),L,5/K,-6/K); % f={0,0.5}+-df/2 (Segunda y penúltima)
% 	s2_local(:,3) = local_th(a,full(diag(g)),L,5/K,-7/K); % f=resto
% 	s2_local = sqrt(s2_local(1:end-1,:));
% end
% 
% norm_mx = [ones(1,K+1); ... alpha = 0 no se toca
% 	s2_local(2:end,1), s2_local(2:end,2), repmat(s2_local(2:end,3),1,K-3), ...
% 	s2_local(2:end,2), s2_local(2:end,1); ...
% 	repmat([s2_local(end-1:-1:2,1);s2_local(:,1)],K-1,1), ...
% 	repmat([s2_local(end-1:-1:2,2);s2_local(:,2)],K-1,1), ...
% 	repmat([s2_local(end-1:-1:2,3);s2_local(:,3)],K-1,K-3), ...
% 	repmat([s2_local(end-1:-1:2,2);s2_local(:,2)],K-1,1), ...
% 	repmat([s2_local(end-1:-1:2,1);s2_local(:,1)],K-1,1)];
% 
% NSCF = SCF./norm_mx;
		

function [SCF] = get_SCF(x,K,f1,f2);

x = x(:);
N = length(x);

f = (f1+f2);

L = K/4;

a = hamming(2*K);
a = a(:);
a = a(end:-1:1)/sqrt(sum(abs(a).^2));

P = floor((N-length(a))/L)+1;
alpha = f1-f2;
alphabin = round(alpha*P*L);

df_da = P*L/K;
ci = ceil((alphabin-df_da/2)/df_da)+1;
ch_centre = mod(round(f*K)+K,2*K)+1;

fi = ch_centre-ci+1;

% Filtramos y diezmamos
X_f = x.*exp(-j*2*pi*(fi-1+K)/(2*K)*[0:N-1].');
X_f = filter(a,1,X_f); % Ventana simétrica
gX_f = conj(X_f(length(a):L:end))/P;
X_f = x.*exp(-j*2*pi*(fi+(ci-1)*2-1+K)/(2*K)*[0:N-1].');
X_f = filter(a,1,X_f); % Ventana simétrica
X_f = X_f(length(a):L:end);

%for Li=1:L:N-2*K+1
%	X_f(1,(Li-1)/L+1) = sum(x(Li:Li+2*K-1).*a.*...
%			exp(-j*2*pi*(fi-1+K)/(2*K)*[Li-1:Li+2*K-2].'));
%	X_f(2,(Li-1)/L+1) = sum(x(Li:Li+2*K-1).*a.*...
%			exp(-j*2*pi*(fi+(ci-1)*2-1+K)/(2*K)*[Li-1:Li+2*K-2].'));
%end
%
%gX_f = conj(X_f(1,:))/P;
%X_f = X_f(2,:);

indices = mod([-df_da/2+1:df_da/2],P)+1;

aux = fft(gX_f.*X_f);

SCF = aux(indices(mod(alphabin+df_da/2-1,df_da)+1));


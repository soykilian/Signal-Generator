l_s = 200;
snr = 20;
i_train=1;
cAl=1;
nPSK_k = 2;
k = 1;
codPSK = [];
%%
[X1,Y1,lbl1] = signal_generator(snr,i_train,[l_s, l_s],3,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],1,[10, 15, 20, 40, 50,60, 70],nPSK_k,1,1,[],[],[],[]);
%%
sig = zeros(l_s);
for i=1:l_s,
    sig(i) = X1(1,i,1) + (j*X1(1,i,2));
end
%%
SCF = get_SCF_comp_full(sig, 96);
%%
figure()
contour(20*log(abs(SCF)))
title('QPSK input signal')
xlabel('f')
ylabel('alpha')
%%
display("TRAZA START")
figure()
surf(20*log(abs(SCF)))
title('QPSK input signal')
xlabel('f')
ylabel('alpha')
display("TRAZA END")
%%
%%% BPSK signal
nPSK_k = 1;
[X2,Y2,lbl2] = signal_generator(snr,i_train,[l_s, l_s],3,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],1,[10, 15, 20, 40, 50,60, 70],nPSK_k,1,1,[],[],[],[]);
%%
sig2 = zeros(l_s);
for i=1:l_s,
    sig2(i) = X2(1,i,1) + (j*X2(1,i,2));
end
%%
SCF2 = get_SCF_comp_full(sig2, 128);
figure()
surf(20*log(abs(SCF2)))
% figure()
% contour(20*log(abs(SCF2)))
title('BPSK input signal')
xlabel('f')
ylabel('alpha')
%%
%%% Ahora un tono
[X3,Y3,lbl3] = signal_generator(snr,i_train,[l_s, l_s],4,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],1,[2,5, 10, 15, 20],1,1,1,[],[],[],[]);
%%
sig3 = zeros(l_s);
for i=1:l_s,
    sig3(i) = X3(1,i,1) + (j*X3(1,i,2));
end
%%
SCF = get_SCF_comp_full(sig3, 96);
surf(20*log(abs(SCF)))
title('NM input signal')
xlabel('f')
ylabel('alpha')
%%
%%% Ahora un tono
[X4,Y4,lbl4] = signal_generator(snr,i_train,[l_s, l_s],4,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],1,[2,5, 10, 15, 20],1,1,1,[],[],[],[]);
%%
sig3 = zeros(l_s);
for i=1:l_s,
    sig3(i) = X3(1,i,1) + (j*X3(1,i,2));
end
%%
SCF = get_SCF_comp_full(sig3, 96);
surf(20*log(abs(SCF)))
title('NM input signal')
xlabel('alpha')
ylabel('f')
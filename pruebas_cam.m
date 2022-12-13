
[status,msg,msgID] = mkdir('Dataset2');

snr = -12:2:20;
i_train =  300;
i_val = 100;
i_test = 100;

total = length(snr)*8;

X_train = zeros(total*i_train,1024,2);
Y_train = zeros(total*i_train, 8);
lbl_train = zeros(total*i_train, 6);

X_test = zeros(total*i_test,1024,2);
Y_test = zeros(total*i_test, 8);
lbl_test = zeros(total*i_test, 6);

X_val = zeros(total*i_val,1024,2);
Y_val = zeros(total*i_val, 8);
lbl_val = zeros(total*i_val, 6);


l_s = 1024;

ii = 1;
for i = 1:5
cAl = 1;
j = 1;
k = 1;
switch i
	%% LFM 
    case 1
        [X1,Y1,lbl1] = signal_generator(snr,i_train,[l_s, l_s],i,[1/12, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        [X2,Y2,lbl2] = signal_generator(snr,i_test,[l_s, l_s],i,[1/12, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        [X3,Y3,lbl3] = signal_generator(snr,i_val,[l_s, l_s],i,[1/12, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        fprintf('LFM generated\n');

        X_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = X1;
        Y_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = Y1;
        lbl_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = lbl1;
        
        X_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X2;
        Y_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
        lbl_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl2;

        X_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X3;
        Y_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
        lbl_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl3;
        ii = ii+1;
        fprintf('LFM stored\n');

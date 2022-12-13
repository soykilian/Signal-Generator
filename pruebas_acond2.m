[status,msg,msgID] = mkdir('Dataset2');

snr = -12:2:20;
i_train =  300;
i_val = 100;
i_test = 100;

total = length(snr)*23;

X_train = zeros(total*i_train,1024,2);
Corr_train = zeros(total*i_train,1024,2);
Y_train = zeros(total*i_train, 23);
lbl_train = zeros(total*i_train, 6);

X_test = zeros(total*i_test,1024,2);
Corr_test = zeros(total*i_test,1024,2);
Y_test = zeros(total*i_test, 23);
lbl_test = zeros(total*i_test, 6);

X_val = zeros(total*i_val,1024,2);
Corr_val = zeros(total*i_val,1024,2);
Y_val = zeros(total*i_val, 23);
lbl_val = zeros(total*i_val, 6);


l_s = 1024;

ii = 1;
for i = 1:5
cAl = 1;
j = 1;
k = 1;
switch i
    case 1
        [X1, Corr1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        [X2,Corr2,Y2,lbl2] = signal_generator2(snr,i_test,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        [X3,Corr3,Y3,lbl3] = signal_generator2(snr,i_val,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        fprintf('LFM generated\n');

        X_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = X1;
        Corr_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = Corr1;
        Y_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = Y1;
        lbl_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = lbl1;
        
        X_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X2;
        Corr_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr2;
        Y_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
        lbl_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl2;

        X_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X3;
        Corr_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr3;
        Y_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
        lbl_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl3;
        ii = ii+1;
        fprintf('LFM stored\n');
    case 2
        cAl=1;
        for j = 1:3
            [X1, Corr1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
            [X2,Corr2,Y2,lbl2] = signal_generator2(snr,i_test,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
            [X3,Corr3,Y3,lbl3] = signal_generator2(snr,i_val,[l_s, l_s],i,[1/30, 1/4],[],[],[],[1, 2, 5, 10],[1/100, 1/30],j,[20],j,1,cAl,k,[],[],[]);
            fprintf('FSK generated\n');
            X_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = X1;
        	Corr_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = Corr1;
            Y_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = Y1;
            lbl_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = lbl1;
            
            X_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X2;
        	Corr_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr2;
            Y_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
            lbl_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl2;

            X_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:,:) = X3;
        Corr_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr3;
            Y_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = Y3;
            lbl_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = lbl3;

            ii = ii+1;
            fprintf('FSK stored\n');
        
        end
        cAl = 0;
        [X1, Corr1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10],[1/100, 1/20],j,[20],j,1,cAl,[],[],[],[]);
        [X2,Corr2,Y2,lbl2] = signal_generator2(snr,i_test,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10],[1/100, 1/20],j,[20],j,1,cAl,[],[],[],[]);
        [X3,Corr3,Y3,lbl3] = signal_generator2(snr,i_val,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10],[1/100, 1/20],j,[20],j,1,cAl,[],[],[],[]);
        fprintf('Costas generated\n');
        X_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = X1;
        Corr_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = Corr1;
        Y_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = Y1;
        lbl_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = lbl1;
        
        X_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X2;
        Corr_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr2;
        Y_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
        lbl_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl2;

        X_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:,:) = X3;
        Corr_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr3;
        Y_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = Y3;
        lbl_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = lbl3;
        ii = ii+1;
        fprintf('Costas Stored\n');
    case 3
        cAl = 1;
        for j = 1:3
            [X1, Corr1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[2,5, 10, 15, 20],j,1,cAl,k,[],[],[]);
            [X2,Corr2,Y2,lbl2] = signal_generator2(snr,i_test,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[2,5, 10, 15, 20],j,1,cAl,k,[],[],[]);
            [X3,Corr3,Y3,lbl3] = signal_generator2(snr,i_val,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[2,5, 10, 15, 20],j,1,cAl,k,[],[],[]);
            fprintf('PSK generated\n');
            X_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = X1;
        	Corr_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = Corr1;
            Y_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = Y1;
            lbl_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = lbl1;
            
            X_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X2;
        	Corr_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr2;
            Y_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
            lbl_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl2;

			X_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:,:) = X3;
			Y_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = Y3;
			lbl_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = lbl3;
            ii = ii+1;
            fprintf('PSK stored\n');
        end
        cAl = 0;
        codigos = ["Barker" ,"Huffman" ,"Frank", "P1" ,"P2" ,"P3", "P4", "Px", "Zadoff-Chu" ,"T1" ,"T2" ,"T3", "T4"];
        for k = 1:13
            [X1, Corr1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[7 10 15 20],j,1,cAl,k,[],[],[]);
            [X2,Corr2,Y2,lbl2] = signal_generator2(snr,i_test,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[7 10 15 20],j,1,cAl,k,[],[],[]);
            [X3,Corr3,Y3,lbl3] = signal_generator2(snr,i_val,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[7 10 15 20],j,1,cAl,k,[],[],[]);
            fprintf('Phase modulation ' + codigos(k)+' generated\n');
            X_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = X1;
        	Corr_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = Corr1;
            Y_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = Y1;
            lbl_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = lbl1;
            
            X_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X2;
        	Corr_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr2;
            Y_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
            lbl_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl2;

			X_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:,:) = X3;
        	Corr_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr3;
			Y_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = Y3;
			lbl_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = lbl3;
            ii = ii+1;
            fprintf('Phase modulation stored\n');
        end
    case 4
        [X1, Corr1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        [X2,Corr2,Y2,lbl2] = signal_generator2(snr,i_test,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        [X3,Corr3,Y3,lbl3] = signal_generator2(snr,i_val,[l_s, l_s],i,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        fprintf('NM generated\n');
        X_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = X1;
        Corr_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = Corr1;
        Y_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = Y1;
        lbl_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = lbl1;
        
        X_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X2;
        Corr_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr2;
        Y_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
        lbl_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl2;

		X_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:,:) = X3;
        Corr_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr3;
		Y_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = Y3;
		lbl_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = lbl3;
        ii = ii+1;
        fprintf('NM stored\n');
    case 5
        [X1, Corr1,Y1,lbl1] = signal_generator2(snr,i_train,[l_s, l_s],8,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        [X2,Corr2,Y2,lbl2] = signal_generator2(snr,i_test,[l_s, l_s],8,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        [X3,Corr3,Y3,lbl3] = signal_generator2(snr,i_val,[l_s, l_s],8,[1/20, 1/4],[],[],[],[1, 2, 5, 10, 15],[1/100, 1/20],j,[20],j,1,cAl,k,[],[],[]);
        fprintf('Noise generated\n');
        X_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = X1;
        Corr_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:,:) = Corr1;
        Y_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = Y1;
        lbl_train(length(snr)*i_train*(ii-1)+1:length(snr)*i_train*(ii),:) = lbl1;
        
        X_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = X2;
        Corr_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr2;
        Y_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = Y2;
        lbl_test(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:) = lbl2;

		X_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:,:) = X3;
        Corr_val(length(snr)*i_test*(ii-1)+1:length(snr)*i_test*(ii),:,:) = Corr3;
		Y_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = Y3;
		lbl_val(length(snr)*i_val*(ii-1)+1:length(snr)*i_val*(ii),:) = lbl3;
        fprintf('Noise stored\n');

end
end

fprintf('Beginning to save\n');
save('Dataset2/X_train.mat', 'X_train', '-v7.3', '-nocompression')
fprintf('X train saved\n');
 save('Dataset2/Corr_train.mat', 'Corr_train', '-v7.3', '-nocompression')
 fprintf('Correlation train saved\n');
save('Dataset2/Y_train.mat', 'Y_train')
fprintf('Y train saved\n');
save('Dataset2/lbl_train.mat', 'lbl_train')
fprintf('lbl train saved\n');
save('Dataset2/X_test.mat', 'X_test','-v7.3', '-nocompression')
fprintf('X_test saved\n');
 save(['Dataset2/Corr_test.mat'], 'Corr_test', '-v7.3', '-nocompression')
 fprintf('Correlation test saved\n');
save('Dataset2/Y_test.mat', 'Y_test')
fprintf('Y test saved\n');
save('Dataset2/lbl_test.mat', 'lbl_test')
fprintf('lbl_test saved\n');
save('Dataset2/X_val.mat', 'X_val', '-v7.3', '-nocompression')
fprintf('X val saved\n');
 save('Dataset2/Corr_val.mat', 'Corr_val', '-v7.3', '-nocompression')
 fprintf('Correlation valsaved\n');
save('Dataset2/Y_val.mat', 'Y_val')
fprintf('Y val saved\n');
save('Dataset2/lbl_val.mat', 'lbl_val')
fprintf('lbl val saved\n');

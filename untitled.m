Data_train = load("/Users/mariavictoriadacostarivas/Downloads/Radar Dataset/X_train.mat")
%%
X_train = Data_train.X_train;
%%
I_train = X_train(:,:,1);
Q_train = X_train(:,:,2);
%%
X_corr = zeros(469,1024,2);

%%
for i=1:469200,
    s = I_train(i, :) + j*Q_train(i, :);
    [B,lags] = xcorr(s);
    corr = B(length(s):end);
    X_corr(i,:,1) = real(corr);
    X_corr(i,:,2) = imag(corr);
end
%%
Corr_data = load("Dataset_correlation/Corr_val.mat")
%%
Corr_data.Corr_val
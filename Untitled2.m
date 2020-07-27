clear all; clc; close all;
figure('Color','w','DefaultAxesFontName','Arial');

opts = delimitedTextImportOptions("NumVariables", 1);
opts.DataLines = [1, Inf];
opts.Delimiter = ",";
opts.VariableNames = "e07";
opts.VariableTypes = "double";
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
Lamda = readtable([pwd,'\SecondOrderHom\HomogenizedLamda.txt'], opts);
L = table2array(Lamda);


filename = [pwd,'\SecondOrderHom\HomogenizedFreqAnalysisResults.txt'];
formatSpec = '%13f%14f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
freqAn = [dataArray{1:end-1}];


freq=logspace(-1,6,101);
w=2*pi*freq;
Z = L(13);
Z = 1./(1i*w*L(12))+1./Z;
Z = L(11) + 1./Z;
Z = 1./(1i*w*L(10))+1./Z;
Z = L(9) + 1./Z;
Z = 1./(1i*w*L(8))+1./Z;
Z = L(7) + 1./Z;
Z = 1./(1i*w*L(6))+1./Z;
Z = L(5) + 1./Z;
Z = 1./(1i*w*L(4))+1./Z;
Z = L(3) + 1./Z;
Z = 1./(1i*w*L(2))+1./Z;
Z = L(1) + 1./Z;

stages=(length(L)-1)/2;

subplot(121);
loglog(freqAn(:,1),freqAn(:,2),'k.'); grid on; hold on;
subplot(122);
loglog(freqAn(:,1),freqAn(:,3),'k.'); grid on; hold on;

Z2 = vcln(L,w,1);
subplot(121); loglog(freq,real(1./Z2)); 
subplot(122); loglog(freq,imag(Z2)./w);
Z2 = vcln(L,w,2); 
subplot(121); loglog(freq,real(1./Z2)); 
subplot(122); loglog(freq,imag(Z2)./w);
Z2 = vcln(L,w,3); 
subplot(121); loglog(freq,real(1./Z2)); 
subplot(122); loglog(freq,imag(Z2)./w);
Z2 = vcln(L,w,4); 
subplot(121); loglog(freq,real(1./Z2)); 
subplot(122); loglog(freq,imag(Z2)./w);
Z2 = vcln(L,w,5); 
subplot(121); loglog(freq,real(1./Z2));
subplot(122); loglog(freq,imag(Z2)./w);
Z2 = vcln(L,w,6); 
subplot(121); loglog(freq,real(1./Z2)); set(gca, 'FontName', 'Times'); grid on; xlabel('f (Hz)');ylabel('L'); xlim([1e-1 1e6]); grid on;
subplot(122); loglog(freq,imag(Z2)./w); set(gca, 'FontName', 'Times'); grid on; xlabel('f (Hz)');ylabel('Re(R)'); xlim([1e-1 1e6]); grid on;


fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print('-dpng','-r600','Fig4.png');

function Z2 = vcln(L,w,stages)
Z2=L(stages*2+1);
for ii=1:stages
    Z2 = 1./(1i*w*L((stages-ii)*2+2))+1./Z2;
    Z2 = L((stages-ii)*2+1) + 1./Z2;
end
end


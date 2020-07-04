clear all; clc; close all;
figure('Color','w','DefaultAxesFontName','Arial');

opts = delimitedTextImportOptions("NumVariables", 1);
opts.DataLines = [1, Inf];
opts.Delimiter = ",";
opts.VariableNames = "e07";
opts.VariableTypes = "double";
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
Lamda = readtable("UnGaugedLaminatedLamda.txt", opts);
Lu = table2array(Lamda);

opts = delimitedTextImportOptions("NumVariables", 1);
opts.DataLines = [1, Inf];
opts.Delimiter = ",";
opts.VariableNames = "e07";
opts.VariableTypes = "double";
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
Lamda = readtable("GaugedLaminatedLamda.txt", opts);
Lg = table2array(Lamda);

filename = 'LaminatedFreqAnalysisResults.txt';
formatSpec = '%13f%14f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
freqAn = [dataArray{1:end-1}];


freq=logspace(-1,6,101);
w=2*pi*freq;
stages=length(Lu)/2-1;

subplot(121);
loglog(freqAn(:,1),freqAn(:,2),'k.'); grid on; hold on;
subplot(122);
loglog(freqAn(:,1),freqAn(:,3),'k.'); grid on; hold on;

Z2 = vcln(Lu,w,stages);
subplot(121); loglog(freq,real(1./Z2)); 
subplot(122); loglog(freq,imag(Z2)./w);
Z2 = vcln(Lg,w,stages); 
subplot(121); loglog(freq,real(1./Z2)); set(gca, 'FontName', 'Times'); grid on; xlabel('f (Hz)');ylabel('L'); xlim([1e-1 1e6]); grid on;
subplot(122); loglog(freq,imag(Z2)./w); set(gca, 'FontName', 'Times'); grid on; xlabel('f (Hz)');ylabel('Re(R)'); xlim([1e-1 1e6]); grid on;


fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
% print('-dpng','-r600','Fig4.png');

function Z2 = vcln(L,w,stages)
Z2=L(stages*2+1);
for ii=1:stages
    Z2 = 1./(1i*w*L((stages-ii)*2+2))+1./Z2;
    Z2 = L((stages-ii)*2+1) + 1./Z2;
end
end


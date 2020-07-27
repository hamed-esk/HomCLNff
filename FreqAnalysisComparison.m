clear all; clc; close all;
figure('Color','w','DefaultAxesFontName','Arial');

filename = [pwd,'\LaminatedFreqAnalysisResults.txt'];
formatSpec = '%13f%14f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
lamin = [dataArray{1:end-1}];

filename = [pwd,'\ZeroOrderHom\HomogenizedFreqAnalysisResults.txt'];
formatSpec = '%13f%14f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
hom = [dataArray{1:end-1}];

filename = [pwd,'\SecondOrderHom\HomogenizedFreqAnalysisResults.txt'];
formatSpec = '%13f%14f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
hom2 = [dataArray{1:end-1}];

subplot(121);
loglog(lamin(:,1),lamin(:,2),'displayname','laminated'); hold on;
loglog(hom(:,1),hom(:,2),'displayname','homogenized');
loglog(hom2(:,1),hom2(:,2),'displayname','homogenized2');
xlabel('f (Hz)');
ylabel('Re(Y)');
set(gca, 'FontName', 'Times'); grid on; xlim([1e-1 1e6]); grid on; legend('location','northoutside');

subplot(122);
loglog(lamin(:,1),lamin(:,3),'displayname','laminated'); hold on;
loglog(hom(:,1),hom(:,3),'displayname','homogenized');
loglog(hom2(:,1),hom2(:,3),'displayname','homogenized2');
xlabel('f (Hz)');ylabel('L');
set(gca, 'FontName', 'Times'); grid on; xlim([1e-1 1e6]); grid on; legend('location','northoutside');

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 4 3];
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print('-dpng','-r600','Fig5.png');
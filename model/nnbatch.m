%nnbatch
clear; close all;

pwbSw=1;
numRuns = 50;
perfTH = 1e-3;

[inputs,targets] = trainDatGen();

while numRuns > 0
    [net,performance,fh,outputs,errors] = andorhybrid(inputs,targets,1,1,0);
    if performance < perfTH
        if ~exist('netwb')
            netwb(:,1) = getwb(net);
        else
            ni = size(netwb,2);
            netwb(:,ni+1) = getwb(net);
        end
        numRuns = numRuns-1
    end
end

if pwbSw
    set(0,'defaultaxesfontsize',12);
    scrsz = get(0,'ScreenSize');
    tmppath = 'fig';
    for i = 1:size(netwb,2)
        net = setwb(net,netwb(:,i));
        hf1 = figure('Visible','off','Position',[0 0 scrsz(3)*.25 scrsz(4)],'Color','w');
        plotwb(net);
        export_fig([tmppath sprintf('/netwb-%0.0f.pdf',i)],hf1);
        close(hf1);
    end
    system(['gs -q -dNOPAUSE -sDEVICE=pdfwrite '...
        '-sOUTPUTFILE=' tmppath '/combined.pdf -dBATCH ' tmppath '/*.pdf']);
end

cg=clustergram(netwb,'RowPDist','correlation','ColumnPDist','cityblock',...
                   'Colormap',redbluecmap,'Standardize','row',...
                   'Symmetric',1,'OptimalLeafOrder',1,'Dendrogram',2,...
                   'AnnotColor','k');

% avgwb = mean(netwb,2);
% stdwb = std(netwb,0,2);
% %net = custNetGen(1);
% 
% net = setwb(net,avgwb);
% outputs = net(inputs);
% errors = gsubtract(targets,outputs);
% performance = perform(net,targets,outputs)
% figure;
% fh1=plotwb(net);
% set(fh1,'Color','w');
% 
% net = setwb(net,stdwb);
% figure;
% fh2=plotwb(net);
% set(fh2,'Color','w');
    
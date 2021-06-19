function[] = PlotCountry(param1)
T = readtable(param1); %% inserire qua il csv da plottare.
%load(param2) %% caricamento file di corrispondenza paesi probe

FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")
%fname = sprintf('%s_%s_Median_', FileOut{1},FileOut{3});

IndiciRegion=find(ismember(T{:,4},Nations))%trovo indici per dove sono le regfioni che voglio
T=T(IndiciRegion,:)
G = findgroups(T{:,5});     
Tc = splitapply( @(varargin) varargin, T, G);
asn_id=cellfun(@unique,Tc(:,1),'UniformOutput',false) % asn unici
[cellsz1, cellsz2] = cellfun(@size,asn_id,'uni',false); %dimensione di ciascun gruppo
conv=cell2mat(cellsz1)
idxd=find(conv>10) %trovo le posizioni dei magg di 10
%Tc(:,6)=cellsz1(:,1)
Tc2=Tc(idxd,:) % isolo solo quelli con più di 1o probe
Nations2=["ES" "FR" "IT" "SE" "DE"]
Nations={'ES','FR','IT','SE','DE'}
[numRows2,numCols2] = size(Tc2)
regions=cellfun(@unique,Tc2(:,4),'UniformOutput',false)
%find(ismember(cell2mat(regions{9,1}), Nations))
for b=1:numRows2
    Tc2(b,4)=unique(Tc{b,4})
    Tc2{b,5}=unique(Tc{b,5})
end
%con il for metto info su asn e regione di cciscun gruppo.

[Rows,Cols] = size(Tc2)
for j = 1:size(Nations,2)%dim nazioni poi
        idf=find(ismember(Tc2(:,4), Nations(j))) %trovo gli indici della nazione j
        Tc3=Tc2(idf,:)
        
        plottare=[]
        label=[]
        for b=1:size(Tc3,1)
            tabx = table(Tc3{b,3},Tc3{b,2});
            tab1 = sortrows(tabx,2);
            tab2 = groupsummary(tab1,'Var2',hours(4),'median','Var1');
            y=double(tab2.median_Var1);
            plottare=[plottare,y]
            %cella={'2019'}
            cella=Tc3{b,5}
            label=[label, cella]
        end
        
        tab2 = groupsummary(tab1,'Var2',hours(4),'median','Var1');
        %%tab2 = groupsummary(tab1,'Var2',hours(2),@(x) prctile(x,90));
        x=categorical(tab2.disc_Var2);
        y=double(tab2.median_Var1);        
        set(gcf, 'Visible', 'off');
        figure('Visible', 'off')
        boxplot([plottare],'Labels',label,'Whisker',1)
        ylim([0 100])
        topName = sprintf('BoxPlotMedian %s',Nations{j});
        title(topName)
        xlabel('ASN') 
        ylabel('Result') 
        
        set(gcf,'color','w');
        fname = sprintf('%s_%s_boxplot_%s', FileOut2,FileOut{2},Nations{j});
        export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
   
    
end

end
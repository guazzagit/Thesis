function[] = PlotCountry(param1,param2)
T = readtable(param1); %% inserire qua il csv da plottare.
%load(param2) %% caricamento file di corrispondenza paesi probe

FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")
%fname = sprintf('%s_%s_Median_', FileOut{1},FileOut{3});
Nations2=["ES" "FR" "IT" "SE" "DE"]
Nations={'ES','FR','IT','SE','DE'}
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

[numRows2,numCols2] = size(Tc2)
regions=cellfun(@unique,Tc2(:,4),'UniformOutput',false)
%find(ismember(cell2mat(regions{9,1}), Nations))
load('ASNnumUSERonly.csv')
tabellaNumeriUser = groupsummary(ASNnumUSERonly,'ASN','sum','Usersest');


for b=1:numRows2
    Tc2(b,4)=unique(Tc{b,4})
    Tc2{b,5}=unique(Tc{b,5})
end
for b=1:numRows2
    PostASn=find(Tc2{b,5}==tabellaNumeriUser{:,1})
    Tc2{b,6}=tabellaNumeriUser{PostASn,3}
end
%con il for metto info su asn e regione di cciscun gruppo.
%secondatabella
T=[]
T = readtable(param2); %% inserire qua il csv da plottare.
IndiciRegion=find(ismember(T{:,4},Nations))%trovo indici per dove sono le regfioni che voglio
T=T(IndiciRegion,:)
G = findgroups(T{:,5});     
Tc = splitapply( @(varargin) varargin, T, G);
asn_id=cellfun(@unique,Tc(:,1),'UniformOutput',false) % asn unici
[cellsz1, cellsz2] = cellfun(@size,asn_id,'uni',false); %dimensione di ciascun gruppo
conv=cell2mat(cellsz1)
idxd=find(conv>10) %trovo le posizioni dei magg di 10
%Tc(:,6)=cellsz1(:,1)
Tc22=Tc(idxd,:)
[numRows2,numCols2] = size(Tc22)
for b=1:numRows2
    Tc22(b,4)=unique(Tc{b,4})
    Tc22{b,5}=unique(Tc{b,5})

end
for b=1:numRows2
    PostASn=find(Tc22{b,5}==tabellaNumeriUser{:,1})
    Tc22{b,6}=tabellaNumeriUser{PostASn,3}
end


T=[]


[Rows,Cols] = size(Tc2)
for j = 1:size(Nations,2)%dim nazioni poi
        idf=find(ismember(Tc2(:,4), Nations(j))) %trovo gli indici della nazione j
        idf2=find(ismember(Tc22(:,4), Nations(j))) %trovo gli indici della nazione j
        Tc3=Tc2(idf,:)
        Tc4=Tc22(idf2,:)
        plottare=[]
        label=[]
        color=[]
        for b=1:size(Tc3,1)
            tabx = table(Tc3{b,3},Tc3{b,2});
            tabxx = table(Tc4{b,3},Tc4{b,2});
            tab1 = sortrows(tabx,2);
            tab11 = sortrows(tabxx,2);
            tab2 = groupsummary(tab1,'Var2',hours(4),@(Var1) prctile(Var1,90));
            %tab2 = groupsummary(tab1,'Var2',hours(4),'median','Var1');
            tab22 = groupsummary(tab11,'Var2',hours(4),@(Var1) prctile(Var1,90));
            %tab22 = groupsummary(tab11,'Var2',hours(4),'median','Var1');
            %minimo=min(size(tab22(:,2),1),size(tab2(:,2),1))
            diff=size(tab22(:,2),1)-size(tab2(:,2),1)
            aggiunto=NaN(1,diff).';
            %tab22=tab22(1:minimo,:)
            y=double(tab2.fun1_Var1);;
            %y=double(tab2.median_Var1);;
            y=[y;aggiunto]
            y2=double(tab22.fun1_Var1);
            %y2=double(tab22.median_Var1);
            plottare=[plottare,y,y2]
            

            
            name=sprintf('2019(%d)',Tc3{b,5})
            cella={name}
            name2=sprintf('2020(%d)',Tc4{b,5})
            %cella=['2019',Tc3{b,5}];%Tc3{b,5}
            cella2={name2}%sprintf('2020(%d)',Tc4{b,5});%Tc4{b,5}
            label=[label, cella,cella2]
            if(isempty(Tc3{b,6}))%vuoto
                color=[color,0]
            elseif(Tc3{b,6}>1000000)%resid
                color=[color,1]
            else % non residenziale
                color=[color,2]
            end
            if(isempty(Tc4{b,6}))%vuoto
                color=[color,0]
            elseif(Tc4{b,6}>1000000)%resid
                color=[color,1]
            else % non residenziale
                color=[color,2]
            end
        end
        
        %%tab2 = groupsummary(tab1,'Var2',hours(2),@(x) prctile(x,90));      
        set(gcf, 'Visible', 'off');
        figure('Visible', 'off')
        boxplot([plottare],'Labels',label,'Whisker',1)
        hold on
        set(gca,'XTickLabelRotation',45)
        %set(gca, 'YScale', 'log')
        a = findobj(gca,'Tag','Box'); %trovare i box nel grafico
        %t = get(a,'tag');
        colorsForPlotting = cell(size(label));
        for i = 1:size(label,2)    
            if (color(1,i) ==0)
                colorsForPlotting{i} = 'w';
            elseif (color(1,i)==1)
                colorsForPlotting{i} = 'm';
            else
                colorsForPlotting{i} = 'g';
            end        
        end
        colorsForPlotting=fliplr(colorsForPlotting)
        for g=1:length(a)
            patch(get(a(g),'XData'),get(a(g),'YData'),colorsForPlotting{g},'FaceAlpha',.15);
        end
        ylim([0 500])
        topName = sprintf('BoxPlot 90 Percentile %s',Nations{j});
        title(topName)
        xlabel('ASN') 
        ylabel('Result')
        h = zeros(3, 1);
        h(1) = bar(NaN,NaN,'w');
        hold on
        h(2) = bar(NaN,NaN,'m');
        hold on
        h(3) = bar(NaN,NaN,'g');
        legend(h, 'Empty','Resident','Non-Resident');
               
        set(gcf,'color','w');
        fname = sprintf('%s_%s_boxplot90perc_%s', FileOut2,FileOut{2},Nations{j});
        export_fig(['/home/guazzelli/disco/Thesis/Matlab file/plot/' fname], '-pdf');
   
    
end

end
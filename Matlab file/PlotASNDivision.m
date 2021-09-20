function[] = PlotASNDivision(param1)

T = readtable(param1);  % read csv with all info (classic info plus asn of dest addr and type)

FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")

Nations2=["ES" "FR" "IT" "SE" "DE"]
Nations={'ES','FR','IT','SE','DE'}
% per ogni as che prendiamo in cosiderazopne ci deve essere una
% distribuione equa di probe cioè magari se sono 10 5 prvate e 5 pubbliche
% per esempio per l'as di google.
% se separi private e pub dopo non capisci se ci sono x pub e x priv tra le
% probe. va fatto tutto misto. per poi vedere se le varie as hanno un tot
% priv ed un tot pubb ma come la organizzi questa cosa?
% le as che prendiamo con piu di venti probe cosi la cosa può tornare
% perche levi già quelli che hanno meno probe e poi di quelle vedi quali as
% hanno un tot probe priv e un tot public.

IndiciRegion=find(ismember(T{:,5},Nations))%trovo indici per dove sono le regfioni che voglio
T=T(IndiciRegion,:)

G = findgroups(T{:,6});     
Tc = splitapply( @(varargin) varargin, T, G);

asn_id=cellfun(@unique,Tc(:,1),'UniformOutput',false) % asn unici
[cellsz1, cellsz2] = cellfun(@size,asn_id,'UniformOutput',false); %dimensione di ciascun gruppo
conv=cell2mat(cellsz1)
idxd=find(conv>20) %trovo le posizioni dei magg di 10
%Tc(:,6)=cellsz1(:,1)
Tc2=Tc(idxd,:)

[numRows2,numCols2] = size(Tc2)
for j = 1:numRows2
    type=[]
    taby=[]
    tabx = table(Tc2{j,1},Tc2{j,2},Tc2{j,3},Tc2{j,8});
    tabDim = table(Tc2{j,1},Tc2{j,8});
    [C,IA,IC] = unique(tabDim,'row');
    tabx2=tabx(IA,:)
    sizePublic=size(find(ismember(tabx2{:,4},'Public')),1)
    sizePrivandUNK=size(find(ismember(tabx2{:,4},'Private') | ismember(tabx2{:,4},'UnknownPublic')),1)
    %countPublic=find(ismember(tabx2{:,4},'Public'))
    %countPrivandUNK=find(ismember(tabx2{:,4},'Private') | ismember(tabx2{:,4},'UnknownPublic'))    
    
        for h=1:2
            if (h==1)
                type='Public'
                countP=find(ismember(tabx{:,4},'Public'))
                taby=tabx(countP,:)

            else
                type="ISP"
                countP=find(ismember(tabx{:,4},'Private') | ismember(tabx{:,4},'UnknownPublic'))
                taby=tabx(countP,:)
            end
            tab1 = sortrows(taby,2);
            tab1 = removevars(tab1, {'Var1','Var4'});
            tab2 = groupsummary(tab1,'Var2',hours(4),'median','Var3');
            %tab2 = groupsummary(tab1,'Var2',hours(4),@(x) prctile(x,90));
            x1=categorical(tab2.disc_Var2);
            %y1= double(tab2.fun1_Var1);
            y1=double(tab2.median_Var3);
            stringa = string(x1)
            stringa2 = split(stringa,',',2)
            iwant = stringa2(:,2)
            val = strrep(iwant,']','')
            val2 = strrep(val,')','')
            DateCorrectFormat1 = datetime(val2)
            set(gcf, 'Visible', 'off');
            figure('Visible', 'off')
            plot(DateCorrectFormat1,y1)
            ylim([0 1000])
            asname=string(unique(Tc2{j,6}))
            title(sprintf('Plot Median %s AS%s',type,asname))
            xlabel('4h Time Bins') 
            ylabel('Result(ms)') 

            set(gcf,'color','w');
            fname = sprintf('%s_%s_Median_AS%s_%s', FileOut2,FileOut{2},asname,type);
            export_fig(['C:/Users/guazz/Desktop/AS_graph/' fname], '-pdf');

            tab2 = groupsummary(tab1,'Var2',hours(4),@(x) prctile(x,90));
            x1=categorical(tab2.disc_Var2);
            y1= double(tab2.fun1_Var3);
            stringa = string(x1)
            stringa2 = split(stringa,',',2)
            iwant = stringa2(:,2)
            val = strrep(iwant,']','')
            val2 = strrep(val,')','')
            DateCorrectFormat1 = datetime(val2)
            N = length(y1);
            limit = 900;
            for i = 1:N
                if(y1(i)>limit)
                    y1(i)=limit;
                end
            end
            set(gcf, 'Visible', 'off');
            figure('Visible', 'off')
            plot(DateCorrectFormat1,y1)
            ylim([0 1000])
            title(sprintf('Plot 90 Percentile %s AS%s',type,asname))
            xlabel('4h Time Bins') 
            ylabel('Result(ms)') 

            set(gcf,'color','w');
            fname = sprintf('%s_%s_90Perc_AS%s_%s', FileOut2,FileOut{2},asname,type);
            export_fig(['C:/Users/guazz/Desktop/AS_graph/' fname], '-pdf');
        end
        
end

end


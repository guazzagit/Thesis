function[] = PlotASNPublicDivision(param1)

T = readtable(param1);  % read csv with all info (classic info plus asn of dest addr and type)

FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")

Nations2=["ES" "FR" "IT" "SE" "DE"]
Nations={'ES','FR','IT','SE','DE'}


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
    tabx = table(Tc2{j,1},Tc2{j,2},Tc2{j,3},Tc2{j,4},Tc2{j,6},Tc2{j,7},Tc2{j,8});
    tabDim = table(Tc2{j,1},Tc2{j,8});
    [C,IA,IC] = unique(tabDim,'row');
    tabx2=tabx(IA,:)
    sizePublic=size(find(ismember(tabx2{:,4},'Public')),1)
    sizePrivandUNK=size(find(ismember(tabx2{:,4},'Private') | ismember(tabx2{:,4},'UnknownPublic')),1)
    type='Public'
    countP=find(ismember(tabx{:,7},'Public'))
    taby=tabx(countP,:)
    G1 = findgroups(taby{:,6});
    TcPROVA = splitapply( @(varargin) varargin, taby, G1);
    asname=string(unique(TcPROVA{1,5}))
    figure('Visible', 'off')
    for i=1:size(TcPROVA,1)
        tabt = table(TcPROVA{i,2},TcPROVA{i,3},TcPROVA{i,5},TcPROVA{i,4});
        tab1 = sortrows(tabt,1);
        tab1 = removevars(tab1, {'Var3','Var4'});
        tab2 = groupsummary(tab1,'Var1',hours(4),'median','Var2');
        %tab2 = groupsummary(tab1,'Var2',hours(4),@(x) prctile(x,90));

        x1=categorical(tab2.disc_Var1);
        %y1= double(tab2.fun1_Var1);
        y1=double(tab2.median_Var2);        
        N = length(y1);
        limit = 900;
        for o = 1:N
            if(y1(o)>limit)
                y1(o)=limit;
            end
        end
        stringa = string(x1)
        stringa2 = split(stringa,',',2)
        iwant = stringa2(:,2)
        val = strrep(iwant,']','')
        val2 = strrep(val,')','')
        DateCorrectFormat1 = datetime(val2)
        TT = timetable(DateCorrectFormat1,y1)
        TT1=retime(TT,'regular','fillwithmissing','TimeStep',hours(4))
        set(gcf, 'Visible', 'off');
        %figure('Visible', 'off')
        plot(TT1.DateCorrectFormat1,TT1.y1)
        hold on              

    end
        ylim([0 1000])
        title(sprintf('Plot Median %s AS%s',type,asname))
        xlabel('4h Time Bins') 
        ylabel('Result(ms)') 
        set(gcf,'color','w');
        legend('Google','Quad9','Neustar')
        fname = sprintf('%s_%s_Median_AS%s_%s_division', FileOut2,FileOut{2},asname,type);
        export_fig(['C:/Users/guazz/Desktop/AS_graph/' fname], '-pdf');
    figure('Visible', 'off')
    for i=1:size(TcPROVA,1)
        tabt = table(TcPROVA{i,2},TcPROVA{i,3},TcPROVA{i,5},TcPROVA{i,4});
        tab1 = sortrows(tabt,1);
        tab1 = removevars(tab1, {'Var3','Var4'});
        %tab2 = groupsummary(tab1,'Var1',hours(4),'median','Var2');
        tab2 = groupsummary(tab1,'Var1',hours(4),@(x) prctile(x,90));

        x1=categorical(tab2.disc_Var1);
        y1= double(tab2.fun1_Var2);
        %y1=double(tab2.median_Var2);        
        N = length(y1);
        limit = 900;
        for o = 1:N
            if(y1(o)>limit)
                y1(o)=limit;
            end
        end
        stringa = string(x1)
        stringa2 = split(stringa,',',2)
        iwant = stringa2(:,2)
        val = strrep(iwant,']','')
        val2 = strrep(val,')','')
        DateCorrectFormat1 = datetime(val2)
        TT = timetable(DateCorrectFormat1,y1)
        TT1=retime(TT,'regular','fillwithmissing','TimeStep',hours(4))
        set(gcf, 'Visible', 'off');
        %figure('Visible', 'off')
        plot(TT1.DateCorrectFormat1,TT1.y1)
        hold on

               

    end
        ylim([0 1000])      
        title(sprintf('Plot 90 Percentile %s AS%s',type,asname))
        xlabel('4h Time Bins') 
        ylabel('Result(ms)') 
        set(gcf,'color','w');
        legend('Google','Quad9','Neustar')     
        fname = sprintf('%s_%s_90Perc_AS%s_%s_division', FileOut2,FileOut{2},asname,type);
        export_fig(['C:/Users/guazz/Desktop/AS_graph/' fname], '-pdf');
               
end
end
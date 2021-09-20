function[] = FindChangePTRegions(param1,param2)
T = readtable(param1); %% inserire qua il csv da plottare.

FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")
%fname = sprintf('%s_%s_Median_', FileOut{1},FileOut{3});
Nations2=["ES" "FR" "IT" "SE" "DE"]
Nations={'ES','FR','IT','SE','DE'}
IndiciRegion=find(ismember(T{:,6},Nations))%trovo indici per dove sono le regfioni che voglio
T=T(IndiciRegion,:)
G = findgroups(T{:,7});     
Tc = splitapply( @(varargin) varargin, T, G);
asn_id=cellfun(@unique,Tc(:,1),'UniformOutput',false) % asn unici
[cellsz1, cellsz2] = cellfun(@size,asn_id,'UniformOutput',false); %dimensione di ciascun gruppo
conv=cell2mat(cellsz1)
idxd=find(conv>10) %trovo le posizioni dei magg di 10
%Tc(:,8)=cellsz1(:,1)
Tc2=Tc(idxd,:) % isolo solo quelli con più di 1o probe

[numRows2,numCols2] = size(Tc2)
regions=cellfun(@unique,Tc2(:,6),'UniformOutput',false)

ASNnumUSERNationsonly=readtable('asn_people_nations_new.csv')
IndiciRegionASN=find(ismember(ASNnumUSERNationsonly{:,3},Nations))
ASNnumUSERNationsonly=ASNnumUSERNationsonly(IndiciRegionASN,:)
tabellaNumeriUser = groupsummary(ASNnumUSERNationsonly,'ASN','sum','Users_est__');


for b=1:numRows2
    Tc2(b,6)=unique(Tc2{b,6})
    Tc2{b,7}=unique(Tc2{b,7})
end
for b=1:numRows2
    PostASn=find(Tc2{b,7}==tabellaNumeriUser{:,1})
    Tc2{b,6}=tabellaNumeriUser{PostASn,3}
end
%con il for metto info su asn e regione di cciscun gruppo.
%secondatabella
T=[]

T = readtable(param2); %% inserire qua il csv da plottare.
IndiciRegion=find(ismember(T{:,6},Nations))%trovo indici per dove sono le regfioni che voglio
T=T(IndiciRegion,:)
G = findgroups(T{:,7});     
Tc = splitapply( @(varargin) varargin, T, G);
asn_id=cellfun(@unique,Tc(:,1),'UniformOutput',false) % asn unici
[cellsz1, cellsz2] = cellfun(@size,asn_id,'uni',false); %dimensione di ciascun gruppo
conv=cell2mat(cellsz1)
idxd=find(conv>10) %trovo le posizioni dei magg di 10
%Tc(:,8)=cellsz1(:,1)
Tc22=Tc(idxd,:)
[numRows2,numCols2] = size(Tc22)
for b=1:numRows2
    Tc22(b,4)=unique(Tc22{b,4})
    Tc22{b,5}=unique(Tc22{b,5})

end
for b=1:numRows2
    PostASn=find(Tc22{b,6}==tabellaNumeriUser{:,1})
    Tc22{b,8}=tabellaNumeriUser{PostASn,3}
end


T=[]

[Rows,Cols] = size(Tc2)
for j = 1:size(Nations,2)%dim nazioni poi
        idf=find(ismember(Tc2(:,6), Nations(j))) %trovo gli indici della nazione j
        idf2=find(ismember(Tc22(:,6), Nations(j))) %trovo gli indici della nazione j
        Tc3=Tc2(idf,:)
        Tc4=Tc22(idf2,:)
            % cè completo quando lo smezzo di 6 mesi sennò ricorda di
            % cancellarlocecaca
        dueventi=[]
        duenove=[]
        for b=1:size(Tc3,1)
            tabx = table(Tc3{b,3},Tc3{b,2});
            tabxx = table(Tc4{b,3},Tc4{b,2});
        
            tab1 = sortrows(tabx,2);
            tab11 = sortrows(tabxx,2);
            dueventi=[dueventi;tab11]
            duenove=[duenove;tab1]
            dueventi = sortrows(dueventi,2);
            duenove = sortrows(duenove,2);
            
        end
            %% -----------------------------------------------------
            tab2 = groupsummary(duenove,'Var2',hours(4),@(x) prctile(x,90));
            tab22 = groupsummary(dueventi,'Var2',hours(4),@(x) prctile(x,90));
            x1=categorical(tab2.disc_Var2);
            y1= double(tab2.fun1_Var1);
            x22=categorical(tab22.disc_Var2);
            y22= double(tab22.fun1_Var1);
            %% -----------------------------------------------------
            y=[y1;y22]
            x=[x1;x22]
            
            % moving mean filtering 2 elem per part
            y_filtered = movmean(y,5)   
            %--------------
            stringa = string(x)
            stringa2 = split(stringa,',',2)
            iwant = stringa2(:,2)
            val = strrep(iwant,']','')
            val2 = strrep(val,')','')
            DateCorrectFormat = datetime(val2)
            dimens=size(DateCorrectFormat,1)

            hF=figure;  
            set(gcf, 'Visible', 'off');
            
            findchangepts(y_filtered,'Statistic','mean','MaxNumChanges',6,'MinDistance',100)
            hAx(1)=gca;
            xlim([0 dimens])
            hAx(2)=axes('Position',hAx(1).Position,'color','none','Parent',hF);  % make second axes for time
            set(get(hAx(1),'XRuler'),'visible','off')       % hide the x axis for original
            set(get(hAx(2),'YRuler'),'visible','off')       % and the y axis for time one
            hL2=line(DateCorrectFormat,NaN(size(y,1)));     
            hAx(2).XLim=[DateCorrectFormat(1) DateCorrectFormat(end)]; 
            set(gcf,'color','w');
            xticks(datetime('01-Jan-2019') : calmonths(4) : datetime('01-Jan-2021'))
            %ylim([0 500])
            legend(Nations{j})
            as_name=sprintf('%d',Tc4{b,4}) 
            fname = sprintf('%s_ChangePTS_19-20_%s',FileOut2{2},as_name);
            export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
            


    
end

end
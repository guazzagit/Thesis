function[] = TTtestSIgn(param1,param2)
T = readtable(param1); %% inserire qua il csv da plottare.
%load(param2) %% caricamento file di corrispondenza paesi probe

FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")
%fname = sprintf('%s_%s_Median_', FileOut{1},FileOut{3});
Nations2=["ES" "FR" "IT" "SE" "DE"]
Nations={'ES','FR','IT','SE','DE'}

AFRica={'ZA','SN','MA','DZ','LY','SD','EG'}

IndiciRegion=find(ismember(T{:,4},Nations))%trovo indici per dove sono le regfioni che voglio
T=T(IndiciRegion,:)
G = findgroups(T{:,5});     
Tc = splitapply( @(varargin) varargin, T, G);
asn_id=cellfun(@unique,Tc(:,1),'UniformOutput',false) % asn unici
[cellsz1, cellsz2] = cellfun(@size,asn_id,'UniformOutput',false); %dimensione di ciascun gruppo
conv=cell2mat(cellsz1)
idxd=find(conv>10) %trovo le posizioni dei magg di 10
%Tc(:,6)=cellsz1(:,1)
Tc2=Tc(idxd,:) % isolo solo quelli con più di 1o probe

[numRows2,numCols2] = size(Tc2)
regions=cellfun(@unique,Tc2(:,4),'UniformOutput',false)

ASNnumUSERNationsonly=readtable('asn_people_nations_new.csv')
IndiciRegionASN=find(ismember(ASNnumUSERNationsonly{:,3},Nations))
ASNnumUSERNationsonly=ASNnumUSERNationsonly(IndiciRegionASN,:)
tabellaNumeriUser = groupsummary(ASNnumUSERNationsonly,'ASN','sum','Users_est__');


for b=1:numRows2
    Tc2(b,4)=unique(Tc2{b,4})
    Tc2{b,5}=unique(Tc2{b,5})
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
    Tc22(b,4)=unique(Tc22{b,4})
    Tc22{b,5}=unique(Tc22{b,5})

end
for b=1:numRows2
    PostASn=find(Tc22{b,5}==tabellaNumeriUser{:,1})
    Tc22{b,6}=tabellaNumeriUser{PostASn,3}
end
%solo i primi 6 mesi del 2020
for v=1:size(Tc22,1)
    primi6=find(Tc22{v,2}<='2020-06-30 23:55:55')
    Tc22{v,2}=Tc22{v,2}(primi6,1)
    Tc22{v,1}=Tc22{v,1}(primi6,1)
    Tc22{v,3}=Tc22{v,3}(primi6,1)
end


T=[]

[Rows,Cols] = size(Tc2)
for j = 1:size(Nations,2)%dim nazioni poi
        idf=find(ismember(Tc2(:,4), Nations(j))) %trovo gli indici della nazione j
        idf2=find(ismember(Tc22Copy(:,4), Nations(j))) %trovo gli indici della nazione j
        Tc3=Tc2(idf,:)
        Tc4=Tc22Copy(idf2,:)
            % c'è completo quando lo smezzo di 6 mesi sennò ricorda di
            % cancellarlo
        

        for b=1:size(Tc3,1)
            tabx = table(Tc3{b,3},Tc3{b,2});
            tabxx = table(Tc4{b,3},Tc4{b,2});
            
            tab1 = sortrows(tabx,2);
            tab11 = sortrows(tabxx,2);
            x1=(tab1.Var2);
            y1=double(tab1.Var1);    
            x2=(tab11.Var2);
            y2=double(tab11.Var1);
            %% -----------------------------------------------------
            tab2 = groupsummary(tab1,'Var2',hours(4),@(x) prctile(x,90));
            tab22 = groupsummary(tab11,'Var2',hours(4),@(x) prctile(x,90));
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
            set(gcf, 'Visible', 'on');
            
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
            
            as_name=sprintf('%d',Tc4{b,5}) 
            fname = sprintf('%s_ChangePTS_19-20_AS%s',FileOut2{2},as_name);
            export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
            
        end


    
end

end
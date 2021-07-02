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

ASNnumUSERNationsonly=readtable('Asn_people_nations.csv')
IndiciRegionASN=find(ismember(ASNnumUSERNationsonly{:,3},Nations))
ASNnumUSERNationsonly=ASNnumUSERNationsonly(IndiciRegionASN,:)
tabellaNumeriUser = groupsummary(ASNnumUSERNationsonly,'ASN','sum','Users_est__');


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
Type=[]
ttest_result=[]
Asn_Number=[]
Nation=[]

[Rows,Cols] = size(Tc2)
for j = 1:size(Nations,2)%dim nazioni poi
        idf=find(ismember(Tc2(:,4), Nations(j))) %trovo gli indici della nazione j
        idf2=find(ismember(Tc22(:,4), Nations(j))) %trovo gli indici della nazione j
        Tc3=Tc2(idf,:)
        Tc4=Tc22(idf2,:)


        for b=1:size(Tc3,1)
            tabx = table(Tc3{b,3},Tc3{b,2});
            tabxx = table(Tc4{b,3},Tc4{b,2});
            tab1 = sortrows(tabx,2);
            tab11 = sortrows(tabxx,2);

            y=double(tab1.Var1);

            y2=double(tab11.Var1);
            %mah mah mah 
            [h,p,ci,stats] = ttest2(y,y2,'Vartype','unequal')
            Asn_Number=[Asn_Number;Tc3{b,5}]
            Nation=[Nation;convertCharsToStrings(Tc3{b,4})]
            if(h==0)
                 ttest_result=[ttest_result;'='] % solito means
            end
            if(h==1 && stats.tstat>0)
                ttest_result=[ttest_result;'-'] % mean di x > y 
            end
            if(h==1 && stats.tstat<0)
                ttest_result=[ttest_result;'+'] % mean di y > x
            end
        
            %% determinare se resid o no.
            if(isempty(Tc3{b,6}))%vuoto
                Type=[Type;"Empty"]
            elseif(Tc3{b,6}>1000000)%resid
                Type=[Type;"Residential"]
            else % non residenziale
                Type=[Type;"Not Residential"]
            end            
        end

    
end
Type=array2table(Type)
ttest_result=array2table(ttest_result)
Asn_Number=array2table(Asn_Number)
Nation=array2table(Nation)
Tabellastampare=[Asn_Number,Type,Nation,ttest_result]
resident_entry=Tabellastampare(find(Tabellastampare{:,2}=="Residential"),:)
nonResident_entry=Tabellastampare(find(Tabellastampare{:,2}=="Not Residential"),:)

[p_residential,h_residential,stats_residential] = signtest(resident_entry{:,4})
[p_Notresidential,h_Notresidential,stats_Notresidential] = signtest(nonResident_entry{:,4})

%% il sign test applicazione al risultato  ottenuto dal ttest.
%Tabellastampare{:,4}


%f = figure;
%uit = uitable(f,'Data',Tabellastampare);

end
function[] = TTtestSIgn(param1,param2)
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
Type=[]
ttest_result=[]
Asn_Number=[]
Nation=[]
Tabellastampare=[]
Pvalues=[]
[Rows,Cols] = size(Tc2)
for j = 1:size(Nations,2)%dim nazioni poi
        idf=find(ismember(Tc2(:,4), Nations(j))) %trovo gli indici della nazione j
        idf2=find(ismember(Tc22Completo(:,4), Nations(j))) %trovo gli indici della nazione j
        Tc3=Tc2(idf,:)
        Tc4=Tc22Completo(idf2,:)


        for b=1:size(Tc3,1)
            tabx = table(Tc3{b,3},Tc3{b,2});
            tabxx = table(Tc4{b,3},Tc4{b,2});
            tab1 = sortrows(tabx,2);
            tab11 = sortrows(tabxx,2);
            x=(tab1.Var2);
            y=double(tab1.Var1);    
            x2=(tab11.Var2);
            y2=double(tab11.Var1);
            %% -----------------------------------------------------
            
            tab2 = groupsummary(tab1,'Var2',hours(4),@(x) prctile(x,90));
            tab22 = groupsummary(tab11,'Var2',hours(4),@(x) prctile(x,90));
            x1=categorical(tab2.disc_Var2);
            y1= double(tab2.fun1_Var1);
            x22=categorical(tab22.disc_Var2);
            y22= double(tab22.fun1_Var1);
            N = length(y1);
            limit = 500;
            for i = 1:N
                if(y1(i)>limit)
                    y1(i)=limit;
                end
            end
            N = length(y22);
            limit = 500;
            for i = 1:N
                if(y22(i)>limit)
                    y22(i)=limit;
                end
            end
            stringa = string(x1)
            stringa2 = split(stringa,',',2)
            iwant = stringa2(:,2)
            val = strrep(iwant,']','')
            val2 = strrep(val,')','')
            DateCorrectFormat1 = datetime(val2)
            plot(DateCorrectFormat1,y1)
            ylim([0 500])
            title('AS3269 90 Percentile')
            xlabel('4h Time Bins') 
            ylabel('Result(ms)') 
            set(gcf,'color','w');
            fname ='3269_90percent2019'
            export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
            
            stringa = string(x22)
            stringa2 = split(stringa,',',2)
            iwant = stringa2(:,2)
            val = strrep(iwant,']','')
            val2 = strrep(val,')','')
            DateCorrectFormat2 = datetime(val2)
            plot(DateCorrectFormat2,y22)
            ylim([0 500])
            title('AS3269 90 Percentile')
            xlabel('4h Time Bins') 
            ylabel('Result(ms)') 
            set(gcf,'color','w');
            fname ='3269_90percent2020'
            export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
            %% -----------------------------------------------------
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
            Pvalues=[Pvalues;p]
        end

    
end
Type=array2table(Type)
ttest_result=array2table(ttest_result)
Asn_Number=array2table(Asn_Number)
Nation=array2table(Nation)
Pvalues=array2table(Pvalues)
Tabellastampare=[Asn_Number,Type,Nation,ttest_result,Pvalues]

resident_entry=Tabellastampare(find(Tabellastampare{:,2}=="Residential"),:)
nonResident_entry=Tabellastampare(find(Tabellastampare{:,2}=="Not Residential"),:)
resident_entry=resident_entry(find(resident_entry{:,4}~= '='),:)
nonResident_entry=nonResident_entry(find(nonResident_entry{:,4}~= '='),:)

%% il sign test applicazione al risultato  ottenuto dal ttest.

%[p_residential,h_residential,stats_residential] = signtest(resident_entry{:,5})
%[p_Notresidential,h_Notresidential,stats_Notresidential] = signtest(nonResident_entry{:,5})
plus_resident=size(find(resident_entry{:,4}=='+'),1)
limit_resident=size(resident_entry,1)
number_residemt = plus_resident:limit_resident
signResult_residential=sum(binopdf(number_residemt,limit_resident,0.5))
signResultCDF_residential=(binocdf(plus_resident,limit_resident,0.5))

plus_Notresident=size(find(nonResident_entry{:,4}=='-'),1)
limit_Notresident=size(nonResident_entry,1)
number_Notresidemt = plus_Notresident:limit_Notresident
signResult_Notresidential=sum(binopdf(number_Notresidemt,limit_Notresident,0.5))
signResultCDF_Notresidential=(binocdf(plus_Notresident,limit_Notresident,0.5))
%Tabellastampare{:,4}


%f = figure;
%uit = uitable(f,'Data',Tabellastampare);

end
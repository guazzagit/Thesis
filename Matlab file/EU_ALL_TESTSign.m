function[] = EU_ALL_TEST(param1,param2)


AllCountryAlpha2=readtable('paesiAlpha2')
EuropaALpha2=readtable('EuropaALpha2')

[Rows,Cols] = size(EuropaALpha2)
for p=1:Rows
    tappo=find(AllCountryAlpha2{:,3}==string(EuropaALpha2{p,2}))
    valore = cellstr(AllCountryAlpha2{tappo,2});
    EuropaALpha2{p,3}=valore(1,1);
end

%% 2019
T = readtable(param1); %% inserire qua il csv da plottare.
%load(param2) %% caricamento file di corrispondenza paesi probe

FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")

EuropaNations=EuropaALpha2{:,3}.'
EuropaNationscell=cellstr(EuropaNations)
IndiciRegion=find(ismember(T{:,4},EuropaNationscell))
TEuropa=T(IndiciRegion,:)
G = findgroups(TEuropa{:,5});     
Tc = splitapply( @(varargin) varargin, TEuropa, G);
asn_id=cellfun(@unique,Tc(:,1),'UniformOutput',false) % asn unici
[cellsz1, cellsz2] = cellfun(@size,asn_id,'UniformOutput',false); %dimensione di ciascun gruppo
conv=cell2mat(cellsz1)
idxd=find(conv>=2) %trovo le posizioni dei magg di 2
Tc2EU=Tc(idxd,:) % isolo solo quelli con più di 1o probe
Tc=[]

% Next find population served by the ASs
ASNnumUSERNationsonly=readtable('Asn_people_nations_new.csv')
IndiciRegionASN=find(ismember(ASNnumUSERNationsonly{:,3},EuropaNationscell))
ASNnumUSERNationsonly2=ASNnumUSERNationsonly(IndiciRegionASN,:)
tabellaNumeriUserUE = groupsummary(ASNnumUSERNationsonly2,'ASN','sum','Users_est__');

Tier1_2_Numb=readtable('Tier1_2_isp.csv') %% find max value for resid/nonRes filtering
Tier1_2_Numb=table2array(Tier1_2_Numb);
IndiciRegionASN=find(ismember(ASNnumUSERNationsonly{:,1},Tier1_2_Numb))
TierTable=table()
TierTable(:,1)=ASNnumUSERNationsonly(IndiciRegionASN,1)
TierTable(:,2)=ASNnumUSERNationsonly(IndiciRegionASN,2)
TierTable(:,3)=ASNnumUSERNationsonly(IndiciRegionASN,3)
TierTable_UniqueSum= groupsummary(TierTable,'Var1','sum','Var2');


Tc2EU(:,5)=num2cell(cellfun(@unique,Tc2EU(:,5))) % single as name for each row
[numRows2,numCols2] = size(Tc2EU)
for b=1:numRows2
    Tc2EU{b,4}=unique(Tc2EU{b,4})
end

for b=1:numRows2
    PostASn=find(Tc2EU{b,5}==tabellaNumeriUserUE{:,1})
    Tc2EU{b,6}=tabellaNumeriUserUE{PostASn,3}
end
T=[]

%% 2020
T = readtable(param2); %% inserire qua il csv da plottare.
%load(param2) %% caricamento file di corrispondenza paesi probe

IndiciRegion=find(ismember(T{:,4},EuropaNationscell))
TEuropa2020=T(IndiciRegion,:)
G = findgroups(TEuropa2020{:,5});     
Tc = splitapply( @(varargin) varargin, TEuropa2020, G);
asn_id=cellfun(@unique,Tc(:,1),'UniformOutput',false) % asn unici
[cellsz1, cellsz2] = cellfun(@size,asn_id,'UniformOutput',false); %dimensione di ciascun gruppo
conv=cell2mat(cellsz1)
idxd=find(conv>=2) %trovo le posizioni dei magg di 10
Tc2EU2020=Tc(idxd,:) % isolo solo quelli con più di 1o probe
Tc=[]

% Next find population served by the ASs
ASNnumUSERNationsonly=readtable('Asn_people_nations_new.csv')
IndiciRegionASN=find(ismember(ASNnumUSERNationsonly{:,3},EuropaNationscell))
ASNnumUSERNationsonly2=ASNnumUSERNationsonly(IndiciRegionASN,:)
tabellaNumeriUserUE = groupsummary(ASNnumUSERNationsonly2,'ASN','sum','Users_est__');

Tc2EU2020(:,5)=num2cell(cellfun(@unique,Tc2EU2020(:,5))) % single as name for each row

[numRows2,numCols2] = size(Tc2EU2020)
for b=1:numRows2
    Tc2EU2020{b,4}=unique(Tc2EU2020{b,4})
end

for b=1:numRows2
    PostASn=find(Tc2EU2020{b,5}==tabellaNumeriUserUE{:,1})
    Tc2EU2020{b,6}=tabellaNumeriUserUE{PostASn,3}
end
T=[]
Tc2EU2020Copy=Tc2EU2020
%solo i primi 6 mesi del 2020

for v=1:size(Tc2EU2020,1)
    primi6=find(Tc2EU2020{v,2}<='2020-06-30 23:55:55')
    Tc2EU2020{v,2}=Tc2EU2020{v,2}(primi6,1)
    Tc2EU2020{v,1}=Tc2EU2020{v,1}(primi6,1)
    Tc2EU2020{v,3}=Tc2EU2020{v,3}(primi6,1)
end


Tc2=Tc2EU
Tc22=Tc2EU2020

Type=[]
ttest_result=[]
Asn_Number=[]
Nation=[]
Tabellastampare=[]
Pvalues=[]
[Rows,Cols] = size(Tc2)

for b=1:Rows
            tabx = table(Tc2{b,3},Tc2{b,2});
            tabxx = table(Tc22{b,3},Tc22{b,2});
            tab1 = sortrows(tabx,2);
            tab11 = sortrows(tabxx,2);
            x=(tab1.Var2);
            y=double(tab1.Var1);    
            x2=(tab11.Var2);
            y2=double(tab11.Var1);
            %% -----------------------------------------------------
                       
            [h,p,ci,stats] = ttest2(y,y2,'Vartype','unequal')
            Asn_Number=[Asn_Number;Tc2{b,5}]
            if(size(convertCharsToStrings(Tc2{b,4}),1)>1)
                s=convertCharsToStrings(Tc2{b,4})
                Nat=[sprintf('%s/',s{1:end-1}),s{end}]
                Nation=[Nation;Nat]
            else
                Nation=[Nation;convertCharsToStrings(Tc2{b,4})]
            end
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
            if(isempty(Tc2{b,6}))%vuoto
                Type=[Type;"Empty"]
            elseif(Tc2{b,6}>1000000)%resid
                Type=[Type;"Residential"]
            elseif((Tc2{b,6}<100000)) % non residenziale
                Type=[Type;"Not Residential"]
            else
                Type=[Type;"NotClassified"]
            end   
            Pvalues=[Pvalues;p]
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
signResult_residential=sum(binopdf(number_residemt,limit_resident,0.5))%
signResultCDF_residential=(binocdf(plus_resident,limit_resident,0.5))%nn serve

plus_Notresident=size(find(nonResident_entry{:,4}=='-'),1)
limit_Notresident=size(nonResident_entry,1)
number_Notresidemt = plus_Notresident:limit_Notresident
signResult_Notresidential=sum(binopdf(number_Notresidemt,limit_Notresident,0.5))%
signResultCDF_Notresidential=(binocdf(plus_Notresident,limit_Notresident,0.5))%nn serve
%Tabellastampare{:,4}
Tc2EU2020_6mesi=Tc2EU2020
Tc2EU2020=Tc2EU2020Copy
Tc2=Tc2EU
Tc22=Tc2EU2020
T=[]


T0=cat(1, Tc22{:,3})
T1=cat(1, Tc22{:,2})
T2=table()
T2{:,1}=T0
T2{:,2}=T1
tab1 = sortrows(T2,2);
%tab2 = groupsummary(tab1,'Var2',hours(4),'median','Var1');
tab2 = groupsummary(tab1,'Var2',hours(4),@(x) prctile(x,90));
x=categorical(tab2.disc_Var2);
%y=double(tab2.median_Var1);
y= double(tab2.fun1_Var1);
N = length(y);

stringa = string(x)
stringa2 = split(stringa,',',2)
iwant = stringa2(:,2)
val = strrep(iwant,']','')
val2 = strrep(val,')','')
DateCorrectFormat = datetime(val2)
set(gcf, 'Visible', 'off');
plot(DateCorrectFormat,y);
ylim([0 450])
hold on
title('Europe Median')
xlabel('4h Time Bins') 
ylabel('Result(ms)') 
set(gcf,'color','w');
fname ='EU_16430285_Median2020v2'
export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');

%% ---------------------- fasce orarie va diviso poi lo script

T0=cat(1, Tc22{:,3})
T1=cat(1, Tc22{:,2})
T2=table()
T2{:,1}=T0
T2{:,2}=T1
tab1 = sortrows(T2,2);
tab2 = groupsummary(tab1,'Var2',hours(4),'median','Var1');
%%tab2 = groupsummary(tab1,'Var2',hours(4),@(x) prctile(x,90));
x=categorical(tab2.disc_Var2);
y=double(tab2.median_Var1);
%%y= double(tab2.fun1_Var1);

stringa = string(x)
stringa2 = split(stringa,',',2)
iwant = stringa2(:,2)
val = strrep(iwant,']','')
val2 = strrep(val,')','')
DateCorrectFormat = datetime(val2)
tabletest=[]
tabletest=table(DateCorrectFormat,y)
sera= find((hour(DateCorrectFormat)>0 & hour(DateCorrectFormat)<=8)) %notte
pomeriggio=find( 16<hour(DateCorrectFormat) & hour(DateCorrectFormat)<=23 | (hour(DateCorrectFormat)==0)) %
mattina=find(8<hour(DateCorrectFormat) & hour(DateCorrectFormat)<=16) %lavoro
tabmattina=tabletest(mattina,:)
tabpomeriggio=tabletest(pomeriggio,:)
tabsera=tabletest(sera,:)
set(gcf, 'Visible', 'off');
figure('Visible', 'off')
scatter(tabmattina.DateCorrectFormat,tabmattina.y,'x');
ylim([0 200])
title('Plot Median morning')
xlabel('2h Time Bins') 
ylabel('Result(ms)') 

set(gcf,'color','w');
fname = sprintf('%s_%s_Median_morning', FileOut2,FileOut{2});
export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
set(gcf, 'Visible', 'off');
figure('Visible', 'off')
scatter(tabpomeriggio.DateCorrectFormat,tabpomeriggio.y,'+');
ylim([0 200])
title('Plot Median afternoon')
xlabel('2h Time Bins') 
ylabel('Result(ms)') 

set(gcf,'color','w');
fname = sprintf('%s_%s_Median_afternoon', FileOut2,FileOut{2});
export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
set(gcf, 'Visible', 'off');
figure('Visible', 'off')
scatter(tabsera.DateCorrectFormat,tabsera.y,'x');
ylim([0 200])
title('Plot Median night')
xlabel('2h Time Bins') 
ylabel('Result(ms)') 

set(gcf,'color','w');
fname = sprintf('%s_%s_Median_night', FileOut2,FileOut{2});
export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');



end
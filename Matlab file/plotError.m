function[]= plotError(param1, param2)
T = readtable(param1); %% inserire qua il csv da plottare.
G = findgroups(T{:,8});     
Country = readtable('ContryProbe.csv');
Tc = splitapply( @(varargin) varargin, T, G);
load(param2) %% caricamento file di corrispondenza paesi probe
FileOut= split(param1,"_")
fname = sprintf('%s_%s_Error_All', FileOut{1},FileOut{2});

[numRows,numCols] = size(Tc);
arrayTempo=[]
arrayConto=[]
for p=1:numRows
    for h=1:numRows;
        if unique(Tc{p,19})==Corri{h,1}
            Tc{h,28}=Corri{h,2};
        end
    end
end
Nations={'ES','FR','IT','SE','DE'}

Peso=[]
Tempo=[]
appoggio=[]
tabella=cell(5,2)
tatto=cell(5,1)
scount=0;

for g=1:size(Nations,2)
    for b=1:numRows
        if Tc{b,5} == Nations{1,g}
            appoggio=cell2table(Tc(b,2))
            Peso=vertcat(Peso,cell2mat(Tc(b,3)))
            %Peso=vertcat(Peso,cell2mat(Tc{b,25})) %% fittizzio
            % problema qui perchè vedecell array e poi alcune non sono
            if iscell(appoggio.Var1)
                Tempo=cat(1,Tempo,appoggio.Var1{1,1})
                appoggio=[]                
            else
                Tempo=cat(1,Tempo,appoggio.Var1)
                appoggio=[] 
            end
        end
    end
    prop=cell(size(Tempo,1),size(Tempo,2))
    tabella{g,1}=Peso
    Peso=[];
    tabella{g,2}=Tempo
    Tempo=[]

end






[Rows,Cols] = size(tabella)
for j = 1:Rows
    if(~cellfun('isempty',tabella(j,1)))
        tabx = table(tabella{j,1},tabella{j,2});
        tab1 = sortrows(tabx,2);
        array=table2array(tab1(:,1))
        idx=find(isnan(array))
        idx2=find(array>0)
        tab1.Var1(idx)=1
        tab1.Var1(idx2)=0
        Var_Count = groupsummary(tab1,'Var2',hours(2),'sum','Var1'); %% raggruppa e calcola il metodo/funzione che gli si passa.

        time = Var_Count.disc_Var2;
        count = Var_Count.max_Var1;
    %% ---------- prova miglioramento grafico.

        stringa = string(time)
        stringa2 = split(stringa,',',2)
        iwant = stringa2(:,2)
        val = strrep(iwant,']','')
        val2 = strrep(val,')','')
        DateCorrectFormat = datetime(val2)
        N = length(count);
        limit = 100;
        for i = 1:N
            if(count(i)>limit)
                count(i)=limit;
            end

        end

        %% ---------------------------------------------
        %% per riempire i missing value


        %%grammo=zeros(size(DateCorrectFormat,1),1)
        %% cambia in scatter che si vede meglio e metti i bin più grossi.
        %% puoi fa pure i plot classici.
        datenumb= datenum(DateCorrectFormat) % converto dat e in numeri
        datenumb=datenumb.'
        difference= diff([0 datenumb]) % differenza tra elementi
        difference=difference*24*60 % lo porto in formato migliore
        difference2=difference/2 % cosi divido per 6 ore cosi num come 1 ecc ho 
        vuoto=find(difference2 > 360) % trovo le differenze cioè le posizioni

        NewDate= DateCorrectFormat.'
        valori= difference2(difference2>360)
        dimensione=size(vuoto,2)
        NewCount=count.'
        v=2
        for v=2:dimensione
            xnat=NaT(1,round(valori(v)))
            xnan=NaN(1,round(valori(v)))
            NewDate= [NewDate(1:round(vuoto(v))-1) xnat NewDate(round(vuoto(v)):size(NewDate,2))]
            NewCount=[NewCount(1:round(vuoto(v))-1) xnan NewCount(round(vuoto(v)):size(NewCount,2))]
            vuoto=vuoto+valori(v)

        end
        NewDate=NewDate.'
        NewCount=NewCount.'


        plot(NewDate,NewCount)
        hold on
     end
end
ylim([0 50])
title('Plot Error')
xlabel('2hrs Time Bins') 
ylabel('Count') 
legend('ES','FR','IT','SE','DE')
set(gcf,'color','w');
export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');

end

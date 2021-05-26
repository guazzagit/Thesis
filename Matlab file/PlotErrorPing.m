T = readtable('23324638_ping_2020_format_dataCambiata_80percent_all.csv'); %% inserire qua il csv da plottare.
G = findgroups(T{:,15});     
%Country = readtable('ContryProbe.csv');
Tc = splitapply( @(varargin) varargin, T, G);
[numRows,numCols] = size(Tc);
arrayTempo=[]
arrayConto=[]
for p=1:numRows
    for h=1:numRows;
        if unique(Tc{p,15})==Corri{h,1}
            Tc{h,28}=Corri{h,2};
        end
    end
end
Nations={'ES','FR','IT','SE','DE'}

Peso1=[]
Peso2=[]
Peso3=[]
Tempo=[]
appoggio=[]
tabella=cell(5,4)
tatto=cell(5,4)
scount=0;
errore=[]

%% follia ci mette una vita..for
%%sscanf(Tc{1,11}{1,1},"[{'rtt': %f}, {'rtt': %f}, {'rtt': %f}]")

for g=1:size(Nations,2)
    for b=1:numRows
        if Tc{b,28} == Nations{1,g}
            appoggio=cell2table(Tc(b,24))
            Peso1=vertcat(Peso1,cell2mat(Tc(b,3)))
            Peso2=vertcat(Peso2,cell2mat(Tc(b,17)))
            Peso3=vertcat(Peso3,cell2mat(Tc(b,19)))
            %%Peso=vertcat(Peso,cell2mat(Tc(b,17)))
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
    
    tabella{g,1}=Peso1
    Peso1=[];
    tabella{g,3}=Peso2
    Peso2=[];
    tabella{g,4}=Peso3
    Peso3=[];
    tabella{g,2}=Tempo
    Tempo=[]

end



[Rows,Cols] = size(tabella)
for j = 1:1
    tabx = table(tabella{j,1},tabella{j,2},tabella{j,3},tabella{j,4});
    tab1 = sortrows(tabx,2);
    array=table2array(tab1(:,1))
    array1=table2array(tab1(:,3))
    array2=table2array(tab1(:,4))
    idx=find(array>-1)
    idx2=find(array==-1)
    ids=find(array1<array2)
    tab1.Var1(idx)=0
    tab1.Var1(idx2)=100
    for i=1:size(ids,1)
        tab1.Var1(ids(i,1))=(array2(ids(i,1),1)-array1(ids(i,1),1))/array2(ids(i,1),1)*100
    end
    Var_Count = groupsummary(tab1,'Var2',hours(336),'mean','Var1'); %% raggruppa e calcola il metodo/funzione che gli si passa.

    time = Var_Count.disc_Var2;
    count = Var_Count.mean_Var1;
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
    %scatter(DateCorrectFormat,count,'x')
    plot(DateCorrectFormat,count)
    hold on
end

ylim([0 60])
title('Plot Error')
xlabel('2hrs Time Bins') 
ylabel('Mean Error(%)') 
set(gcf,'color','w');
legend('DE')
export_fig('C:/Users/guazz/Desktop/Correzione Plot/23324638_2020_Error_DE', '-pdf');

function[]= plotError(param1, param2)
T = readtable(param1); %% inserire qua il csv da plottare.
G = findgroups(T{:,19});     
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
        if Tc{b,28} == Nations{1,g}
            appoggio=cell2table(Tc(b,20))
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
    tabella{g,1}=prop
    Peso=[];
    tabella{g,2}=Tempo
    Tempo=[]

end





[Rows,Cols] = size(tabella)
for j = 1:Rows
    tabx = table(tabella{j,1},tabella{j,2});
    tab1 = sortrows(tabx,2);
    array=table2array(tab1(:,1))
    idx=find(array>-1)
    idx2=find(array==-1)
    tab1.Var1(idx)=0
    tab1.Var1(idx2)=1
    Var_Count = groupsummary(tab1,'Var2',hours(2),'max','Var1'); %% raggruppa e calcola il metodo/funzione che gli si passa.

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
    scatter(DateCorrectFormat,count,'x')
    hold on
end
ylim([0 50])
title('Plot Error')
xlabel('2hrs Time Bins') 
ylabel('Result(ms)') 
legend('ES','FR','IT','SE','DE')
set(gcf,'color','w');
export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');

end

T = readtable('16474724_nuovo_formattato_dataCambiata_ONLYERROR.csv'); %% inserire qua il csv da plottare.
G = findgroups(T{:,11});     
%Country = readtable('ContryProbe.csv');
Tc = splitapply( @(varargin) varargin, T, G);
[numRows,numCols] = size(Tc);
arrayTempo=[]
arrayConto=[]

Nations={'ES','FR','IT','SE','DE'}

Peso=[]
Tempo=[]
appoggio=[]
tabella=cell(5,2)
tatto=cell(5,1)
scount=0;

for g=1:size(Nations,2)
    for b=1:numRows
        if Tc{b,26} == Nations{1,g}
            appoggio=cell2table(Tc(b,15))
            Peso=vertcat(Peso,cell2mat(Tc{b,16})) %% fittizzio
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
    tabella{g,1}=Peso
    Peso=[];
    tabella{g,2}=Tempo
    Tempo=[]

end


[Rows,Cols] = size(tabella)
for j = 5:5
    tabx = table(tabella{j,1},tabella{j,2});
    tab1 = sortrows(tabx,2);

    Var_Count = groupsummary(tab1,'Var2',hours(2)); %% raggruppa e calcola il metodo/funzione che gli si passa.

    time = Var_Count.disc_Var2;
    count = Var_Count.GroupCount;
%% ---------- prova miglioramento grafico.

    stringa = string(time)
    stringa2 = split(stringa,',')
    iwant = stringa2(:,2)
    val = strrep(iwant,']','')
    val2 = strrep(val,')','')
    DateCorrectFormat = datetime(val2)
    N = length(count);
    limit = 20;
    for i = 1:N
        if(count(i)>limit)
            count(i)=limit;
        end

    end
    bar(DateCorrectFormat,count)
    hold on
end
ylim([0 20])
title('Plot Error')
xlabel('2hrs Time Bins') 
ylabel('Result(ms)') 
legend('DE')
export_fig('C:/Users/Me/Documents/figures/myfig', '-pdf', '-png');
%export_fig tutto.pdf
%% --- mostra solo alcuni tick.. più brutto secondo me. cambia il valore in bar() 
%%legend('Probe 16100')
%tickStep=380;
%val = cellstr(time)
%xTickLabels = cell(1,numel(val));  % Empty cell array the same length as xAxis
%xTickLabels(1:tickStep:numel(val)) = val(1:tickStep:numel(val));
                                     % Fills in only the values you want
%set(gca,'XTickLabel',xTickLabels); 

%xtickangle(45);
%% -----------------------------------------------------
%%saveas(gcf,'Probe16100Error.pdf')

%%savefig('Probe16100Error.fig');

%% -------------------------------------------------------- altro

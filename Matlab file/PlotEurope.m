function[] = PlotEurope(param1,param2)
T = readtable(param1); %% inserire qua il csv da plottare.
Country = readtable('ContryProbe.csv');
load(param2) %% caricamento file di corrispondenza paesi probe
G = findgroups(T{:,15});     
Tc = splitapply( @(varargin) varargin, T, G);
FileOut= split(param1,"_")
fname = sprintf('%s_%s_Median_All', FileOut{1},FileOut{2});


%% carica il file corrispondenza
[numRows,numCols] = size(Tc)
for p=1:numRows
    for h=1:numRows;
        if unique(Tc{p,15})==Corri{h,1}
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

for g=1:size(Nations,2)
    for b=1:numRows
        if cell2mat(Tc(b,28)) == Nations{1,g}
            %%Peso=[Peso;cell2mat(Tc(b,23))];
            %%Tempo=[Tempo;[Tc(b,15)]]
            Peso=vertcat(Peso,cell2mat(Tc(b,3)))
            %% la parte sotto va sistemata
            appoggio=cell2table(Tc(b,24))
            appoggio=table2cell(appoggio)
            Tempo=cat(1,Tempo,appoggio{1,1})
            appoggio=[]
        end
    end
    tabella{g,1}=Peso
    Peso=[];
    tabella{g,2}=Tempo
    Tempo=[]
     %% la parte sotto va sistemata
    %% C = table2cell(Tempo)
    %% tatto=[tatto;Tempo]
end



%% non plotta tutto ma è follia farlo cosi tanto.
[Rows,Cols] = size(tabella)
for j = 1:Rows
    tabx = table(tabella{j,1},tabella{j,2});
    tab1 = sortrows(tabx,2);
    tab2 = groupsummary(tab1,'Var2',hours(2),'median','Var1');
    %%tab2 = groupsummary(tab1,'Var2',hours(2),@(x) prctile(x,90));
    x=categorical(tab2.disc_Var2);
    y=double(tab2.median_Var1);
    %%y= double(tab2.fun1_Var1);
    N = length(y);
    limit = 100;
    for i = 1:N
        if(y(i)>limit)
            y(i)=limit;
        end
    end
    %%h=T{j,11};
    %% tickStep=380;
    %% val = cellstr(x)
    %% xTickLabels = cell(1,numel(val));  % Empty cell array the same length as xAxis
    %% xTickLabels(1:tickStep:numel(val)) = val(1:tickStep:numel(val));
                                         % Fills in only the values you want
    %% set(gca,'XTickLabel',xTickLabels); 

    %% xtickangle(65);
    
    stringa = string(x)
    stringa2 = split(stringa,',',2)
    iwant = stringa2(:,2)
    val = strrep(iwant,']','')
    val2 = strrep(val,')','')
    DateCorrectFormat = datetime(val2)
    set(gcf, 'Visible', 'off');
    scatter(DateCorrectFormat,y,'x');
    hold on
    %%plot(DateCorrectFormat,y);

    %%legend(num2str(h))
    
    %%ylim([0 100])
    %scatter(DateCorrectFormat,z,'x');
    %% set(gca,'xticklabel',{[]})
    %% set(gca, 'YScale', 'log')
    
end
ylim([0 100])
title('Plot Median')
xlabel('2h Time Bins') 
ylabel('Result(ms)') 
legend('ES','FR','IT','SE','DE')
set(gcf,'color','w');

export_fig(['C:/Users/guazz/Desktop/' fname], '-pdf');
end
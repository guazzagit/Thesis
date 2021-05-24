T = readtable('12001626_quad1_2019_formattato_dataCambiata_NOERROR_abuf'); %% inserire qua il csv da plottare.
G = findgroups(T{:,11});     
Tc = splitapply( @(varargin) varargin, T, G);

TotalNumBin = size(groupsummary(T,'timestamp',hours(2)),1)
 %% inserire qua il csv da plottare.


%% non plotta tutto ma è follia farlo cosi tanto.
[numRows,numCols] = size(Tc)
tabella=[]
counter=[]
for j = 1:numRows
    tabx = table(Tc{j,24},Tc{j,16});
    tab1 = sortrows(tabx,2);
    
    tab2 = groupsummary(tab1,'Var2',hours(2),'median','Var1');
    %%tab3 = groupsummary(tab1,'Var2',hours(2),@(x) prctile(x,90));
    x=categorical(tab2.disc_Var2);
    y=double(tab2.median_Var1);
    %%z= double(tab3.fun1_Var1);
    N = length(y);
    limit = 100;
    for i = 1:N
        if(y(i)>limit)
            y(i)=limit;
        end
    end
    counter=size(tab2,1)
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
    prb_id=unique(Tc{j,11})
    tabella(j,2)=counter
    tabella(j,1)=prb_id
    %%scatter(DateCorrectFormat,y,'x');
    %%legend(num2str(h))
    %%hold on
    %scatter(DateCorrectFormat,z,'+');
    %% set(gca,'xticklabel',{[]})
    %% set(gca, 'YScale', 'log')
    
end
title('Plot median for separated Probes')
xlabel('2hrs Time Bins') 
ylabel('Result(ms)') 
%%legend('median','90percent')
%%legend('Probe 2256','Probe 3131','Probe 3178','Probe 16100','Probe 25438','Probe 32880','Probe 50218','Probe 52490','Probe 52741','Probe 54377');
export_fig('C:/Users/guazz/Desktop/myfig', '-pdf', '-png');

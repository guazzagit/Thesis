T = readtable('quad1Results_formattato_dataCambiata_NOERROR'); %% inserire qua il csv da plottare.
G = findgroups(T{:,11});     
Tc = splitapply( @(varargin) varargin, T, G);


%% non plotta tutto ma è follia farlo cosi tanto.
[numRows,numCols] = size(Tc)
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
    %%h=T{j,11};
    %% tickStep=380;
    %% val = cellstr(x)
    %% xTickLabels = cell(1,numel(val));  % Empty cell array the same length as xAxis
    %% xTickLabels(1:tickStep:numel(val)) = val(1:tickStep:numel(val));
                                         % Fills in only the values you want
    %% set(gca,'XTickLabel',xTickLabels); 

    %% xtickangle(65);
    
    stringa = string(x)
    stringa2 = split(stringa,',')
    iwant = stringa2(:,2)
    val = strrep(iwant,']','')
    val2 = strrep(val,')','')
    DateCorrectFormat = datetime(val2)
    
    
    scatter(DateCorrectFormat,y,'x');
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


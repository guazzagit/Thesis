T = readtable('16474724_nuovo_formattato_dataCambiata_NOERROR.csv'); %% inserire qua il csv da plottare.

Date = T.timestamp;
Response = T.result_rt;
table2 = table(Date,Response);
table1 = sortrows(table2,1);
%% [numRows,numCols] = size(T);
%% ID = [2256 3131 3178 16100 25438 32880 50218 52490 52741 54377]
Var_Median = groupsummary(table1,'Date',hours(2),'median','Response'); %% raggruppa e calcola il metodo/funzione che gli si passa.
Nov_Percent = groupsummary(table1,'Date',hours(2),@(x) prctile(x,90));

value1 = Var_Median.disc_Date; %% time bins.
value2 = Var_Median.median_Response; %% median value
value3= Nov_Percent.fun1_Response; %% 90 percentile value
%% plot(value1,value2,value1,value3);
%% t = linspace(Date(1),Date(1085143),length(value1));

%% ----prima prova per fare il plot pulito l'ora visualizzata sno i dati delle due ore passate es 14 -> dati dalle 12 alle 14
stringa = string(value1)
stringa2 = split(stringa,',')
iwant = stringa2(:,2)
val = strrep(iwant,']','')
val2 = strrep(val,')','')
DateCorrectFormat = datetime(val2)
N = length(value2);
limit = 100;
for i = 1:N
    if(value2(i)>limit)
        value2(i)=limit;
    end
    if(value3(i)>limit)
        value3(i)=limit;
    end
end

%% ------------------------
scatter(DateCorrectFormat,value2,'+')
hold on;
scatter(DateCorrectFormat,value3,'x');
hold off;
title('Plot median and 90 percentile of probe 54377')
xlabel('2hrs Time Bins') 
set(gca, 'YScale', 'log')
ylabel('Result(ms)LogScale') 
legend('Median','90percentile');


%% --- mostra solo alcuni tick.. più brutto secondo me. cambia il valore negli scatter() sopra

%%tickStep=200;
%%val = cellstr(value1)
%%xTickLabels = cell(1,numel(val));  % Empty cell array the same length as xAxis
%%xTickLabels(1:tickStep:numel(val)) = val(1:tickStep:numel(val));
                                     % Fills in only the values you want
%%set(gca,'XTickLabel',xTickLabels); 

%%xtickangle(45);
%% -----------------------------------------------------
%% saveas(gcf,'Probe3178Version1.pdf')
%% savefig('Probe52741Version1.fig');
%% ------------------------------------------------------
%% prova con altre tempistiche tipo mensile o settimanale.
%% prova1 = groupsummary(table,'Date','day','median','Response');
%% prova2 = groupsummary(table,'Date','day',@(x) prctile(x,90));
%% scatter(prova1.day_Date,prova1.median_Response,'+')
%% hold on;
%% scatter(prova2.day_Date,prova2.fun1_Response,'x');
%% hold off;
%% title('Plot median and 90 percentile of probe 54377')
%% xlabel('Time Bins') 
%% ylabel('Result(ms)') 
%% legend('Median','90percentile');
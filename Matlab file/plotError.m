function[]= plotError(param1, param2)
T = readtable(param1); %% inserire qua il csv da plottare.
Country = readtable('ContryProbe.csv');
load(param2) %% caricamento file di corrispondenza paesi probe
G = findgroups(T{:,1});     
Tc = splitapply( @(varargin) varargin, T, G);
FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")
%fname = sprintf('%s_%s_Error_All_', FileOut{1},FileOut{3});

[numRows,numCols] = size(Tc)
%% carica il file corrispondenza non serve più questo

%for p=1:numRows
 %   for h=1:numRows;
 %       if unique(Tc{p,1})==Corri{h,1}
 %%           Tc{h,5}=Corri{h,2};
  %      end
 %   end
%end
%% cancella fin qui
Nations={'ES','FR','IT','SE','DE'}
Nations2=["ES" "FR" "IT" "SE" "DE"]
Tc(:,5)=Corri(:,2) % forse cosi posso assegnare diretto le corrispondenze...


T=[]
tabellaTempi=cell(5,1)
tabellaPesi=cell(5,1)
parfor (g=1:size(Nations,2),3)
    singlerow=cell(1,2)
    tabellaTempo=[]
    tabellaPeso=[]
    for b=1:numRows
        
        if cell2mat(Tc(b,5)) == Nations{g}

            singlerow{1,1}=cell2mat(Tc(b,3))
            singlerow{1,2}=Tc{b,2}
            %appoggio=[]
            tabellaPeso=[tabellaPeso;singlerow{1}]
            tabellaTempo=[tabellaTempo;singlerow{2}]
        end

    end
    tabellaPesi{g,:}=tabellaPeso
    tabellaTempi{g,:}=tabellaTempo


end


[Rows,Cols] = size(tabella)
for j = 1:Rows
    if(~cellfun('isempty',tabellaPesi(j,1)))
        tabx = table(tabellaPesi{j,1},tabellaTempi{j,1});
        tab1 = sortrows(tabx,2);
        array=table2array(tab1(:,1))
        idx=find(isnan(array))
        idx2=find(array>0)
        tab1.Var1(idx)=1
        tab1.Var1(idx2)=0
        Var_Count = groupsummary(tab1,'Var2',hours(4),'sum','Var1'); %% raggruppa e calcola il metodo/funzione che gli si passa.

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

        datenumb= datenum(DateCorrectFormat) % converto dat e in numeri
        datenumb=datenumb.'
        difference= diff([0 datenumb]) % differenza tra elementi
        difference=difference*24*60 % lo porto in formato migliore
        difference2=difference/2 % cosi divido per 6 ore cosi num come 1 ecc ho 
        vuoto=find(difference2 > 240) % trovo le differenze cioè le posizioni

        NewDate= DateCorrectFormat.'
        valori= difference2(difference2>240)
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
        set(gcf, 'Visible', 'off');
        figure('Visible', 'off')

        plot(NewDate,NewCount)
        hold on
     end
end
ylim([0 50])
title('Plot Error')
xlabel('4hrs Time Bins') 
ylabel('Count') 
legend('ES','FR','IT','SE','DE')
set(gcf,'color','w');
export_fig(['/home/guazzelli/disco/Thesis/Matlab file/plot/' fname], '-pdf');

end

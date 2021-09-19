function[] = PlotCountry(param1,param2)
T = readtable(param1); %% inserire qua il csv da plottare.
Country = readtable('ContryProbe.csv');
load(param2) %% caricamento file di corrispondenza paesi probe
G = findgroups(T{:,15});     
Tc = splitapply( @(varargin) varargin, T, G);
FileOut= split(param1,"_")
FileOut2=split(FileOut{1},"/")
%fname = sprintf('%s_%s_Median_', FileOut{1},FileOut{3});

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
            singlerow{1,2}=Tc{b,24}
            %appoggio=[]
            tabellaPeso=[tabellaPeso;singlerow{1}]
            tabellaTempo=[tabellaTempo;singlerow{2}]
        end

    end
    tabellaPesi{g,:}=tabellaPeso
    tabellaTempi{g,:}=tabellaTempo


end


[Rows,Cols] = size(tabellaPesi)
for j = 1:Rows
    if(~cellfun('isempty',tabellaPesi(j,1)))
        tabx = table(tabellaPesi{j,1},tabellaTempi{j,1});
        tab1 = sortrows(tabx,2);
        tab2 = groupsummary(tab1,'Var2',hours(4),'median','Var1');
        %%tab2 = groupsummary(tab1,'Var2',hours(2),@(x) prctile(x,90));
        x=categorical(tab2.disc_Var2);
        y=double(tab2.median_Var1);
        %%y= double(tab2.fun1_Var1);
        N = length(y);
        limit = 200;
        for i = 1:N
            if(y(i)>limit)
                y(i)=limit;
            end
        end

        stringa = string(x)
        stringa2 = split(stringa,',',2)
        iwant = stringa2(:,2)
        val = strrep(iwant,']','')
        val2 = strrep(val,')','')
        DateCorrectFormat = datetime(val2)
        set(gcf, 'Visible', 'off');
        figure('Visible', 'off')
        scatter(DateCorrectFormat,y,'x');
        ylim([0 200])
        title('Plot Median')
        xlabel('4h Time Bins') 
        ylabel('AVG_RTT(ms)') 
        legend(Nations{j})
        set(gcf,'color','w');
        fname = sprintf('%s_%s_Median_%s', FileOut2{end},FileOut{2},Nations{j});
        export_fig(['/home/guazzelli/disco/Thesis/Matlab file/plot/' fname], '-pdf');
    end
    
end

end
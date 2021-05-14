%% in realtà stampa i plot di nsid e median insieme o separati a piacimento
T = readtable('12001626_quad1_formattato_dataCambiata_NOERROR_ABUF.csv'); %% inserire qua il csv da plottare.
Country = readtable('ContryProbe.csv');
%load('corrispondenze.mat')
G = findgroups(T{:,11});     
probeid = unique(T{:,11})
Tc = splitapply( @(varargin) varargin, T, G);
%% carica il file corrispondenza
[numRows,numCols] = size(Tc)
for p=1:numRows
    for h=1:numRows;
        if unique(Tc{p,11})==Corri{h,1}
            Tc{h,27}=Corri{h,2};
        end
    end
end
Nations={'ES','FR','IT','SE','DE'}

Peso=[]
Tempo=[]
appoggio=[]
abuf=[]
probe=[]
tabella=cell(5,4)
tatto=cell(5,1)

for g=1:size(Nations,2)
    for b=1:numRows
        if cell2mat(Tc(b,27)) == Nations{1,g}
            %%Peso=[Peso;cell2mat(Tc(b,23))];
            %%Tempo=[Tempo;[Tc(b,15)]]
            abuf=cat(1,abuf,string(Tc{b,23}))
            Peso=vertcat(Peso,cell2mat(Tc(b,24)))
            %% la parte sotto va sistemata
            appoggio=cell2table(Tc(b,16))
            Tempo=cat(1,Tempo,appoggio.Var1{1,1})
            appoggio=[]
            probe=cat(1,probe,Tc{b,11})
        end
    end
    tabella{g,1}=Peso
    Peso=[];
    tabella{g,2}=Tempo
    Tempo=[]
    tabella{g,3}=abuf
    abuf=[]
    tabella{g,4}=probe
    probe=[]

end



%% non plotta tutto ma è follia farlo cosi tanto.
[Rows,Cols] = size(tabella)
conta=0
tatta=table(probeid)
for l=1:size(tatta,1)
    tatta{l,2}="'empty'"
end

contagrosso=[]
for j = 4:4
    tabx = table(tabella{j,1},tabella{j,2},tabella{j,3},tabella{j,4});
    tab1 = sortrows(tabx,2);
    gruppo=discretize(tab1.Var2,hours(2))
    HH= findgroups(gruppo);   
    Tappo = splitapply( @(varargin) varargin, tab1, HH);
    
    for v=1:size(Tappo,1)
        for k=1:size(probeid,1)
            appoggio2=Tappo{v,4}
            appoggio3=Tappo{v,3}
                for a=1:size(Tappo{v,4},1)
                    if tatta{k,1}==appoggio2(a,1) 
                        if tatta{k,2}~= appoggio3{a,1} & appoggio3{a,1}~="'empty'"
                            conta=conta+1
                            tatta{k,2}= string(appoggio3{a,1})
                        end
                    end
                end
        end
        contagrosso=cat(1,contagrosso,conta(1,1))
        conta=0
    end
    
    
    
    % posso dedurlo da qua forse se metto in tabella pure nsid e probeid
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

    
    stringa = string(x)
    stringa2 = split(stringa,',')
    iw = stringa2(:,1)
    val3 = strrep(iw,'[','')
    val23 = strrep(val3,')','')
    Data2 = datetime(val23)
    
    % uso dataprima per calcolarmi i bordi dellintervallo
    iwant = stringa2(:,2)
    val = strrep(iwant,']','')
    val2 = strrep(val,')','')
    DateCorrectFormat = datetime(val2)
    
    scatter(DateCorrectFormat,y,'+');
    hold on
    scatter(DateCorrectFormat,contagrosso,'x');
    
    
    
end
ylim([0 100])
title('Plot NSID Change & RT <SE>')
xlabel('2hrs Time Bins') 
ylabel('Count/result') 
legend('RT','NSID')
export_fig('C:/Users/guazz/Desktop/myfig', '-pdf', '-png');
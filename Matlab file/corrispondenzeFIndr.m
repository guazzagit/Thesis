%% associa regione al probe_id

T = readtable('23324638_ping_2020_format_dataCambiata_OnlyERROR_80percent.csv'); %% inserire qua il csv da plottare.
     
Country = readtable('ContryProbe.csv');
[numRows,numCols] = size(Country)

prb_id= unique(T{:,15})
[Rows,Cols] = size(prb_id)
for p=1:Rows
    for h=1:numRows;
        if prb_id(p,1)==Country{h,2}
            Corri{p,1}=prb_id(p,1);
            valore = cellstr(Country{h,3});
            Corri{p,2}=valore{1,1};
        end
    end
end
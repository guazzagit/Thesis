%% associa regione al probe_id
[numRows,numCols] = size(Country)

prb_id= unique(T{:,11})
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
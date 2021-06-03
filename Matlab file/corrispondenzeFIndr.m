%% associa regione al probe_id
function[] = corrispondenzeFIndr(Param1)
T = readtable(Param1); %% inserire qua il csv da caricare
Country = readtable('ContryProbe.csv');
[numRows,numCols] = size(Country)
FileOut= split(param1,"_")
fname = sprintf('Corrispondenza_%s_%s.mat', FileOut{1},FileOut{3});
prb_id= unique(T{:,8})
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
save([Filename],'close')
end
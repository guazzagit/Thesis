%% associa regione al probe_id
function[] = corrispondenzeFIndr(Param1)
T = readtable(Param1); %% inserire qua il csv da caricare
Country = readtable('ContryProbe.csv');
[numRows,numCols] = size(Country)
FileOut= split(Param1,"_")
FileOut2=split(FileOut{1},"/")
fname = sprintf('Corrispondenza_%s_%s.mat', FileOut2{end},FileOut{3});
prb_id= unique(T{:,1})
[Rows,Cols] = size(prb_id)
for p=1:Rows
    tappo=find(Country{:,2}==prb_id(p,1))

    Corri{p,1}=prb_id(p,1);
    valore = cellstr(Country{tappo,3});
    Corri{p,2}=valore{1,1};

end
save(fname, "Corri")
end
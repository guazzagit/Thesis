%%fa l'associazione in tabella( spezzone d codice)
[numRows,numCols] = size(Tc)
for p=1:numRows
    for h=1:numRows;
        if unique(Tc{p,11})==Corri{h,1}
            Tc{h,26}=Corri{h,2};
        end
    end
end
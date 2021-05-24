datenumb= datenum(DateCorrectFormat) % converto dat e in numeri
datenumb=datenumb.'
difference= diff([0 datenumb]) % differenza tra elementi
difference=difference*24*60 % lo porto in formato migliore
difference2=difference/336 % cosi divido per 6 ore cosi num come 1 ecc ho 
vuoto=find(difference2 > 1) % trovo le differenze cioè le posizioni

NewDate= DateCorrectFormat.'
valori= difference2(difference2>1)
dimensione=size(vuoto,2)
NewCount=count.'
for v=2:dimensione
    xnat=NaT(1,valori(v))
    xnan=NaN(1,valori(v))
    NewDate= [NewDate(1:vuoto(v)-1) xnat NewDate(vuoto(v):size(NewDate,2))]
    NewCount=[NewCount(1:vuoto(v)-1) xnan NewCount(vuoto(v):size(NewCount,2))]
    vuoto=vuoto+valori(v)
end
NewDate=NewDate.'
NewCount=NewCount.'


%% salvo qui il comando per filtrare i dati dal campo result dei ping:
%% sscanf(lol{1,1},"[{'rtt': %f}, {'rtt': %f}, {'rtt': %f}]")
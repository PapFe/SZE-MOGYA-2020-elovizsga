param nRows; #max sorszám(szelesseg)
set Rows := 1..nRows;#akkor ez legyen set hogy jobban tudjuk hasznalni
param cashierCount; #mennyi penztert akarunk
param cashierLength; # 1 penztar hossz

set ProductGroups; #termekek amiket ki kell rakni

param space{ProductGroups}; # termekek hossza 

var rowsLength{Rows} >= 0; #az altalunk alkotott sorok hossza meterben
var whichRow{Rows,ProductGroups} binary; #melyik termek melyik sorba lesz
var numberofCashierperRow{Rows} integer; #melyik sorba hany penztar van (egesz szam mert fel penztar nem penztar)

var bigSor; #a leghosszabb sor

s.t. everyGroupinOneRow{g in ProductGroups}: #minden termekcsoport egy sorba le legyen rakva es csakis egybe
	sum{r in Rows} whichRow[r,g] = 1;

s.t. cashiertoRow{r in Rows}: #melyik sorba hany penztargep legyen de egy sorba nem lehet tobb mint a megadott penztarok szama(nem mondta semmi hogy 1 sor 1 penztar)
	numberofCashierperRow[r] <= cashierCount;

s.t. maxCashier: #minden penztar legyen elhelyezve es ne legyen tobb mint amennyi kell
	sum{r in Rows} numberofCashierperRow[r] = cashierCount;

s.t. ourRowsLength{r in Rows}: #Az altalunk krealt sorok hossza a penztargepekkel egyut
	rowsLength[r] = numberofCashierperRow[r]*cashierLength+sum{g in ProductGroups} whichRow[r,g]*space[g];

s.t. maxRowLength{r in Rows}: #a leghoszabb sorunk merete
	bigSor>=rowsLength[r];

minimize Legkisebb: bigSor; #a leghosszabb sor minel kisebb legyen

solve;

printf "%f\n",bigSor;


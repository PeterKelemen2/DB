/*
ZH-ra:
Create, Alter table
2 Create view
Insert - Delete
Update
fetch first rows 
unió, metszet, különbség
*/


/*
Szúrja be a saját autótípus táblájába a szerelõ séma autótipus táblájából
a Toyota márkájú autókat
*/

CREATE TABLE e_autotipus AS 
    SELECT * FROM szerelo.sz_autotipus where 1=0;
    
CREATE TABLE e_autofelertekeles AS 
    SELECT * FROM szerelo.sz_autofelertekeles where 1=0;

DROP TABLE e_autofelertekeles;
    
INSERT INTO e_autotipus (
    azon,
    megnevezes,
    marka,
    leiras
)
SELECT  azon,
    megnevezes,
    marka,
    leiras FROM szerelo.sz_autotipus
    WHERE marka = 'Toyota';
ROLLBACK;


/* A piros Fiat autókat felértékelik a mai dátummal.
A felértékelés értéke legyen az autó elsõ vásárlási ára*/

SELECT * FROM szerelo.sz_auto a
    INNER JOIN szerelo.sz_autotipus at
    ON a.tipus_azon = at.azon
WHERE marka = 'Fiat' AND szin = 'piros';

INSERT INTO e_autofelertekeles (auto_azon, datum, ertek)
SELECT azon, sysdate, elso_vasarlasi_ar FROM szerelo.sz_auto
WHERE szin = 'piros' AND
    tipus_azon in (SELECT azon From szerelo.sz_autotipus
                    WHERE marka = 'Fiat');
COMMIT;

/* Azokat az autókat amelyeknek 3-nál több tulajdonosa van
felértékelik a mai nappal. A felértékelés értéke legyen
az autó elsõ vásárlási ára csökkentve annyi százalékkal
Ahány éves az autó. */

CREATE TABLE e_auto_tulajdonosa AS 
    SELECT * FROM szerelo.sz_auto_tulajdonosa where 1=0;

SELECT azon, sysdate, elso_vasarlasi_ar * (1- months_between (sysdate, elso_vasarlas_idopontja)/12/100)
FROM szerelo.sz_auto
WHERE azon in (
            SELECT auto_azon FROM szerelo.sz_auto_tulajdonosa
            GROUP BY auto_azon
            HAVING count(tulaj_azon) > 3);
            
/* A tiszafüredi lakos tulaj megvásárolja a legnagyobb elsõ vásárlási árú
autót. A vásárlás ideje legyen a mai dátum. Vegye fel a megfelelõ sort */

SELECT tu.azon FROM szerelo.sz_tulajdonos tu
WHERE cim like 'Tiszafüred, %';

SELECT * FROM szerelo.sz_auto au
WHERE elso_vasarlasi_ar = (SELECT max(elso_vasarlasi_ar) FROM szerelo.sz_auto);

INSERT INTO e_auto_tulajdonosa (tulaj_azon, auto_azon, vasarlas_ideje)
SELECT tu.azon, au.azon, sysdate FROM szerelo.sz_tulajdonos tu, szerelo.sz_auto au
WHERE cim like 'Tiszafüred, %' AND
elso_vasarlasi_ar = (SELECT max(elso_vasarlasi_ar) FROM szerelo.sz_auto);

/*Ugyanez, csak Toyotával*/
INSERT INTO e_auto_tulajdonosa (tulaj_azon, auto_azon, vasarlas_ideje)
SELECT tu.azon tulaj_azon, au.azon auto_azon, sysdate FROM szerelo.sz_auto au, szerelo.sz_tulajdonos tu
WHERE tu.cim like 'Tiszafüred, %' AND  
tipus_azon in (SELECT azon FROM szerelo.sz_autotipus
                    WHERE marka = 'Toyota'
                    )
ORDER BY elso_vasarlasi_ar desc nulls last
FETCH FIRST ROWS WITH TIES;

/* A Féktelenül Bt.-ben szerelik a piros autókat a mai dátummal.
Vegye fel a sorokat a szerelés táblába*/

INSERT INTO e_szereles(auto_azon, muhely_azon, szereles_kezdete)
SELECT szereles.auto_azon, muhely.azon, sysdate 
FROM szerelo.sz_szereles szereles, szerelo.sz_szerelomuhely muhely
WHERE muhely.nev = 'Féktelenül Bt.' AND 
auto_azon in (SELECT azon FROM szerelo.sz_auto 
                    WHERE szin = 'piros')
GROUP BY szereles.auto_azon, muhely.azon, sysdate;

SELECT m.azon
FROM szerelo.sz_szerelomuhely m
WHERE m.nev = 'Féktelenül Bt.';

SELECT au.azon
FROM szerelo.sz_auto au
WHERE szin = 'piros';

CREATE TABLE e_szereles AS SELECT * FROM szerelo.sz_szereles where 1=0;

INSERT INTO e_szereles(auto_azon, muhely_azon, szereles_kezdete)
SELECT au.azon, m.azon, sysdate
FROM szerelo.sz_auto au, szerelo.sz_szerelomuhely m
WHERE szin = 'piros' AND 
    m.nev = 'Féktelenül Bt.';

/* A Féktelenül Bt. vezetõje ma elkezd dolgozni abba a mûhelyben ahol a legtöbb 
szerelést végeztek. Vegye fel a sort a dolgozik táblába */

-- egy része
SELECT vezeto_azon FROM szerelo.sz_szerelomuhely
                WHERE nev = 'Féktelenül Bt.';
            
-- még egy része            
SELECT MUHELY_AZON, Count(auto_azon) FROM szerelo.sz_szereles
GROUP BY muhely_azon
ORDER BY count(auto_azon) desc
FETCH FIRST ROWS WITH TIES;

-- tábla létrehozása
CREATE TABLE e_dolgozik AS SELECT * FROM szerelo.sz_dolgozik where 1=0;

-- actual insert
INSERT INTO e_dolgozik(szerelo_azon, muhely_azon, munkaviszony_kezdete)
SELECT vezeto_azon, muhely_azon, sysdate 
         FROM (SELECT vezeto_azon FROM szerelo.sz_szerelomuhely
                WHERE nev = 'Féktelenül Bt.'),
              (SELECT MUHELY_AZON, Count(auto_azon) FROM szerelo.sz_szereles
                GROUP BY muhely_azon
                ORDER BY count(auto_azon) desc
                FETCH FIRST ROWS WITH TIES);  


/* Az 5 legdrágább autót listázza*/
SELECT * FROM szerelo.sz_auto au

ORDER BY elso_vasarlasi_ar desc nulls last
FETCH FIRST 5 ROWS WITH TIES;

/* Listázza a második öt legnagyobb felértékelési értékkel rendelkezõ
autó rendszámát, színét és értékét*/

SELECT rendszam, szin, ertek
FROM szerelo.sz_autofelertekeles af
    INNER JOIN szerelo.sz_auto au
    ON af.auto_azon = au.azon
ORDER BY ertek DESC NULLS LAST
offset 5 rows fetch next 5 rows with ties;  -- OFFSET FONTOS LEHET?

/* Hozzon létre nézetet amely megmutatja, hogy az egyes autókat hányszor
szerelték. (rendszam, auto_azon) */
CREATE VIEW customView3 AS -- át kell nevezni a dolgokat
SELECT rendszam rnd, auto_azon azon , count(szereles_kezdete) db FROM szerelo.sz_szereles sz
    RIGHT OUTER JOIN szerelo.sz_auto au
    ON sz.auto_azon = au.azon
GROUP BY auto_azon, rendszam;

/* Módosítsa a szerelés táblát azon autók esetén amelyeknek 3-nál
kevesebb felértékelése volt, a szerelés vége is le van zárva.
A szerelés ára csökkenjen a legkissebb felértékelési érték 1%-ával*/
UPDATE e_szereles sz
SET munkavegzes_ara = munkavegzes_ara * (1 - 
                                            SELECT min(ertek)*0.01
                                            FROM szerelo.sz_autofelertekeles af2
                                            WHERE sz.auto_azon = af2.auto_azon)
WHERE szereles_vege is not null
AND auto_azon in (SELECT au.azon 
                    FROM szerelo.sz_auto au
                    LEFT OUTER JOIN szerelo.sz_autofelertekeles af
                    ON au.azon = af.auto_azon
                    GROUP BY au.azon
                    HAVING count(datum) > 3
                );

SELECT auto_azon FROM szerelo.sz_autofelertekeles af
RIGHT OUTER JOIN szerelo.sz_auto au
    ON af.auto_azon = au.azon
GROUP BY auto_azon
HAVING count(auto_azon) > 2;







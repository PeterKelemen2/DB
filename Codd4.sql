/*
ZH-ra:
Create, Alter table
2 Create view
Insert - Delete
Update
fetch first rows 
uni�, metszet, k�l�nbs�g
*/


/*
Sz�rja be a saj�t aut�t�pus t�bl�j�ba a szerel� s�ma aut�tipus t�bl�j�b�l
a Toyota m�rk�j� aut�kat
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


/* A piros Fiat aut�kat fel�rt�kelik a mai d�tummal.
A fel�rt�kel�s �rt�ke legyen az aut� els� v�s�rl�si �ra*/

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

/* Azokat az aut�kat amelyeknek 3-n�l t�bb tulajdonosa van
fel�rt�kelik a mai nappal. A fel�rt�kel�s �rt�ke legyen
az aut� els� v�s�rl�si �ra cs�kkentve annyi sz�zal�kkal
Ah�ny �ves az aut�. */

CREATE TABLE e_auto_tulajdonosa AS 
    SELECT * FROM szerelo.sz_auto_tulajdonosa where 1=0;

SELECT azon, sysdate, elso_vasarlasi_ar * (1- months_between (sysdate, elso_vasarlas_idopontja)/12/100)
FROM szerelo.sz_auto
WHERE azon in (
            SELECT auto_azon FROM szerelo.sz_auto_tulajdonosa
            GROUP BY auto_azon
            HAVING count(tulaj_azon) > 3);
            
/* A tiszaf�redi lakos tulaj megv�s�rolja a legnagyobb els� v�s�rl�si �r�
aut�t. A v�s�rl�s ideje legyen a mai d�tum. Vegye fel a megfelel� sort */

SELECT tu.azon FROM szerelo.sz_tulajdonos tu
WHERE cim like 'Tiszaf�red, %';

SELECT * FROM szerelo.sz_auto au
WHERE elso_vasarlasi_ar = (SELECT max(elso_vasarlasi_ar) FROM szerelo.sz_auto);

INSERT INTO e_auto_tulajdonosa (tulaj_azon, auto_azon, vasarlas_ideje)
SELECT tu.azon, au.azon, sysdate FROM szerelo.sz_tulajdonos tu, szerelo.sz_auto au
WHERE cim like 'Tiszaf�red, %' AND
elso_vasarlasi_ar = (SELECT max(elso_vasarlasi_ar) FROM szerelo.sz_auto);

/*Ugyanez, csak Toyot�val*/
INSERT INTO e_auto_tulajdonosa (tulaj_azon, auto_azon, vasarlas_ideje)
SELECT tu.azon tulaj_azon, au.azon auto_azon, sysdate FROM szerelo.sz_auto au, szerelo.sz_tulajdonos tu
WHERE tu.cim like 'Tiszaf�red, %' AND  
tipus_azon in (SELECT azon FROM szerelo.sz_autotipus
                    WHERE marka = 'Toyota'
                    )
ORDER BY elso_vasarlasi_ar desc nulls last
FETCH FIRST ROWS WITH TIES;

/* A F�ktelen�l Bt.-ben szerelik a piros aut�kat a mai d�tummal.
Vegye fel a sorokat a szerel�s t�bl�ba*/

INSERT INTO e_szereles(auto_azon, muhely_azon, szereles_kezdete)
SELECT szereles.auto_azon, muhely.azon, sysdate 
FROM szerelo.sz_szereles szereles, szerelo.sz_szerelomuhely muhely
WHERE muhely.nev = 'F�ktelen�l Bt.' AND 
auto_azon in (SELECT azon FROM szerelo.sz_auto 
                    WHERE szin = 'piros')
GROUP BY szereles.auto_azon, muhely.azon, sysdate;

SELECT m.azon
FROM szerelo.sz_szerelomuhely m
WHERE m.nev = 'F�ktelen�l Bt.';

SELECT au.azon
FROM szerelo.sz_auto au
WHERE szin = 'piros';

CREATE TABLE e_szereles AS SELECT * FROM szerelo.sz_szereles where 1=0;

INSERT INTO e_szereles(auto_azon, muhely_azon, szereles_kezdete)
SELECT au.azon, m.azon, sysdate
FROM szerelo.sz_auto au, szerelo.sz_szerelomuhely m
WHERE szin = 'piros' AND 
    m.nev = 'F�ktelen�l Bt.';

/* A F�ktelen�l Bt. vezet�je ma elkezd dolgozni abba a m�helyben ahol a legt�bb 
szerel�st v�geztek. Vegye fel a sort a dolgozik t�bl�ba */

-- egy r�sze
SELECT vezeto_azon FROM szerelo.sz_szerelomuhely
                WHERE nev = 'F�ktelen�l Bt.';
            
-- m�g egy r�sze            
SELECT MUHELY_AZON, Count(auto_azon) FROM szerelo.sz_szereles
GROUP BY muhely_azon
ORDER BY count(auto_azon) desc
FETCH FIRST ROWS WITH TIES;

-- t�bla l�trehoz�sa
CREATE TABLE e_dolgozik AS SELECT * FROM szerelo.sz_dolgozik where 1=0;

-- actual insert
INSERT INTO e_dolgozik(szerelo_azon, muhely_azon, munkaviszony_kezdete)
SELECT vezeto_azon, muhely_azon, sysdate 
         FROM (SELECT vezeto_azon FROM szerelo.sz_szerelomuhely
                WHERE nev = 'F�ktelen�l Bt.'),
              (SELECT MUHELY_AZON, Count(auto_azon) FROM szerelo.sz_szereles
                GROUP BY muhely_azon
                ORDER BY count(auto_azon) desc
                FETCH FIRST ROWS WITH TIES);  


/* Az 5 legdr�g�bb aut�t list�zza*/
SELECT * FROM szerelo.sz_auto au

ORDER BY elso_vasarlasi_ar desc nulls last
FETCH FIRST 5 ROWS WITH TIES;

/* List�zza a m�sodik �t legnagyobb fel�rt�kel�si �rt�kkel rendelkez�
aut� rendsz�m�t, sz�n�t �s �rt�k�t*/

SELECT rendszam, szin, ertek
FROM szerelo.sz_autofelertekeles af
    INNER JOIN szerelo.sz_auto au
    ON af.auto_azon = au.azon
ORDER BY ertek DESC NULLS LAST
offset 5 rows fetch next 5 rows with ties;  -- OFFSET FONTOS LEHET?

/* Hozzon l�tre n�zetet amely megmutatja, hogy az egyes aut�kat h�nyszor
szerelt�k. (rendszam, auto_azon) */
CREATE VIEW customView3 AS -- �t kell nevezni a dolgokat
SELECT rendszam rnd, auto_azon azon , count(szereles_kezdete) db FROM szerelo.sz_szereles sz
    RIGHT OUTER JOIN szerelo.sz_auto au
    ON sz.auto_azon = au.azon
GROUP BY auto_azon, rendszam;

/* M�dos�tsa a szerel�s t�bl�t azon aut�k eset�n amelyeknek 3-n�l
kevesebb fel�rt�kel�se volt, a szerel�s v�ge is le van z�rva.
A szerel�s �ra cs�kkenjen a legkissebb fel�rt�kel�si �rt�k 1%-�val*/
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







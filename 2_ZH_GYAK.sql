-- DDL és DML utasítások
/*
173. Hozzunk létre táblát szemely néven a következő oszlopokkal:
    azon: max. 5 számjegyű egész szám,
    nev: maximum 30 hosszú változó hosszúságú karaktersorozat, amelyet ki kell 
    tölteni,
    szul_dat: dátum típusú,
    irsz: pontosan 4 karakter hosszú sztring,
    cim: maximum 40 hosszú változó hosszúságú karaktersorozat,
    zsebpenz: szám, amelynek maximum 12 számjegye lehet, amelyből az utolsó 
    kettő a tizedesvessző után áll.
  A tábla elsődleges kulcsa az azon oszlop legyen. A nev, szul_dat, cim együtt 
  legyen egyedi. A zsebpenz, ha ki van töltve, legyen nagyobb, mint 100.
*/
DROP TABLE szemely purge;
DROP TABLE bicikli purge;

CREATE TABLE szemely(
    azon number(5),
    nev varchar2(30) constraint sz_n not null,
    szul_dat date,
    irsz char(4),
    cim varchar2(40),
    zsebpenz number(12,2),
    constraint sz_b_pk primary key(azon),
    constraint sz_b_n unique(nev),
    constraint sz_b_szul unique(szul_dat),
    constraint sz_b_c unique(cim),
    constraint sz_b_zs check(zsebpenz > 100)
);

/* 174. Szúrjunk be a szemely táblába három sort.
*/

INSERT INTO szemely(
azon, -- number(5)
nev, -- varchar2(30)
szul_dat , -- date 
irsz, -- char(4) 
cim, -- varchar2(40)
zsebpenz -- number(12,2)
)
    VALUES
(
12345,
'Peti', 
to_date('2001.01.06', 'yyyy.mm.dd'), 
'1234', 
'Itt lakik Peti', 
3405.12
);
COMMIT;

INSERT INTO szemely(
azon, -- number(5)
nev, -- varchar2(30)
szul_dat , -- date 
irsz, -- char(4) 
cim, -- varchar2(40)
zsebpenz -- number(12,2)
)
    VALUES
(
4567,
'Attila', 
to_date('2001.04.16', 'yyyy.mm.dd'), 
'5874', 
'Itt lakik Attila', 
3455.13
);

INSERT INTO szemely(
azon, nev, szul_dat, irsz, cim, zsebpenz)
    VALUES
(63672, 'Béla', to_date('1999.03.22', 'yyyy.mm.dd'), 
'4786', 'Itt lakik Béla', 45825.13);

select * from szemely;

/*175. Hozzunk létre táblát bicikli néven a következő oszlopokkal:
    azon: max. 5 számjegyű egész szám,
    szin: maximum 20 hosszú változó hosszúságú karaktersorozat,
    tulaj_azon: max. 5 számjegyű egész szám.
  A tábla elsődleges kulcsa az azon oszlop legyen. A tulaj_azon hivatkozzon a 
  személy tábla elsődleges kulcsára.
*/

CREATE TABLE bicikli (
    azon number(5),
    szin varchar2(20),
    tulaj_azon number(5),
    constraint bic_pk primary key(azon),
    constraint bic_tul_az foreign key(tulaj_azon)
        references szemely(azon)
);

/*176. Szúrjunk be három sort a bicikli táblába!*/

INSERT INTO bicikli(azon, szin, tulaj_azon) VALUES
(15625, 'KÉK', 12345);

INSERT INTO bicikli(azon, szin) VALUES
(35525, 'KÉK');

INSERT INTO bicikli(azon, szin) VALUES
(74565, 'piros');

INSERT INTO bicikli (azon, szin) VALUES
(200, 'sárga');

commit;

SELECT * FROM BICIKLI;

/*177. Listázzuk ki a személyek biciklijeit. A lista tartalmazza azokat a 
személyeket is, akiknek nincs biciklijük, és azokat a bicikliket is, amelyeknek 
nincs tulajdonosuk.
*/

SELECT * FROM szemely RIGHT OUTER JOIN bicikli
    ON szemely.azon = bicikli.tulaj_azon;

/*178. Hozzunk létre táblát eldobom néven egy nev nevű oszloppal, amely maximum 
30 hosszú változó hosszúságú karaktersorozat típusú.
*/
CREATE TABLE eldobom(
    egy varchar2(30)
);

/*179. Dobjuk el az eldobom táblát!
*/
DROP TABLE eldobom;

/*180. Töröljük a piros színű bicikliket!
*/
DELETE FROM bicikli
    WHERE szin = 'piros';
    
SELECT * FROM bicikli;

/*181. Módosítsuk a bicikli tábla szín oszlopában lévő értéket: fűzzünk hozzá 
egy '2'-es karaktert, annál a sornál, ahol az azon értéke 200!
*/
commit;

UPDATE bicikli
SET 
    szin = concat(szin, '2')
WHERE 
    azon = 200;

/*182. Adjuk a bicikli táblához új oszlopot tipus névvel és maximum 30 hosszú 
változó hosszúságú karaktersorozattal.
*/
ALTER TABLE bicikli
ADD tipus varchar2(30);

/*183. Dobjuk el a bicikli tábla tipus oszlopát!
*/
ALTER TABLE bicikli
DROP COLUMN tipus;

/*184. Nevezzük át a bicikli tábla tulaj_azon oszlopát t_azon-ra.
*/
ALTER TABLE bicikli
RENAME COLUMN tulaj_azon to t_azon;

/*185. Módosítsuk a bicikli tábla szín oszlopának típusát varchar2(30)-ra!
*/
ALTER TABLE bicikli
MODIFY szin varchar2(30);

/*186. Nevezzük át a személy tábla cs_ch nevű megszorítását sz_ck-ra!
*/
ALTER TABLE szemely
RENAME CONSTRAINT sz_b_zs to sz_zsebpenz;
-- RENAME CONSTRAINT cs_ch to sz_ck;

/*187. Nevezzük át a személy táblát szemely2-re.
*/
COMMIT;
RENAME szemely to szemely2;
RENAME szemely2 to szemely;

/*188. Dobjuk el a sz_uq nevű megszorítást a személy2 tábláról.
*/
ALTER TABLE szemely2
DROP CONSTRAINT sz_uq;

/*189. Adjunk megszorítást a személy2 táblához: a név, születési dátum és a cím 
együtt legyen egyedi.
*/
ALTER TABLE szemely2
ADD CONSTRAINT nev_szul_cim_u UNIQUE (nev, szul_dat, cim);

/*190. Dobjuk el a bicikli tábla elsődleges kulcsát!
*/
ALTER TABLE bicikli
DROP CONSTRAINT bic_pk;

/*191. Legyen az azon oszlop a bicikli tábla elsődleges kulcsa!
*/
ALTER TABLE bicikli
ADD CONSTRAINT bic_azon_pk PRIMARY KEY(azon);

/*192. Hozzunk létre táblát, amely azt tartalmazza, hogy melyik szerző milyen 
című könyveket írt. A tábla tartalmazza a könyvek oldalankénti árát is.
*/
CREATE TABLE szerzo_custom AS 
    SELECT sz.vezeteknev || ' ' || sz.keresztnev szerzo_nev,
    k.cim konyv_cim, k.ar/k.oldalszam oldalankenti_ar        
    FROM konyvtar.konyv k LEFT OUTER JOIN
    konyvtar.konyvszerzo ksz
        ON k.konyv_azon = ksz.konyv_azon
        INNER JOIN konyvtar.szerzo sz
            ON ksz.szerzo_azon = sz.szerzo_azon;

SELECT * FROM szerzo_custom;
COMMIT;

/*193. Hozzunk létre nézetet v_szerzo_konyv néven, amelyben azt listázzuk, hogy 
az egyes könyveknek kik a szerzői. A lista csak azokat a könyveket tartalmazza, 
amelyeknek van szerzője. A lista tartalmazza a könyvek oldalankénti árát is.
*/

/*194. Hozzunk létre nézete, amely a horror, sci-fi, krimi témájú könyvek címét,
leltári számát és oldalankénti árát listázza.
*/

/*195. Hozzunk létre nézetet legidosebb_szerzo néven, amely a legidősebb szerző 
nevét és születési dátumát listázza.
*/

-- DML utasítások
/*196. Vegyünk fel a könyvszerző táblába egy sort: Agatha Christie megírta a 
legdrágább könyvet, amiért 5000 ft honoráriumot kapott.
*/

/*197. Növeljük meg azon szerzők honoráriumát az általuk írt könyv árának a 
10-szeresével, akik 1900 után születtek.
*/

/*198. Töröljük azokat a könyveket, amelyekhez nincs példány.
*/

/*199. Töröljük azokat a konyvtari_konyveket, amelyeket nem kölcsönöztek ki.
*/

/*200. Azokhoz könyvekhez kapcsolódó honoráriumot növeljük meg 10%-kal, 
amelyeknek az oldalankénti ára több, mint 20.
*/

/*201. Növeljük meg a honoráriumot a könyv árának a felével azon írások esetén, 
ahol a szerző 1900 után születtek és a könyv kiadójának a nevében szerepel 
a KIADÓ szó.
*/

/*202. Növeljük meg azon könyvtári könyvek értékét 10%-kal, amelyeket 2000 után 
kölcsönözték ki, és amelyeknek a címében pontosan 2 db 'a' betű (mindegy, 
hogy kicsi vagy nagy) szerepel.
*/

/*203. Agatha Christie által írt összes könyvből vegyünk fel egy-egy új példányt 
a könyvtári könyv táblába. A példányok értéke egyezzen meg a könyvek árával. 
A könyvek leltári számát generáljuk a szerző monogramjából, 
a könyv_azonosítójából és a mai dátumból.
*/

/*204. Módosítsuk azoknak a könyvtári könyveknek az értékét, amelyeknek az 
értéke nagyobb, mint a hozzátartozó könyv árának a fele. Az eredeti értéket 
csökkentsük azzal az értékkel, amelyet úgy számolunk ki, hogy a könyv árát 
elosztjuk a kiadás dátuma óta eltelt évek számával.
*/

/*205. Módosítsuk azon tagok beiratkozási dátumát, akiknek a beiratkozási dátuma
későbbre esik, mint a legelső kölcsönzési dátuma. Az új beiratkozási dátuma 
legyen a legelső kölcsönzési dátuma.
*/

/*206. Módosítsuk a könyvszerző táblát: az 1900 után született szerzők és azon 
könyvek esetén, amelyek ára több, mint 5000 növeljük meg a honorariumot a könyv
árának a 70%-ával.
*/

/*207. Töröljük azokat a kölcsönzéseket, amelyben horror, sci-fi, vagy krimi 
témájú könyveket olyan női olvasók kölcsönöztek, akik Debrecenben laknak.
*/

/*208. Töröljük azokat a könyszerzőbeli sorokat, amelyek esetén a honorárium 
kisebb, mint a hozzá kapcsolódó könyv árának a 10-szerese.
*/

/*209. Töröljük azokat a könyveket, amelyekhez nem tartozik konyvszerzo, és 
nem tartozik konyvtari_konyv, és 5000-nél olcsóbbak vagy nincs áruk.
*/

/*210. A legidősebb tag ma kikölcsönözte a Napóleon című könyvhöz tartozó 
legdrágább példányt (mivel két Napóleon van, ezért mindkettőhöz egy-egy 
példányt). Vegyük fel a megfelelő sort a kölcsönzés táblába.
*/

/*211. A 2000 után kiadott könyvek árát növeljük a duplájára, az oldalszámát 
felezzük el.
*/

/*212. Módosítsuk a kölcsönzés táblát a diákok esetén: a visszahozási dátum 
legyen kölcsönzési dátum megnövelve annyi nappal ahány évesek, a késedelmi 
díjat növeljük a könyv értékének a felével (ha null érték volt, akkor könyv 
értékének a fele legyen)!
*/

/*213. Móra Ferenc megírja az a könyvet, amelyikhez a legtöbb példány van. 
Szúrjunk be ennek megfelelően egy sort a könyvszerző táblába.
*/
SELECT ar,oldalszam, ar/oldalszam "Ár per oldalszám", ar*10  "Tizszeres ár", 5*5, cim FROM konyvtar.konyv;

SELECT 5*5, sin(0), cos(0), (45*13+2)/25 FROM dual;

SELECT * FROM konyvtar.konyv 
    ORDER BY kiado asc, tema desc, ar desc ;
    
SELECT * FROM konyvtar.konyv
    ORDER BY cim;
    
SELECT * FROM konyvtar.konyv
    ORDER BY ar nulls first;

SELECT * FROM konyvtar.konyv
    ORDER BY ar desc nulls last, cim;
    
SELECT * FROM konyvtar.konyv
WHERE ar <= 5000
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE ar >= 5000 AND ar <= 10000;

SELECT * FROM konyvtar.konyv
WHERE ar between 5000 and 10000;

SELECT * FROM konyvtar.konyv
WHERE ar <= 5000 OR tema='történelem'
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE not(ar <= 5000 OR tema='történelem')
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE ar not between 5000 and 10000;

SELECT * FROM konyvtar.konyv
WHERE tema='történelem' OR tema ='informatika' OR tema='mesekönyv'
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE tema in ('történelem','informatika','mesekönyv')
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE tema not in ('történelem','informatika','mesekönyv')
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE tema is null
ORDER BY cim;

SELECT * FROM konyvtar.konyv
WHERE tema is not null
ORDER BY cim;

SELECT * FROM konyvtar.konyv
WHERE cim='Napóleon';

SELECT * FROM konyvtar.konyv
WHERE cim like 'N%';

SELECT * FROM konyvtar.konyv
WHERE cim not like 'N%';

SELECT * FROM konyvtar.konyv
WHERE cim like '_a%';

SELECT * FROM konyvtar.konyv
WHERE cim like '%A%' AND cim not like '%a%';

SELECT cim, upper(cim), lower(cim) FROM konyvtar.konyv;

SELECT * FROM konyvtar.konyv
WHERE lower(cim) like '%a%';

/*
Keressük azokat a nyugdijas, diák és gyerek tagokat, akiknek a kresztnevében
szerepel egy 'e' betû, mindegy hogy kicsi vagy nagy
a lista legyen "nem" azon belül név szerint csökkenõen rendezett
*/

SELECT nem, vezeteknev, keresztnev, besorolas from konyvtar.tag
WHERE besorolas in('diák','nyugdíjas','gyerek') AND LOWER(keresztnev) like '%e%'
ORDER BY nem, vezeteknev desc, keresztnev desc;

SELECT nem, vezeteknev||' '||keresztnev "nev", besorolas from konyvtar.tag
WHERE besorolas in('diák','nyugdíjas','gyerek') AND LOWER(keresztnev) like '%e%'
ORDER BY nem, vezeteknev desc,keresztnev desc;

/*
A debreceni tagok nevét és címét listázzuk 
A lista legyen név szerint rendezett
*/

SELECT vezeteknev||' '||keresztnev nev, cim FROM konyvtar.tag
WHERE cim like '____ Debrecen%'
ORDER BY vezeteknev,keresztnev;

SELECT ar/oldalszam, round(ar/oldalszam, 2), trunc(ar/oldalszam, 2)
FROM konyvtar.konyv;

SELECT ar, round(ar, -2), trunc(ar, -2)
FROM konyvtar.konyv;

SELECT ar/oldalszam, floor(ar/oldalszam), floor(-ar/oldalszam)
FROM konyvtar.konyv;

SELECT chr(), ascii('') FROM dual;

SELECT length(cim), cim FROM konyvtar.konyv;

SELECT instr(lower(cim), 'a', 3, 2), cim
FROM konyvtar.konyv;

SELECT concat(vezeteknev, keresztnev), vezeteknev || ' ' || keresztnev
FROM konyvtar.tag;

SELECT initcap(cim)
FROM konyvtar.tag;

SELECT cim, replace(lower(cim), 'an', '*****')
FROM konyvtar.konyv;

SELECT lower(cim), upper(cim)
FROM konyvtar.konyv;

SELECT cim, substr(cim, 5, 4), substr(cim, -5, 4)
FROM konyvtar.konyv;

SELECT greatest(30,20,1,5,3), least (30,20,1,-5) FROM dual;

SELECT * FROM konyvtar.konyv
WHERE to_char(ar) = '2090';

SELECT ar, nvl(ar,1000000), nvl(to_char(ar),'****')
FROM konyvtar.konyv;

SELECT tema, decode(tema, 'krimi', 'K', 'sci-fi', 'S', 'horror', 'H', '?')
FROM konyvtar.konyv;

SELECT user from dual;

SELECT sysdate FROM dual;

SELECT to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss year/syyyy') FROM dual;

SELECT to_char(szuletesi_datum, 'mm Mon MON month Month MONTH')
FROM konyvtar.szerzo;

SELECT to_char(szuletesi_datum, 'd dd ddd')
FROM konyvtar.szerzo;

SELECT to_char(sysdate, 'dy Dy DY, day Day DAY')
FROM dual;

SELECT to_char(sysdate, 'w ww q')
FROM konyvtar.konyv;

SELECT to_char(sysdate, 'hh24 hh')
FROM dual;

SELECT to_char(sysdate, 'sssss')
FROM dual;

SELECT to_date('2001.01.01 03:45:23', 'yyyy.mm.dd hh24:mi:ss') FROM dual;

SELECT to_date('85', 'yy') FROM dual;
SELECT to_char(to_date('85', 'yy') , 'yyyy') FROM dual; 

SELECT to_char(sysdate+7, 'yyyy.mm.dd hh24:mi:ss') FROM dual;

SELECT to_char(add_months(sysdate,1), 'yyyy.mm.dd hh24:mi:ss') FROM dual;

SELECT to_char(add_months(sysdate,12), 'yyyy.mm.dd hh24:mi:ss') FROM dual;

SELECT to_char(sysdate +1/24, 'yyyy.mm.dd hh24:mi:ss') FROM dual;

SELECT sysdate-to_date('2001.01.06', 'yyyy.mm.dd') FROM dual; -- napok

SELECT months_between(sysdate, to_date('2001.01.06', 'yyyy.mm.dd')) FROM dual; -- hónapos

SELECT months_between(sysdate, to_date('2001.01.06', 'yyyy.mm.dd'))/12 FROM dual; -- éves

SELECT last_day(sysdate) FROM dual;

SELECT to_char(round(sysdate), 'yyyy.mm.dd hh24:mi:ss'),
to_char(trunc(sysdate), 'yyyy.mm.dd hh24:mi:ss')
FROM dual;

SELECT to_char(round(sysdate, 'yyyy'),  'yyyy.mm.dd hh24:mi:ss'),
to_char(trunc(sysdate, 'yyyy'), 'yyyy.mm.dd hh24:mi:ss')
FROM dual;

SELECT extract (year from sysdate), 
extract (month from sysdate), 
extract (day from sysdate) 
FROM dual;

/*
Listázza ki a 100 évnél idõsebb szerzõk nevét (egyben), életkorát, születési dátumát
A lista legyen életkor szerint csökkenõen rendezett;
*/
SELECT 
vezeteknev || ' ' || keresztnev "Név", 
to_char(szuletesi_datum, 'yyyy.mm.dd hh24:mi:ss') "Születési dátum", 
months_between(sysdate, szuletesi_datum)/12 eletkor
    FROM konyvtar.szerzo
    WHERE months_between(sysdate, szuletesi_datum)/12 > 100
    ORDER BY eletkor desc;
    
/*
A szerdán vagy márciusban született szerzõk nevét és születési dátumár listázzuk
A lista legyen hónap, azon belül név szerint rendezett
*/

SELECT 
    vezeteknev || ' ' || keresztnev nev,
    to_char(szuletesi_datum, 'yyyy.mm.dd hh24:mi:ss, day') szul_dat
    FROM konyvtar.szerzo
        WHERE to_char(szuletesi_datum, 'mm') ='03'
        or to_char(szuletesi_datum, 'dy') = 'sze'
            ORDER BY to_char(szuletesi_datum, 'mm'), nev;
            
 -- JOIN
            
SELECT * FROM hr.employees emp, hr.departments dept
    WHERE emp.department_id = dept.department_id;
    
SELECT * FROM hr.employees emp INNER JOIN hr.departments dept
    ON emp.department_id= dept.department_id;
    
SELECT * FROM hr.employees emp INNER JOIN hr.departments dept
    USING (department_id);
    
SELECT * FROM hr.employees NATURAL JOIN hr.jobs; -- ne használjuk

SELECT * FROM hr.employees emp LEFT OUTER JOIN hr.departments dept 
    ON emp.department_id = dept.department_id;
    
SELECT * FROM hr.employees emp RIGHT OUTER JOIN hr.departments dept 
    ON emp.department_id = dept.department_id;

SELECT * FROM hr.employees emp FULL OUTER JOIN hr.departments dept 
    ON emp.department_id = dept.department_id;


/*
Listázza ki a Suzuki márkájú autók rendszámát
A lista legyen szín, azon belûl rendszám szerint csökkenõen rendezve
*/

SELECT * FROM szerelo.sz_autotipus atip INNER JOIN szerelo.sz_auto auto
    ON atip.azon = auto.tipus_azon
    WHERE marka = 'Suzuki'
    ORDER BY szin, rendszam desc;
    
SELECT rendszam, atip.megnevezes, szin, auto.azon 
FROM szerelo.sz_autotipus atip INNER JOIN szerelo.sz_auto auto
    ON atip.azon = auto.tipus_azon
    WHERE marka = 'Suzuki'
    ORDER BY szin, rendszam desc;
    
/*
Bekõ Antal melyik szerelõmûhelynek a fõnöke
*/

SELECT szm.nev, szm.azon FROM szerelo.sz_szerelomuhely szm INNER JOIN szerelo.sz_szerelo sz
    ON szm.vezeto_azon = sz.azon
    WHERE sz.nev = 'Bekõ Antal';
    
/*
Listázza ki az összes autót és ha van típusa, akkor tegye mellé
az összes piros autót
*/

SELECT au.azon, au.rendszam, au.szin, ati.megnevezes, ati.azon 
FROM szerelo.sz_auto au LEFT OUTER JOIN szerelo.sz_autotipus ati
    ON au.tipus_azon = ati.azon
    WHERE szin = 'piros';
    

--Bekõ Tóni mûhelyében mely szerelõk dolgoznak

SELECT distinct sz.azon, sz.nev
    --to_char(d.munkaviszony_kezdete, 'yyyy.mm.dd hh24:mi:ss'), 
    --to_char(d.munkaviszony_vege, 'yyyy.mm.dd hh24:mi:ss')
FROM szerelo.sz_szerelo sz INNER JOIN szerelo.sz_dolgozik d
    ON sz.azon = d.szerelo_azon
        INNER JOIN szerelo.sz_szerelomuhely m ON d.muhely_azon = m.azon
    WHERE m.nev like 'Bekõ Tóni%';
    
/*
Listázza ki az összes szerelõt és azt, hogy melyik mûhelyben
dolgoztak vagy dolgoznak
Listázza ki a munkaviszony kezdetét és végét is
*/

SELECT sz.azon, sz.nev, to_char(d.munkaviszony_kezdete, 'yyyy.mm.dd hh24:mi:ss') kezd, 
    to_char(d.munkaviszony_vege, 'yyyy.mm.dd hh24:mi:ss') veg,
    m.azon, m.nev muhely
    FROM szerelo.sz_szerelo sz LEFT OUTER JOIN szerelo.sz_dolgozik d
    ON sz.azon = d.szerelo_azon
        LEFT OUTER JOIN szerelo.sz_szerelomuhely m ON d.muhely_azon = m.azon;
        
/*
A "Féktelenül Bt." szerelõmûhelyben mely autókat szerelték és mikor?
A lista legyen rendezett autó rendzsáma alapján
Ha a szerelésnek nincs vége a mai dátummal számoljon
*/

SELECT auto FROM szerelo.sz_szereles sz LEFT OUTER JOIN szerelo.sz_szerelomuhely m
    ON sz.muhely_azon = m.azon
    LEFT OUTER JOIN szerelo.sz_auto au
        ON sz.auto_azon = au.tipus_azon
    WHERE m.nev = 'Féktelenül Bt.';
    
SELECT au.azon, au.rendszam,
to_char(sz.szereles_kezdete, 'yyyy.mm.dd hh24:mi:ss') kezd,
to_char(sz.szereles_vege, 'yyyy.mm.dd hh24:mi:ss') veg,
nvl(sz.szereles_vege, sysdate) - sz.szereles_kezdete hossz
FROM szerelo.sz_auto au INNER JOIN szerelo.sz_szereles sz
    ON au.azon = sz.auto_azon
        INNER JOIN szerelo.sz_szerelomuhely szm
        ON sz.muhely_azon = szm.azon
    WHERE szm.nev = 'Féktelenül Bt.' 
    ORDER BY hossz;
    
/*
Listázza a fekete, piros vagy kék színû autók rendszámát
és tulajdonosát (ha van) a címével és városával, de csak azon tulajdonosságok esetén, amelyek 
2000 és 2021 között kezdõdtek.
A lista legyen rendszám, azon belül a tulajdonolás kezdete szerint csökkenõen rendezve.
*/

SELECT * FROM szerelo.sz_auto au LEFT OUTER JOIN szerelo.sz_auto_tulajdonosa autul
    ON au.tipus_azon = autul.auto_azon
        LEFT OUTER JOIN szerelo.sz_tulajdonos tul
        ON autul.tulaj_azon = tul.azon
    WHERE to_char(autul.vasarlas_ideje, 'yyyy') BETWEEN 2000 AND 2005;
    
    /*
select * FROM szerelo.sz_auto_tulajdonosa
    WHERE szerelo.vasarlas_ideje BETWEEN 
        to_date('1999.12.31 23:59:59', 'yyyy.mm.dd hh24:mi:ss') and 
        to_date('2020.12.31 23:59:59', 'yyyy.mm.dd hh24:mi:ss')
    */
    
SELECT max(ar), min(ar), avg(ar), sum(ar), 
       count(*), count(konyv_azon), count(ar),
       sum(ar) / count(*), sum(ar) / count(ar)
       FROM konyvtar.konyv;
       
SELECT tema, ar, cim, konyv_azon FROM konyvtar.konyv
    ORDER BY tema;
   
SELECT tema, min(ar), sum(ar), avg(ar),
       count(konyv_azon), count(*) FROM konyvtar.konyv
    GROUP BY tema; 
    
/*
Melyek azok a témák, amelyekhez tartozó átlagár kevesebb, mint 2000
*/
SELECT tema, avg(ar) FROM konyvtar.konyv
    GROUP BY tema
        HAVING avg(ar) < 2000;

/* Az egyes könyvekhez hány példány tartozik*/
SELECT konyv_azon, count(leltari_szam) FROM konyvtar.konyvtari_konyv
    GROUP BY konyv_azon;
    
/* Az egyes könyvekhez (cim) hány példány tartozik? */

SELECT cim, count(kk.leltari_szam) FROM konyvtar.konyv ko LEFT OUTER JOIN konyvtar.konyvtari_konyv kk 
/* LEFT OUTER JOIN konyv-bõl minden, konyvtari_konyv-bõl nem */
    ON kk.konyv_azon = ko.konyv_azon
    GROUP BY cim, ko.konyv_azon;
    
/* Az egyes szerzõk(vezetéknév, keresztnév, szül.dát.) hány könyvet írtak? */
SELECT sz.vezeteknev ||' ' || sz.keresztnev nev, count(konyv_azon), to_date(sz.szuletesi_datum, 'yyyy.mm.dd hh24:mi:ss') 
FROM konyvtar.szerzo sz LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON sz.szerzo_azon = ksz.szerzo_azon
    GROUP BY sz.szerzo_azon, vezeteknev, keresztnev, to_date(sz.szuletesi_datum, 'yyyy.mm.dd hh24:mi:ss');
    
/* 
Lisázzuk azokat a könyveket, melyeknek 3-nál több szerzõje van. 
A lista legyen szerzõk száma szerint csökkenõen rendezve 
*/  
SELECT ko.konyv_azon, cim, count(szerzo_azon) db FROM konyvtar.konyv ko LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON ko.konyv_azon = ksz.konyv_azon
    GROUP BY ko.konyv_azon, cim
    HAVING count(3)>3
    ORDER BY db desc;
    
/* Listázzuk a tagokat, akik az elmúlt 3 évben legalább 1 könyvet kölcsönöztek */
    /*Enyém:*/
SELECT tag_azon, count(tag_azon), to_char(kolcsonzesi_datum, 'yyyy.mm.dd hh24:mi:ss') FROM konyvtar.kolcsonzes k INNER JOIN konyvtar.tag t
    ON k.tag_azon = t.olvasojegyszam
    WHERE months_between (sysdate, kolcsonzesi_datum)/12 < 2
    GROUP BY tag_azon, kolcsonzesi_datum;
    
    /*Megoldás:*/
SELECT t.olvasojegyszam, vezeteknev, keresztnev, count(leltari_szam) 
    FROM konyvtar.tag t INNER JOIN konyvtar.kolcsonzes k
    ON k.tag_azon = t.olvasojegyszam
    WHERE months_between(sysdate, kolcsonzesi_datum)/12 < 2
    GROUP BY t.olvasojegyszam, vezeteknev, keresztnev
    HAVING COUNT(leltari_szam) >=2
    ORDER BY vezeteknev, keresztnev;
    
/* az egyes besorolások esetén mennyi tag van és mennyi össztagdíjat fizetnek */
SELECT besorolas, count(*), sum(tagdij)
    FROM konyvtar.tag
    GROUP BY besorolas;
    
/* Mely hónapban született 3-nál több szerzõ. A lista legyen hónapok szerint rendezett*/
SELECT to_char(szuletesi_datum, 'mm-month') ho 
FROM konyvtar.szerzo
    GROUP BY to_char(szuletesi_datum, 'mm-month')
    HAVING count(*)>3
    ORDER BY ho;
    
/* Melyek azok a szerzõk, akik 10.000-nél több összhonoráriumot kaptak */
SELECT vezeteknev || ' ' || keresztnev nev, sum(honorarium) 
FROM konyvtar.szerzo sz LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON sz.szerzo_azon = ksz.szerzo_azon
    GROUP BY sz.szerzo_azon, vezeteknev, keresztnev
    HAVING sum(honorarium) > 10000
    ORDER BY sum(honorarium) desc;
    
/* Melyek azok a szerzõk, akik 10.000-nél kevesebb összhonoráriumot kaptak */
SELECT vezeteknev || ' ' || keresztnev nev, sum(honorarium) 
FROM konyvtar.szerzo sz LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON sz.szerzo_azon = ksz.szerzo_azon
    GROUP BY sz.szerzo_azon, vezeteknev, keresztnev
    HAVING sum(honorarium) < 10000
    ORDER BY sum(honorarium) desc;
    
/* Az egyes szerzõk hány különbözõ témában írtak könyvet (ha null is) */
-- count(distinct tema)
SELECT vezeteknev, keresztnev, count(distinct tema) 
FROM konyvtar.szerzo sz LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON sz.szerzo_azon = ksz.szerzo_azon
        LEFT OUTER JOIN konyvtar.konyv ko
            ON ksz.konyv_azon = ko.konyv_azon
    GROUP BY sz.szerzo_azon, vezeteknev, keresztnev
    ORDER BY count(distinct tema) desc;
    
/* Hány könyv tartozik ahhoz a témához, amelyhez a legtöbb könyv tartozik */
SELECT tema, count(*)
FROM konyvtari_konyv
GROUP by tema;

/* Kik azok a szerzõk, akik nevében *pontosan* 2 'a' betû szerepel, 
mindegy hogy kicsi, vagy nagy */
SELECT vezeteknev  ||' '|| keresztnev FROM konyvtar.szerzo
    WHERE lower(vezeteknev  ||' '|| keresztnev) like '%a%a%' AND 
    lower(vezeteknev  ||' '|| keresztnev) not like '%a%a%a%';
    
/* Ki Pat Fay fõnöke? */
SELECT fonok.first_name, fonok.last_name FROM hr. employees pf INNER JOIN hr.employees fonok
    on pf.manager_id = fonok.employee_id
WHERE pf.first_name = 'Pat' AND pf.last_name = 'Fay';

/* Melyek azok a példányok, melyek értéke több, mint a hozzájuk tartozó könyv árának a 99%-a */
SELECT ko.konyv_azon, ko.cim, ertek FROM konyvtar.konyvtari_konyv kko INNER JOIN konyvtar.konyv ko
    ON ko.konyv_azon = kko.konyv_azon
    WHERE ertek > ar*0.99
    GROUP BY ko.cim, ko.konyv_azon, ertek
    ORDER BY ertek desc;
    
/* Listázza ki az Agatha Christie-tõl idõsebb szerzõket */
SELECT * FROM konyvtar.szerzo
    WHERE to_char(szuletesti_datum, 'yyyy.mm.dd'); --?
    
SELECT * FROM konyvtar.szerzo ach INNER JOIN konyvtar.szerzo sz
    ON ach.szuletesi_datum > sz.szuletesi_datum
WHERE sz.vezeteknev = 'Christie' AND sz.keresztnev = 'Agatha';


    
    
    
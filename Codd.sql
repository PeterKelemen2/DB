SELECT ar,oldalszam, ar/oldalszam "�r per oldalsz�m", ar*10  "Tizszeres �r", 5*5, cim FROM konyvtar.konyv;

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
WHERE ar <= 5000 OR tema='t�rt�nelem'
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE not(ar <= 5000 OR tema='t�rt�nelem')
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE ar not between 5000 and 10000;

SELECT * FROM konyvtar.konyv
WHERE tema='t�rt�nelem' OR tema ='informatika' OR tema='mesek�nyv'
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE tema in ('t�rt�nelem','informatika','mesek�nyv')
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE tema not in ('t�rt�nelem','informatika','mesek�nyv')
ORDER BY ar desc;

SELECT * FROM konyvtar.konyv
WHERE tema is null
ORDER BY cim;

SELECT * FROM konyvtar.konyv
WHERE tema is not null
ORDER BY cim;

SELECT * FROM konyvtar.konyv
WHERE cim='Nap�leon';

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
Keress�k azokat a nyugdijas, di�k �s gyerek tagokat, akiknek a kresztnev�ben
szerepel egy 'e' bet�, mindegy hogy kicsi vagy nagy
a lista legyen "nem" azon bel�l n�v szerint cs�kken�en rendezett
*/

SELECT nem, vezeteknev, keresztnev, besorolas from konyvtar.tag
WHERE besorolas in('di�k','nyugd�jas','gyerek') AND LOWER(keresztnev) like '%e%'
ORDER BY nem, vezeteknev desc, keresztnev desc;

SELECT nem, vezeteknev||' '||keresztnev "nev", besorolas from konyvtar.tag
WHERE besorolas in('di�k','nyugd�jas','gyerek') AND LOWER(keresztnev) like '%e%'
ORDER BY nem, vezeteknev desc,keresztnev desc;

/*
A debreceni tagok nev�t �s c�m�t list�zzuk 
A lista legyen n�v szerint rendezett
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

SELECT months_between(sysdate, to_date('2001.01.06', 'yyyy.mm.dd')) FROM dual; -- h�napos

SELECT months_between(sysdate, to_date('2001.01.06', 'yyyy.mm.dd'))/12 FROM dual; -- �ves

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
List�zza ki a 100 �vn�l id�sebb szerz�k nev�t (egyben), �letkor�t, sz�let�si d�tum�t
A lista legyen �letkor szerint cs�kken�en rendezett;
*/
SELECT 
vezeteknev || ' ' || keresztnev "N�v", 
to_char(szuletesi_datum, 'yyyy.mm.dd hh24:mi:ss') "Sz�let�si d�tum", 
months_between(sysdate, szuletesi_datum)/12 eletkor
    FROM konyvtar.szerzo
    WHERE months_between(sysdate, szuletesi_datum)/12 > 100
    ORDER BY eletkor desc;
    
/*
A szerd�n vagy m�rciusban sz�letett szerz�k nev�t �s sz�let�si d�tum�r list�zzuk
A lista legyen h�nap, azon bel�l n�v szerint rendezett
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
    
SELECT * FROM hr.employees NATURAL JOIN hr.jobs; -- ne haszn�ljuk

SELECT * FROM hr.employees emp LEFT OUTER JOIN hr.departments dept 
    ON emp.department_id = dept.department_id;
    
SELECT * FROM hr.employees emp RIGHT OUTER JOIN hr.departments dept 
    ON emp.department_id = dept.department_id;

SELECT * FROM hr.employees emp FULL OUTER JOIN hr.departments dept 
    ON emp.department_id = dept.department_id;


/*
List�zza ki a Suzuki m�rk�j� aut�k rendsz�m�t
A lista legyen sz�n, azon bel�l rendsz�m szerint cs�kken�en rendezve
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
Bek� Antal melyik szerel�m�helynek a f�n�ke
*/

SELECT szm.nev, szm.azon FROM szerelo.sz_szerelomuhely szm INNER JOIN szerelo.sz_szerelo sz
    ON szm.vezeto_azon = sz.azon
    WHERE sz.nev = 'Bek� Antal';
    
/*
List�zza ki az �sszes aut�t �s ha van t�pusa, akkor tegye mell�
az �sszes piros aut�t
*/

SELECT au.azon, au.rendszam, au.szin, ati.megnevezes, ati.azon 
FROM szerelo.sz_auto au LEFT OUTER JOIN szerelo.sz_autotipus ati
    ON au.tipus_azon = ati.azon
    WHERE szin = 'piros';
    

--Bek� T�ni m�hely�ben mely szerel�k dolgoznak

SELECT distinct sz.azon, sz.nev
    --to_char(d.munkaviszony_kezdete, 'yyyy.mm.dd hh24:mi:ss'), 
    --to_char(d.munkaviszony_vege, 'yyyy.mm.dd hh24:mi:ss')
FROM szerelo.sz_szerelo sz INNER JOIN szerelo.sz_dolgozik d
    ON sz.azon = d.szerelo_azon
        INNER JOIN szerelo.sz_szerelomuhely m ON d.muhely_azon = m.azon
    WHERE m.nev like 'Bek� T�ni%';
    
/*
List�zza ki az �sszes szerel�t �s azt, hogy melyik m�helyben
dolgoztak vagy dolgoznak
List�zza ki a munkaviszony kezdet�t �s v�g�t is
*/

SELECT sz.azon, sz.nev, to_char(d.munkaviszony_kezdete, 'yyyy.mm.dd hh24:mi:ss') kezd, 
    to_char(d.munkaviszony_vege, 'yyyy.mm.dd hh24:mi:ss') veg,
    m.azon, m.nev muhely
    FROM szerelo.sz_szerelo sz LEFT OUTER JOIN szerelo.sz_dolgozik d
    ON sz.azon = d.szerelo_azon
        LEFT OUTER JOIN szerelo.sz_szerelomuhely m ON d.muhely_azon = m.azon;
        
/*
A "F�ktelen�l Bt." szerel�m�helyben mely aut�kat szerelt�k �s mikor?
A lista legyen rendezett aut� rendzs�ma alapj�n
Ha a szerel�snek nincs v�ge a mai d�tummal sz�moljon
*/

SELECT auto FROM szerelo.sz_szereles sz LEFT OUTER JOIN szerelo.sz_szerelomuhely m
    ON sz.muhely_azon = m.azon
    LEFT OUTER JOIN szerelo.sz_auto au
        ON sz.auto_azon = au.tipus_azon
    WHERE m.nev = 'F�ktelen�l Bt.';
    
SELECT au.azon, au.rendszam,
to_char(sz.szereles_kezdete, 'yyyy.mm.dd hh24:mi:ss') kezd,
to_char(sz.szereles_vege, 'yyyy.mm.dd hh24:mi:ss') veg,
nvl(sz.szereles_vege, sysdate) - sz.szereles_kezdete hossz
FROM szerelo.sz_auto au INNER JOIN szerelo.sz_szereles sz
    ON au.azon = sz.auto_azon
        INNER JOIN szerelo.sz_szerelomuhely szm
        ON sz.muhely_azon = szm.azon
    WHERE szm.nev = 'F�ktelen�l Bt.' 
    ORDER BY hossz;
    
/*
List�zza a fekete, piros vagy k�k sz�n� aut�k rendsz�m�t
�s tulajdonos�t (ha van) a c�m�vel �s v�ros�val, de csak azon tulajdonoss�gok eset�n, amelyek 
2000 �s 2021 k�z�tt kezd�dtek.
A lista legyen rendsz�m, azon bel�l a tulajdonol�s kezdete szerint cs�kken�en rendezve.
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
Melyek azok a t�m�k, amelyekhez tartoz� �tlag�r kevesebb, mint 2000
*/
SELECT tema, avg(ar) FROM konyvtar.konyv
    GROUP BY tema
        HAVING avg(ar) < 2000;

/* Az egyes k�nyvekhez h�ny p�ld�ny tartozik*/
SELECT konyv_azon, count(leltari_szam) FROM konyvtar.konyvtari_konyv
    GROUP BY konyv_azon;
    
/* Az egyes k�nyvekhez (cim) h�ny p�ld�ny tartozik? */

SELECT cim, count(kk.leltari_szam) FROM konyvtar.konyv ko LEFT OUTER JOIN konyvtar.konyvtari_konyv kk 
/* LEFT OUTER JOIN konyv-b�l minden, konyvtari_konyv-b�l nem */
    ON kk.konyv_azon = ko.konyv_azon
    GROUP BY cim, ko.konyv_azon;
    
/* Az egyes szerz�k(vezet�kn�v, keresztn�v, sz�l.d�t.) h�ny k�nyvet �rtak? */
SELECT sz.vezeteknev ||' ' || sz.keresztnev nev, count(konyv_azon), to_date(sz.szuletesi_datum, 'yyyy.mm.dd hh24:mi:ss') 
FROM konyvtar.szerzo sz LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON sz.szerzo_azon = ksz.szerzo_azon
    GROUP BY sz.szerzo_azon, vezeteknev, keresztnev, to_date(sz.szuletesi_datum, 'yyyy.mm.dd hh24:mi:ss');
    
/* 
Lis�zzuk azokat a k�nyveket, melyeknek 3-n�l t�bb szerz�je van. 
A lista legyen szerz�k sz�ma szerint cs�kken�en rendezve 
*/  
SELECT ko.konyv_azon, cim, count(szerzo_azon) db FROM konyvtar.konyv ko LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON ko.konyv_azon = ksz.konyv_azon
    GROUP BY ko.konyv_azon, cim
    HAVING count(3)>3
    ORDER BY db desc;
    
/* List�zzuk a tagokat, akik az elm�lt 3 �vben legal�bb 1 k�nyvet k�lcs�n�ztek */
    /*Eny�m:*/
SELECT tag_azon, count(tag_azon), to_char(kolcsonzesi_datum, 'yyyy.mm.dd hh24:mi:ss') FROM konyvtar.kolcsonzes k INNER JOIN konyvtar.tag t
    ON k.tag_azon = t.olvasojegyszam
    WHERE months_between (sysdate, kolcsonzesi_datum)/12 < 2
    GROUP BY tag_azon, kolcsonzesi_datum;
    
    /*Megold�s:*/
SELECT t.olvasojegyszam, vezeteknev, keresztnev, count(leltari_szam) 
    FROM konyvtar.tag t INNER JOIN konyvtar.kolcsonzes k
    ON k.tag_azon = t.olvasojegyszam
    WHERE months_between(sysdate, kolcsonzesi_datum)/12 < 2
    GROUP BY t.olvasojegyszam, vezeteknev, keresztnev
    HAVING COUNT(leltari_szam) >=2
    ORDER BY vezeteknev, keresztnev;
    
/* az egyes besorol�sok eset�n mennyi tag van �s mennyi �ssztagd�jat fizetnek */
SELECT besorolas, count(*), sum(tagdij)
    FROM konyvtar.tag
    GROUP BY besorolas;
    
/* Mely h�napban sz�letett 3-n�l t�bb szerz�. A lista legyen h�napok szerint rendezett*/
SELECT to_char(szuletesi_datum, 'mm-month') ho 
FROM konyvtar.szerzo
    GROUP BY to_char(szuletesi_datum, 'mm-month')
    HAVING count(*)>3
    ORDER BY ho;
    
/* Melyek azok a szerz�k, akik 10.000-n�l t�bb �sszhonor�riumot kaptak */
SELECT vezeteknev || ' ' || keresztnev nev, sum(honorarium) 
FROM konyvtar.szerzo sz LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON sz.szerzo_azon = ksz.szerzo_azon
    GROUP BY sz.szerzo_azon, vezeteknev, keresztnev
    HAVING sum(honorarium) > 10000
    ORDER BY sum(honorarium) desc;
    
/* Melyek azok a szerz�k, akik 10.000-n�l kevesebb �sszhonor�riumot kaptak */
SELECT vezeteknev || ' ' || keresztnev nev, sum(honorarium) 
FROM konyvtar.szerzo sz LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON sz.szerzo_azon = ksz.szerzo_azon
    GROUP BY sz.szerzo_azon, vezeteknev, keresztnev
    HAVING sum(honorarium) < 10000
    ORDER BY sum(honorarium) desc;
    
/* Az egyes szerz�k h�ny k�l�nb�z� t�m�ban �rtak k�nyvet (ha null is) */
-- count(distinct tema)
SELECT vezeteknev, keresztnev, count(distinct tema) 
FROM konyvtar.szerzo sz LEFT OUTER JOIN konyvtar.konyvszerzo ksz
    ON sz.szerzo_azon = ksz.szerzo_azon
        LEFT OUTER JOIN konyvtar.konyv ko
            ON ksz.konyv_azon = ko.konyv_azon
    GROUP BY sz.szerzo_azon, vezeteknev, keresztnev
    ORDER BY count(distinct tema) desc;
    
/* H�ny k�nyv tartozik ahhoz a t�m�hoz, amelyhez a legt�bb k�nyv tartozik */
SELECT tema, count(*)
FROM konyvtari_konyv
GROUP by tema;

/* Kik azok a szerz�k, akik nev�ben *pontosan* 2 'a' bet� szerepel, 
mindegy hogy kicsi, vagy nagy */
SELECT vezeteknev  ||' '|| keresztnev FROM konyvtar.szerzo
    WHERE lower(vezeteknev  ||' '|| keresztnev) like '%a%a%' AND 
    lower(vezeteknev  ||' '|| keresztnev) not like '%a%a%a%';
    
/* Ki Pat Fay f�n�ke? */
SELECT fonok.first_name, fonok.last_name FROM hr. employees pf INNER JOIN hr.employees fonok
    on pf.manager_id = fonok.employee_id
WHERE pf.first_name = 'Pat' AND pf.last_name = 'Fay';

/* Melyek azok a p�ld�nyok, melyek �rt�ke t�bb, mint a hozz�juk tartoz� k�nyv �r�nak a 99%-a */
SELECT ko.konyv_azon, ko.cim, ertek FROM konyvtar.konyvtari_konyv kko INNER JOIN konyvtar.konyv ko
    ON ko.konyv_azon = kko.konyv_azon
    WHERE ertek > ar*0.99
    GROUP BY ko.cim, ko.konyv_azon, ertek
    ORDER BY ertek desc;
    
/* List�zza ki az Agatha Christie-t�l id�sebb szerz�ket */
SELECT * FROM konyvtar.szerzo
    WHERE to_char(szuletesti_datum, 'yyyy.mm.dd'); --?
    
SELECT * FROM konyvtar.szerzo ach INNER JOIN konyvtar.szerzo sz
    ON ach.szuletesi_datum > sz.szuletesi_datum
WHERE sz.vezeteknev = 'Christie' AND sz.keresztnev = 'Agatha';


    
    
    
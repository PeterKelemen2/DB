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


/*2023-m�rc-22*/

/*
Az IT, Sales �s Marketing r�szleg dolgoz�it list�zzuk
*/
SELECT employee_id, first_name, last_name FROM hr.employees emp INNER JOIN
    hr.departments dept 
        ON emp.department_id = dept.department_id
    WHERE department_name in ('Marketing', 'IT','Sales');
    
/*
    Ugyamez be�gyazottan:
*/
SELECT employee_id, first_name, last_name FROM hr.employees
WHERE department_id in (
                        SELECT department_id FROM hr.departments
                            WHERE department_name in ('Marketing', 'IT','Sales')
                        );
    
/**/
SELECT * FROM hr.employees emp INNER JOIN (
    select department_id, department_name
        FROM hr.departments
        WHERE department_name in ('Marketing', 'IT','Sales')
) d
ON emp.department_id = d.department_id;

/*
List�zza azokat a r�szlegeket melyekhez nem tartozik dolgoz�
*/
SELECT * FROM hr.departments
WHERE department_id not in(
                            SELECT department_id
                            FROM hr.employees
                            WHERE department_id is not null
                            );
    
/* Melyik dolgoz� fizet�se a legnagyobb*/
SELECT * FROM hr.employees
WHERE salary = (SELECT max(salary) FROM hr.employees);

/* Kinek kevesebb a fizet�se mint az IT r�szleg �tlag fizet�se */


/* Kinek kevesebb a fizet�se mint valamely IT r�szleg 
dolgoz�j�nak a fizet�se */
SELECT * FROM hr.employees
WHERE salary < any(
                SELECT salary FROM hr.employees
                WHERE department_id = (
                                        SELECT department_id
                                        FROM hr.departments
                                        WHERE department_name = 'IT'
                                        )
                ); 
                
SELECT * FROM hr.employees
WHERE salary < all(
                SELECT salary FROM hr.employees
                WHERE department_id = (
                                        SELECT department_id
                                        FROM hr.departments
                                        WHERE department_name = 'IT'
                                        )
                );
                
-- Mely r�szleghez nem l�tezik dolgoz� 
SELECT * FROM hr.departments dept
WHERE not exists(
                SELECT 1
                FROM hr.employees emp
                WHERE dept.department_id = emp.employee_id
                );
                
-- List�zza az els� 7 legnagyobb fizet�s� dolgoz�t
SELECT first_name, last_name, salary, rownum FROM hr.employees
ORDER BY salary desc;

SELECT first_name, last_name, salary, rownum FROM (
                SELECT first_name, last_name, salary
                FROM hr.employees
                ORDER BY salary desc
    )
    WHERE rownum < 8;
    
SELECT first_name, last_name, salary
FROM hr.employees
ORDER BY salary desc
fetch first 7 rows only; -- csak 7-et fog ki�rni

SELECT * FROM konyvtar.konyv
ORDER BY ar desc nulls last
fetch first 8 rows with ties; -- ami egyforma m�g ki�rja (9 lesz ki�rva)

SELECT * FROM konyvtar.konyv
WHERE ar = (
    SELECT max(ar) FROM konyvtar.konyv
    );

-- M�sodik 10 darab
SELECT * FROM konyvtar.konyv
ORDER BY ar desc nulls last
offset 10 rows fetch next 10 rows with ties; 

-- Els� 10% a list�b�l
SELECT * FROM konyvtar.konyv
ORDER BY ar desc nulls last
fetch first 10 percent row only;

--
-- Halmazm�velet p�ld�k
--

SELECT vezeteknev, keresztnev FROM konyvtar.tag
    UNION
SELECT vezeteknev, keresztnev FROM konyvtar.szerzo;

SELECT vezeteknev, keresztnev FROM konyvtar.tag
    INTERSECT 
SELECT vezeteknev, keresztnev FROM konyvtar.szerzo;

SELECT vezeteknev, keresztnev, 'alma' FROM konyvtar.tag
    UNION 
SELECT vezeteknev, keresztnev FROM konyvtar.szerzo;

SELECT keresztnev FROM konyvtar.tag
    union all
SELECT keresztnev FROM konyvtar.szerzo
ORDER BY keresztnev;

/* Azok a keresztnevek, amelyek egy tagnak �s szerz�nek is
a keresztneve */
SELECT distinct t.keresztnev FROM konyvtar.tag t INNER JOIN konyvtar.szerzo sz
ON t.keresztnev = sz.keresztnev;

/**/
SELECT department_id FROM hr.departments
    MINUS 
SELECT department_id FROM hr.employees;

SELECT * FROM hr.departments
WHERE department_id in (
    SELECT department_id FROM hr.departments
        MINUS 
    SELECT department_id FROM hr.employees
);

/* List�zza azon tulajdonosok nev�t akiknek valamely
aut�j�t szerelt�k vagy fel�rt�kelt�k az elm�lt k�t �vben */

SELECT nev FROM szerelo.sz_tulajdonos
WHERE azon in (
               SELECT tulaj_azon
               FROM szerelo.sz_auto_tulajdonosa
               WHERE auto_azon in(
                        SELECT auto_azon 
                        FROM szerelo.sz_autofelertekeles
                        WHERE months_between (sysdate, datum)/12 < 2
                            UNION
                        SELECT sz.auto_azon 
                        FROM szerelo.sz_szereles sz; 
                        WHERE months_between (sysdate, szereles_kezdete)/12 < 2
                        )
);

/*Melyik aut�nak van a legnagyobb felv�s�rl�si �ra*/
SELECT * FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar = (
    SELECT max(elso_vasarlasi_ar) FROM szerelo.sz_auto
);

-- Melyik aut�t �rt�kelt�k fel a legnagyobbra
SELECT auto_azon,rendszam 
FROM szerelo.sz_auto au 
    INNER JOIN szerelo.sz_autofelertekeles af
    ON au.azon = af.auto_azon
WHERE ertek = (SELECT max(ertek) 
               FROM szerelo.sz_autofelertekeles);
               
-- List�zza az utols� 5 szerel�sben r�szt vett aut� rendsz�m�t
-- �s azt hogy hol szerelt�k
SELECT * FROM szerelo.sz_szereles sz 
    LEFT OUTER JOIN
    szerelo.sz_auto au
    ON sz.auto_azon = au.azon
        INNER JOIN szerelo.sz_szerelomuhely szm
        ON sz.muhely_azon = szm.azon
ORDER BY szereles_kezdete desc nulls last
fetch first 5 row with ties;


/* Melyek azok az aut�k melyeknek az �tlagos fel�rt�kel�si
�rt�ke t�bb mint 2M */
SELECT auto_azon, rendszam, avg(ertek) 
    FROM szerelo.sz_autofelertekeles af 
    INNER JOIN szerelo.sz_auto au
    ON af.auto_azon = au.azon
GROUP BY auto_azon, rendszam
HAVING avg(ertek) > 2000000;

/* Melyek azok az aut� melyek �tlagos fel.�rt�ke t�bb, mint
az aut� els� v�s�rl�si �r�nak a 80%-a */
SELECT au.azon, rendszam, avg(ertek) 
    FROM szerelo.sz_autofelertekeles af 
    INNER JOIN szerelo.sz_auto au
    ON af.auto_azon = au.azon

GROUP BY au.azon, rendszam, elso_vasarlasi_ar
HAVING avg(ertek) > elso_vasarlasi_ar*0.8;

/*
List�zza azokat az aut�kat melyeknek az els� v�s�rl�si �ra
t�bb mint az �sszes szerel�s�kre ford�tott munkav�gz�s �r�ra
90%-a
*/
SELECT azon, rendszam, sum(munkavegzes_ara) 
FROM szerelo.sz_auto au 
INNER JOIN szerelo.sz_szereles sz
ON au.azon = sz.auto_azon
GROUP BY auto_azon
HAVING elso_vasarlasi_ar > sum(munkavegzes_ara)*0.9;


-- ZH gyakorl�s:
/* List�zza azokat az aut�kat, melyeknek az els� v�s�rl�si
�r 2M �s 5M k�z� esik �S a sz�ne piros/fekete/k�k
A lista legyen sz�n, azon bel�l �r szerint cs�kken�en rendezett */

SELECT rendszam, azon, szin, elso_vasarlasi_ar FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar > 2000000 AND
    elso_vasarlasi_ar < 5000000 AND 
    szin in ('piros', 'fekete', 'k�k')
ORDER BY szin, elso_vasarlasi_ar desc;

SELECT rendszam, azon, szin, elso_vasarlasi_ar FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar between 2000000 and 5000000 and
    szin in ('piros', 'fekete', 'k�k')
ORDER BY szin, elso_vasarlasi_ar desc;

/* List�zza azokat az aut�kat amelyeket el�ssz�r 2010 �s 2020
k�z�tt adtak el 
A lista legyen �v, azon bel�l �r szerint rendezett*/
SELECT to_char(elso_vasarlas_idopontja, 'yyyy.mm.dd hh24:mi:ss') 
FROM szerelo.sz_auto
WHERE extract (year from elso_vasarlas_idopontja) 
    between 2010 and 2020;
-- stb

/* Melyek azok a tulajdonosok akiknek 3-n�l t�bb aut�ja van
A tulajdonosnak az azonosjt�j�t list�zzuk
A lista legyen darabsz�m szerint cs�kken�en rendezett*/
SELECT tulaj_azon, count(auto_azon) db FROM szerelo.sz_auto_tulajdonosa
GROUP BY tulaj_azon
HAVING count(auto_azon) > 3
ORDER BY db desc;

-- n�vvel:
SELECT t.nev, tulaj_azon, count(auto_azon) db FROM szerelo.sz_auto_tulajdonosa at
INNER JOIN szerelo.sz_tulajdonos t
    ON at.tulaj_azon = t.azon
GROUP BY tulaj_azon, t.nev
HAVING count(auto_azon) > 3
ORDER BY db desc;

/* Melyek azok a tulajdonosok akiknek 3-n�l kevesebb aut�ja van */
SELECT t.nev, tulaj_azon, count(auto_azon) db FROM szerelo.sz_auto_tulajdonosa at
RIGHT OUTER JOIN szerelo.sz_tulajdonos t
    ON at.tulaj_azon = t.azon
GROUP BY tulaj_azon, t.nev
HAVING count(auto_azon) < 3
ORDER BY db desc;
    
/* Melyek azok az aut�k melyek �tlagok fel�rt�kel�si �ra t�bb
mint 1M 
A lista legyen rendsz�m szerint rendezett*/
SELECT rendszam, avg(ertek) FROM szerelo.sz_autofelertekeles aufe
RIGHT OUTER JOIN szerelo.sz_auto au
    ON aufe.auto_azon = au.azon
GROUP BY au.azon, rendszam
HAVING avg(ertek) > 1000000
ORDER BY rendszam;

/* List�zza azon tulajdonosokat, amelyben Debreceni tulaj
piros/k�k/fekete sz�n� aut�t 2010 janu�r 1 ut�n v�s�rolt
A lista legyen tulajn�v, azon bel�l rendsz�m szerint rendezett */
SELECT t.nev, au.rendszam, au.szin, at.vasarlas_ideje FROM szerelo.sz_auto_tulajdonosa at LEFT OUTER JOIN
    szerelo.sz_auto au
    ON at.auto_azon = au.azon
        INNER JOIN szerelo.sz_tulajdonos t
        ON at.tulaj_azon = t.azon
WHERE cim like 'Debrecen,%' 
AND szin in ('piros', 'k�k', 'fekete')
AND to_char(vasarlas_ideje, 'yyyy.mm.dd hh24:mi:ss') >
to_char('2010.01.01 00:00:00')
ORDER BY t.nev, rendszam;

-- to_date:
SELECT t.nev, au.rendszam, au.szin, at.vasarlas_ideje FROM szerelo.sz_auto_tulajdonosa at LEFT OUTER JOIN
    szerelo.sz_auto au
    ON at.auto_azon = au.azon
        INNER JOIN szerelo.sz_tulajdonos t
        ON at.tulaj_azon = t.azon
WHERE cim like 'Debrecen,%' 
AND szin in ('piros', 'k�k', 'fekete')
AND at.vasarlas_ideje > to_date('2010.01.01', 'yyyy.mm.dd')
ORDER BY t.nev, rendszam;

/* Melyek azok az aut�k melyek �ra t�bb mint a piros aut�k
�tlag �ra*/
SELECT * FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar > (SELECT avg(elso_vasarlasi_ar)
                           FROM szerelo.sz_auto
                           WHERE szin = 'piros'
                            );

/* Melyik aut�t szerelt�k a leghosszabb ideig
Ha a szerel�s nem fejezt�k be, akkor az aktu�lis id�t 
haszn�lja */
SELECT rendszam, nvl(szereles_vege, sysdate)-szereles_kezdete ido
-- NV - ha van null, akkor haszn�lja a sysdate-et
FROM szerelo.sz_auto au INNER JOIN szerelo.sz_szereles sz
ON au.azon = sz.auto_azon
ORDER BY ido desc
FETCH FIRST ROW WITH TIES;

/* H�ny piros aut� van */
SELECT count(azon) FROM szerelo.sz_auto
WHERE szin = 'piros';

/* melyik aut�t nem szerelt�k */
SELECT * FROM szerelo.sz_auto
WHERE azon not in(
        SELECT auto_azon FROM szerelo.sz_szereles
    );

/* M�rk�nk�nt mennyi az �tlagos szerel�si �r*/
SELECT marka, AVG(munkavegzes_ara) FROM szerelo.sz_autotipus atip
LEFT OUTER JOIN szerelo.sz_auto au
    ON atip.azon = au.azon
        LEFT OUTER JOIN szerelo.sz_szereles sz
        ON au.azon = sz.auto_azon
GROUP BY marka;

SELECT am.nev marka, avg(munkavegzes_ara) FROM szerelo.sz_automarka am LEFT OUTER JOIN
    szerelo.sz_autotipus at 
    ON am.nev = at.marka
        FULL OUTER JOIN szerelo.sz_auto au
        ON at.azon = au.tipus_azon
            FULL OUTER JOIN szerelo.sz_szereles sz
            ON au.azon = sz.auto_azon
GROUP BY am.nev;

/* Az egyes aut�k utols� elad�si ideje */
SELECT auto_azon, rendszam, to_char(max(vasarlas_ideje), 'yyyy.mm.dd') ido 
FROM szerelo.sz_auto au
right OUTER JOIN szerelo.sz_auto_tulajdonosa at
ON au.azon = at.auto_azon
GROUP BY auto_azon, rendszam
ORDER BY max(vasarlas_ideje) desc;



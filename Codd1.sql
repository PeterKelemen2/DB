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


/*2023-márc-22*/

/*
Az IT, Sales és Marketing részleg dolgozóit listázzuk
*/
SELECT employee_id, first_name, last_name FROM hr.employees emp INNER JOIN
    hr.departments dept 
        ON emp.department_id = dept.department_id
    WHERE department_name in ('Marketing', 'IT','Sales');
    
/*
    Ugyamez beágyazottan:
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
Listázza azokat a részlegeket melyekhez nem tartozik dolgozó
*/
SELECT * FROM hr.departments
WHERE department_id not in(
                            SELECT department_id
                            FROM hr.employees
                            WHERE department_id is not null
                            );
    
/* Melyik dolgozó fizetése a legnagyobb*/
SELECT * FROM hr.employees
WHERE salary = (SELECT max(salary) FROM hr.employees);

/* Kinek kevesebb a fizetése mint az IT részleg átlag fizetése */


/* Kinek kevesebb a fizetése mint valamely IT részleg 
dolgozójának a fizetése */
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
                
-- Mely részleghez nem létezik dolgozó 
SELECT * FROM hr.departments dept
WHERE not exists(
                SELECT 1
                FROM hr.employees emp
                WHERE dept.department_id = emp.employee_id
                );
                
-- Listázza az elsõ 7 legnagyobb fizetésû dolgozót
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
fetch first 7 rows only; -- csak 7-et fog kiírni

SELECT * FROM konyvtar.konyv
ORDER BY ar desc nulls last
fetch first 8 rows with ties; -- ami egyforma még kiírja (9 lesz kiírva)

SELECT * FROM konyvtar.konyv
WHERE ar = (
    SELECT max(ar) FROM konyvtar.konyv
    );

-- Második 10 darab
SELECT * FROM konyvtar.konyv
ORDER BY ar desc nulls last
offset 10 rows fetch next 10 rows with ties; 

-- Elsõ 10% a listából
SELECT * FROM konyvtar.konyv
ORDER BY ar desc nulls last
fetch first 10 percent row only;

--
-- Halmazmûvelet példák
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

/* Azok a keresztnevek, amelyek egy tagnak és szerzõnek is
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

/* Listázza azon tulajdonosok nevét akiknek valamely
autóját szerelték vagy felértékelték az elmúlt két évben */

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

/*Melyik autónak van a legnagyobb felvásárlási ára*/
SELECT * FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar = (
    SELECT max(elso_vasarlasi_ar) FROM szerelo.sz_auto
);

-- Melyik autót értékelték fel a legnagyobbra
SELECT auto_azon,rendszam 
FROM szerelo.sz_auto au 
    INNER JOIN szerelo.sz_autofelertekeles af
    ON au.azon = af.auto_azon
WHERE ertek = (SELECT max(ertek) 
               FROM szerelo.sz_autofelertekeles);
               
-- Listázza az utolsó 5 szerelésben részt vett autó rendszámát
-- és azt hogy hol szerelték
SELECT * FROM szerelo.sz_szereles sz 
    LEFT OUTER JOIN
    szerelo.sz_auto au
    ON sz.auto_azon = au.azon
        INNER JOIN szerelo.sz_szerelomuhely szm
        ON sz.muhely_azon = szm.azon
ORDER BY szereles_kezdete desc nulls last
fetch first 5 row with ties;


/* Melyek azok az autók melyeknek az átlagos felértékelési
értéke több mint 2M */
SELECT auto_azon, rendszam, avg(ertek) 
    FROM szerelo.sz_autofelertekeles af 
    INNER JOIN szerelo.sz_auto au
    ON af.auto_azon = au.azon
GROUP BY auto_azon, rendszam
HAVING avg(ertek) > 2000000;

/* Melyek azok az autó melyek átlagos fel.értéke több, mint
az autó elsõ vásárlási árának a 80%-a */
SELECT au.azon, rendszam, avg(ertek) 
    FROM szerelo.sz_autofelertekeles af 
    INNER JOIN szerelo.sz_auto au
    ON af.auto_azon = au.azon

GROUP BY au.azon, rendszam, elso_vasarlasi_ar
HAVING avg(ertek) > elso_vasarlasi_ar*0.8;

/*
Listázza azokat az autókat melyeknek az elsõ vásárlási ára
több mint az összes szerelésükre fordított munkavégzés árára
90%-a
*/
SELECT azon, rendszam, sum(munkavegzes_ara) 
FROM szerelo.sz_auto au 
INNER JOIN szerelo.sz_szereles sz
ON au.azon = sz.auto_azon
GROUP BY auto_azon
HAVING elso_vasarlasi_ar > sum(munkavegzes_ara)*0.9;


-- ZH gyakorlás:
/* Listázza azokat az autókat, melyeknek az elsõ vásárlási
ár 2M és 5M közé esik ÉS a színe piros/fekete/kék
A lista legyen szín, azon belül ár szerint csökkenõen rendezett */

SELECT rendszam, azon, szin, elso_vasarlasi_ar FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar > 2000000 AND
    elso_vasarlasi_ar < 5000000 AND 
    szin in ('piros', 'fekete', 'kék')
ORDER BY szin, elso_vasarlasi_ar desc;

SELECT rendszam, azon, szin, elso_vasarlasi_ar FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar between 2000000 and 5000000 and
    szin in ('piros', 'fekete', 'kék')
ORDER BY szin, elso_vasarlasi_ar desc;

/* Listázza azokat az autókat amelyeket elõsször 2010 és 2020
között adtak el 
A lista legyen év, azon belül ár szerint rendezett*/
SELECT to_char(elso_vasarlas_idopontja, 'yyyy.mm.dd hh24:mi:ss') 
FROM szerelo.sz_auto
WHERE extract (year from elso_vasarlas_idopontja) 
    between 2010 and 2020;
-- stb

/* Melyek azok a tulajdonosok akiknek 3-nál több autója van
A tulajdonosnak az azonosjtóját listázzuk
A lista legyen darabszám szerint csökkenõen rendezett*/
SELECT tulaj_azon, count(auto_azon) db FROM szerelo.sz_auto_tulajdonosa
GROUP BY tulaj_azon
HAVING count(auto_azon) > 3
ORDER BY db desc;

-- névvel:
SELECT t.nev, tulaj_azon, count(auto_azon) db FROM szerelo.sz_auto_tulajdonosa at
INNER JOIN szerelo.sz_tulajdonos t
    ON at.tulaj_azon = t.azon
GROUP BY tulaj_azon, t.nev
HAVING count(auto_azon) > 3
ORDER BY db desc;

/* Melyek azok a tulajdonosok akiknek 3-nál kevesebb autója van */
SELECT t.nev, tulaj_azon, count(auto_azon) db FROM szerelo.sz_auto_tulajdonosa at
RIGHT OUTER JOIN szerelo.sz_tulajdonos t
    ON at.tulaj_azon = t.azon
GROUP BY tulaj_azon, t.nev
HAVING count(auto_azon) < 3
ORDER BY db desc;
    
/* Melyek azok az autók melyek átlagok felértékelési ára több
mint 1M 
A lista legyen rendszám szerint rendezett*/
SELECT rendszam, avg(ertek) FROM szerelo.sz_autofelertekeles aufe
RIGHT OUTER JOIN szerelo.sz_auto au
    ON aufe.auto_azon = au.azon
GROUP BY au.azon, rendszam
HAVING avg(ertek) > 1000000
ORDER BY rendszam;

/* Listázza azon tulajdonosokat, amelyben Debreceni tulaj
piros/kék/fekete színû autót 2010 január 1 után vásárolt
A lista legyen tulajnév, azon belül rendszám szerint rendezett */
SELECT t.nev, au.rendszam, au.szin, at.vasarlas_ideje FROM szerelo.sz_auto_tulajdonosa at LEFT OUTER JOIN
    szerelo.sz_auto au
    ON at.auto_azon = au.azon
        INNER JOIN szerelo.sz_tulajdonos t
        ON at.tulaj_azon = t.azon
WHERE cim like 'Debrecen,%' 
AND szin in ('piros', 'kék', 'fekete')
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
AND szin in ('piros', 'kék', 'fekete')
AND at.vasarlas_ideje > to_date('2010.01.01', 'yyyy.mm.dd')
ORDER BY t.nev, rendszam;

/* Melyek azok az autók melyek ára több mint a piros autók
átlag ára*/
SELECT * FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar > (SELECT avg(elso_vasarlasi_ar)
                           FROM szerelo.sz_auto
                           WHERE szin = 'piros'
                            );

/* Melyik autót szerelték a leghosszabb ideig
Ha a szerelés nem fejezték be, akkor az aktuális idõt 
használja */
SELECT rendszam, nvl(szereles_vege, sysdate)-szereles_kezdete ido
-- NV - ha van null, akkor használja a sysdate-et
FROM szerelo.sz_auto au INNER JOIN szerelo.sz_szereles sz
ON au.azon = sz.auto_azon
ORDER BY ido desc
FETCH FIRST ROW WITH TIES;

/* Hány piros autó van */
SELECT count(azon) FROM szerelo.sz_auto
WHERE szin = 'piros';

/* melyik autót nem szerelték */
SELECT * FROM szerelo.sz_auto
WHERE azon not in(
        SELECT auto_azon FROM szerelo.sz_szereles
    );

/* Márkánként mennyi az átlagos szerelési ár*/
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

/* Az egyes autók utolsó eladási ideje */
SELECT auto_azon, rendszam, to_char(max(vasarlas_ideje), 'yyyy.mm.dd') ido 
FROM szerelo.sz_auto au
right OUTER JOIN szerelo.sz_auto_tulajdonosa at
ON au.azon = at.auto_azon
GROUP BY auto_azon, rendszam
ORDER BY max(vasarlas_ideje) desc;



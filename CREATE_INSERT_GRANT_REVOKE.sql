CREATE TABLE e_hallgato(
    neptun char(6),
    nev varchar2(30) constraint eh_nn_nev not null,
    szul_dat date,
    cipomeret number(2),
    atlag number(3,2),
    szig char(6),
    constraint eh_pk primary key(neptun),
    constraint eh_uq_szig unique (szig), 
    constraint eh_ch_atl check (atlag >= 1)
);

DROP TABLE e_hallgato;
-- DROP TABLE e_hallgato PURGE;

CREATE TABLE e_szak(
    nev varchar2(30),
    felevek_szama number(2),
    osszkreditszam number(3),
    constraint e_sz_pk primary key (nev)
);

CREATE TABLE e_hallgato_szakja(
    neptun char(6),
    szak varchar2(30),
    constraint ehsz_pk primary key(neptun, szak),
    constraint ehsz_fk_h foreign key(neptun) 
        references e_hallgato(neptun),
    constraint ehsz_fk_sz foreign key(szak)
        references e_szak(nev)
);

DROP TABLE e_hallgato_szakja purge;

INSERT INTO e_szak(felevek_szama, nev, osszkreditszam)
    VALUES (7, 'MI', 210);
    
INSERT INTO e_szak(felevek_szama, nev, osszkreditszam)
    VALUES (7, 'GI', 210);

commit;

-- beh�zva ide a t�bl�t
INSERT INTO e_hallgato (
    neptun, nev, szul_dat, cipomeret, atlag, szig) 
VALUES (
    'AAA111', 'Anna', to_date('2005.01.01', 'yyyy.mm.dd'),
    38, 3.5, 'AAA111'
    );
    
INSERT INTO e_hallgato (
    neptun, nev, szul_dat, cipomeret, atlag, szig
) VALUES (
    'BBB222', 'B�la', 0, 'BBB222');
    
INSERT INTO e_hallgato (
neptun, nev, szul_dat, cipomeret, atlag, szig) 
VALUES (
    'BBB222', 
    'B�la', 
    1.3,
    'aaa111'
    );
    
INSERT INTO e_hallgato (
    neptun,
    nev,
    atlag,
    szig
) VALUES (
    'CCC333', 
    'Cili', 
    4,
    'CCC333'
    );
    
INSERT INTO e_hallgato (
    neptun,
    nev,
    atlag,
    szig
) VALUES (
    'DDD444', 
    'D�nes', 
    3,
    'DDD444'
    );
    
commit;

INSERT INTO e_hallgato_szakja (
    neptun,
    szak
) VALUES (
    'AAA111',
    'PTI'
);

INSERT INTO e_hallgato_szakja (
    neptun,
    szak
) VALUES (
    'BBB222',
    'PTI'
);

INSERT INTO e_hallgato_szakja (
    neptun,
    szak
) VALUES (
    'CCC333',
    'GI'
);

SELECT * FROM e_hallgato h full outer join e_hallgato_szakja hsz
    ON h.neptun = hsz.neptun
        FULL OUTER JOIN e_szak sz
        ON hsz.szak = sz.nev;

INSERT INTO e_szak (
    nev,
    felevek_szama,
    osszkreditszam
) VALUES (
    'AOK', 12, 360
);
commit;

SELECT * FROM e_szak;

DELETE e_szak WHERE nev = 'AOK';
commit;

SELECT * FROM e_szak;

SELECT * FROM E_HALLGATO;

INSERT INTO e_hallgato(neptun, nev)
VALUES('E4', 'Elek');

INSERT INTO e_hallgato(neptun, nev)
VALUES('F5', 'Ferenc');

savepoint sp1;

INSERT INTO e_hallgato(neptun, nev)
VALUES('G6', 'G�za');

INSERT INTO e_hallgato(neptun, nev)
VALUES('H7', 'Hanna');

rollback; -- commitot vissza�ll�t
rollback to sp1;

CREATE synonym f_konyv for konyvtar.konyv; -- elnevezi �gy

SELECT * FROM f_konyv;

DROP synonym f_konyv;

CREATE sequence seq;

SELECT seq.nextval FROM dual;
SELECT seq.currval FROM dual;

CREATE VIEW felos_konyvek as -- nem t�rol, hanem elmenti a m�g�tte lev�t
SELECT * FROM konyvtar.konyv 
WHERE tema in ('sci-Fi', 'krimi', 'horror')
ORDER BY tema;

SELECT * FROM felos_konyvek;

SELECT * FROM dict; -- dictionary

SELECT * FROM user_tables;
SELECT * FROM user_tab_cols;
SELECT * FROM user_constraints;
SELECT * FROM user_sequences;
SELECT * FROM user_synonyms;
SELECT * FROM user_views;
SELECT * FROM user_users;

SELECT * FROM all_tables;
SELECT * FROM all_tab_cols;
SELECT * FROM all_constraints;
SELECT * FROM all_sequences;
SELECT * FROM all_synonyms;
SELECT * FROM all_views;
SELECT * FROM all_users;

-- DROP VIEW felos_konyvek;

DROP sequence seq;


-- jogok:
-- GRANT <jog> TO <user>
-- GRANT select on konyv TO user1, user2, public

/*
t�bla jog: 
SELECT ON
INSERT ON
UPDATE ON
DELETE ON
ALL ON
INSERT (CIM) ON konyv
(REFERENCES)
*/

/*
objektum jog:
CREATE TABLE
ALTER TABLE

CREATE USER
ALTER USER

CREATE NEW
*/

/*
szerepk�r
ROLE

RESOURCE
    CREATE TABLE
    CREATE PROCEDURE

CONNECT
    CREATE SESSION
    
DBA - mindenhez van joga
*/

CREATE TABLE f_konyv as SELECT * FROM konyvtar.konyv;

ALTER TABLE f_konyv add constraint ek_pk primary key (konyv_azon);

GRANT SELECT ON f_konyv TO U_JR4DZ1, aniko;
SELECT * FROM U_JR4DZ1.e_konyv; -- ha j�, akkor mutatja a �tbl�t

GRANT SELECT, INSERT, REFERENCES ON f_konyv TO U_JR4DZ1, aniko;

CREATE TABLE f_vmi
(azon number(5),
nev varchar(30),
konyv_azon number(10),
constraint ev_fk foreign key (konyv_azon) 
    references U_JR4DZ1.e_konyv(konyv_azon) -- az � t�bl�j�b�l
);

INSERT INTO f_konyv(konyv_azon, cim)
values(123, 'k�nyv n�v');
commit;

select * from U_JR4DZ1.e_konyv;
SELECT * FROM F_KONYV;

GRANT UPDATE (ar, oldalszam) on e_konyv to U_JR4DZ1;

UPDATE U_JR4DZ1.e_konyv set ar = ar*10; 

REVOKE select, insert ON f_konyv FROM U_JR4DZ1;

ALTER TABLE f_konyv ADD (szin varchar2(20));

ALTER TABLE f_konyv MODIFY szin varchar2(30);

ALTER TABLE f_konyv RENAME column szin to szin2;

ALTER TABLE f_konyv DROP COLUMN szin2;

RENAME f_konyv TO f_konyv2;

RENAME f_konyv2 TO f_konyv;

ALTER TABLE f_vmi DROP CONSTRAINT ev_fk;
ALTER TABLE f_konyv DROP PRIMARY KEY;

ALTER TABLE f_konyv ADD CONSTRAINT ek_pk primary key (konyv_azon);

ALTER TABLE f_konyv DROP CONSTRAINT ek_pk;

select * from f_konyv
WHERE cim = 'k�nyv n�v';

DELETE f_konyv WHERE cim = 'k�nyv n�v';
commit;

ALTER TABLE f_konyv ADD CONSTRAINT ek_ch CHECK (isbn is not null);
    
ALTER TABLE f_konyv RENAME CONSTRAINT ek_ch to ck_ch2;


/*
Hozzon l�tre n�zetet amely megmutatja, hogy az egyes aut�kat
mikor �rt�kelt�k fel ut�lj�ra, mennyi volt az �tlagos fel�rt�kel�si
�rt�ke �s h�nyszor �rt�kelt�k fel.
A list�t rendsz�m szerint rendezni.
*/
CREATE VIEW v_af AS
    SELECT auto_azon, rendszam, max(datum) max_datum
    -- a f�ggv�nyeket �t kell nevezni, mert m�sk�pp
    -- nem k�sz�l el a n�zet
    FROM szerelo.sz_auto au LEFT OUTER JOIN
        szerelo.sz_autofelertekeles af
        ON au.azon = af.auto_azon
    GROUP BY rendszam, auto_azon
    ORDER BY rendszam;
    
/*
Hozzon l�tre n�zetet, amely megmutatja az �sszes szerel�t
�s a m�helyeket amelyekben valaha dolgoztak
*/
CREATE VIEW v_sz AS
    SELECT sz.azon szerelo_azon, sz.nev szerelo_nev, szm.azon muhely_azon, szm.nev muhely_nev
    FROM szerelo.sz_szerelo sz 
        RIGHT OUTER JOIN szerelo.sz_dolgozik szd
        ON sz.azon = szd.szerelo_azon
            LEFT OUTER JOIN szerelo.sz_szerelomuhely szm
            ON szd.muhely_azon = szm.azon;
            
/*HR.EMPLOYEES
Hozzon l�tre n�zetet, amely megmutatja, hogy az egyes dolgoz�knak 
ki a f�n�ke. Mindkett�h�z azonos�t� �s n�v.
*/
-- eny�m:
SELECT emp.employee_id, emp.first_name, emp.last_name,
    emp2.employee_id, emp2.first_name, emp2.last_name
FROM hr.employees emp 
    INNER JOIN hr.employees emp2
    ON emp.employee_id = emp2.manager_id;
-- fancybb:
CREATE VIEW v_b_f AS -- minden szart el kell nevezni
SELECT beosztott.employee_id dolgozo_azon, 
beosztott.first_name || ' ' || beosztott.last_name beosztott_nev,
fonok.employee_id fonok_azon, 
fonok.first_name || ' ' || fonok.last_name fonok_nev
FROM hr.employees beosztott 
LEFT OUTER JOIN hr.employees fonok
    ON beosztott.manager_id = fonok.employee_id;
    
-- SELECT * FROM user_views;

/*Az egyes szinekhez tartoz� aut�k k�z�l melyik a legdr�g�bb*/
SELECT szin, max (ertek) FROM szerelo.sz_auto au LEFT OUTER JOIN 
    szerelo.sz_autofelertekeles auf
    ON au.azon = auf.auto_azon
GROUP BY szin;

SELECT szin, max(elso_vasarlasi_ar) FROM szerelo.sz_auto
GROUP BY szin;

SELECT * FROM szerelo.sz_auto au INNER JOIN (
WHERE (szin, elso_vasarlasi_ar) IN (SELECT szin, max(elso_vasarlasi_ar) meva
                                    FROM szerelo.sz_auto
                                    GROUP BY szin)) bs
ON au.szin = bs.szin AND au.elso_vasarlasi_ar = bs.meva;

/*Az egyes aut�kat mennyire �rt�kelt�k fel ut�lj�ra*/

SELECT * FROM szerelo.sz_autofelertekeles
WHERE (auto_azon, datum) IN ( SELECT auto_azon, max(datum) 
                              FROM szerelo.sz_autofelertekeles af
                              GROUP BY auto_azon);
                              
SELECT * FROM szerelo.sz_auto au LEFT OUTER JOIN 
(
SELECT * FROM szerelo.sz_autofelertekeles
WHERE (auto_azon, datum) IN ( SELECT auto_azon, max(datum) 
                              FROM szerelo.sz_autofelertekeles
                              GROUP BY auto_azon) bs
)
ON au.azon = bs.auto_azon;

        


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

-- behúzva ide a táblát
INSERT INTO e_hallgato (
    neptun, nev, szul_dat, cipomeret, atlag, szig) 
VALUES (
    'AAA111', 'Anna', to_date('2005.01.01', 'yyyy.mm.dd'),
    38, 3.5, 'AAA111'
    );
    
INSERT INTO e_hallgato (
    neptun, nev, szul_dat, cipomeret, atlag, szig
) VALUES (
    'BBB222', 'Béla', 0, 'BBB222');
    
INSERT INTO e_hallgato (
neptun, nev, szul_dat, cipomeret, atlag, szig) 
VALUES (
    'BBB222', 
    'Béla', 
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
    'Dénes', 
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
VALUES('G6', 'Géza');

INSERT INTO e_hallgato(neptun, nev)
VALUES('H7', 'Hanna');

rollback; -- commitot visszaállít
rollback to sp1;

CREATE synonym f_konyv for konyvtar.konyv; -- elnevezi így

SELECT * FROM f_konyv;

DROP synonym f_konyv;

CREATE sequence seq;

SELECT seq.nextval FROM dual;
SELECT seq.currval FROM dual;

CREATE VIEW felos_konyvek as -- nem tárol, hanem elmenti a mögötte levõt
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


    
    
    




-- a)
select * from zukunft.FACH;
-- b)
select Note from zukunft.STUDENT;
-- c)
select distinct(Note) from zukunft.STUDENT; 
-- d)
select Note from zukunft.STUDENT order by Note desc; 
-- e)
select s.ID from zukunft.STUDENT s, zukunft.FACH f 
where s.Fach = f.ID 
AND f.Bezeichnung = 'SE 1';
-- f)
select count(s.ID) from zukunft.STUDENT s, zukunft.FACH f 
where s.Fach = f.ID 
AND f.Bezeichnung = 'SE 1';
-- g)
select s.ID as Student, avg(Note) as Durchschnitt 
from zukunft.STUDENT s
group by s.ID;
-- h)
select avg(s.Note) as SE1_Notendurchschnitt
from zukunft.STUDENT s, zukunft.FACH f
where s.Fach = f.ID 
AND f.Bezeichnung = 'SE 1';
-- i)
select distinct(s.ID) as Student from zukunft.STUDENT s, zukunft.PROF p, zukunft.HAELT h
where h.Prof = p.ID 
AND s.Fach = h.Fach 
AND p.Name = 'Schmidt';


select ID as Matrnr, Fach, Note from zukunft.STUDENT; --fetch first 5 rows only;
select * from zukunft.PROF;
select * from zukunft.HAELT;
select * from zukunft.FACH;
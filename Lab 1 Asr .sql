--1--
select distinct c.name, p.company, s.price, s.dividend, s.eps
from clinet c, purchse p, stock s
where c.clno = p.clno and p.company = s.company;

--2--
select c.name, p.company, sum(p.qty) total_qty, 
sum(p.qty*p.price)/ sum(p.qty) APP
from client c, purchase p
where c.clno = p.clno
group by c.name, p.company;

--3--
select p.compay, c

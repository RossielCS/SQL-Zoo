/*  1.
    How many stops are in the database. */

SELECT COUNT(id)
  FROM stops


/*  2.
    Find the id value for the stop 'Craiglockhart'. */

SELECT id
  FROM stops
 WHERE name = 'Craiglockhart'


/*  3.
    Give the id and the name for the stops on the '4' 'LRT' service. */

SELECT id, name
  FROM stops JOIN route ON (id = stop)
 WHERE num = '4' AND company = 'LRT'


/*  4.  Routes and stops
    The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
Run the query and notice the two services that link these stops have a count of 2.
Add a HAVING clause to restrict the output to these two routes. */ 

SELECT company, num, COUNT(*)
  FROM route WHERE stop = 149 OR stop = 53
 GROUP BY company, num
 HAVING COUNT(*) = 2


/*  5
    Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes.
Change the query so that it shows the services from Craiglockhart to London Road. */

SELECT a.company, a.num, a.stop, b.stop
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
 WHERE a.stop = 53
 AND b.stop = 149


/*  6.
    The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number.
Change the query so that the services between 'Craiglockhart' and 'London Road' are shown.
If you are tired of these places try 'Fairmilehead' against 'Tollcross'. */

SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
 WHERE stopa.name = 'Craiglockhart'
 AND stopb.name = 'London Road'


/*  7.  Using a self join
    Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith'). */

SELECT DISTINCT(a.company), a.num
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
 WHERE a.stop = 115 AND b.stop = 137 


/*  8.
    Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'. */

SELECT DISTINCT(a.company), a.num
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
 WHERE stopa.name = 'Craiglockhart'
 AND stopb.name = 'Tollcross'


/*  9.
    Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus,
    including 'Craiglockhart' itself, offered by the LRT company.
Include the company and bus no. of the relevant services. */

SELECT DISTINCT(stopb.name),a.company, a.num
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
 WHERE stopa.name = 'Craiglockhart'
 AND a.company = 'LRT'

/*  10.
    Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus. */

SELECT busa.busnumber AS 'num', busa.company, busb.transfer AS 'name', busb.busnumber AS 'num', busb.company 
  FROM (SELECT r1.num AS 'busnumber', r1.company AS 'company', r2.stop AS 'stopp' 
          FROM route r1 JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) 
          JOIN stops s1 ON s1.id = r1.stop
          JOIN stops s2 ON s2.id = r2.stop
         WHERE s1.name = 'Craiglockhart'
       ) busa JOIN (SELECT s1.name AS 'transfer', 
                         r1.num AS 'busnumber', 
                         r1.company AS 'company', 
                         r1.stop AS 'stopp', 
                         r1.pos AS 'pos' 
                          FROM route r1 JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) 
                         JOIN stops s1 ON s1.id = r1.stop
                         JOIN stops s2 ON s2.id = r2.stop
                         WHERE s2.name = 'Lochend') busb ON (busa.stopp = busb.stopp)
                         ORDER BY busa.busnumber, name, 4;
                         
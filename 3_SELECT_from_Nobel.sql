/*  1.  Winners from 1950
    Change the query shown so that it displays Nobel prizes for 1950. */

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950


/*  2.  1962 Literature
    Show who won the 1962 prize for Literature. */

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'


/*  3.  Albert Einstein
    Show the year and subject that won 'Albert Einstein' his prize. */

SELECT yr, subject
  FROM nobel
 WHERE winner = 'Albert Einstein'


/*  4.  Recent Peace Prizes
    Give the name of the 'Peace' winners since the year 2000, including 2000. */

SELECT winner
  FROM nobel
 WHERE subject = 'Peace'
 AND yr >= 2000


/*  5.  Literature in the 1980's
    Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. */

SELECT yr, subject, winner
  FROM nobel
 WHERE subject = 'Literature'
 AND yr BETWEEN 1980 AND 1989


/*  6.  Only Presidents
    Show all details of the presidential winners:

    - Theodore Roosevelt
    - Woodrow Wilson
    - Jimmy Carter
    - Barack Obama */

SELECT * FROM nobel
 WHERE winner = 'Theodore Roosevelt'
 OR winner = 'Woodrow Wilson'
 OR winner = 'Jimmy Carter'
 OR winner = 'Barack Obama'


/*  7.  John
    Show the winners with first name John. */

SELECT winner
  FROM nobel
 WHERE winner LIKE 'John%'


/*  8.  Chemistry and Physics from different years
    Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984. */

SELECT yr, subject, winner
  FROM nobel
 WHERE (subject = 'Physics' AND yr = 1980)
 OR (subject = 'Chemistry'AND yr = 1984)


/*  9.  Exclude Chemists and Medics
    Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine. */

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1980
 AND subject <> 'Medicine'
 AND subject <> 'Chemistry'


/*  10. Early Medicine, Late Literature
    Show year, subject, and name of people who won a 'Medicine' prize in an early year 
    (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year 
    (after 2004, including 2004) */

SELECT yr, subject, winner
  FROM nobel
 WHERE (yr < 1910 AND subject = 'Medicine')
 OR (yr >= 2004 AND subject = 'Literature')


/*  11. Umlaut
    Find all details of the prize won by PETER GRÜNBERG. */

SELECT yr, subject, winner
  FROM nobel
 WHERE winner = 'PETER GRÜNBERG'


/*  12. Apostrophe
    Find all details of the prize won by EUGENE O'NEILL. */

SELECT yr, subject, winner
  FROM nobel
 WHERE winner = 'EUGENE O''NEILL'


/*  13. Knights of the realm
    Knights in order

    List the winners, year and subject where the winner starts with Sir.
    Show the the most recent first, then by name order. */

SELECT winner, yr, subject
  FROM nobel
 WHERE winner LIKE 'Sir%'
 ORDER BY yr DESC, winner


/*  14. Chemistry and Physics last
    The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.

    Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last. */

SELECT winner, subject
  FROM nobel
 WHERE yr = 1984
 ORDER BY 
 CASE WHEN subject IN ('Physics','Chemistry') THEN 1 ELSE 0 END,
  subject, winner

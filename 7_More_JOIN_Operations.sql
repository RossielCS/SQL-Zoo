/*  1.
    List the films where the yr is 1962 [Show id, title]. */

SELECT id, title
 FROM movie
 WHERE yr=1962


/*  2.
    When was Citizen Kane released?. */

SELECT yr
  FROM movie
 WHERE title = 'Citizen Kane'


/*  3.  Star Trek movies
    List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title).
    Order results by year. */

SELECT id, title, yr
  FROM movie
 WHERE title LIKE '%Star Trek%'
 ORDER BY yr


/*  4.  id for actor Glenn Close
    What id number does the actor 'Glenn Close' have?. */

SELECT id
  FROM actor
 WHERE name = 'Glenn Close'


/*  5.  id for Casablanca
    What is the id of the film 'Casablanca'. */ 

SELECT id
  FROM movie
 WHERE title = 'Casablanca'


/*  6.  Cast list for Casablanca
    Obtain the cast list for 'Casablanca'.
    
    Use movieid=11768, (or whatever value you got from the previous question). */

SELECT name
  FROM casting JOIN actor ON (id = actorid)
 WHERE movieid = 11768


/*  7.  Alien cast list
    Obtain the cast list for the film 'Alien'. */

SELECT name
  FROM casting JOIN actor ON (id = actorid)
 WHERE movieid = (
   SELECT id 
     FROM movie
    WHERE title = 'Alien'
  )


/*  8.  Harrison Ford movies
    List the films in which 'Harrison Ford' has appeared. */

SELECT title
  FROM casting JOIN movie ON (id = movieid)
 WHERE actorid = (
   SELECT id
     FROM actor
    WHERE name = 'Harrison Ford'
  )

/*  9.  Harrison Ford as a supporting actor
    List the films where 'Harrison Ford' has appeared - but not in the starring role.
    [Note: the ord field of casting gives the position of the actor.
    If ord=1 then this actor is in the starring role]. */

SELECT title
  FROM casting JOIN movie ON (id = movieid)
 WHERE actorid = (
   SELECT id
     FROM actor
    WHERE name = 'Harrison Ford'
  )
 AND ord <> 1


/*  10. Lead actors in 1962 movies
    List the films together with the leading star for all 1962 films. */

SELECT title, name
  FROM casting JOIN movie ON (id = movieid) 
               JOIN actor ON (actor.id = actorid)
 WHERE yr = 1962
 AND ord = 1


/*  11. Busy years for Rock Hudson
    Which were the busiest years for 'Rock Hudson', 
show the year and the number of movies he made each year for any year in which he made more than 2 movies. */

SELECT yr, COUNT(title)
  FROM movie JOIN casting ON (movie.id = movieid)
             JOIN actor   ON (actorid = actor.id)
 WHERE name = 'Rock Hudson'
 GROUP BY yr
 HAVING COUNT(title) > 2


/*  12. Lead actor in Julie Andrews movies
    List the film title and the leading actor for all of the films 'Julie Andrews' played in. */

SELECT title, name
  FROM casting JOIN movie ON (movie.id = movieid
                              AND ord = 1)
               JOIN actor ON (actor.id = actorid)
 WHERE movie.id IN (
   SELECT movieid 
     FROM casting
    WHERE actorid IN (
       SELECT id
         FROM actor
        WHERE name = 'Julie Andrews'))


/*  13. Actors with 15 leading roles
    Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. */

SELECT name
  FROM casting JOIN actor ON (id = actorid
                              AND (
                               SELECT COUNT(ord)
                                 FROM casting
                                WHERE id = actorid
                                AND ord = 1)
                              >= 15)
 GROUP BY name


/*  14.
    List the films released in the year 1978 ordered by the number of actors in the cast, then by title. */

SELECT title, COUNT(actorid)
  FROM casting JOIN movie ON (movie.id = movieid)
               JOIN actor ON (actor.id = actorid)
 WHERE yr = 1978
 GROUP BY title
 ORDER BY COUNT(actorid) DESC, title


/*  15.
    List all the people who have worked with 'Art Garfunkel'. */

SELECT name
  FROM casting JOIN actor ON (id = actorid)
 WHERE movieid IN (
   SELECT movieid
     FROM casting JOIN actor ON ( id = actorid
                                 AND name = 'Art Garfunkel')
   )
 AND name != 'Art Garfunkel'

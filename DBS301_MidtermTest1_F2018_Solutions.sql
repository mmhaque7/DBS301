-------------------------------------------------------------------------------
-- DBS301 Midterm Test
-- Date: October 18th, 2018
-- Student Name: Clint MacDonald
-- Student ID: SOLUTION FILE
-------------------------------------------------------------------------------
-- OUT OF 30 MARKS
--Q1
SELECT namefirst || ' ' || namelast AS "Name"
    FROM tbldatplayers JOIN tbljncrosters USING (playerID)
    WHERE UPPER(nameFirst) LIKE 'C%' AND teamID=&teamID
    ORDER BY namefirst, namelast;
    
--Q2
SELECT  games.gameID AS "gameID", 
        games.gameNum AS "Game#", 
        games.gamedatetime AS "Date",
        home.teamnamelong AS "Home Team",
        visit.teamnamelong AS "Away Team",
        games.locationid AS "LocID",
        NVL(games.notes,'-') AS "Notes"
    FROM tbldatgames games
        JOIN tbldatteams home ON games.hometeam = home.teamid
        JOIN tbldatteams visit ON games.visitteam = visit.teamid
    WHERE games.hometeam = 222 OR games.visitteam = 222
    ORDER BY games.gamedatetime;
--Q3
SELECT  gameID AS "gameID", 
        gameNum AS "Game#", 
        to_char(gamedatetime,'fmDay, Month ddth, yyyy') AS "Date",
        hometeam AS "Home Team",
        homescore AS "Home Score",
        visitscore AS "Visit Score",
        visitteam AS "Away Team",
        CASE 
            WHEN homescore > visitscore THEN 'Home'
            WHEN visitscore > homescore THEN 'Away'
            ELSE 'Tie'
            END AS "Winner"
    FROM tbldatgames
    WHERE gamedatetime < sysdate AND gamedatetime > sysdate-8
    ORDER BY gamedatetime DESC;
--Q4
SELECT namelast || ', ' || namefirst AS "Player", IsActive
    FROM tbldatplayers 
    WHERE playerID IN (SELECT playerID FROM tbljncrosters WHERE teamID = 220)
    ORDER BY namelast, namefirst;
--Q5
SELECT teamnameshort, namefirst, namelast, regnumber, tbljncrosters.isactive
    FROM tbldatplayers 
        FULL OUTER JOIN tbljncrosters USING (playerid)
        FULL OUTER JOIN tbldatteams USING (teamid)
    ORDER BY teamnameshort, namefirst, namelast;
--Q6
SELECT  namefirst || ' ' || namelast AS "Player",
        SUM(numgoals) AS "Total Goals",
        teamnamelong AS "Team"
    FROM tbldatplayers JOIN tbldatgoalscorers USING (playerID)
        JOIN tbldatteams USING (teamid)
    GROUP BY namefirst, namelast, teamnamelong
    HAVING Sum(NumGoals) >= 10
    ORDER BY "Total Goals" DESC;
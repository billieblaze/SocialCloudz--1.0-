Here's the query to get the children of a community (or whatever)

SELECT DISTINCT A.TREELEVEL,A.childid,A.ParentID
 FROM API_CORPACCTTREE A
       INNER JOIN TREE B
           ON A.LeftExtent BETWEEN B.LeftExtent AND B.RightExtent
       INNER JOIN COMMUNITIES AA
           ON A.ChildID = AA.CommunityID
WHERE B.CommunityID = #id#
ORDER BY A.childid
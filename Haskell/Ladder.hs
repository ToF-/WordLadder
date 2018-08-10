module Ladder
where 

adjacent [] [] = False
adjacent (c:cs) (d:ds) = c /= d && cs == ds

# Write your MySQL query statement below
/*
Question 1: return the overall acceptance rate;
思路:
overall acceptance rate = # of unique accept / # of unique request;
难点:
- Need to cover corner test cases when both table are empty, since count only count 
non-null value. 
- 原来想着用CTE求俩值，有些浪费内存，subquery as single-value就够够用了
*/

# SELECT
#     IFNULL(ROUND((SELECT count(distinct requester_id,accepter_id) FROM RequestAccepted)/
#     (SELECT count(distinct sender_id,send_to_id) FROM FriendRequest),2),0.00) AS accept_rate

/*
Follow-up-1: return the acceptance rate for every month?
*/





/*
Follow-up-2: Return the cumulative accpetance rate for every day?
*/

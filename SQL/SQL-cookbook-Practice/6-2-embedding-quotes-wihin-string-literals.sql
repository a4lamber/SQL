/*
Problem: you want to embed quote marks within string literals. 
Introduce how to work with '' with string in SQL
*/




# 在quote mark''中，''代表一个引号
select '''' as comment from t1;

# example
select 'girl friend''s birthday' comment from t1;

# '' means null in SQL
select '' as comment from t1;
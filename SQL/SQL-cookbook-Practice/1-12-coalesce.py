'''
 # @ Author: Yixiang Zhang
 # @ Create Time: 2022-08-19 10:01:25
 # @ Modified by: Yixiang Zhang
 # @ Modified time: 2022-08-19 10:38:22
 # @ Description:
 Created SQL-equivalent coalesce function in python
 for better understanind how it works.
 '''

comm = [None,300,500,None,1400,None,None,None,None,0,None,None,None,None,]

def coalesce(inputs):
    """
    replicate coalesce function in SQL.
    Args:
        inputs (list): a list of variable.
    Returns:
        _type_: the first non-None value if exists.
    """
    # initialize output to be None
    output = None
    # iterate through inputs
    for input in inputs:
        # find the 1s occurance of not None, then break
        if input is not None:
            output = input
            break
    return output


def null_modifier(inputs,change_to):
    """
    SQL equivalent version of COALESCE(comm,0)
    where comm is a column name.
    Args:
        inputs (_type_): column containing None in Python or Null in SQL
        change_to (_type_): the value you wish to replace None  

    Returns:
        list: the new list 
    """
    output = []
    for input in inputs:
        temp = [input,change_to]
        output.append(coalesce(temp))
    return output

a = coalesce(inputs = comm)
# print(a)

b = null_modifier(inputs = comm,
                  change_to = 0)
print(b)



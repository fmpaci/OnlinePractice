#Given an integer, n , and n space-separated integers as input, create a tuple, t , of those n integers. 
#Then compute and print the result of hash(t).

#Note: hash() is one of the functions in the __builtins__ module, so it need not be imported.

# Input Format

#The first line contains an integer, n , denoting the number of elements in the tuple.
#The second line contains n space-separated integers describing the elements in tuple .

#Output Format

#Print the result of hash(t).

##Important: Is necesary to use Python 2 to pass the test.

if __name__ == '__main__':
    n = int(raw_input())
    integer_list = map(int, raw_input().split())
    print(hash(tuple(integer_list)))
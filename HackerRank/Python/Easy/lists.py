# Consider a list (list = []). You can perform the following commands:
# 
# insert i e: Insert integer  at position .
# print: Print the list.
# remove e: Delete the first occurrence of integer .
# append e: Insert integer  at the end of the list.
# sort: Sort the list.
# pop: Pop the last element from the list.
# reverse: Reverse the list.


if __name__ == '__main__':
    N = int(input())
    lst = []
    for i in range(N):
        cmd_input = input().split()
        command = cmd_input[0]
        if command == 'insert':
            cmd_i = int(cmd_input[1])
            cmd_e = int(cmd_input[2])
            lst.insert(cmd_i, cmd_e)
        elif command == 'print':
            print(lst)
        elif command == 'remove':
            cmd_e = int(cmd_input[1])
            lst.remove(cmd_e)
        elif command == 'append':
            cmd_e = int(cmd_input[1])
            lst.append(cmd_e)
        elif command == 'sort':
            lst.sort()
        elif command == 'pop':
            lst.pop()
        elif command == 'reverse':
            lst.reverse()
        else:
            print("Invalid Input")
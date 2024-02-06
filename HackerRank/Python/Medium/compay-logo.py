#!/bin/python3

import math
import os
import random
import re
import sys


def calculate_chars(s):
    aux = {k:s.count(k) for k in s}
    list_of_values = [v for k,v in aux.items()]
    list_of_values.sort(reverse=True)
    for i in range(3):
        keys = [k for k,v in aux.items() if v == list_of_values[i]]
        keys.sort()
        print(f"{keys[0]} {list_of_values[i]}")
        aux.pop(keys[0])


if __name__ == '__main__':
    s = input()
    calculate_chars(s)

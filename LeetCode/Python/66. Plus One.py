class Solution:
    def plusOne(self, digits: list[int]) -> list[int]:
        num = 0
        for digit in digits:
            num = num * 10 + digit
        
        num = num + 1

        result = []

        while num > 0:
            result.insert(0, num % 10)
            num //= 10
        
        return result


# Test cases, IA generated
def test_plusOne():
    """Test the plusOne function with various test cases."""
    plusOne = Solution().plusOne
    
    # Test case 1: Normal increment
    digits1 = [1, 2, 3]
    result1 = plusOne(digits1.copy())
    expected1 = [1, 2, 4]
    print(f"Test 1: {digits1} -> {result1}, Expected: {expected1}")
    assert result1 == expected1, f"Test 1 failed: got {result1}, expected {expected1}"
    
    # Test case 2: Normal increment
    digits2 = [4, 3, 2, 1]
    result2 = plusOne(digits2.copy())
    expected2 = [4, 3, 2, 2]
    print(f"Test 2: {digits2} -> {result2}, Expected: {expected2}")
    assert result2 == expected2, f"Test 2 failed: got {result2}, expected {expected2}"
    
    # Test case 3: Carry operation
    digits3 = [9]
    result3 = plusOne(digits3.copy())
    expected3 = [1, 0]
    print(f"Test 3: {digits3} -> {result3}, Expected: {expected3}")
    assert result3 == expected3, f"Test 3 failed: got {result3}, expected {expected3}"
    
    # Test case 4: Multiple 9s
    digits4 = [9, 9, 9]
    result4 = plusOne(digits4.copy())
    expected4 = [1, 0, 0, 0]
    print(f"Test 4: {digits4} -> {result4}, Expected: {expected4}")
    assert result4 == expected4, f"Test 4 failed: got {result4}, expected {expected4}"
    
    # Test case 5: Single digit non-9
    digits5 = [5]
    result5 = plusOne(digits5.copy())
    expected5 = [6]
    print(f"Test 5: {digits5} -> {result5}, Expected: {expected5}")
    assert result5 == expected5, f"Test 5 failed: got {result5}, expected {expected5}"
    
    # Test case 6: Mixed digits with carry
    digits6 = [1, 9, 9]
    result6 = plusOne(digits6.copy())
    expected6 = [2, 0, 0]
    print(f"Test 6: {digits6} -> {result6}, Expected: {expected6}")
    assert result6 == expected6, f"Test 6 failed: got {result6}, expected {expected6}"
    
    print("All test cases passed!")


if __name__ == "__main__":
    test_plusOne()

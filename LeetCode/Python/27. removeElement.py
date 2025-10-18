class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:
        replaced_list = [num for num in nums if num != val]
        nums[:len(replaced_list)] = replaced_list
        return len(replaced_list)
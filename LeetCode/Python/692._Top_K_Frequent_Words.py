
class Solution:
    def topKFrequent(self, words: List[str], k: int) -> List[str]:
        final_list = []
        word_count = {word:words.count(word) for word in words}
        frequency = [v for k,v in word_count.items()]
        frequency.sort(reverse=True)
        for i in range(k):
            word = [k for k,v in word_count.items() if v == frequency[i]]
            word.sort()
            final_list.append(word[0])
            word_count.pop(word[0])
        return final_list
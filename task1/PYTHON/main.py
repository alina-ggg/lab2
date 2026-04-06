def allSymvl(strok, t):
    count = [0] * 128

    for i in strok:
        count[ord(i)] += 1

    for i in t:
        count[ord(i)] -= 1
        if count[ord(i)] < 0:
            return False
    return True

def minStr(s, t):
    if len(t) > len(s):
        return "Не найдено"

    result = ""
    minLen = len(s) + 1

    for i in range (0, len(s)):
        for j in range (i, len(s)):
            strok = s[i : j+1]

            if allSymvl(strok, t):
                if len(strok) < minLen:
                    minLen = len(strok)
                    result = strok

                break

    return result if result else "Не найдено"


s = input()
t = input()
print(minStr(s, t))
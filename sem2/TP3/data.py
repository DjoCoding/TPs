def toList(s : str) -> list:
    result = []
    temp = ""
    for i in range(len(s)):
        if (s[i] != '[') and (s[i] != ']') and (s[i] != ','):
            if (s[i] == "'"):
                if (temp != ""):
                    result.append(temp)
                    temp = ""
            else :
                temp += s[i]
    return result



# with open('p' , 'r') as data:
#     with open('result.txt' , 'w') as result:
#         for line in data:
#             content = toList(line)
#             for word in content :
#                 result.write(word)
#                 result.write('\n')
#         result.close()
#     data.close()
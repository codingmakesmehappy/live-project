from pyecharts import Bar
from pyecharts import Line
import re

record = ""
timearr= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
with open('PlusA.txt','r',encoding='utf-8') as file:
    for char in file:
        record += char
        #print(char)
        #print(record)

pattern = re.compile("([0-1]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])")   # 查找时间
timelist = pattern.findall(record)

#统计时间
for i in timelist:
    x = int(i[0])%24
    #print(x)
    timearr[x] = timearr[x] + 1
print(timearr)

#绘制 发言量—时间 折线图
attr = []
for i in range(0,24):
    attr.append(str(i)+"点")

print(attr)

v1 = timearr

line = Line("各时间段发言量分布")
line.add("时间段内消息总数",attr, v1,is_smooth = True)
line.render('line01.html')

import jieba
from wordcloud import WordCloud

newtext = []
textname = 'QQrecord-2022.txt'

for word in open(textname, 'r', encoding='utf-8'):
    tmp = word[0:4]
    if (tmp == "2022" or tmp == "===="):  # 过滤掉聊天记录的时间和qq名称
        continue
    tmp = word[0:2]
    if (tmp[0] == '[' or tmp[0] == '/' or tmp[0] == '@'):  # 过滤掉图片和表情，例如[图片]，/滑稽
        continue
    newtext.append(word)

textname_opt=textname[:-4]+'_opt.txt'  # 重写分词文件
with open(textname_opt, 'w', encoding='utf-8') as f:
    for i in newtext:
        f.write(i)

text = open(textname_opt, 'r', encoding='utf-8').read()  #过滤好的txt文件

stopword = {'我要', '软工', '实践', '红包', '换组', '一条', '一个', '同学', '表情', '撤回', '作业', '助教', '图片'}

def jiebaclearText(text):
    mywordlist = []
    seg_list = jieba.cut(text, cut_all=False)
    liststr="/ ".join(seg_list)
    f_stop = open('StopWords.txt')
    try:
        f_stop_text = f_stop.read( )
    finally:
        f_stop.close( )
    f_stop_seg_list=f_stop_text.split('\n')
    for myword in liststr.split('/'):
        if not(myword.strip() in f_stop_seg_list) and len(myword.strip())>1:
            mywordlist.append(myword)
    return ''.join(mywordlist)

text = jiebaclearText(text)

wordcloud = WordCloud(
                        max_words=50,
                        background_color='white',
                        width=800,
                        height=600,
                        margin=10,
                        stopwords=stopword, #  手动添加的筛选词
                        font_path='C:/Windows/Fonts/simhei.ttf'
                      )
wordcloud.generate(text)

picture=textname[:-4]+'.jpg'
wordcloud.to_file(picture)  # 输出词云
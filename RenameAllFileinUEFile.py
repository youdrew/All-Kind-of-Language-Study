import os
import pypinyin

#这是一个将文件夹下所有的子文件/文件夹改成拼音的小程序
#撰写日期：20220124  Engene

def is_chinese(string):
    """
    检查整个字符串是否包含中文
    :param string: 需要检查的字符串
    :return: bool
    """
    for ch in string:
        if u'\u4e00' <= ch <= u'\u9fff':
            return True
    return False


def ADDFileName(parent, dirnames, filenames):

    for filename in filenames:
        # print("parent is: " + parent)
        # print("filename is: " + filename)
        # print("dirnames is: " + dirnames)
        # print(os.path.join(parent, filename))

        # 输出rootdir路径下所有文件（包含子文件）信息
        #files_list.append([os.path.join(parent, filename)])
        print([os.path.join(parent, filename)])

        #如果找到了文件立刻改名
        for filename in filenames:
            if is_chinese(filename):
                EN= pypinyin.lazy_pinyin(filename)
                strEN="".join(EN)
                if os.path.exists(parent + "/" + filename):
                    os.rename(parent + "/" + filename, parent + "/" + strEN)

        #如果找到的文件以**为尾缀，打开来遍历




def get_files_list(dir):

    for parent, dirnames, filenames in os.walk(dir):
        ADDFileName(parent, dirnames, filenames)
        #如果找到了文件立刻改名
        for filename in filenames:
            if is_chinese(filename):
                EN= pypinyin.lazy_pinyin(filename)
                strEN="".join(EN)
                if os.path.exists(parent + "/" + filename):
                    os.rename(parent + "/" + filename, parent + "/" + strEN)


        # 判断字符串里是否包含中文
        for m in dirnames:
            #如果包含中文
            if is_chinese(m):
                EN= pypinyin.lazy_pinyin(m)
                strEN="".join(EN)
                if os.path.exists(dir + "/" + m):
                    os.rename(dir + "/" + m, dir + "/" + strEN)


        #往下遍历
        if dirnames!=None:
            m = 0
            while m < len(dirnames):
                subdir = dir + "/" + dirnames[m]
                m=1+m
                get_files_list(subdir)


if __name__ == '__main__':
    dir = input("请把你想要修改文件名的文件夹整个扔进来🚮 \n 请注意，路径后面不要有空格符。")
    print("读取到的路径是: ", dir)
    get_files_list(dir)
# 将XG的FBX文件转换成人可读的文件类型
#撰写日期：20220830  EngeneHsuan
#conding=utf8

import os
import struct
import binascii
import shutil


def readDouble(fw):
    dob = fw.read(8)
    value = struct.unpack('d', dob)[0]
    return value


def readInt32(fw):
    dob = fw.read(4)
    value = struct.unpack('i', dob)[0]
    return value


def readVec3(fw):
    p1 = readDouble(fw)
    p2 = readDouble(fw)
    p3 = readDouble(fw)
    return (p1,p2,p3)


def readMat3x3(fw):
    m1 = readVec3(fw)
    m2 = readVec3(fw)
    m3 = readVec3(fw)
    return (m1,m2,m3)


def readTimecode(fw):
    hh =  readInt32(fw)
    mm =  readInt32(fw)
    ss =  readInt32(fw)
    frame = readInt32(fw)
    return (hh,mm,ss,frame)


def readPose(fw):
    pos = readVec3(fw)
    rotate = readMat3x3(fw)
    timecode = readTimecode(fw)
    return (pos,rotate,timecode)


def findAllFile(base):                      #文件夹内的遍历
    for SubFilePath, ds, fs in os.walk(base):
        for f in fs:
            yield f,SubFilePath


def findNeededFile(dir):                    #给定一个路径，返回所有的.raw文件的绝对路径，并将他们建立为一个String列表返回
    Count=0
    RawFileList=[]
    for File,root in findAllFile(dir):
        #root获取到的是最底层的文件路径，File获取到的是文件
        s, extension = os.path.splitext(File)
        if(extension==".raw"):
            Count = 1 + Count
            FullPathName =  root +"/"+ File
            RawFileList.append(FullPathName)
            #[测试输出值]print("需要修改的第", Count, "个地址是: ", FullPathName)
    return RawFileList


def decodeBinary(RawFileList):             #给一个.raw文件路径的列表，返回修改后的文件绝对路径列表
    afterDecodeFileList = []
    print("\n")
    for oneFilePath in RawFileList:
        print("\n \n %s File_Path ——————>  File_Path :    %s" % (RawFileList.index(oneFilePath) + 1, oneFilePath)) #打印一个raw文件的路径
        #print("上级目录：",print(os.path.abspath(os.path.join(oneFilePath, ".."))))

        with open(oneFilePath, 'rb') as file:  # 打开一个raw文件
            size = os.path.getsize(oneFilePath)
            with open(os.path.abspath(os.path.join(oneFilePath, ".."))+"/0.txt","w") as filecopy:   #创建一个txt文件
                afterDecodeFileList.append(os.path.abspath(os.path.join(oneFilePath, ".."))+"/0.txt")
                for Line in range(size//(8*3+8*9+4*4)):
                    pose = readPose(file)       #每次只读区一行的数据
                    print(Line,":",pose)
                    filecopy.write(pose.__str__())
                    filecopy.write("\n")
    return afterDecodeFileList


def Renamer(oldName):                      #给定一个绝对路径将其改名为上级路径的名称，扩展名不变，返回新的名称
    upperFIleName = os.path.basename(oldName)
    newName = os.path.abspath(os.path.join(oldName, ".."))+upperFIleName+".txt"
    if os.path.exists(oldName) == True:
        os.rename(oldName, newName)
    return newName



#——————————————————————————————————————主函数——————————————————————————————————————————————

def main():
    #拿根目录
    dir = input("请把你想转换的FBX文件或是文件夹🚮进来 \n( 请注意，路径后面不要有空格符 ) \n请输入:")
    print("读取到的路径是: ", dir)
    print('\n' + 30 * '-' + '\n')

    #获取所有的.raw文件
    RawFileList = findNeededFile(dir)

    #将RawFileList中所有的raw文件反二进制到.txt文件中
    afterDecodeFileList = decodeBinary(RawFileList)
    print(afterDecodeFileList)

    #询问用是要整合到一个文件夹还是直接放在.raw文件的边上
    ask = input("是否需要把所有转换后的文件放到一个统一的文件夹下？ \n请输入(1或0):")
    if(ask=='1'):
        toPath = input("请输入需要转换移动到的路径？\n(请自行创建好文件夹，因为鑫哥的raw文件都是叫0的，所以这里会以素材条号命名) \n请输入:")
        for oneAfterDecodeFileList in afterDecodeFileList:
            if os.path.exists(toPath) == False:
                print("文件夹不存在")
            if os.path.isdir(toPath):
                if os.path.exists(Renamer(oneAfterDecodeFileList)) == True:
                    shutil.copy(Renamer(oneAfterDecodeFileList), toPath)
            else:
                print("路径有问题")

    print("\n \n 脚本完成 ✅")


if __name__ == '__main__':
    main()
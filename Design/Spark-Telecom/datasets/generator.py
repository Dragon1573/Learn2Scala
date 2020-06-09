#!/usr/bin/env python
# coding: utf-8

# 使用Python生成符合规范的数据集

from random import randint
import time
import json
import sys


if len(sys.argv) != 3:
    raise SyntaxError("错误：需要2个额外参数指定数据集规模！")


jsonObj = {
    # 登录时间
    'logid': '201803202114010303498949',
    # 用户编号（A0001～A1000）
    'imei': 'A0273',
    # IP地址（192.168.0.1～192.168.0.3）
    'requestip': '192.168.0.3',
    # 用户区域（浙江·丽水、福建·南平、福建·福州）
    'areacode': '0',
    # 登录渠道（手机、电脑、平板）
    'channelno': '2',
    # 请求类型（GET、POST）
    'requesttype': '1',
    # 请求结果（无结果、查询成功）
    'responsedata': '1'
}


start_time = time.mktime((2020, 5, 1, 0, 0, 0, 0, 0, 0))
end_time = time.mktime((2020, 5, 31, 23, 59, 59, 0, 0, 0))


def randomLogin():
    """ 登陆时间戳 """
    t = randint(start_time, end_time)
    date_tuple = time.localtime(t)
    date = time.strftime('%Y%m%d%H%M%S', date_tuple)
    return date + ('%010d' % t)


def randomIMEI():
    """ 用户编号 """
    return ('A%04d' % randint(1, 1000))


def randomRequestIp():
    return '192.168.0.%d' % randint(1, 3)


def randomJSON():
    jsonObj['logid'] = randomLogin()
    jsonObj['imei'] = randomIMEI()
    jsonObj['requestip'] = randomRequestIp()
    jsonObj['areacode'] = str(randint(0, 2))
    jsonObj['channelno'] = str(randint(0, 2))
    jsonObj['requesttype'] = str(randint(0, 1))
    jsonObj['responsedata'] = str(randint(0, 1))


if __name__ == "__main__":
    with open(sys.argv[2], 'w', encoding='UTF-8') as file:
        for i in range(int(sys.argv[1])):
            randomJSON()
            file.write(json.dumps(jsonObj, ensure_ascii=False) + '\n')

#!/usr/bin/env python
#author :  with <dc198424601@outlook.com>
# -*- coding: utf-8 -*-

import os
import json
import re

def get_windows():
    #获得一个字典,键是工作区名字,值是一个列表,里面是程序的classname
    classPattern=re.compile("class': '(.*?)',")#获取class名称的正则
    tree_dict={}
    p=os.popen('i3-msg -t get_tree')
    treeData=json.load(p)
    for workspace in treeData['nodes'][1]['nodes'][1]['nodes']:
        tree_dict[workspace['name']]=[]
        windows=classPattern.findall(str(workspace))
        for i in windows:
            tree_dict[workspace['name']].append(i)
    return tree_dict


def get_current_workspace():
    #返回当前工作区的名字
    p=os.popen('i3-msg -t get_workspaces')
    treeData=json.load(p)
    for i in treeData:
        if i['focused']==True:
            return i['name']


if __name__=="__main__":
    current_player=os.popen("playerctl -p netease-cloud-music,mpv,%any metadata|cut -d' ' -f1|uniq").read().replace('\n','')
    if current_player not in (get_windows()[get_current_workspace()]):
        os.system("i3-msg -t command [class={}] focus".format(current_player))
    else:
        os.system("i3-msg -t command workspace back_and_forth")

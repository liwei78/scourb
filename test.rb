# encoding: utf-8
a = '<a href="/html/guzhenshipin/2012/1013/150.html" target="_blank">中国古镇泸沽湖：神往之地</a>'
p a.scan('uz')
p a.scan('中国古')
p a.scan('皇家')

p '皇冠'.force_encoding('GBK')
p '中国'.force_encoding('GBK')

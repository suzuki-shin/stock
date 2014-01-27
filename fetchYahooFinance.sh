#!/bin/sh
#
# http://info.finance.yahoo.co.jp/history/?code=**** の株価時系列データのページを取ってくる
#


pages="1 2"
divl=100000000
code=$1
url="http://info.finance.yahoo.co.jp/history/?code="$code"&p="

for page in $pages;do
  curl -o tmp/yf$page $url$page
done

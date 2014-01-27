#!/bin/sh
#
# http://www.miller.co.jp/ のケンミレ式年初来高値更新銘柄 ページをとってきてnkfでUTF-8にする
#

pages="1 2"
divl=100000000

for page in $pages;do
  curl -O http://www.miller.co.jp/applications/cgi-bin/cv0/rnk20/01/cv0rnk20c.cgi -X POST -d "rankid=4" -d "p_kbn=0" -d "id=4" -d "page=$page" -d "divl=$divl" -d "ind_code=0";
  cat cv0rnk20c.cgi | nkf -u > ./tmp/kenmile_utf8_$page.html
  rm cv0rnk20c.cgi
done

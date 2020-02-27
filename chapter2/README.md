chapter1.nasをわかりやすく書き換える→chapter2.nas

chapter2.nasの内、ブートセクタだけ残したものをipl.nasとしてファイルを作成する。

ブートセクタ以外の部分をtail.asmファイルとして作成。



`nasm ipl.nas -o ipl.bin -l ipl.lst`で　ipl.nasをコンパイルしたものをipl.binとして出力。また、

どの命令がどの機械語に翻訳されたかを確認できるテキストファイルipl.lstを作成した。



ブートセクタとtail.asmをコンパイルしてつなげるためのMakefileを作成



参考記事

http://tsurugidake.hatenablog.jp/entry/2017/08/15/202414

https://yn0014.hatenablog.com/entry/2019/01/16/233946j
; hello-os
; TAB=4

ORG 0x7c00               ; このプログラムがどこに読み込まれるのか

; 以下は標準的なFAT12フォーマットフロッピーディスクのための記述

JMP entry
DB 0x90

DB "HELLOIPL"              ; ブートセクタの名前を自由に書いてよい（8バイト）
DW 512                     ; 1セクタの大きさ（512にしなければならない）
DB 1                       ; クラスタの大きさ（1セクタにしなければならない）
DW 1                       ; FATがどこから始まるか（普通は1セクタ目にする）
DB 2                       ; FATの個数（2にしなければならない定）
DW 224                     ; ルートディレクトリ領域の大きさ（普通は224エントリ）
DW 2280                    ; このドライブの大きさ(2280にしなければならない)
DB 0xf0                    ; メディアのタイプ（0xf0にしなければならない）
DW 9                       ; FAT領域の長さ（9セクタにしなければならない）
DW 18                      ; 1トラックにいくつのセクタがあるか（18にしなければならない）
DW 2                       ; ヘッドの数（2にしなければならない）
DD 0                       ; パーティションを使っていないので0
DD 2880                    ; このドライブの大きさをもう一度書く
DB 0,0,0x29                ; よくわからないけどこの値にしておくといいらしい
DD 0xffffffff              ; 多分ボリュームシリアル番号
DB "HELLO-OS   "           ; ディスクの名前（11バイト）
DB "FAT12   "              ; フォーマットの名前（8バイト）
RESB 18                    ; とりあえず18バイトあけておく

; プログラム本体

entry:
  MOV AX,0
  MOV SS,AX
  MOV SP,0x7c00
  MOV DS,AX
  MOV ES,AX

  MOV SI,msg

putloop:
  MOV AL,[SI]
  ADD SI,1
  CMP AL,0
  JE fin
  MOV AH,0x0e
  MOV BX,15
  INT 0x10
  JMP putloop

fin:
  HLT
  JMP fin

; メッセージ部分

msg:
 db 0x0A, 0x0A              ; 改行を2つ
 db "hello. world"
 db 0x0A                    ; 改行
 db 0

 resb 0X1FE-($-$$)          ; 0X001FEまでを0X00で埋める命令

 db 0X55, 0XAA

; 以下はブートセクタ以外の部分の記述

DB 0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
RESB 4600
DB 0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
RESB 1469432

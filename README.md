# fpx.app for MAC OSX

フルスクリーンWEBView最前面表示アプリ for mac osx

## Summary

インスタレーションや、展示などで、ツールバーなどの全くないアプリ切り替えも出来ないウェブ表示、flash(swf)全画面表示がほしい時があります。
その時に役立つのがこのアプリ。
好きな画面サイズで、最前面にウィンドウを表示してくれて、ツールバーもなければ、ウィンドウバーもないです。四角い画面だけのアプリケーションです。
もちろんマルチスクリーンにも対応しています。
Flashの全画面表示でマルチスクリーンで使いたいときなど重宝しますよ。

## Download latest

Download [fpx.1.0.1.zip](https://github.com/fataio/fpx/raw/master/dist/fpx.1.0.1.zip).

## History

current: v1.0.1

1. Cmdキーを押しながら、起動することで、SettingModeに入ることができるようにしました。
2. Windowをトップに持ってこないようにするオプションを付けました。

## Usage

1. ファイル名を好きに変える。（変えなくてもいい。日本語不可。ascii文字限定、理由は「内部の動作」で説明します）
2. アプリを立ち上げる
3. 設定画面が現れるので、たちあげたいURLまたは、FILEを指定して、スクリーンの矩形を指定し、「Apply」する。
4. 自動的に起動する。終了は、Cmd+Qで。
5. なまえがtest.appなら、同じディレクトリにtest.plistというファイルができているので、それを直接編集しても良い。削除すれば、また編集画面が立ち上がるようになる。

と言った感じです。

## About internal

ファイル名を変えた時の内部動作。

1. test.appに変えると、test.app/Contents/MacOS/fpxバイナリの名前を、
test.app/Contents/MacOS/testに変更する。
2. test.app/Contents/Info.plist内の、「Executable file」、「Bundle identifier」、「Bundle name」をそれぞれ、「test」,「jp.yusukeshibata.fpx.test」,「test」に変更する。
3. そうすることで、`% killall test`などと、terminalから、直接アプリを終了することが出来るようになり、また、bundle identifierで、アプリを個別認識できるようになる。
4. アプリをコピーして２つとか立ち上げた場合でも、ちゃんと動作する設計です。


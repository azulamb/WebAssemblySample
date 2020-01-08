# WebAssemblySample

WebAssembly/WASI Sample

## Xorshift

C++で作ったXorshiftの答えを正解とし、AssemblyScriptから作ったWebAssemblyとJavaScriptのみでのXorshiftの実装の出力がおなじになるようにしたサンプル。

* xorshift/
  * answer.cpp
    * 答え。適当にオンラインサービスでビルドと実行をした
  * xorshift.ts
    * AssemblyScriptによるXorshiftの実装
  * xorshift.wast
  * xorshift.wat
    * 確認のために出力してみたテキスト形式のWebAssembly
* docs/
  * xorshift.html
    * 出力確認サイト兼JavaScriptによるXorshiftの実装
  * xorshift.wasm
    * AssemblyScriptによる出力結果
* node/
  * index.js
    * ブラウザと同じく10回乱数を発生させたサンプル
    * ブラウザと同じWebAssemblyを使用している
    * 読み込みは xorshift.js と同じ
  * xorshift.js
    * `--experimental-wasm-modules` フラグを有効にした読み込み方法
    * importのみでお手軽に使える
  * xorshift_old.js
    * `--expose-wasm` フラグを有効にした読み込み方法
    * ブラウザに近い方法で読み込む

## Reverse

入力文字列を反転させるサンプル。
ただしASCIIのみ対応とする。

* string/
  * reverse.ts
    * AssemblyScriptによる文字列の反転処理の実装
  * reverse.wat
    * 確認のために出力してみたテキスト形式のWebAssembly
* docs/
  * reverse.html
    * 出力確認サイト
  * reverse.wasm
    * AssemblyScriptによる出力結果

## WASI

WASIでHello, World!したサンプル。
ランタイムはLucetにしたかったがWindowsで使えなかったのでWasmtimeを使用。
ビルドができないのでビルドは https://wasm.fastlylabs.com/ で行った。（実行エラーは出るが出力は正常）

* wasi/
  * hello.wat
    * WAT形式の手書きによるHello, World!
    * そのままWasmtimeで実行も可能
  * hello.wasm
    * fastlyのTerrariumでビルドした結果
    * Wasmtimeで上と同じ結果になるのを確認

### 手書きによるWASIの利用

WASI対応をちゃんと使いたかったのでWAT形式の手書きで実装した。

いくつかあるのでメモ。

#### Wasmtimeのエントリーポイント

Wasmtimeでは特に指定しない場合は `_start` 関数を実行するのでこれを必ず用意する。

#### WASIの利用

単なる外部連携なのでインポートについては特筆することなし。

ただし使い方には色々気をつける必要がある。

例えば `fd_write` は以下のページでこのように書かれている。

https://github.com/bytecodealliance/wasmtime/blob/master/docs/WASI-api.md#fd_write

* Inputs
  * `__wasi_fd_t fd`
  * `const __wasi_ciovec_t *iovs` and `size_t iovs_len`
* Outputs:
  * `size_t nwritten`

これの書き方は非常にわかりにくくて実際はこう。

* `__wasi_fd_t fd`
  * __wasi_fd_t は `uint32_t` なので4バイトの整数
* `__wasi_ciovec_t *iovs`
  * `*iovs` はポインタなので4バイトの整数
  * `__wasi_ciovec_t` は後で出すが手書き構造体になる。
* `size_t iovs_len`
  * 上の構造体の数なので4バイトの整数
* `size_t *nwritten`
  * 返り値の4バイトの整数のポインタ

この4つの値を渡す必要がある。その作業が以下。

```wat
  ;; データをスタックに積んでいく
  i32.const 1 ;; どこに出力するか。標準出力はfd=1なので1を指定
  i32.const 0 ;; 文字列情報の構造体のポインタ。今回は0の位置に設置している
  i32.const 1 ;; 文字列のセット数。今回は1つなので1
  i32.const 8 ;; 返り値の格納先。今回は文字列情報の後ろに入れる。
  call $__wasi_fd_write ;; 上の4つの値を引数にして fd_write を実行
```

第一引数の1は標準出力の1なので分かるが他はメモリを見ないといけないので見る。

```wat
 (data (i32.const 0) "\0c\00\00\00\0d\00\00\00\00\00\00\00Hello, world!")
```

```txt
    | 0| 1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|
----+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
0x00|0C 00 00 00 0D 00 00 00 00 00 00 00 48 65 6C 6C
0x10|6F 2C 20 77 6F 72 6C 64 21
```

まず `__wasi_ciovec_t` は以下のような構造体となっている。

* `const void *buf`
  * バッファの開始ポインタ(4バイト)
* `size_t buf_len`
  * バッファサイズ(4バイト)

となっている。実際に値を見ると以下。

```txt
Address    | Memory      | Value
0x00～0x03 | 0C 00 00 00 | 12
0x04～0x07 | 0D 00 00 00 | 13
```

これの先頭アドレスが第二引数なので 0 を与えるとともにバッファは今回1つなので第三引数は1となる。

最後の返り値を格納する領域だが、今回はこの構造体の後ろに配置しているので4+4の8が格納先ポインタとなる。

文字列は更にその先にいるため、上の構造体では(4+4)+4の12がポインタとなりバッファサイズが13なので、上のメモリには12と13が入っている。ちなみに見て分かる通りバイトオーダーはリトルエンディアン。

ちなみに文字列を先に持ってくるとメモリアライメントの関係で4バイトの区切りができるようにするっぽい。

```txt
 (data (i32.const 0) "Hello, world!\00\00\00\00\00\00\00\0d\00\00\00")
```

こちらは`[文字列(13バイト)]` `[パディング(3バイト)]` `[バッファ開始ポインタ=0(4バイト)]` `[バッファサイズ=13(4バイト)]` で返り値を受け取る場所は 13+3+4+4の24となる。

#### エクスポート対象

Wasmtimeでの実行の場合は `_start` 関数が必要だが、他にも今回はメモリにデータを入れている。
文字列反転の時同様ホスト側でメモリにいい感じにアクセスして組み立てているようなので、今回であれば `memory` も外に出しておかないと出力がなくなるので注意。
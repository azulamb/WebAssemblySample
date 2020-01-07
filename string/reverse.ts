/// <reference path="../node_modules/assemblyscript/std/assembly/index.d.ts" />

// 文字列反転関数
// 実際にはメモリの中身を反転させていく。
// ただしどこまでデータが入っているかわからないので、バイト数だけは送ってもらう。
export function reverse( length: i32 ): void {
	const max = length / 2;
	for ( let i: i32 = 0 ; i < max ; ++i ) {
		// メモリのどこに書き込むか計算する。今回は1バイトごとだがUint32のように4バイト使う場合はさらに4を掛ける必要がある
		const pos = length - 1 - i;
		// 交換する後ろの値を読み込む
		const tmp = load<i8>( pos );
		// 後ろに先頭側の値を書き込む
		store<i8>( pos, load<i8>( i ) );
		// 先頭側に保存済みの後ろの値を書き込む
		store<i8>( i, tmp );
	}
}

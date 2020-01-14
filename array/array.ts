/// <reference path="../node_modules/assemblyscript/std/assembly/index.d.ts" />

export function sum( max: i32 ): f64 {
	let sum: f64 = 0;
	max *= 4; // アドレス計算を省くために4倍にしておく
	for ( let i: i32 = 0 ; i < max ; i += 4 ) { // アドレス計算を省く
		const value = load<i32>( i ); // 4バイト読み込む
		sum += value;
	}
	return sum;
}
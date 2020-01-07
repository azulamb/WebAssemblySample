/// <reference path="../node_modules/assemblyscript/std/assembly/index.d.ts" />

export const X: u32 = 123456789;
export const Y: u32 = 362436069;
export const Z: u32 = 521288629;
export const W: u32 = 88675123;
let x: u32 = X;
let y: u32 = Y;
let z: u32 = Z;
let w: u32 = W;

export function seed( a: u32 = 0, b: u32 = 0, c: u32 = 0, d: u32 = 0 ): void {
	if ( !a && !b && !c && !d ) {
		a = X;
		b = Y;
		c = Z;
		d = W;
	}
	x = a;
	y = b;
	z = c;
	w = d;
}

export function nextInt(): f64 {
	const t: u32 = ( x ^ ( x << 11 ) );
	x = y;
	y = z;
	z = w;
	w = ( w ^ ( w >> 19 ) ^ ( t ^ ( t >> 8 ) ) );

	// JSでは31bitより大きい整数は負の数に見られてしまう。
	// しかし、JSの浮動小数点(64bit)なら53bit分までは正確な整数値を表現できる。
	// そのため、i32の整数値を正しく送るためここで予めf64に変換してから返す。
	return <f64>w;
}

export function next(): f64 {
	return <f64>nextInt() / 0xffffffff;
}

import * as xorshift from '../docs/xorshift.wasm'

console.log( xorshift );
console.log( '0x' + xorshift.nextInt().toString( 16 ) );
console.log( '0x' + xorshift.nextInt().toString( 16 ) );
console.log( '0x' + xorshift.nextInt().toString( 16 ) );

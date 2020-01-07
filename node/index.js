import * as xorshift from '../docs/xorshift.wasm'

console.log( xorshift );

const list = [];

for ( let i = 0 ; i < 10 ; ++i ) {
	list.unshift( '0x' + xorshift.nextInt().toString( 16 ) );
}

list.forEach( ( v ) => { console.log( v ); } );

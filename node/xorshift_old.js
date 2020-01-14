import { promises as fs } from 'fs'
import path from 'path'
//const fs = require( 'fs' ).promises;
//const path = require( 'path' );

const WASM_FILE = path.join( path.dirname( new URL( import.meta.url ).pathname ), '../docs/xorshift.wasm' ).substr( 1 );
//const WASM_FILE = path.join( __dirname, '../docs/xorshift.wasm' );
console.log( WASM_FILE );

async function LoadWebAssembly( file, importObject = {} ) {
	const buffer = await fs.readFile( file );
	const mod = await WebAssembly.compile( buffer );
	const wasm = new WebAssembly.Instance( mod, importObject );
	console.log( wasm );
	return wasm.exports;
}

LoadWebAssembly( WASM_FILE ).then( ( xorshift ) => {
	console.log( xorshift );
	console.log( xorshift.nextInt() );
} );

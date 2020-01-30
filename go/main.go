/*
GOOS=js GOARCH=wasm go build -o hello.wasm main.go

set GOOS=js
set GOARCH=wasm
go build -o hello.wasm main.go

https://github.com/golang/go/tree/master/misc/wasm
wasm_exec.html
wasm_exec.js
*/
package main

import "fmt"

func main() {
	fmt.Println("Hello wasm!")
}

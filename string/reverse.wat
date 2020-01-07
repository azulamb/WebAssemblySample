(module
 (type $FUNCSIG$vi (func (param i32)))
 (type $FUNCSIG$v (func))
 (memory $0 0)
 (table $0 1 funcref)
 (elem (i32.const 0) $null)
 (export "memory" (memory $0))
 (export "reverse" (func $string/reverse/reverse))
 (func $string/reverse/reverse (; 0 ;) (type $FUNCSIG$vi) (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.const 2
  i32.div_s
  local.set $1
  block $break|0
   i32.const 0
   local.set $2
   loop $loop|0
    local.get $2
    local.get $1
    i32.lt_s
    i32.eqz
    br_if $break|0
    local.get $0
    i32.const 1
    i32.sub
    local.get $2
    i32.sub
    local.set $3
    local.get $3
    i32.load8_s
    local.set $4
    local.get $3
    local.get $2
    i32.load8_s
    i32.store8
    local.get $2
    local.get $4
    i32.store8
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $loop|0
   end
   unreachable
  end
 )
 (func $null (; 1 ;) (type $FUNCSIG$v)
 )
)

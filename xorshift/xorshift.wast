(module
 (type $FUNCSIG$v (func))
 (type $FUNCSIG$viiii (func (param i32 i32 i32 i32)))
 (type $FUNCSIG$d (func (result f64)))
 (type $FUNCSIG$vi (func (param i32)))
 (memory $0 0)
 (table $0 1 funcref)
 (elem (i32.const 0) $null)
 (global $xorshift/xorshift/X i32 (i32.const 123456789))
 (global $xorshift/xorshift/Y i32 (i32.const 362436069))
 (global $xorshift/xorshift/Z i32 (i32.const 521288629))
 (global $xorshift/xorshift/W i32 (i32.const 88675123))
 (global $xorshift/xorshift/x (mut i32) (i32.const 0))
 (global $xorshift/xorshift/y (mut i32) (i32.const 0))
 (global $xorshift/xorshift/z (mut i32) (i32.const 0))
 (global $xorshift/xorshift/w (mut i32) (i32.const 0))
 (global $~lib/argc (mut i32) (i32.const 0))
 (export "memory" (memory $0))
 (export "X" (global $xorshift/xorshift/X))
 (export "Y" (global $xorshift/xorshift/Y))
 (export "Z" (global $xorshift/xorshift/Z))
 (export "W" (global $xorshift/xorshift/W))
 (export "__setargc" (func $~lib/setargc))
 (export "seed" (func $xorshift/xorshift/seed|trampoline))
 (export "nextInt" (func $xorshift/xorshift/nextInt))
 (export "next" (func $xorshift/xorshift/next))
 (start $start)
 (func $start:xorshift/xorshift (; 0 ;) (type $FUNCSIG$v)
  global.get $xorshift/xorshift/X
  global.set $xorshift/xorshift/x
  global.get $xorshift/xorshift/Y
  global.set $xorshift/xorshift/y
  global.get $xorshift/xorshift/Z
  global.set $xorshift/xorshift/z
  global.get $xorshift/xorshift/W
  global.set $xorshift/xorshift/w
 )
 (func $xorshift/xorshift/seed (; 1 ;) (type $FUNCSIG$viiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  local.get $0
  i32.eqz
  if (result i32)
   local.get $1
   i32.eqz
  else
   i32.const 0
  end
  if (result i32)
   local.get $2
   i32.eqz
  else
   i32.const 0
  end
  if (result i32)
   local.get $3
   i32.eqz
  else
   i32.const 0
  end
  if
   global.get $xorshift/xorshift/X
   local.set $0
   global.get $xorshift/xorshift/Y
   local.set $1
   global.get $xorshift/xorshift/Z
   local.set $2
   global.get $xorshift/xorshift/W
   local.set $3
  end
  local.get $0
  global.set $xorshift/xorshift/x
  local.get $1
  global.set $xorshift/xorshift/y
  local.get $2
  global.set $xorshift/xorshift/z
  local.get $3
  global.set $xorshift/xorshift/w
 )
 (func $xorshift/xorshift/nextInt (; 2 ;) (type $FUNCSIG$d) (result f64)
  (local $0 i32)
  global.get $xorshift/xorshift/x
  global.get $xorshift/xorshift/x
  i32.const 11
  i32.shl
  i32.xor
  local.set $0
  global.get $xorshift/xorshift/y
  global.set $xorshift/xorshift/x
  global.get $xorshift/xorshift/z
  global.set $xorshift/xorshift/y
  global.get $xorshift/xorshift/w
  global.set $xorshift/xorshift/z
  global.get $xorshift/xorshift/w
  global.get $xorshift/xorshift/w
  i32.const 19
  i32.shr_u
  i32.xor
  local.get $0
  local.get $0
  i32.const 8
  i32.shr_u
  i32.xor
  i32.xor
  global.set $xorshift/xorshift/w
  global.get $xorshift/xorshift/w
  f64.convert_i32_u
 )
 (func $xorshift/xorshift/next (; 3 ;) (type $FUNCSIG$d) (result f64)
  call $xorshift/xorshift/nextInt
  f64.const 4294967295
  f64.div
 )
 (func $start (; 4 ;) (type $FUNCSIG$v)
  call $start:xorshift/xorshift
 )
 (func $null (; 5 ;) (type $FUNCSIG$v)
 )
 (func $xorshift/xorshift/seed|trampoline (; 6 ;) (type $FUNCSIG$viiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  block $4of4
   block $3of4
    block $2of4
     block $1of4
      block $0of4
       block $outOfRange
        global.get $~lib/argc
        br_table $0of4 $1of4 $2of4 $3of4 $4of4 $outOfRange
       end
       unreachable
      end
      i32.const 0
      local.set $0
     end
     i32.const 0
     local.set $1
    end
    i32.const 0
    local.set $2
   end
   i32.const 0
   local.set $3
  end
  local.get $0
  local.get $1
  local.get $2
  local.get $3
  call $xorshift/xorshift/seed
 )
 (func $~lib/setargc (; 7 ;) (type $FUNCSIG$vi) (param $0 i32)
  local.get $0
  global.set $~lib/argc
 )
)

-- bit-compat.lua
-- Lua version compatibility shim: define `bit` and `bit32` globally using real modules or native ops

local ok, bit_mod = pcall(require, "bit")      -- LuaJIT / luarocks
if not ok then ok, bit_mod = pcall(require, "bit32") end  -- Lua 5.2

-- If neither library is present (Lua 5.3+/Wireshark 4.x), emulate it using native ops
if not ok then
  bit_mod = {}
  function bit_mod.band(a,b)   return a & b end
  function bit_mod.bor(a,b)    return a | b end
  function bit_mod.bxor(a,b)   return a ~ b end
  function bit_mod.lshift(a,n) return a << n end
  function bit_mod.rshift(a,n) return a >> n end
end

-- Make global so other scripts can use `bit` or `bit32` as usual
_G.bit = bit_mod
_G.bit32 = bit_mod

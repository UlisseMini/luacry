---------------------------- XOR -------------------------------
local function bxor(a, b)if type(a) ~= "number" then;error("bad argument #1 to 'xor' (number expected, got "..type(a)..")")end;if type(b)~="number"then;error("bad argument #1 to 'xor' (number expected, got "..type(b)..")")end;local r=0;for i=0,31 do;local x=a/2+b/2;if x~=math.floor(x)then;r=r+2^i;end;a=math.floor(a/2)b=math.floor(b/2)end;return r;end

local function xor(s1, s2)if type(s1)~="string"then;error("bad argument #1 to 'xor' (string expected, got "..type(s1)..")")end;if type(s2)~="string"then;error("bad argument #2 to 'xor' (string expected, got "..type(s2)..")")end;local R = ""local i,k;for i=1,#s1 do;k=(i-1)%#s2+1;local b1,b2=s1:byte(i,i),s2:byte(k,k)byte=bxor(b1,b2)R=R..string.char(byte)end;return R;end
---------------------------- XOR -------------------------------

---------------------------- BASE85 ----------------------------
local a,b=string.pack,string.unpack;local c,d=string.byte,string.char;local e,f=table.insert,table.concat;local g="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"..".-:+=^!/*?&<>()[]{}@%$#"local h={}for i=1,#g do h[c(g,i)]=i-1 end;local function enc(k)local l,m,n,o,p,q;assert(#k%4==0,"string length must be multiple of 4 bytes")local s={}for i=1,#k,4 do l=b(">I4",k,i)q=l%85;l=l//85;p=l%85;l=l//85;o=l%85;l=l//85;n=l%85;l=l//85;m=l%85;l=l//85;local t=d(g:byte(m+1),g:byte(n+1),g:byte(o+1),g:byte(p+1),g:byte(q+1))e(s,t)end;return table.concat(s)end
---------------------------- BASE85 ----------------------------

local function obsf(code, key)
  local out = [[function bxor(a,b)local c=0;for d=0,31 do local e=a/2+b/2;if e~=math.floor(e)then c=c+2^d end;a=math.floor(a/2)b=math.floor(b/2)end;return c end;function xor(f,g)local h=""local d,i;for d=1,#f do i=(d-1)%#g+1;local j,k=f:byte(d,d),g:byte(i,i)byte=bxor(j,k)h=h..string.char(byte)end;return h end;local a={...}if#a<1 then print'argument #1 must be the key'return end;local l,m=string.pack,string.unpack;local byte,n=string.byte,string.char;local o,p=table.insert,table.concat;local q="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"..".-:+=^!/*?&<>()[]{}@%$#"local s={}for i=1,#q do s[byte(q,i)]=i-1 end;local function dec(b)local c={}local d,e,f,g,h,i;if#b%5~=0 then return nil,"invalid length"end;for j=1,#b,5 do d=0;for k=0,4 do r=s[b:byte(j+k)]if not r then return nil,"invalid char"end;d=d*85+r end;local u=l(">I4",d)o(c,u)end;return table.concat(c)end
]]

  -- Add padding for base85
  while #xor(code, key) % 4 ~= 0 do
    code = code..'\n'
  end

  b64xor = enc(xor(code, key))
  out = out.."assert((loadstring or load)(xor(dec('"..b64xor.."'), a[1])))()"

	return out
end

local args = {...}
if #args < 2 then
  print("Usage: luacry.lua <input.lua> <key> [output.lua]")
  return
end
local key  = args[2]
local outfile = args[3]

local f    = assert(io.open(args[1]), 'r')
local code = f:read('*all'); f:close()

local output = obsf(code, key)

if outfile then
  local f = assert(io.open(outfile, 'w'))
  f:write(output)
  f:close()
  print("Written to "..outfile)
else
  print(output)
end

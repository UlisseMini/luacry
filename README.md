# luacry
> lua is crying ):

## Example
This code
```lua
print 'hello world'
```

Gets turned into this after running `./luacry.lua ./hello.lua secret_password out.lua`

```lua
function bxor(a,b)local c=0;for d=0,31 do local e=a/2+b/2;if e~=math.floor(e)then c=c+2^d end;a=math.floor(a/2)b=math.floor(b/2)end;return c end;function xor(f,g)local h=""local d,i;for d=1,#f do i=(d-1)%#g+1;local j,k=f:byte(d,d),g:byte(i,i)byte=bxor(j,k)h=h..string.char(byte)end;return h end;local a={...}if#a<1 then print'argument #1 must be the key'return end(loadstring or load)(xor(('AxcKHBFUeBgEHx8YQ1ITHBcPFkRTVQ=='):gsub('.',function(x)if x=='='then return''end;local r,f='',(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'):find(x)-1)for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and'1'or'0')end;return r;end):gsub('%d%d%d?%d?%d?%d?%d?%d?',function(x)if #x ~= 8 then return''end;local c=0;for i=1,8 do c=c+(x:sub(i,i)=='1'and 2^(8-i) or 0) end;return string.char(c)end), a[1]))()
```

Then it can be ran with `lua out.lua secret_password`

# luacry
> lua is crying ):

## Example
This code
```lua
print 'hello world'
```

Gets turned into this
```lua
loadstring(('G0x1YVMAGZMNChoKBAgECAh4VgAAAAAAAAAAAAAAKHdAAQtAaGVsbG8ubHVhAAAAAAAAAAAAAQIEAAAABgBAAEFAAAAkQAABJgCAAAIAAAAEBnByaW50BAxoZWxsbyB3b3JsZAEAAAABAAAAAAAEAAAAAQAAAAEAAAABAAAAAQAAAAAAAAABAAAABV9FTlY='):gsub('.',function(x)if x=='='then return''end;local r,f='',(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'):find(x)-1)for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and'1'or'0')end;return r;end):gsub('%d%d%d?%d?%d?%d?%d?%d?',function(x)if #x ~= 8 then return''end;local c=0;for i=1,8 do c=c+(x:sub(i,i)=='1'and 2^(8-i) or 0) end;return string.char(c)end))()
```

Have fun :)

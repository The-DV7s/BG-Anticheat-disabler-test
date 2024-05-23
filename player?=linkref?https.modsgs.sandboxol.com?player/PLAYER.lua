e=nil
--@ Local function x()
check = gg.alert('...')
--@(...(...)...)
if check[1] == '...' then gg.alert("Bypassed")
end

array = {{}}
qwerty = 2
array1 = {3,4}
array2 = {2,3}
array3 = {{}}


-- if array2[1] > array3[1] and array1[1] > array2[1] then
--     array2[1] = nil
--     array2[2] = nil
--     array2 = {100, 500}
--     print(string.sub(os.date("%c"),10))
-- end

-- test = tostring(os.date("%c"))
-- array3["her"] = 0
-- array3["her"] = array3["her"]+2
t = {{}}

test = {1,2,3,4,5}

t[255.11] = {
    qwe = 1234
}
t[1] = {
    qwe = 32
}
function MySort(a,b)         
    if a > b then 
       return true; 
    else 
       return false; 
    end;
 end;
fileName = os.date("!*t")

print(test.day.."|"..test.month.."|"..test.year.."|")
for i = 1,3,1 do   
l_file = io.open("C:\\Users\\Neo\\Desktop\\log\\"..tostring(fileName.day).."."
..tostring(fileName.month).."."..tostring(fileName.year)..".txt","w")
--if l_file ~= nil then
    l_file:write("Что-тотамяпишу лул")
--end
end
-- for k, val in pairs(t) do
--     --print(k.."---->"..tostring(val["qwe"]))
--     l_file:write("Цена  :   "..tostring(k).."   Объем  "..tostring(val["qwe"]).."\n")
-- end
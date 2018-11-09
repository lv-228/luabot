status_work = true

p_classcode = "QJSIM"

p_seccode = "SBER"


count = 1

function main()
    while status_work do
        test = {}
        sleep(5000)
        GetBestPriceOnDay()
        -- table = getItem("all_trades", 10)
        -- test[tostring(table.price)] = table.qty
        -- message(tostring(test[tostring(table.price)]))
        offer = getParamEx(p_classcode,p_seccode,"OFFER")
        N = getNumCandles("SberbankPRICE5MIN")--˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜
        N15min = getNumCandles("SberbankPRICE15MIN")
        s,d,f = getCandlesByIndex("SberbankPRICE15MIN",0,N15min-2,2)
        t,n,i = getCandlesByIndex("SberbankPRICE5MIN",0,N-2,2)
        message(
            "˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ 5MIN"..t[0].close.."\n"..
            "˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ 15MIN"..s[0].close.."\n"..
            "˜˜˜˜˜˜˜ ˜˜˜˜˜"..s[1].close.."\n"
        ,1)
        bid = getParamEx(p_classcode,p_seccode,"BID")
        message(offer.param_value.."BID",1)
    end
end

-- function OnQuote (class_code,sec_code)
--     if class_code==p_classcode and sec_code==p_seccode then
--         tb=getQuoteLevel2(class_code, sec_code)
--         message(tb,1)
--     end
-- end

function OnStop(stop_flag)
    status_work = false
end

function GetBestPriceOnDay()
    paperPrice = {{}}
    time = GetServerDateTime()

        for i = 0, getNumberOf("all_trades") - 1 do
            table = getItem("all_trades", i)
            if table.sec_code == "SBER" and paperPrice[table.price] == nil then
                paperPrice[table.price] = {
                    qty = table.qty
                }
            elseif paperPrice[table.price] ~= nil then
                paperPrice[table.price]["qty"] = paperPrice[table.price]["qty"] + table.qty
            end
        end
        
        if tostring(time.hour..":"..time.min) == "18:45" then
            log(paperPrice)
        end
end

function log(array)
    fileName = os.date("!*t")
    l_file = io.open("C:\\Users\\Neo\\Desktop\\log\\"..tostring(fileName.day).."."
..tostring(fileName.month).."."..tostring(fileName.year)..".txt","w")
    local maxValue = 0
    local valuePrice = 0
    for k, val in pairs(array) do
        --print(k.."---->"..tostring(val["qwe"]))
        if l_file ~= nil then
            l_file:write("Öåíà  :   "..tostring(k).."   Îáúåì  "..tostring(val["qty"]).."\n")
        else 
            message("˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜!",3)
        end
        if val["qty"] ~= nil and val["qty"] > maxValue then
            maxValue = val["qty"]
            valuePrice = k
        end
    end
    if l_file ~= nil then
        l_file:write("Ìàêñ öåíà + Ìàêñ îáúåì === "..tostring(valuePrice).."          "..tostring(maxValue))
        message("˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜!",1)
    else
        message("˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜!",3)
    end
end

GetServerDateTime = function()
    local dt = {}
    dt.day,dt.month,dt.year,dt.hour,dt.min,dt.sec = string.match(getInfoParam('TRADEDATE')..
    ' '..getInfoParam('SERVERTIME'),"(%d*).(%d*).(%d*) (%d*):(%d*):(%d*)")
    for key,value in pairs(dt) do dt[key] = tonumber(value) end
    return dt
 end

 function MySort(a,b)         
    if a > b then 
       return true; 
    else 
       return false; 
    end;
 end;
 -- table.sort(paperPrice);         -- ˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ Arr ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ {1,2,3,4,5}
 -- table.sort(paperPrice, MySort); -- ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜
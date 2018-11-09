
is_run = true

p_classcode = "QJSIM"

p_seccode = "SBER"

buy_order="";

buy_price=0;

buy_count=0;

sell_order=""

sell_price=0;

sell_count=0;

function main()
    while is_run do
        sleep(2000)
    end
end

function OnStop(stop_flag)
    is_run = false
end

-- function OnQuote(class_code,sec_code)
--     if class_code==p_classcode and sec_code==p_seccode then
--         l_file = io.open("C:\\Users\\Neo\\Desktop\\Торговля"..tostring(count)..".txt","w")
--         tb = getQuoteLevel2(class_code, sec_code)

--         l_file:write("BID:\n")

--         for i=1, tb.bid_count,1 do
--             l_file:write(tostring(tb.bid[i].price).."; "..tostring(tb.bid[i].quantity).."\n")
--         end

--         l_file:write("OFFER:\n")

--         for i=1, tb.offer_count,1 do
--             l_file:write(tostring(tb.offer[i].price).."; "..tostring(tb.offer[i].quantity).."\n")
--         end

--         count = count+1

--         l_file:close()
--     end
-- end


function OnOrder(order)
    --когда мы вводим заявку, у нас flags=25, а когда удаляем 26. Если у нас заявка исполняется, то flags=24.
    -- бит 0 (0x1) Заявка активна, иначе – не активна
    -- бит 1 (0x2) Заявка снята. Если флаг не установлен и значение бита «0» равно «0», то заявка исполнена
    -- бит 2 (0x4) Заявка на продажу, иначе – на покупку. Данный флаг для сделок и сделок для исполнения определяет направление сделки (BUY/SELL)
    -- бит 3 (0x8) Заявка лимитированная, иначе – рыночная
    -- бит 4 (0x10) Возможно исполнение заявки несколькими сделками
    -- бит 5 (0x20) Исполнить заявку немедленно или снять (FILL OR KILL)
    -- бит 6 (0x40) Заявка маркет-мейкера. Для адресных заявок – заявка отправлена контрагенту
    -- бит 7 (0x80) Для адресных заявок – заявка получена от контрагента
    -- бит 8 (0x100) Снять остаток
    -- бит 9 (0x200) Айсберг-заявка
    p_file:write(os.date().." OnOrder\n");

    --сначала проверим, по нашему ли инструменту эта заявка

    if order["sec_code"]==p_seccode and order["class_code"]==p_classcode then
        p_file:write(os.date().."  заявка "..order["order_num"].."\n")
         --если заявка активна, то запоминаем ее
          if bit.band(order["flags"],1)>0 then
                if bit.band(order["flags"],4)>0 then
                      sell_order=order["order_num"]
                      sell_price=tonumber(order["price"])
                      sell_count=tonumber(order["balance"])
                else
                      buy_order=order["order_num"]
                      buy_price=tonumber(order["price"])
                      buy_count=tonumber(order["balance"])
                end
          else
                --если заявка не активна то сбрасываем информацию о заявке
                if bit.band(order["flags"],1)>0 then
                      if bit.band(order["flags"],8)>0 then
                           sell_order=""
                           sell_price=0
                           sell_count=0
                      else
                           buy_order=""
                           buy_price=0
                           buy_count=0
                      end
                end
          end
    end
end


function OnQuote(class_code, sec_code)

    if class_code==p_classcode and sec_code==p_seccode then

          tb=getQuoteLevel2(class_code, sec_code)

         

          if buy_count==0 then

                v_bid=tb.bid[math.ceil(tb.bid_count)].price+p_delta

          else

                if tonumber(tb.bid[math.ceil(tb.bid_count)].quantity)==buy_count and tonumber(tb.bid[math.ceil(tb.bid_count)].price)==buy_price then

                      v_bid=tb.bid[math.ceil(tb.bid_count)-1].price+p_delta

                else

                      v_bid=tb.bid[math.ceil(tb.bid_count)].price+p_delta

                end

          end

         

          if sell_count==0 then

                v_offer=tb.offer[1].price-p_delta

          else

                if tonumber(tb.offer[1].quantity)==sell_count and tonumber(tb.offer[1].price)==sell_price then

                      v_offer=tb.offer[2].price-p_delta

                else

                      v_offer=tb.offer[1].price-p_delta

                end

          end

         

          p_file:write(os.date().."    "..v_bid..","..v_offer.."\n")

    end

end

--покупка
-- t = {
--     ["CLASSCODE"] = "QJSIM",
--     ["SECCODE"] = "SBER",
--     ["ACTION"] = "NEW_ORDER",
--     ["ACCOUNT"] = "NL0011100043",
--     ["CLIENT_CODE"] = "10008",
--     ["TYPE"] = "L",
--     ["OPERATION"] = "B",
--     ["QUANTITY"] = "1",
--     ["PRICE"] = цена покупки,
--     ["TRANS_ID"] = "1"
-- }

-- --продажа

-- t = {
--     ["CLASSCODE"] = "QJSIM",
--     ["SECCODE"] = "SBER",
--     ["ACTION"] = "NEW_ORDER",
--     ["ACCOUNT"] = "NL0011100043",
--     ["CLIENT_CODE"] = "10008",
--     ["TYPE"] = "L",
--     ["OPERATION"] = "S",
--     ["QUANTITY"] = "1",
--     ["PRICE"] = цена продажи,
--     ["TRANS_ID"] = "1"
-- }
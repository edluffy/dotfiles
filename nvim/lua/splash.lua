local api = vim.api

local splash = {}
splash.options = {
    filetype = 'splash',
    modifiable = true,
    modified = false,
    number = false,
}

splash.header = {
    [[                                    _,,]],
    [[                                  ,iSMP                                  ,dW]],
    [[                                 sPT1Y'                                 JIl;]],
    [[                                sIl:l1                                 JWS:']],
    [[                               dIi:Il;                                fWIl?]],
    [[                              dIi:l:I'                               fW1"]],
    [[                             dIli:l:I;                              fWI:]],
    [[                           .dIli:I:S:S                     .       fWIl`]],
    [[                         ,sWSSIIIiISIIS w,_             .sMW     ,MWIl;]],
    [[                    _.,sWWWWWWMMMSSSWWMMMWWMmMmu,,._  .iSYISb, ,MM*SI!:]],
    [[                _,sYYMMWWWWWsdMMMMWWMMiM"*MW*MWWWMWMbWMMS WWPWWMWIIS1!`]],
    [[           _,osMMMMMYYWWMmMWWWWWWWb`SWMMImMMMMSISIISWWSISIPWWWWSIIIII!.]],
    [[        .osSMWMWWWWSI111MMPSSSbWWSWWISIIMSYYiIIIII!IlI1Ii,ui:W*1:li:l1!]],
    [[     ,sSMMWWWSSSSSSWWbdWWWWWWYSbiSSWWIlIM711IIil1II1!I'l:+'+l; `''+1i:1i]],
    [[  ,sYSMWMWYWWWSSSSSWWWSSIIiWWWWWY11WWIIIbM?!liI?l:i,         `      `'1!:]],
    [[ sPITMWMWWWMMwwdWWbbYYIIiYYTTWW1!1IIISIWWMmm+?+ `+Ili                 `'l:,]],
    [[ YIi1lTYfPSkyLinedI!YYI!iYYTT!11IIISWWMMMMMmm,]],
    [[   "T1l1lI**lMMW2006?mMWo?*'``  ```""**YSWMMMWMm,]],
    [[        "*:iil1I!I!"` '                 ``"*YMMWWMm,]],
    [[              ii!                             '*YMWM,]],
    [[              I'                                  "YM]],
}

function splash.open()
    local buf = api.nvim_create_buf(true, true)
    api.nvim_win_set_buf(0, buf)

    api.nvim_buf_set_text(buf, 0, 0, 0, 0, splash.center(splash.header))

    for k, v in pairs(splash.options) do
        vim.opt_local[k] = v
    end

    for i=1, 50 do
        api.nvim_buf_add_highlight(buf, 0, 'Macro', i, 0, -1)
    end
end

function splash.center(lines)
    local longest = 0
    for _, l in ipairs(lines) do
        local w = api.nvim_strwidth(l)
        if w > longest then longest = w end
    end
    local left_pad = math.floor((api.nvim_win_get_width(0)-longest) / 2)
    local top_pad = math.floor((api.nvim_win_get_height(0)-#lines) / 2)

    lines = vim.tbl_map(function(v)
        return string.rep(' ', left_pad) .. v
    end, lines)

    for _=1, top_pad do
        table.insert(lines, 1, "")
    end


    return lines
end

function splash.highlight()
end

return splash

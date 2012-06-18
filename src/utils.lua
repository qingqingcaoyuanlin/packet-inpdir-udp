
-- assorted util functions


local function add_named_tree_field(buf, tree, offset, len, text)
    local data = buf(offset, len)
    local st = tree:add(data, text)
    if len == 8 then
        data = data:le_uint64()
        st:append_text(_F(": %u (0x%016x)", data, data))
    elseif len == 4 then
        data = data:le_uint()
        st:append_text(_F(": %u (0x%08x)", data, data))
    else
        data = data:le_uint()
        st:append_text(_F(": %u (0x%04x)", data, data))
    end
    return st
end

local function add_named_tree_field_int(buf, tree, offset, len, text)
    local data = buf(offset, len)
    local st = tree:add(data, text)
    if len == 8 then
        data = data:le_int64()
        st:append_text(_F(": %d (0x%016x)", data, data))
    elseif len == 4 then
        data = data:le_int()
        st:append_text(_F(": %d (0x%08x)", data, data))
    else
        data = data:le_int()
        st:append_text(_F(": %d (0x%04x)", data, data))
    end
    return st
end

local function add_named_tree_field_str(buf, tree, offset, len, text)
    local data = buf(offset, len)
    local st = tree:add(data, text)
    st:append_text(": '" .. data:stringz() .. "'")
    return st
end

local function add_named_tree_field_bytes(buf, tree, offset, len, text)
    local data = buf(offset, len)
    local st = tree:add(data, text)
    st:append_text(": " .. data)
    return st
end

local function add_named_tree_field_ipv4(buf, tree, offset, len, text)
    local data = buf(offset, len)
    local str = _F("%u.%u.%u.%u", 
        data(0, 1):le_uint(), 
        data(1, 1):le_uint(), 
        data(2, 1):le_uint(), 
        data(3, 1):le_uint()
    )
    local st = tree:add(data, text)
    st:append_text(": " .. str)
    return st
end












local function add_unknown_fields(buf, pinfo, tree, goffset, number, sz)
    local offset = goffset

    for i = 1,number do
        add_named_tree_field(buf, tree, offset, sz, _F("Unknown%d", i))
        offset = offset + sz
    end

    -- how many bytes have we consumed
    return (offset - goffset)
end






local function add_zeros_field(buf, pinfo, tree, goffset, len)
    -- handle default argument
    len = len or (buf:len() - goffset)
    if len ~= 0 then
        tree:add(buf(goffset, len), "Zeros / Garbage"):append_text(_F(", %u bytes", len))
    end
    return len
end



local function add_unknown_field(buf, pinfo, tree, goffset, len)
    -- handle default argument
    len = len or (buf:len() - goffset)
    if len ~= 0 then
        tree:add(buf(goffset, len), "Unknown"):append_text(_F(", %u bytes", len))
    end
    return len
end


local function add_encrypted_field(buf, pinfo, tree, goffset, len)
    -- handle default argument
    len = len or (buf:len() - goffset)
    if len ~= 0 then
        tree:add(buf(goffset, len), "Encrypted"):append_text(_F(", %u bytes", len))
    end
    return len
end



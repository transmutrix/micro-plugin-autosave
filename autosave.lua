VERSION = "0.1.0"

if GetOption("save_on_rune") == nil then
    AddOption("save_on_rune", false)
end

if GetOption("save_on_switch_buffer") == nil then
    AddOption("save_on_switch_buffer", false)
end


--- helpers ---
local settings = {
    ["eofnewline"] = GetOption("eofnewline"),
    ["rmtrailingws"] = GetOption("rmtrailingws"),
    ["autosave"] = GetOption("autosave")
}

local function CanSave(v)
    if not v.Buf:Modified() then return end
    if not v.Buf.Path or v.Buf.Path=='' then return end
    return true
end

local function Save(v)
    for k,v in pairs(settings) do SetOption(k, false) end
    v:Save(false)
    for k,v in pairs(settings) do if v then SetOption(k, v) end end
end


--- save_on_rune ---
local rune_save_timer

local function RuneSave(v)
    if not GetOption("save_on_rune") then return end
    if not CanSave(v) then return end
    if not rune_save_timer then
        rune_save_timer = os.time()
    else
        if os.time() - rune_save_timer >= 2 then
            rune_save_timer = os.time()
            Save(v)
        end
    end
end

function onRune(r, v) RuneSave(v) end
function onUndo(r, v) RuneSave(v) end
function onRedo(r, v) RuneSave(v) end


--- save_on_switch_buffer ---
local function TabSave(v)
    if not GetOption("save_on_switch_buffer") then return end
    if not CanSave(v) then return end
    Save(v)
end

function prePreviousTab(v) TabSave(v) end
function preNextTab(v) TabSave(v) end
function preAddTab(v) TabSave(v) end
function prePreviousSplit(v) TabSave(v) end
function preNextSplit(v) TabSave(v) end


--- documentation ---
AddRuntimeFile("autosave", "help", "autosave.md")

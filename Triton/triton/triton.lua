require("triton/utilities/logic")
textstream = require("triton/utilities/textstream")
bytestream = require("triton/utilities/bytestream")
byte = require("triton/data/byte")
bytelist = require("triton/data/bytelist")
int16 = require("triton/data/int16")
int32 = require("triton/data/int32")
int64 = require("triton/data/int64")
usertype = require("triton/data/usertype")

local triton = {}

triton.configuration = {
    ["lvm51"] = require("triton/configurations/lvm51")
}

function triton.bruteforce(bytecode)
    local selectedConfiguration = nil
    for key, configuration in pairs(triton.configuration) do
        if configuration:isSignaturePresent(bytecode) then
            print("[triton] - detected virtual machine signature " .. configuration.virtualMachineName)
            selectedConfiguration = configuration
            break
        end
    end
    if selectedConfiguration == nil then
        error("[triton] - could not find a possible configuration.")
    end
    local chunk = selectedConfiguration:deserialize(bytecode)
    selectedConfiguration:dump(chunk)
end

return triton
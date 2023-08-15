---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Wesley.
--- DateTime: 15/08/2023 17:08
---

local AtosClient = AtosRadiatedZones.Client

local lightMask = "LightMask"
local gasMask = "GasMask"
local hazmat = "HazmatSuit"

AtosClient.protectionTypeMap = {
    ["Hat_DustMask"] = lightMask,
    ["Hat_SurgicalMask_Green"] = lightMask,
    ["Hat_SurgicalMask_Blue"] = lightMask,
    ["Hat_BandanaMaskTINT"] = lightMask,
    ["Hat_BandanaMask"] = lightMask,
    ["Hat_GasMask"] = gasMask,
    ["HazmatSuit"] = hazmat,
}
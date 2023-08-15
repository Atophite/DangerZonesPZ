---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Wesley.
--- DateTime: 12/07/2023 23:07
---
---
local AtosClient = AtosRadiatedZones.Client
require "MF_ISMoodle"
MF.createMoodle("Iodine")
MF.createMoodle("Hazmat")
MF.createMoodle("GasMask")
MF.createMoodle("LightMask")


function AtosClient:getIodineMoodle()
    return MF.getMoodle("Iodine")
end

function AtosClient:getHazmatMoodle()
    return MF.getMoodle("Hazmat")
end

function AtosClient:setIodineMoodle(value)
    MF.getMoodle("Iodine"):setValue(value)
end

function AtosClient:setHazmatMoodle(value)
    MF.getMoodle("Hazmat"):setValue(value)
end

function AtosClient:getGasMaskMoodle()
    return MF.getMoodle("GasMask")
end

function AtosClient:setGasMaskMoodle(value)
    MF.getMoodle("GasMask"):setValue(value)
end

function AtosClient:getLightMaskMoodle()
    return MF.getMoodle("LightMask")
end

function AtosClient:setLightMaskMoodle(value)
    MF.getMoodle("LightMask"):setValue(value)
end
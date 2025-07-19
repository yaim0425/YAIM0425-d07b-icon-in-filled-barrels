---------------------------------------------------------------------------------------------------
---> data-final-fixes.lua <---
---------------------------------------------------------------------------------------------------

--- Contenedor de funciones y datos usados
--- unicamente en este archivo
local ThisMOD = {}

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Iniciar el modulo
function ThisMOD.Start()
    --- Valores de la referencia
    ThisMOD.setSetting()

    --- Información a usar
    ThisMOD.BuildInfo()

    --- Cambiar la propiedad necesaria
    ThisMOD.ChangePproperty()
end

--- Valores de la referencia
function ThisMOD.setSetting()
    --- Otros valores
    Prefix       = "zzzYAIM0425-0700-"
    ThisMOD.name = "icon-in-barrel-filled"

    --- Contenedor
    ThisMOD.Info = { load = {} }
end

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Información a usar
function ThisMOD.BuildInfo()
    local function Load(recipe)
        --- Validación
        if #recipe.results ~= 1 then return end
        if #recipe.ingredients ~= 2 then return end
        local Item  = GPrefix.get_table(recipe.ingredients, "name", "barrel")
        local Fuild = GPrefix.get_table(recipe.ingredients, "type", "fluid")
        if not Item.name then return end
        if not Fuild.name then return end

        --- Crear el espacio para la entidad
        local name              = recipe.results[1].name
        local Space             = ThisMOD.Info.load[name] or {}
        ThisMOD.Info.load[name] = Space

        --- Guardar la información
        Space.item              = GPrefix.items[name]

        if not Space.item or not GPrefix.recipes[Space.item.name] then
            ThisMOD.Info.load[name] = nil
            return
        end

        Space.recipe = recipe
    end

    for _, recipes in pairs(GPrefix.recipes) do
        for _, recipe in pairs(recipes) do
            Load(recipe)
        end
    end
end

--- Cambiar la propiedad necesaria
function ThisMOD.ChangePproperty()
    for _, Space in pairs(ThisMOD.Info.load) do
        Space.item.icons = Space.recipe.icons
    end
end

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------

--- Iniciar el modulo
ThisMOD.Start()

---------------------------------------------------------------------------------------------------

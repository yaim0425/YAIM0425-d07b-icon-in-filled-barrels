---------------------------------------------------------------------------------------------------
---> data-final-fixes.lua <---
---------------------------------------------------------------------------------------------------

--- Contenedor de funciones y datos usados
--- unicamente en este archivo
local This_MOD = {}

---------------------------------------------------------------------------------------------------

--- Iniciar el modulo
function This_MOD.start()
    --- Valores de la referencia
    This_MOD.setSetting()

    --- Información a usar
    This_MOD.BuildInfo()

    --- Cambiar la propiedad necesaria
    This_MOD.ChangePproperty()
end

--- Valores de la referencia
function This_MOD.setSetting()
    --- Otros valores
    Prefix       = "zzzYAIM0425-0700-"
    This_MOD.name = "icon-in-barrel-filled"

    --- Contenedor
    This_MOD.Info = { load = {} }
end

---------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------

--- Información a usar
function This_MOD.BuildInfo()
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
        local Space             = This_MOD.Info.load[name] or {}
        This_MOD.Info.load[name] = Space

        --- Guardar la información
        Space.item              = GPrefix.items[name]

        if not Space.item or not GPrefix.recipes[Space.item.name] then
            This_MOD.Info.load[name] = nil
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
function This_MOD.ChangePproperty()
    for _, Space in pairs(This_MOD.Info.load) do
        Space.item.icons = Space.recipe.icons
    end
end

---------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------

--- Iniciar el modulo
This_MOD.start()

---------------------------------------------------------------------------------------------------

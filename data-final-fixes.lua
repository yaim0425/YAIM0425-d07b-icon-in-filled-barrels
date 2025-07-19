---------------------------------------------------------------------------------------------------
---> data-final-fixes.lua <---
---------------------------------------------------------------------------------------------------

--- Contenedor de funciones y datos usados
--- unicamente en este archivo
local This_MOD = {}

---------------------------------------------------------------------------------------------------

--- Iniciar el modulo
function This_MOD.start()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Obtener información desde el nombre de MOD
    GPrefix.split_name_folder(This_MOD)

    --- Valores de la referencia
    This_MOD.setting_mod()

    --- Información a usar
    This_MOD.get_recipes()

    --- Cambiar la propiedad necesaria
    This_MOD.set_icon_in_item()

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Valores de la referencia
function This_MOD.setting_mod()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Contenedor
    This_MOD.recipes = {}

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------

--- Información a usar
function This_MOD.get_recipes()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Validar un receta
    local function validate_recipe(recipe)
        --- Validación
        if #recipe.results ~= 1 then return end
        if #recipe.ingredients ~= 2 then return end
        local Item  = GPrefix.get_table(recipe.ingredients, "name", "barrel")
        local Fuild = GPrefix.get_table(recipe.ingredients, "type", "fluid")
        if not Item then return end
        if not Fuild then return end

        --- Crear el espacio para la entidad
        local name = recipe.results[1].name
        local Space = This_MOD.recipes[name] or {}
        This_MOD.recipes[name] = Space

        --- Guardar la información
        Space.item = GPrefix.items[name]

        if not Space.item then
            This_MOD.recipes[name] = nil
            return
        end

        Space.recipe = recipe
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    --- Buscar las recetas y los objetos
    for _, recipes in pairs(GPrefix.recipes) do
        for _, recipe in pairs(recipes) do
            validate_recipe(recipe)
        end
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

--- Cambiar la propiedad necesaria
function This_MOD.set_icon_in_item()
    --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    for _, space in pairs(This_MOD.recipes) do
        space.item.icons = space.recipe.icons
    end

    --- --- --- --- --- --- --- --- --- --- --- --- --- ---
end

---------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------

--- Iniciar el modulo
This_MOD.start()

---------------------------------------------------------------------------------------------------

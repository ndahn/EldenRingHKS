-- Global hooks table
HOOKS = {}

--[[
Add "before" and "after" hook code points to a function. 
Functions do not need to call these hooks explicitly.
The "before" hooks will get passed the same arguments as the function.
The "after" hooks will get passed the function's results.

Use as follows after defining your function:
    MyFunction = hookup_function(MyFunction)
]]
function hookup_function(func)
    -- Avoid expensive global lookups
    local hooks = HOOKS[func] or {}
    local before = hooks["before"] or {}
    local after = hooks["after"] or {}

    return function(...)
        -- Call hooks before executing function
        for i = 1, #before do
            local handled, result = before[i](...)
            if handled then 
                -- Hook replaces the function's normal execution
                return result 
            end
        end

        -- Call the actual function
        local results = {func(...)}

        -- Call hooks after executing function
        for i = 1, #after do
            local handled, result = after[i](table.unpack(results))
            if handled then 
                -- Hook replaces the function's normal return
                return table.unpack(result )
            end
        end

        -- Return the actual function's result
        return table.unpack(results)
    end
end

--[[
Register a new hook.
The hook keys "before" and "after" are special, see hookup_function() for details.
See call_hook() for calling regular registered hooks.

For consistency, callbacks should expect the function's arguments plus an additional "context" 
table containing the calling function's local variables (so the callback can modify them if 
desired).

Callbacks can return two values: the 1st is a boolean to indicate whether the calling function
should return early. If it is true, the function will return early with the 2nd value returned 
by the callback. No other hooks will be called in this case. Otherwise, the 2nd value will be 
ignored.

Expect to enter a world of mergies and pain if you stray from this path!
]]
function register_hook(func, code_point, callback)
    HOOKS[func] = HOOKS[func] or {}
    HOOKS[func][code_point] = HOOKS[func][code_point] or {}
    table.insert(HOOKS[func][code_point], callback)
end

--[[
Call all hooks registered for a specific hook code point.
For registering hooks see register_hook().

Use as follows inside your function (e.g. MyFunc):
    local handled, result = call_hook(MyFunc, "my_code_point", ...)
    if handled then return result end
]]
function call_hook(func, code_point, ...)
    local hook_list = HOOKS[func] and HOOKS[func][code_point]
    if not hook_list then return false end

    for i = 1, #hook_list do
        local handled, result = hook_list[i](...)
        if handled then 
            -- Hook is asking the function to return early
            return true, result 
        end
    end

    return false
end


--[[
EXAMPLE:
--------

-- An actual c0000.hks function
function GetAttackRequest(is_guard)
    -- Usually these are defined as locals, but in order to allow hooks to modify these they 
    -- should be stored inside a table instead. On one hand this is slower than using a local. On 
    -- the other hand, people don't shy away from calling the same env function over and over in 
    -- different if-branches, so it can't be that bad.
    local context = {
        style = c_Style,
        is_both = FALSE,
        is_both_right = FALSE,
    }
    
    -- hypothetical hook code point
    local handled, result = call_hook(MyFunc, "define_style", is_guard, context)
    if handled then return result end
    
    -- continue with regular execution
    ...
end

-- Our custom hook
function my_attack_request_hook_hand_always_both(is_guard, context)
    context.is_both = true
    -- returning nil is fine if we don't want the calling function to exit early
end

-- Hook setup
GetAttackRequest = hookup_function(GetAttackRequest)
register_hook(GetAttackRequest, "define_style", my_hook_style_always_both)

]]

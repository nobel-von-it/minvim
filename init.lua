local function get_fish_env(var_name)
    local cmd = string.format("fish -c 'unlock_vault > /dev/null; echo $%s'", var_name)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return result:gsub("%s+", "")
end

local gpg_home = get_fish_env("GNUPGHOME")
if gpg_home ~= "" then
    vim.env.GNUPGHOME = gpg_home
end

local ssh_auth = get_fish_env("SSH_AUTH_SOCK")
if ssh_auth ~= "" then
    vim.env.SSH_AUTH_SOCK = ssh_auth
end

require("config.lazy")

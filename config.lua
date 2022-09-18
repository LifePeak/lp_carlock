--[[

██╗     ██╗███████╗███████╗██████╗ ███████╗ █████╗ ██╗  ██╗              ███████╗██╗  ██╗██████╗ ██╗██████╗ ████████╗███████╗
██║     ██║██╔════╝██╔════╝██╔══██╗██╔════╝██╔══██╗██║ ██╔╝              ██╔════╝██║ ██╔╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██║     ██║█████╗  █████╗  ██████╔╝█████╗  ███████║█████╔╝     █████╗    ███████╗█████╔╝ ██████╔╝██║██████╔╝   ██║   ███████╗
██║     ██║██╔══╝  ██╔══╝  ██╔═══╝ ██╔══╝  ██╔══██║██╔═██╗     ╚════╝    ╚════██║██╔═██╗ ██╔══██╗██║██╔═══╝    ██║   ╚════██║
███████╗██║██║     ███████╗██║     ███████╗██║  ██║██║  ██╗              ███████║██║  ██╗██║  ██║██║██║        ██║   ███████║
╚══════╝╚═╝╚═╝     ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝              ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
                                                                                                                             
--]]

Config = {}
Config.Notification = {}
Config.RequiredKey = 'U'
Config.PlayerCarArea = 30
Config.Locale  = 'de'
Config.EnableJobvehicle = true --not implimentet jet

Config.Notification.System = "none", -- lp_notify / none
Config.Notification.postion = "top right" -- Only works lp_notify! | lp_"top right", [top Left, top Right, bottom Left, bottom Right]
Config.Notification.displaytime = 13000 -- ms

Config.AdminGroups = {
	superadmin = true,
	admin = true
}
-- You can also give player AcePerms to admincarlockkeys instead
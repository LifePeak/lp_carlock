--[[

██╗     ██╗███████╗███████╗██████╗ ███████╗ █████╗ ██╗  ██╗              ███████╗██╗  ██╗██████╗ ██╗██████╗ ████████╗███████╗
██║     ██║██╔════╝██╔════╝██╔══██╗██╔════╝██╔══██╗██║ ██╔╝              ██╔════╝██║ ██╔╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██║     ██║█████╗  █████╗  ██████╔╝█████╗  ███████║█████╔╝     █████╗    ███████╗█████╔╝ ██████╔╝██║██████╔╝   ██║   ███████╗
██║     ██║██╔══╝  ██╔══╝  ██╔═══╝ ██╔══╝  ██╔══██║██╔═██╗     ╚════╝    ╚════██║██╔═██╗ ██╔══██╗██║██╔═══╝    ██║   ╚════██║
███████╗██║██║     ███████╗██║     ███████╗██║  ██║██║  ██╗              ███████║██║  ██╗██║  ██║██║██║        ██║   ███████║
╚══════╝╚═╝╚═╝     ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝              ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
                                                                                                                             
--]]

Config = {}
Config.RequiredKey = 'U'
Config.UseOldESX = false

Config.PlayerCarArea = 30
Config.Locale  = 'de'
Config.EnableJobvehicle = true -- players can open all vehicle with same job.
Config.Notification = {}
Config.Notification.System = "none" -- lp_notify / none
Config.Notification.Postion = "top right" -- Only works lp_notify! | lp_"top right", [top Left, top Right, bottom Left, bottom Right]
Config.Notification.Displaytime = 1000 -- ms

Config.AdminGroups = {
	superadmin = true,
	admin = true
}
-- You can also give player AcePerms to admincarlockkeys instead

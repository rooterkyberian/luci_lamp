--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>
Copyright 2008-2011 Jo-Philipp Wich <xm@subsignal.org>
Copyright 2012 Daniel Golle <dgolle@allnet.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

module("luci.controller.lamp.lamp", package.seeall)

function index()
	local root = node()
	if not root.target then
		root.target = alias("lamp")
		root.index = true
	end

	page          = node()
	page.lock     = true
	page.target   = alias("lamp")
	page.subindex = true
	page.index    = false

	page          = node("lamp")
	page.title    = _("Lamp")
	page.target   = alias("lamp", "switch")
	page.order    = 5
	page.setuser  = "root"
	page.setgroup = "root"
	page.index    = true

	entry({"lamp", "switch"}, call("action_lamp"), _("lamp"), 70)
end

function action_lamp()
	local state = luci.http.formvalue("rstate")
	luci.template.render("lamp/switch", {rstate=rstate})
    if state then
        local cmd = string.format("echo %d > /sys/class/gpio/gpio7/value", state)
        luci.sys.exec(cmd)                                  
    end
end


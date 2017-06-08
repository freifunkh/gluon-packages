local cbi = require "luci.cbi"
local uci = luci.model.uci.cursor()
local site = require 'gluon.site_config'
local fs = require "nixio.fs"
local i18n = require "luci.i18n"
local districts = require 'gluon.districts'

local sites = {}
local M = {}

-- walk over table sorted by keys alphabetically
function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end

function M.section(form)
	local s = form:section(cbi.SimpleSection, nil, 
                i18n.translate("Please choose your district."))
		
	local o = s:option(cbi.ListValue, "district", i18n.translate("District"))
	o.rmempty = false
	o.optional = false

	if uci:get_first("gluon-setup-mode", "setup_mode", "configured") == "0" then
		o:value("")
	else
		o:value(site.district, site.site_name)
	end

	for code, d in pairsByKeys(districts) do
		o:value(code, d['n'])
	end

end

function M.handle(data)

	if data.site_code ~= site.site_code then
		-- copy new site conf
		fs.copy('/lib/gluon/site-select/' .. data.site_code .. '.json', '/lib/gluon/site.json')
		-- store new site conf in uci currentsite
		uci:set('currentsite', 'current', 'name', data.site_code)
		uci:save('currentsite')
		uci:commit('currentsite')
		os.execute('sh "/lib/gluon/site-upgrade"')
	end
end

return M

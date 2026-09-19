local m, s, o

m = Map("tailscale", translate("Tailscale"),
	translate("保存并应用后，设置会由 /etc/init.d/tailscale-settings 应用到 tailscale。"))

s = m:section(NamedSection, "settings", "settings")
s.anonymous = true
s.addremove = false

o = s:option(Flag, "service_enabled", translate("启用 Tailscale 服务"))
o.default = "1"
o.rmempty = false

o = s:option(Flag, "accept_routes", translate("接受子网路由 (--accept-routes)"))
o.default = "0"
o.rmempty = false

o = s:option(Flag, "advertise_exit_node", translate("通告为出口节点 (--advertise-exit-node)"))
o.default = "0"
o.rmempty = false

o = s:option(DynamicList, "advertise_routes", translate("通告路由 (--advertise-routes)"))
o.placeholder = "192.168.31.0/24"
o.validate = function(self, value)
	if type(value) ~= "string" or value == "" then
		return value
	end
	local ip, mask = value:match("^(%d+%.%d+%.%d+%.%d+)/(%d+)$")
	if ip and tonumber(mask) and tonumber(mask) >= 0 and tonumber(mask) <= 32 then
		return value
	end
	return nil, translate("必须是 CIDR 格式，例如 192.168.31.0/24")
end

o = s:option(Value, "exit_node", translate("使用出口节点 (--exit-node)"))
o.placeholder = "exit-node-name-or-id"
o.rmempty = true

o = s:option(Flag, "exit_node_allow_lan_access", translate("出口节点允许访问本地 LAN (--exit-node-allow-lan-access)"))
o.default = "0"
o.rmempty = false

o = s:option(Flag, "ssh", translate("启用 Tailscale SSH (--ssh)"))
o.default = "0"
o.rmempty = false

o = s:option(ListValue, "dns_mode", translate("DNS 模式"))
o:value("disabled", translate("禁用 (--accept-dns=false)"))
o:value("magicdns", translate("使用 MagicDNS (--accept-dns=true)"))
o:value("openwrt_forward", translate("使用 OpenWrt dnsmasq 转发 MagicDNS"))
o.default = "disabled"

o = s:option(Flag, "shields_up", translate("屏蔽传入连接 (--shields-up)"))
o.default = "0"
o.rmempty = false

o = s:option(Flag, "runwebclient", translate("启用 Web 客户端 (--webclient)"))
o.default = "0"
o.rmempty = false

o = s:option(Flag, "nosnat", translate("禁用 SNAT (--snat-subnet-routes=false)"))
o.default = "0"
o.rmempty = false

o = s:option(Value, "hostname", translate("主机名 (--hostname)"))
o.rmempty = true

o = s:option(Flag, "enable_relay", translate("启用中继服务端口 (--relay-server-port)"))
o.default = "0"
o.rmempty = false

o = s:option(Value, "relay_server_port", translate("中继端口"))
o.default = "40000"
o.datatype = "port"

o = s:option(Value, "port", translate("tailscaled 监听端口"))
o.default = "41641"
o.datatype = "port"

o = s:option(Value, "state_file", translate("状态文件"))
o.default = "/etc/tailscale/tailscaled.state"

o = s:option(Flag, "log_stdout", translate("记录标准输出"))
o.default = "1"

o = s:option(Flag, "log_stderr", translate("记录标准错误"))
o.default = "1"

o = s:option(ListValue, "fw_mode", translate("防火墙模式"))
o:value("nftables", "nftables")
o:value("iptables", "iptables")
o.default = "iptables"

return m

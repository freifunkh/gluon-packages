local function check_speedtest_peer(k)
	need_alphanumeric_key(k)

	-- we only support ip6 as gluon only has ip6 addresses in the mesh as of now
	need_string_match(extend(k, {'ip6'}), '^[%x:]+$')
end

need_table({'ffh', 'speedtest_peers'}, check_speedtest_peer)

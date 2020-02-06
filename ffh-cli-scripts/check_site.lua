local function check_speedtest_peer(k)
	need_alphanumeric_key(k)

	need_string(extend(k, {'host'}))
end

need_table({'ffh', 'speedtest_peers'}, check_speedtest_peer)

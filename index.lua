--Frankenfirm Updater Tool
--
--This tool uses Lua Player Plus 3DS with svchax support. It *could* potentially brick your 3DS!
--
--If you're not familiar with the terms "Frankenfirmware", "NVer", "CIA", "NAND" or "NATIVE_FIRM", DO NOT USE THIS PRIOR TO RESEARCHING.
--This *should* be foolproof, but you should take caution as well.
--
-- Now, enjoy this. ~gnmmarechal/gnmpolicemata




--Primary checks (extremely important)
function fsystemcheck() --Checks firmware version (major, minor, rev) and system region (USA, EUR, JPN)
	major, minor, rev = System.getFirmware()
	regint = System.getRegion()
	if regint == 1 then
		region = "USA"
	else
		if regint == 2 then
			region = "EUR"
		else
			region = "JPN"
		end	
	end
end


while true do

end

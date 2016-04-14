--Frankenfirm Updater Tool
--
--This tool uses Lua Player Plus 3DS with svchax support. It *could* potentially brick your 3DS!
--
--If you're not familiar with the terms "Frankenfirmware", "NVer", "CIA", "NAND" or "NATIVE_FIRM", DO NOT USE THIS PRIOR TO RESEARCHING.
--This *should* be foolproof, but you should take caution as well.
--
-- Now, enjoy this. ~gnmmarechal/gnmpolicemata

white = Color.new(255,255,255)
green = Color.new(0,240,32)
red = Color.new(255,0,0)


--Important functions

rel = 0 --1 means it will install the CIAs, 0 is merely a test for the interface itself, it won't change any files.

function systemcheck() --Checks firmware version (major, minor, rev) , system region (USA, EUR, JPN) and model (0 = OLD, 1 = NEW)
	major, minor, rev = System.getFirmware() --gets firmware version
	regint = System.getRegion() --gets region
	if regint == 1 then
		region = "USA"
	else
		if regint == 2 then
			region = "EUR"
		else
			region = "JPN"
		end	
	end
	modeln = System.getModel() --gets model
	if modeln == 0 or model == 1 or model == 3 then
		model = 0
		modelstring = "Old 3DS/2DS"
	else
		model = 1
		modelstring = "New 3DS"
	end
		
end

function displaysystem() -- Displays system information
	debugPrint(0,0,"MAKE SURE THIS IS CORRECT!", red, BOTTOM_SCREEN)
	debugPrint(0,20,"Abort if wrong! (XL doesn't matter)", red, BOTTOM_SCREEN)
	debugPrint(0,20,"Model:"..modelstring, white, BOTTOM_SCREEN)
end

--other functions
function checkquit()
	if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
		System.exit()
	end
end




--Checking stuff before doing anything to the console
systemcheck()


while true do

end

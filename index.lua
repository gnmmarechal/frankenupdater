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
System.currentDirectory("/")
root = System.currentDirectory()
updatedir = "cia"

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
	debugPrint(0,40,"Model:"..modelstring, white, BOTTOM_SCREEN)
end

--other functions
function checkquit()
	if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
		System.exit()
	end
end
function waitchange(string nextscr)
	if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
		scr = nextscr
	end
end


--CIA Checks
function regionsetcia() --checks if the correct CIAs are available on the SD Card. As of now, it doesn't check for file corruption
if region == "USA" then
	nver = "000400DB00016302" -- latest ver 512 (10.7)
	friends = "0004013000003202" -- latest ver 10240 (10.7)
	eshop = "0004001000021900" -- latest ver 21506 (10.7)
	mint = "000400300000CE02" -- latest ver 16384 (10.7)
end
if region == "EUR" then
	nver = "000400DB00016102" -- latest ver 512 (10.7)
	friends = "0004013000003202" -- latest ver 10240 (10.7)
	eshop = "0004001000022900" -- latest ver 21505 (10.7)
	mint = "000400300000D602" -- latest ver 16384 (10.7)
end
if region == "JPN" then
	nver = "000400DB00016202" -- latest ver 512 (10.7)
	friends = "0004013000003202" -- latest ver 10240 (10.7)
	eshop = "0004001000020900" -- latest ver 21504 (10.7)
	mint = "000400300000C602" -- latest ver 16384 (10.7)
end

end

--Checking stuff before doing anything to the console
systemcheck()


while true do

end

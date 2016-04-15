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
updatedir = root.."cia"
scr = 1
installed = 0

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
	debugPrint(0,60,"FW:"..major.."."..minor.."."..rev, white, BOTTOM_SCREEN)
end

--other functions
function checkquit()
	if Controls.check(pad,KEY_B) and not Controls.check(oldpad,KEY_B) then
		System.exit()
	end
end
function waitchange(nextscr)
	if Controls.check(pad,KEY_A) and not Controls.check(oldpad,KEY_A) then
		scr = nextscr
	end
end
function clear()
	Screen.refresh()
	Screen.clear(TOP_SCREEN)
	Screen.clear(BOTTOM_SCREEN)
end 


--CIA Checks
function oldregionsetcia() --checks if the correct CIAs are available on the SD Card. As of now, it doesn't check for file corruption
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

function newregionsetcia() -- Same as oldregionsetcia(), for the new3DS
	if region == "USA" then
		nver = ""
		friends = ""
		eshop = ""
		mint = ""
	end
	if region == "EUR" then
		nver = ""
		friends = ""
		eshop = ""
		mint = ""
	end
	if region == "JPN" then
		nver = ""
		friends = ""
		eshop = ""
		mint = ""
	end
end

function setcia() -- Uses the variables to decide whether to use newregionsetcia or oldregionsetcia
	if model == 0 then --o3DS/2DS
		oldregionsetcia()
	end
	if model == 1 then --n3DS
		newregionsetcia()
	end
end

function doesciaexist() --checks if the CIA files are in the correct directory and/or exist
	if not System.doesFileExist(updatedir..nver..".cia") then
		return 0
	end
	if not System.doesFileExist(updatedir..friends..".cia") then
		return 0
	end
	if not System.doesFileExist(updatedir..eshop..".cia") then
		return 0
	end
	if not System.doesFileExist(updatedir..mint..".cia") then
		return 0
	else
		return 1
	end
end

function installcia() --installs the CIA files to NAND (doesn't do anything if rel = 0)
	if doesciaexist() then
		debugPrint(0,0,"Installing CIA files...", white, TOP_SCREEN)
		if rel == 1 and installed == 0
			System.installCIA(updatedir..nver..".cia", NAND)
			System.installCIA(updatedir..friends..".cia", NAND)
			System.installCIA(updatedir..eshop..".cia", NAND)
			System.installCIA(updatedir..mint..".cia", NAND)
			installed == 1
		end
		
	else
		err = 0 --Error 0 is missing files
		scr = 0 -- error screen
	end
end



oldpad = Controls.read()

--Checking stuff before doing anything to the console
systemcheck()
setcia()

--UI Screens
function disclaimer() --scr = 1 -- Disclaimer, first screen
	debugPrint(0,0,"DISCLAIMER:", red, TOP_SCREEN)
	debugPrint(0,40,"It's your console, and your choice!", white, TOP_SCREEN)
	debugPrint(0,60,"Don't blame me if anything happens!", white, TOP_SCREEN)
	debugPrint(0,80,"USE THE CORRECT FILES!", red, TOP_SCREEN)
	debugPrint(0,100,"Press A to install CIAs.", white, TOP_SCREEN)
	waitchange(2)
	checkquit()
end


while true do
	clear()
	pad = Controls.read()
	displaysystem()
	if scr == 1

	end
	
	
	Screen.flip()
	Screen.waitVblankStart()
	oldpad = pad
end

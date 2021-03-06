--Frankenfirm Updater Tool (FrankenUpdater)
--
--This tool uses Lua Player Plus 3DS with svchax support. It *could* potentially brick your 3DS!
--
--Prior to using this, make sure your SD Card is ok and doesn't corrupt files out of the blue, try to download the CIAs multiple times and make sure they're the same file, and make sure the CIAs copy without issues.
--
--If you're not familiar with the terms "Frankenfirmware", "NVer", "CIA", "NAND" or "NATIVE_FIRM", DO NOT USE THIS PRIOR TO RESEARCHING.
--This *should* be foolproof, but you should take caution as well.
--
-- Now, enjoy this. ~gnmmarechal/gnmpolicemata
--
--
-- Credits:
--
-- *gnmmarechal/gnmpolicemata - Creator of the script itself
-- *Rinnegatamante - Creator of Lua Player Plus 3DS
--

-- THIS TOOL IS NOT SAFE. DO NOT USE IT. IT HAS NOT BEEN TESTED.

--Indicates the version of FrankenUpdater
scriptver = "1.0.2"

--These lines set the colours for the text in RGB
white = Color.new(255,255,255)
green = Color.new(0,240,32)
red = Color.new(255,0,0)


System.currentDirectory("/") -- Sets the current directory
root = System.currentDirectory() --Defines the directory "root" as the root of the SDMC
updatedir = root.."cia/" --Defines the directory containing the CIA update files
scr = 1 --Defines the starting screen
installed = 0 --Sets whether the CIA files have already been installed or not
--cia_table = System.listCIA()

--Important functions

rel = 0 --1 means it will install the CIAs, 0 is merely a test for the interface itself, it won't change any files.

function setsafemode() --defines whether the system is using SAFE test or not
	if rel == 0 then
		setmode = "SAFE"
	else
		setmode = "ARMED"	
	end
end

function systemcheck() --Checks firmware version (major, minor, rev) , system region (USA, EUR, JPN) and model (0 = OLD, 1 = NEW)
	major, minor, rev = System.getFirmware() --gets firmware version
	regioncheck()
	modelcheck()
end
function regioncheck()
	regint = System.getRegion() --gets region number
	if regint == 1 then --checks if the region is 1 (US)
		region = "USA" --Sets region string as USA
	else
		if regint == 2 then --checks if the region is 2 (EUR)
			region = "EUR" --Sets region string as EUR
		else
			region = "JPN" --If it's not EUR or US, defines it as JPN --- This includes any console that isn't EUR/US, could go wrong with KOR/whatever that isn't EUR/US/JPN!
		end	
	end
end
function modelcheck()
	modeln = System.getModel() --gets model number
	if modeln == 0 or n == 1 or modeln == 3 then --If the system is a 2DS, 3DS or 3DS XL, defines the model as '0' and the correct string.
		model = 0
		modelstring = "Old 3DS/2DS"
	else --If the system is not an old3DS system, defines it as '1', aka New 3DS/New 3DS XL
		model = 1
		modelstring = "New 3DS" 
	end
end
function newregioncheck() --This might work
	cialist = System.listCIA()
	for k, v in pairs(cialist) do
		if v.uniqueid == 0x00017302 then
			region = "USA"
		end
		if v.uniqueid == 0x00017102 then
			region = "EUR"
		end
		if v.uniqueid == 0x00017202 then
			region = "JPN"
		end
		if v.uniqueid == 0x00017402 then
			region = "CHN"
		end
		if v.uniqueid == 0x00017502 then
			region = "KOR"
		end
		if v.uniqueid == 0x00017602 then
			region = "TWN"
		end
	end
end

function displaysystem() -- Displays system information
	Screen.debugPrint(0,0,"MAKE SURE THIS IS CORRECT!", red, BOTTOM_SCREEN)
	Screen.debugPrint(0,20,"Abort if wrong! (XL is irrelevant)", red, BOTTOM_SCREEN)
	Screen.debugPrint(0,40,"Model:"..modelstring, white, BOTTOM_SCREEN)
	Screen.debugPrint(0,60,"Region:"..region, white, BOTTOM_SCREEN)
	Screen.debugPrint(0,80,"NATIVE_FIRM:"..major.."."..minor.."-"..rev, white, BOTTOM_SCREEN)
	Screen.debugPrint(0,100,"SCRIPT:"..scriptver, white, BOTTOM_SCREEN)
	Screen.debugPrint(0,120,"SAFE:"..setmode, white, BOTTOM_SCREEN)
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
		nverto = 0x000400DB
		nverts = 0x00016302
		friends = "0004013000003202" -- latest ver 10240 (10.7)
		friendso = 0x00040130
		friendss = 0x00003202
		eshop = "0004001000021900" -- latest ver 21506 (10.7)
		eshopo = 0x00040010
		eshops = 0x00021900
		mint = "000400300000CE02" -- latest ver 16384 (10.7)
		minto = 0x00040030
		mints = 0x0000CE02
	end
	if region == "EUR" then
		nver = "000400DB00016102" -- latest ver 512 (10.7)
		nvero = 0x000400DB
		nvers = 0x00016102
		friends = "0004013000003202" -- latest ver 10240 (10.7)
		friendso = 0x00040130
		friendss = 0x00003202
		eshop = "0004001000022900" -- latest ver 21505 (10.7)
		eshopo = 0x00040010
		eshops = 0x00022900
		mint = "000400300000D602" -- latest ver 16384 (10.7)
		minto = 0x00040030
		mints = 0x0000D602
	end
	if region == "JPN" then
		nver = "000400DB00016202" -- latest ver 512 (10.7)
		nvero = 0x000400DB
		nvers = 0x00016202
		friends = "0004013000003202" -- latest ver 10240 (10.7)
		friendso = 0x00040130
		friendss = 0x00003202
		eshop = "0004001000020900" -- latest ver 21504 (10.7)
		eshopo = 0x00040010
		eshops = 0x00020900
		mint = "000400300000C602" -- latest ver 16384 (10.7)
		minto = 0x00040030
		mints = 0x0000C602
	end

end

function newregionsetcia() -- Same as oldregionsetcia(), for the new3DS
	if region == "USA" then
		nver = "000400DB20016302" --latest ver 512 (10.7)
		nvero = 0x000400DB
		nvers = 0x20016302
		friends = "0004013000003202" --latest ver 10240 (10.7)
		friendso = 0x00040130
		friendss = 0x00003202
		eshop = "0004001000021900" --latest ver 21506 (10.7)
		eshopo = 0x00040010
		eshops = 0x00021900
		mint = "000400300000CE02" --latest ver 16384 (10.7)
		minto = 0x00040030
		mints = 0x0000CE02
	end
	if region == "EUR" then
		nver = "000400DB20016102" --latest ver 512 (10.7)
		nvero = 0x000400DB
		nvers = 0x20016102
		friends = "0004013000003202" --latest ver 10240 (10.7)
		friendso = 0x00040130
		friendss = 0x00003202
		eshop = "0004001000022900" --latest ver 21505 (10.7)
		eshopo = 0x00040010
		eshops = 0x00022900
		mint = "000400300000D602" --latest ver 16384 (10.7)
		minto = 0x00040030
		mints = 0x0000D602
	end
	if region == "JPN" then
		nver = "000400DB20016202" --latest ver 512 (10.7)
		nvero = 0x000400DB
		nvers = 0x20016202
		friends = "0004013000003202" --latest ver 10240 (10.7)
		friendso = 0x00040130
		friendss = 0x00003202
		eshop = "0004001000020900" --latest ver 21504 (10.7)
		eshopo = 0x00040010
		eshops = 0x00020900
		mint = "000400300000C602" --latest ver 16384 (10.7)
		minto = 0x00040030
		mints = 0x0000C602
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
	checkciaexist = doesciaexist()
	if checkciaexist == 1 then
		Screen.debugPrint(0,80,"Installing CIA files...", white, TOP_SCREEN)
		if rel == 1 and installed == 0 then
			deletecia(nvero,nvers)
			System.installCIA(updatedir..nver..".cia", NAND)
			deletecia(friendso,friendss)
			System.installCIA(updatedir..friends..".cia", NAND)
			deletecia(eshopo,eshops)
			System.installCIA(updatedir..eshop..".cia", NAND)
			deletecia(minto,mints)
			System.installCIA(updatedir..mint..".cia", NAND)
			installed = 1
		end
		
	else
		err = 0 --Error 0 is missing files
		scr = 0 -- error screen
	end
end

function deletecia(ciao,cias) --featuring copypasta ty Rinnegatamante
	title_id = Core.alloc(0x08)
	Core.storeWord(title_id, ciao)
	Core.storeWord(title_id + 0x04, ciaf)

	-- Initializing AM service
	Core.execCall("amInit")
	if not ret == 0 then
		error("amInit returned an error: 0x" .. string.format("%X",ret))
	end

	-- Launching both Delete calls just to be sure
	Core.execCall("AM_DeleteTitle", 0x00, title_id)
	Core.execCall("AM_DeleteAppTitle", 0x00, title_id)

	-- Closing AM service
	Core.execCall("amExit")

	-- Freeing memory and exiting
	Core.free(title_id)
end

function optnrtrn() --Waits for SELECT then toggles between SCR 1 and SCR 3
	if Controls.check(pad, KEY_SELECT) and not Controls.check(oldpad, KEY_SELECT) then
		if scr==1 then
			scr=3
		else
			if scr==3 then
				scr=1
			end
		end
	end
end

oldpad = Controls.read()

--Checking stuff before doing anything to the console
systemcheck()
setcia()
setsafemode()

--UI Screens
function errorscreen() --scr = 0 -- Error screen, displays error code in case of an error
	head()
	Screen.debugPrint(0,40,"An error has ocurred.", white, TOP_SCREEN)
	Screen.debugPrint(0,60,"Please refer to the documentation.", white, TOP_SCREEN)
	Screen.debugPrint(0,80,"Error code: "..err, red, TOP_SCREEN)
	Screen.debugPrint(0,100,"Press B to quit.", white, TOP_SCREEN)
	checkquit()
end

function disclaimer() --scr = 1 -- Disclaimer, first screen
	head()
	Screen.debugPrint(0,80,"DISCLAIMER:", red, TOP_SCREEN)
	Screen.debugPrint(0,100,"It's your console, and your choice!", white, TOP_SCREEN)
	Screen.debugPrint(0,120,"Don't blame me if anything happens!", white, TOP_SCREEN)
	Screen.debugPrint(0,140,"USE THE CORRECT FILES!", red, TOP_SCREEN)
	Screen.debugPrint(0,160,"Press A to install CIAs.", white, TOP_SCREEN)
	waitchange(2)
	checkquit()
end

function startinstall() --scr = 2 --Second screen, starts the installation of the CIA files
	head()
	Screen.debugPrint(0,40,"Installation started. Please wait...", white, TOP_SCREEN)
	Screen.debugPrint(0,60,"DO NOT TURN THE POWER OFF!!!", red, TOP_SCREEN)
	installcia()
	Screen.debugPrint(0,100,"Done! Press B to quit!", white, TOP_SCREEN) 
end

function showciainfo() --scr = 3 --show the information about the CIA files
	head()
	Screen.debugPrint(0,40,"CIA Title Info:", white, TOP_SCREEN)
	Screen.debugPrint(0,60,"NVer:"..nver, white, TOP_SCREEN)
	Screen.debugPrint(0,80,"F. Module:"..friends, white, TOP_SCREEN)
	Screen.debugPrint(0,100,"eShop:"..eshop, white, TOP_SCREEN)
	Screen.debugPrint(0,120,"Mint:"..mint, white, TOP_SCREEN)
	Screen.debugPrint(0,140,"Press SELECT to go back", white, TOP_SCREEN)
end

function head() -- Head of all screens
	Screen.debugPrint(0,0,"FrankenUpdater v."..scriptver.." by gnmmarechal", white, TOP_SCREEN)
	Screen.debugPrint(0,20,"===============", red, TOP_SCREEN)	
end
while true do
	clear()
	pad = Controls.read()
	displaysystem()
	if scr == 0 then
		errorscreen()
	end
	if scr == 1 then
		disclaimer()
		--optnrtrn()
	end
	if scr == 2 then
		startinstall()
		checkquit()
	else
		optnrtrn()
	end 
	if scr == 3 then
		showciainfo()
		--optnrtrn()
	end
	
	Screen.flip()
	Screen.waitVblankStart()
	oldpad = pad
end

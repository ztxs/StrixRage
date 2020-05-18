-- StrixRage
-- Made by Zetix

-------------------------------------- Print

print("StrixRage has been successfully loaded")

------------------------------------ Auto Update

local CURRENTVERSION = "1.3"
local LATESTVERSION = http.Get("https://raw.githubusercontent.com/ztxs/StrixRage/master/CurrentVersion.txt")
local function Update() 
    if CURRENTVERSION ~= LATESTVERSION then
        currentScript = file.Open(GetScriptName(), "w")
        currentScript:Write(http.Get("https://raw.githubusercontent.com/ztxs/StrixRage/master/StrixRage.lua"))
        currentScript:Close()
        LoadScript(GetScriptName())
    end
end


--------------- Gui button etc

local StrixRage_TAB = gui.Tab(gui.Reference("Ragebot"), "strix.1", "StrixRage")


local StrixUpdate_TAB = gui.Tab(gui.Reference("Ragebot"), "strix.2", "StrixUpdate")


----------------- update 1

local StrixRage_UPDATER_GBOX = gui.Groupbox(StrixUpdate_TAB, "Updater", 10, 10, 160, 0)


local StrixRage_CHANGELOG_GBOX = gui.Groupbox(StrixUpdate_TAB, "Changelog", 190, 10, 290, 0)


-------------------------------- Update versions


local StrixRage_CURRENTVERSION = gui.Text(StrixRage_UPDATER_GBOX, "Current version: v" .. CURRENTVERSION)

local StrixRage_LATESTVERSION = gui.Text(StrixRage_UPDATER_GBOX, "Latest version: v" .. LATESTVERSION)

local StrixRage_UPDATE = gui.Button(StrixRage_UPDATER_GBOX, "Update", Update)

local StrixLua_CHANGELOG_TEXT = gui.Text(StrixRage_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/ztxs/StrixRage/master/Changelog.txt"))

-- windowss


local StrixRage_RAGE_GBOX = gui.Groupbox(StrixRage_TAB, "Manual AA", 260, 14, 145, 0)

local StrixRage_VISUALS_GBOX = gui.Groupbox(StrixRage_TAB, "Visuals", 260, 340, 145, 0)


local StrixRage_MOVEMENT_GBOX = gui.Groupbox(StrixRage_TAB, "Movement", 20, 450, 180, 0)

-- autobuy
local ref = gui.Reference("Ragebot", "StrixRage"); 
local Group = gui.Groupbox(ref, "Autobuy", 450, 14, 160)
local checkbox_buybot = gui.Checkbox( Group, "Checkbox", "BuyBot Active",  false)
local primary_guns = gui.Combobox( Group, "primary", "Primary", "Off", "Scar-20 | G3SG1","AK47 | M4A1", "SSG-08", "AWP", "SG553 | AUG")
local secondary_guns = gui.Combobox( Group, "Secondary", "Secondary",  "Off", "Dual Berettas", "Deagle | Revolver", "P250","TEC-9 | CZ75-Auto" )
local k_armor = gui.Checkbox( Group, "k_armor", "Buy Kevlar + Armor", false)
local armor = gui.Checkbox( Group, "armor", "Buy Armor", false)
local nades = gui.Checkbox( Group, "nades", "Buy Nades", false)
local buybot_zeus = gui.Checkbox( Group, "zeus", "Buy Zeus",  false)
local defuser = gui.Checkbox( Group, "defuser", "Buy Defuser",  false)
local weapons_ = {"pistol", "revolver", "smg", "rifle", "shotgun", "scout", "autosniper", "sniper", "lmg"}
local hitboxes_ = {"head", "neck", "chest", "stomach", "pelvis", "arms", "legs"}
local primary_w = {"buy scar20", "buy m4a1", "buy ssg08", "buy awp", "buy aug"}
local secondary_w = {"buy elite", "buy deagle", "buy p250", "buy tec9"}
local function Events( event )
    if event:GetName() == "round_start" and checkbox_buybot:GetValue() then
        local needtobuy = ""
        local primary = primary_guns:GetValue()
        local secondary = secondary_guns:GetValue()

        if k_armor:GetValue() then needtobuy = "buy vesthelm;"  
        end
        if armor:GetValue() then needtobuy = "buy vest;"  
        end
        if nades:GetValue() then needtobuy = needtobuy.."buy hegrenade;buy molotov;buy smokegrenade;buy flashbang;buy flashbang;"
        end
        if buybot_zeus:GetValue() then needtobuy = needtobuy.."buy taser;"
        end       
        if defuser:GetValue() then needtobuy = needtobuy.."buy defuser;"
        end
        if primary > 0 then needtobuy = needtobuy..primary_w[primary]..";"  
        end       
        if secondary > 0 then needtobuy = needtobuy..secondary_w[secondary]..";"
        end


        client.Command(needtobuy, false)
  end
          end
callbacks.Register( "FireGameEvent", Events)

--------- manual aa

local gui_set = gui.SetValue;
local gui_get = gui.GetValue;
local LeftKey = 0;
local BackKey = 0;
local RightKey = 0;
local UpKey = 0;
local rage_ref = gui.Reference("Ragebot", "StrixRage", "Manual AA");
local check_indicator = gui.Checkbox(rage_ref, "manual", "Manual AA", false)
local manual_left = gui.Keybox(rage_ref, "manual_left", "Left Keybind", 0);
local manual_right = gui.Keybox(rage_ref, "manual_right", "Right Keybind", 0);
local manual_back = gui.Keybox(rage_ref, "manual_back", "Back Keybind", 0);
local manual_up = gui.Keybox(rage_ref, "manual_up", "Up Keybind", 0);

-- Fonts
local text_font = draw.CreateFont("Verdana", 20, 700)
local arrow_font = draw.CreateFont("Marlett", 35, 700)

local function main()
    if manual_left:GetValue() ~= 0 then
        if input.IsButtonPressed(manual_left:GetValue()) then
            LeftKey = LeftKey + 1;
            BackKey = 0;
            RightKey = 0;
            UpKey = 0;
        end
    end
    if manual_back:GetValue() ~= 0 then
        if input.IsButtonPressed(manual_back:GetValue()) then
            BackKey = BackKey + 1;
            LeftKey = 0;
            RightKey = 0;
            UpKey = 0;
        end
    end
    if manual_right:GetValue() ~= 0 then
        if input.IsButtonPressed(manual_right:GetValue()) then
            RightKey = RightKey + 1;
            LeftKey = 0;
            BackKey = 0;
            UpKey = 0;
        end
    end
    if manual_up:GetValue() ~= 0 then
        if input.IsButtonPressed(manual_up:GetValue()) then
            UpKey = UpKey + 1;
            LeftKey = 0;
            BackKey = 0;
            RightKey = 0;
        end
    end
end


function CountCheck()
   if ( LeftKey == 1 ) then
        BackKey = 0;
        RightKey = 0;
        UpKey = 0;
   elseif ( BackKey == 1 ) then
        LeftKey = 0;
        RightKey = 0;
        UpKey = 0;
    elseif ( RightKey == 1 ) then
        LeftKey = 0;
        BackKey = 0;
        UpKey = 0;
    elseif ( UpKey == 1 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
    elseif ( LeftKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
        UpKey = 0;
   elseif ( BackKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
        UpKey = 0;
   elseif ( RightKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
        UpKey = 0;
   elseif ( UpKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
        UpKey = 0;
   end 
end

function SetLeft()
   gui_set("rbot.antiaim.base", 90);
   gui_set("rbot.antiaim.advanced.autodir", 0);
end

function SetBackWard()
   gui_set("rbot.antiaim.base", 180);
   gui_set("rbot.antiaim.advanced.autodir", 0);
end

function SetRight()
   gui_set("rbot.antiaim.base", -90);
   gui_set("rbot.antiaim.advanced.autodir", 0);
end

function SetUp()
   gui_set("rbot.antiaim.base", 0);
   gui_set("rbot.antiaim.advanced.autodir", 0);
end

function SetAuto()
   gui_set("rbot.antiaim.base", 180);
   gui_set("rbot.antiaim.advanced.autodir", 1);
end

function draw_indicator()
    local active = check_indicator:GetValue()
    if active then
        local w, h = draw.GetScreenSize();
        draw.SetFont(text_font);
        if (LeftKey == 1) then
            SetLeft();
            draw.Color(255, 255, 255);
            draw.Text(15, h - 560, "left");
            draw.TextShadow(15, h - 560, "left");
            draw.SetFont(arrow_font);
            draw.Text( w/2 - 60, h/2 - 16, "3");
            draw.TextShadow( w/2 - 60, h/2 - 16, "3");
            draw.SetFont(text_font);
        elseif (BackKey == 1) then
            SetBackWard();
            draw.Color(255, 255, 255);
            draw.Text(15, h - 560, "back");
            draw.TextShadow(15, h - 560, "back");
            draw.SetFont(arrow_font);
            draw.Text( w/2 - 17, h/2 + 33, "6");
            draw.TextShadow( w/2 - 17, h/2 + 33, "6");
            draw.SetFont(text_font);
        elseif (RightKey == 1) then
            SetRight();
            draw.Color(255, 255, 255);
            draw.Text(15, h - 560, "right");
            draw.TextShadow(15, h - 560, "right");
            draw.SetFont(arrow_font);
            draw.Text( w/2 + 30, h/2 - 16, "4");
            draw.TextShadow( w/2 + 30, h/2 - 16, "4");
            draw.SetFont(text_font);
        elseif (UpKey == 1) then
            SetUp();
            draw.Color(255, 255, 255);
            draw.Text(15, h - 560, "up");
            draw.TextShadow(15, h - 560, "up");
            draw.SetFont(arrow_font);
            draw.Text( w/2 - 17, h/2 + -66, "5");
            draw.TextShadow( w/2 - 17, h/2 + -66, "5");
            draw.SetFont(text_font);
        elseif ((LeftKey == 0) and (BackKey == 0) and (RightKey == 0) and (UpKey == 0)) then
            SetAuto();
            draw.Color(255, 255, 255);
            draw.Text(15, h - 560, "auto");
            draw.TextShadow(15, h - 560, "auto");
        end
    end
end

callbacks.Register( "Draw", "main", main);
callbacks.Register( "Draw", "CountCheck", CountCheck);
callbacks.Register( "Draw", "draw_indicator", draw_indicator);

----- epic antiaim 1

local inverted = false;
local switch = false;
function DrawUI()
    screenX,screenY = draw.GetScreenSize();
    local window = gui.Reference("Ragebot", "StrixRage"); 
    
    groupboxyaw = gui.Groupbox(window,"Base AA",20,15,200,200);
    invert_key = gui.Keybox(groupboxyaw,"invert_key","Inverter Key",0);
    yawamount = gui.Slider(groupboxyaw,"yaw_offset","Yaw Offset",0,-180,180);
    fakeamount = gui.Slider(groupboxyaw,"fake_amount","Fake Amount (%)",100,0,100);
    
    groupboxlag = gui.Groupbox(window,"Lagsync",20,280,200,200);
    lagsyncbox = gui.Combobox(groupboxlag,"lagsync_type","Lagsync Type","Off","CT Auto","Lagsync V1","Lagsync V2","Lagsync V3","Lagsync V4","Custom");
    delayamount = gui.Slider(groupboxlag,"delay_amount","Delay Amount (ticks)",1,1,64);
    
    window:SetOpenKey(45);
    
    lscustom = gui.Groupbox(window,"Lagsync",20,450,200,200);
    lscustomyaw1 = gui.Slider(lscustom,"yawoffset1","Yaw Offset 1",0,-180,180);
    lscustomyaw2 = gui.Slider(lscustom,"yawoffset2","Yaw Offset 2",0,-180,180);
    lscustomfake1 = gui.Slider(lscustom,"fakeoffset1","Fake Amount 1",0,0,100);
    lscustomfake2 = gui.Slider(lscustom,"fakeoffset2","Fake Amount 2",0,0,100);
    
    lscustom:SetInvisible(true);
end

function YawHandler()

    if yawamount:GetValue() > 0 then
        gui.SetValue("rbot.antiaim.base",yawamount:GetValue()-180);
    else
        gui.SetValue("rbot.antiaim.base",yawamount:GetValue()+180);
    end
    
    if not inverted then
        gui.SetValue("rbot.antiaim.base.lby",fakeamount:GetValue()/100*60*-1);
        gui.SetValue("rbot.antiaim.base.rotation",fakeamount:GetValue()/100*58);
    else
        gui.SetValue("rbot.antiaim.base.lby",fakeamount:GetValue()/100*60);
        gui.SetValue("rbot.antiaim.base.rotation",fakeamount:GetValue()/100*58*-1);
    end
    
    
end

function KeyPressHandler()
    if invert_key:GetValue() ~= 0 then
        if input.IsButtonPressed(invert_key:GetValue()) then
            inverted = not inverted;
        end
    end
end

function lagsync(cmd)
    if cmd.tick_count % delayamount:GetValue() == 0 then
        switch = not switch;
    end
        if lagsyncbox:GetValue() == 1 then
        
                if switch then
                    yawamount:SetValue(2);
                    fakeamount:SetValue(70);
                else
                    yawamount:SetValue(17);
                    fakeamount:SetValue(75);
                end

            elseif lagsyncbox:GetValue() == 2 then
            
                if switch then
                    yawamount:SetValue(30);
                    fakeamount:SetValue(70);
                else
                    yawamount:SetValue(25);
                    fakeamount:SetValue(65);
                end
        
            elseif lagsyncbox:GetValue() == 3 then
                if switch then
                    yawamount:SetValue(25);
                    fakeamount:SetValue(100);
                else
                    yawamount:SetValue(-15);
                    fakeamount:SetValue(100);
                end
        
            elseif lagsyncbox:GetValue() == 4 then
                if switch then
                    yawamount:SetValue(-25);
                    fakeamount:SetValue(70);
                else
                    yawamount:SetValue(15);
                    fakeamount:SetValue(65);
                end
                
            elseif lagsyncbox:GetValue() == 5 then
                if switch then
                    yawamount:SetValue(-20);
                    fakeamount:SetValue(40);
                else
                    yawamount:SetValue(24);
                    fakeamount:SetValue(100);
                end
            
            elseif lagsyncbox:GetValue() == 6 then
                if switch then
                    yawamount:SetValue(lscustomyaw1:GetValue());
                    fakeamount:SetValue(lscustomfake1:GetValue());
                else
                    yawamount:SetValue(lscustomyaw2:GetValue());
                    fakeamount:SetValue(lscustomfake2:GetValue());
                end
        end
        
end

function GUIHandler()
    
    if lagsyncbox:GetValue() == 6 then
        lscustom:SetInvisible(false);
        window:SetHeight(800);
    else
        lscustom:SetInvisible(true);
        window:SetHeight(450);
    end
    
end

DrawUI();
callbacks.Register("CreateMove",lagsync);
callbacks.Register("Draw",YawHandler);
callbacks.Register("Draw",KeyPressHandler);
callbacks.Register("Draw",GUIHandler);

------- Visuals anti aim angles
--- Creator: Superyu'#7167

local POS = gui.Reference("Ragebot", "StrixRage", "Visuals")
local MULTI = gui.Multibox(POS, "Antiaim lines")
local NETWORKED = gui.Checkbox(MULTI, "vis.local.aalines.networked", "Networked Angle", false)
local LBY = gui.Checkbox(MULTI, "vis.local.aalines.lby", "LBY", false)
local LOCALANG = gui.Checkbox(MULTI, "vis.local.aalines.local", "Local Angle", false)
local LASTCHOKEDANG = gui.Checkbox(MULTI, "vis.local.aalines.lastchoked", "Last Choked", false)

--- Variables
local lastChoked = nil;
local fake = nil;
local localAngle = nil;
local lby = nil;
local pLocal = entities.GetLocalPlayer();
local choking;
local lastChoke;

--- The maths
local function AngleVectors(angles)

    local sp, sy, cp, cy;
    local forward = { }

    sy = math.sin(math.rad(angles[2]));
	cy = math.cos(math.rad(angles[2]));

	sp = math.sin(math.rad(angles[1]));
	cp = math.cos(math.rad(angles[1]));

	forward[1] = cp*cy;
	forward[2] = cp*sy;
    forward[3] = -sp;
    return forward;
end

local function doShit(t1, t2, m)
    local t3 ={};
    for i,v in ipairs(t1) do
        t3[i] = v + (t2[i] * m);
    end
    return t3;
end

local function iHateMyself(value, color, text)

    local forward = {};
    local origin = pLocal:GetAbsOrigin();
    forward = AngleVectors({0, value, 0});
    local end3D = doShit({origin.x, origin.y, origin.z}, forward, 25);
    local w2sX1, w2sY1 = client.WorldToScreen(origin);
    local w2sX2, w2sY2 = client.WorldToScreen(Vector3(end3D[1], end3D[2], end3D[3]));
    draw.Color(color[1], color[2], color[3], color[4])

    if w2sX1 and w2sY1 and w2sX2 and w2sY2 then
        draw.Line(w2sX1, w2sY1, w2sX2, w2sY2)
        local textW, textH = draw.GetTextSize(text);
        draw.TextShadow( w2sX2-(textW/2), w2sY2-(textH/2), text)
    end
end

--- Callbacks
callbacks.Register("Draw", function()

    pLocal = entities.GetLocalPlayer();
    lby = pLocal:GetProp("m_flLowerBodyYawTarget");
    fake = pLocal:GetProp("m_angEyeAngles");

    if lastChoke and lastChoke <= globals.CurTime() - 1 then
        choking = false;
    end

    if pLocal and pLocal:IsAlive() then
        if lastChoked and choking and LASTCHOKEDANG:GetValue() then iHateMyself(lastChoked.y, {25, 255, 25, 255}, "Last Choked") end
        if fake and NETWORKED:GetValue() then iHateMyself(fake.y, {255, 25, 25, 255}, "Networked") end
        if localAngle and LOCALANG:GetValue() then iHateMyself(localAngle.y, {25, 25, 255, 255}, "Local Angle") end
        if lby and LBY:GetValue() then iHateMyself(lby, {255, 255, 255, 255}, "LBY") end
    end
end)

callbacks.Register("CreateMove", function(pCmd)
    if pLocal and pLocal:IsAlive() then

        if not pCmd.sendpacket then
            lastChoked = pCmd.viewangles
            choking = true;
            lastChoke = globals.CurTime();
        else
            localAngle = pCmd.viewangles
        end
    end
end)

-- aa fix
local guiRef = gui.Reference( "Ragebot", "StrixRage", "Base AA" )
gui.Checkbox( guiRef, "aafix", "Anti-Aim Fix", true );

local switch = true;

local function create_move(cmd)
    if not gui.GetValue( "rbot.master" ) then return end
    if gui.GetValue("rbot.antiaim.advanced.aafix") and not input.IsButtonDown( "w" ) and not input.IsButtonDown( "a" ) and not input.IsButtonDown( "s" ) and not input.IsButtonDown( "d" ) and not input.IsButtonDown( "space" ) then 
        if switch == true then
            cmd.sidemove = 2;
            switch = false;
        elseif switch == false then
            cmd.sidemove = -2;
            switch = true;
        end
    end
end

callbacks.Register( "CreateMove", create_move );


-- quickpeek

local aimbot_extra = gui.Reference("Ragebot", "StrixRage", "Movement")

local quickpeek_key = gui.Keybox(aimbot_extra, "C_QuickPeek.key", "QuickPeek key", 0)
quickpeek_key:SetDescription("(ESC to clear)")

function blacklisted()
    local blacklisted_weapons = {
        "CKnife",
        "CMolotovGrenade",
        "CSmokeGrenade",
        "CHEGrenade",
        "CFlashbang",
        "CDecoyGrenade",
        "CIncendiaryGrenade"
    }
    if not entities.GetLocalPlayer() then return true end
    if not entities.GetLocalPlayer():IsAlive() then return true end
    local weapon_class = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetClass()
    for k, blacklisted_weapon in pairs(blacklisted_weapons) do
        if blacklisted_weapon == weapon_class then
            return true
        end
    end
    return false

end


local reset_shots = 0
callbacks.Register("Draw", function()
    if (input.IsButtonReleased(65) or input.IsButtonReleased(68) or (not input.IsButtonDown(65) and not input.IsButtonDown(68))) and reset_shots >= 1 then
        reset_shots = 0
    end
    
end)

callbacks.Register("AimbotTarget", function()
    reset_shots = reset_shots + 1
end)

callbacks.Register("CreateMove", function(cmd)
    if blacklisted() then return end
    
    if quickpeek_key:GetValue() ~= 0 and not input.IsButtonDown(quickpeek_key:GetValue()) then
        return
    end
    
    if reset_shots >= 1 then
        if input.IsButtonDown(65) then -- A
            cmd.sidemove = 255
        elseif input.IsButtonDown(68) then -- D
            cmd.sidemove = -255
        end
    end
    
    if cmd.buttons == 4194305 then
        reset_shots = reset_shots + 1
    end
end)

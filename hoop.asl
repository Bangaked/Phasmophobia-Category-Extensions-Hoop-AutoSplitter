state("Phasmophobia") {
    int itemInventory : "UnityPlayer.dll", 0x018080B8, 0x8, 0x38, 0x30, 0x18, 0x80;
    int hoopCounter : "UnityPlayer.dll", 0x018080B8, 0x8, 0x20, 0x1C8, 0x238, 0x18;
}

startup{
    settings.Add("split", true, "Split on Certain Amount of Hoops");
    settings.CurrentDefaultParent = "split";
    settings.Add("10_hoops", true, "10 Hoops");
    settings.Add("50_hoops", true, "50 Hoops");
    settings.Add("100_hoops", true, "100 Hoops");
    settings.SetToolTip("10_hoops", "check this box to make the timer stop when you reach 10 hoops");
    settings.SetToolTip("50_hoops", "check this box to make the timer stop when you reach 50 hoops");
    settings.SetToolTip("100_hoops", "check this box to make the timer stop when you reach 100 hoops");
}

init {
    vars.pickupCount = 0;
    vars.splitCount = 0;
}

update {
    if(old.hoopCounter < current.hoopCounter){
        vars.pickupCount++;
    }
    if(settings["10_hoops"]){
        vars.splitCount = 10;
    }
    if(settings["50_hoops"]){
        vars.splitCount = 50;
    }
    if(settings["100_hoops"]){
        vars.splitCount = 100;
    }
}

start {
    if(old.itemInventory < current.itemInventory){
        if(current.itemInventory < 4){
            vars.pickupCount = 0;
            return true;
        }
    }
}

split {
    if(vars.pickupCount == vars.splitCount){
        return true;
    }
}
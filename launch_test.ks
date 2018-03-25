//hellolaunch

//First, we'll clear the terminal screen to make it look nice
CLEARSCREEN.

HUDTEXT("Initializing kOS Processor", 5, 2, 20, rgb(1,1,0.5), false).

Set Terminal: width to 30.
Set Terminal: height to 20.

CORE:PART:GETMODULE("kOSProcessor"):DOACTION("open terminal", true).

Set LIGHTS to False.
Set LIGHTS to True.

FROM {local x is 3.} UNTIL x = 0 STEP {set x to x-1.} DO {

	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light r", 0.0).
	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light g", 1.0).
	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light b", 0.0).

	CORE:PART:GETMODULE("ModuleLight"):DOACTION("Toggle Light", true).

	Wait 0.1.

	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light r", 0.0).
	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light g", 0.0).
	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light b", 1.0).

	CORE:PART:GETMODULE("ModuleLight"):DOACTION("Toggle Light", true).

	Wait 0.1.

	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light r", 1.0).
	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light g", 0.0).
	CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light b", 0.0).

	CORE:PART:GETMODULE("ModuleLight"):DOACTION("Toggle Light", true).

	Wait 0.1.

	}

CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light r", 0.2).
CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light g", 0.2).
CORE:PART:GETMODULE("kosLightModule"):SETFIELD("light b", 0.4).

CORE:PART:GETMODULE("ModuleLight"):DOACTION("Toggle Light", true).

Set Launched to 0.

//Next, we'll lock our throttle to 100%.
LOCK THROTTLE TO 1.0.   // 1.0 is the max, 0.0 is idle.

//This is our countdown loop, which cycles from 10 to 0
PRINT "Counting down:".
FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1. // pauses the script here for 1 second.
}

STAGE.

Print "Launch!".

Wait 0.2.

Print "Start roll program.".

//This will be our main control loop for the ascent. It will
//cycle through continuously until our apoapsis is greater
//than 100km. Each cycle, it will check each of the IF
//statements inside and perform them if their conditions
//are met
SET MYSTEER TO HEADING(90,90).
LOCK STEERING TO MYSTEER. // from now on we'll be able to change steering by just assigning a new value to MYSTEER
UNTIL MAXTHRUST = 0  { //Remember, all altitudes will be in meters, not kilometers

    //For the initial ascent, we want our steering to be straight
    //up and rolled due east
    IF SHIP:VELOCITY:SURFACE:MAG < 100 {
        //This sets our steering 90 degrees up and yawed to the compass
        //heading of 90 degrees (east)
        SET MYSTEER TO HEADING(90,90).

    //Once we pass 100m/s, we want to pitch down ten degrees
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 100 {
        SET MYSTEER TO HEADING(90,80).
        PRINT "Pitching to 80 degrees" AT(0,15).
        PRINT "Apoasis: " + ROUND(SHIP:APOAPSIS,0) AT (0,16).
    }.
}.

Print "Test Complete.".
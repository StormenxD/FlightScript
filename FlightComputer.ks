clearscreen.
print "Boot success".
function main{
    function variables {
        lock targetPitch to 88.963 - 1.03287 *alt:radar^0.39.
        set targetDirection to 90.
        set TargetApoapsis to 85000.
        set targetPeriapsis to 70000.
        set DeorbitPeriapsis to 10000.
    }
    variables().

    function KerbinToOrbit {
        if ship:altitude <= 500 {
            from {local countdown is 5.} until countdown = 0 STEP {set countdown to countdown -1.} do {
            print (countdown).
            wait 1.
            }
            toggle gear.
            print "launch".
            lock throttle to 1.
            stage.
            lock steering to up.
            wait 10.
            clearscreen.
            print "steering nominal...".    
        }
        

        set oldThrust to ship:AVAILABLETHRUST.
        when AVAILABLETHRUST < (oldThrust) then {
            stage.
            print "stage success".
            wait 0.5.
            set oldThrust to ship:AVAILABLETHRUST.
            preserve.
        }

        wait 1.
        lock steering to heading(targetDirection, targetPitch).

        wait until ship:altitude >= 18500.
        lock throttle to 0.65.
    }
    KerbinToOrbit().

    function MECO{
        wait until ship:apoapsis >= TargetApoapsis.
        lock throttle to 0.
        clearscreen.
        print("MECO!").
    }
    MECO().
    wait until ship:altitude >= 70200.
    stage.

    function OrbitBurn{
        lock steering to prograde.

        wait until ship:altitude >= 84900.
        lock throttle to 1.
        lock steering to prograde.
        if ship:AVAILABLETHRUST <= 0 {
            stage.
        }

        wait until TargetPeriapsis <= ship:periapsis.
        clearscreen.
        if ship:periapsis > 70000. {
            print "Capsule is in orbit!".
            lock throttle to 0.
        }

        // the following code is made speciffically for the stock "Kerbal X":
    }
    OrbitBurn().

    function DeOrbitBurn {
        wait until ship:altitude <= ship:periapsis.
        lock steering to retrograde.
        wait 5.
        lock throttle to 0.6.
        if maxthrust <= 0. {
            stage.
        }
        wait until DeorbitPeriapsis >= ship:periapsis.
        lock throttle to 0.
        wait 3.
        stage.
        lock steering to ship:srfretrograde.
        print "prepare for re-entry!".
    }
    DeOrbitBurn().

    function Landing {
    // Make sure you only have one stage left (the parachute) when re-entering the atmosphere.
        wait until ship:altitude <= 65000.
        wait until stage:ready.
        stage.
        wait 20.
        clearscreen.
        print "Parachute deployed! ".
        wait until ship:altitude <= 1.
        unlock steering.
        clearscreen.
        print "Splashdown!".
    }
    Landing().

}
main().
wait until false.

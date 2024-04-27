clearscreen.
print "boot success".
wait 10.
print "waited 10 sec".
wait until ship:altitude >= 75000.
lock steering to retrograde.
print "steering locked to retrograde".
wait 25.
lock throttle to 1.
wait 8.
lock throttle to 0.
lock steering to srfretrograde.

wait until ship:altitude <= 70500.
toggle AG2.

toggle brakes.

lock steering to srfretrograde.

// Define the ratio for a successful landing
SET ratio TO 7.5.
// Wait until the altitude is less than the calculated burn altitude
WAIT UNTIL alt:radar <= ratio * ship:velocity:surface:mag.
print "Suicide burn!".
toggle gear.
set FinalWeight to mass * 9.81.
set requiredThrust to 1.783 * FinalWeight.
set landing_burn to requiredThrust / ship:maxthrust.
lock throttle to landing_burn.
print landing_burn.

lock steering to srfretrograde.
wait until ship:verticalspeed >= 0.
clearscreen.
set TouchdownSpeed to ship:verticalspeed.
set ToutchdownAltitude to ship:altitude.

SET RoundedSpeed TO ROUND(TouchdownSpeed, 2).
SET RoundedAltitude TO ROUND(ToutchdownAltitude, 2).

print "Final speed before shut down: " + RoundedSpeed + "m/s".
print "At shutdown, the booster was " + RoundedAltitude + " meters above the ground".

print "

Touchdown!".
lock steering to up.
lock throttle to 0.
toggle brakes.
wait until false.

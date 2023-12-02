# RadiatedZonesPZ

![poster](https://github.com/Atophite/RadiatedZonesPZ/assets/14220576/1e210d50-c32f-443d-bec7-1933a599d9e9)
### Workshop:
https://steamcommunity.com/sharedfiles/filedetails/?id=3019024205

# Project Zomboid Radiation Mod Feature List

## Radiation Protection and Detection
- Lootable Hazmat Suit to protect from radiation.
- Functional Geigerteller (Geiger Counter) to detect radiation areas.
- Craftable Iodine as radiation protection.
- Geigerteller drains battery, requiring recharging.
- Battery charging recipes for Geigerteller.
- Geigerteller checks radiation levels and becomes unusable when out of battery.
- Manual inspection of Geigerteller as a backup to sound effects.

## Server Mechanics
- Implementation of radiated zones across the map.
- Custom text file with coordinates defines radiated areas.
- Server-sided control for coordinates file to prevent cheating (except singleplayer).
- Multiplayer compatibility for all mod features.

## Radiation Effects and Gameplay
- Daily chance for radiation cure; failure leads to player death.
- Introduction of burn damage when medium radiated.
- Iodine effectiveness nerfed to 25 RADS.
- Hazmat Suit nerfed for reduced mobility due to weight and slowness.

## Radiation Mechanics
When player gets radiated the player will get sick. The more radiated the player is the more player get sick.<br>
There are three stages of radiated:
- lightly radiated (300 RAD)
- medium radiated (1000 RAD)
- heavily radiated (2000 RAD)

if player is lightly radiated longer than a day the player will get 50% sickness. <br>
if player is medium radiated longer than a day the player get 50% sickness. <br>
If player reach heavily radiated the player will die in a day with 100% sickness. <br>

- Die Chance: 3%
- Cure Chance: 27%
- Burn Chance: 20%
- Radiation is Not Cured (No event occurs): 50%

OR if rad is above 1000
- Die Chance: 10%
- Cure Chance: 10%
- Burn Chance: 30%
- Radiation is Not Cured (No event occurs): 50%

When lightly radiated or medium the player has everyday a chance to cure from radiation. <br>
But also has the chance to die.
The chance of being sick from radiated is X% this will not cure until player hit the luck of being cured. <br>

When player reached cured state the radiation will fall off everyday. <br>

# My other mods:
- [Longer smoke mod](https://steamcommunity.com/sharedfiles/filedetails/?id=2855493549)
- [Better smoke sound mod](https://steamcommunity.com/sharedfiles/filedetails/?id=2858157800)

You wanna support? A nice word is always welcome. Constructive feedback too. Else you can
[![Donation image](https://i.imgur.com/GGnjlGL.png)](https://ko-fi.com/atophite)

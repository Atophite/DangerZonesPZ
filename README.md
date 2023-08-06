# RadiatedZonesPZ

![poster](https://github.com/Atophite/RadiatedZonesPZ/assets/14220576/1e210d50-c32f-443d-bec7-1933a599d9e9)

# TODO LIST

- [x] Make Hazmat suit to protect from radiation
- [x] Make Geigerteller functional to detect when player is in radiation area
- [x] Make Iodine to protect from radiation
- [x] Implement custom moodles with MoodleFramework
- [x] Implement function to read a text file with coordinates and make them the radiated area's
- [x] Implement function that the text file reader is Server sided so players cannot cheat by editing coordinates file. (Unless its singleplayer)
- [x] Save data persistently with ModData
- [x] Geigerteller is drainable
- [x] Added recipes to charge the geigerteller with batteries
- [x] Implement recipecode to add the battery charge to the geigerteller
- [x] Implement radiation self check with a device maybe geiger teller
- [ ] Distribute Iodine, Hazmat, and Geigerteller
- [ ] ~Add a feature to fix holes in the hazmat suit (consider using a new item called rubber)~
- [ ] Radiate different areas of the map
- [x] Implement support for multiplayer
- [x] Create a cure for radiation: introduce a chance for daily radiation cure or else player will die from radiation
- [ ] ~Utilize iodine for aiding in the curing process~
- [x] Implement burn damage when medium radiated
- [x] Nerf Iodine so the player can't spam Iodine to reduce RADS (its 25 RADS now)
- [ ] Implement translation texts
- [x] Use FakeInfectionLevel instead of FoodSicknessLevel
- [x] Make mod logo
- [ ] Make mod showcase images
- [ ] Make mod showcase video



When player gets radiated the player will get sick. The more radiated the player is the more player get sick.<br>
There are three stages of radiated:
- lightly radiated (300 RAD)
- medium radiated (1000 RAD)
- heavily radiated (2000 RAD)

if player is lightly radiated longer than a day the player will get 50% sickness. <br>
if player is medium radiated longer than a day the player get 50% sickness. <br>
If player reach heavily radiated the player will die in a day with 100% sickness. <br>

- Die Chance: 3%
- Cure Chance: 22%
- Burn Chance: 35%
- Radiation is Not Cured (No event occurs): 40%

OR if rad is above 1000
- Die Chance: 10%
- Cure Chance: 10%
- Burn Chance: 60%
- Radiation is Not Cured (No event occurs): 20%

When lightly radiated or medium the player has everyday a chance to cure from radiation. <br>
But also has the chance to die.
The chance of being sick from radiated is X% this will not cure until player hit the luck of being cured. <br>

When player reached cured state the radiation will fall off everyday. <br>



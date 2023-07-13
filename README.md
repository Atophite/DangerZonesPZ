# DangerZonesPZ

# TODO LIST

- [ ] Distribute Iodine, Hazmat, and Geigerteller
- [ ] Add a feature to fix holes in the hazmat suit (consider using a new item called rubber)
- [ ] Radiate different areas of the map
- [x] Save data persistently with ModData
- [ ] Ensure Geigerteller has batteries
- [ ] Implement support for multiplayer
- [ ] Create a cure for radiation: introduce a chance for daily radiation cure or else player will die from radiation
- [ ] Utilize iodine for aiding in the curing process
- [ ] Implement burn damage when medium radiated

When player gets radiated the player will get sick. The more radiated the player is the more player get sick.
There are three stages of radiated:
- lightly radiated (300 RAD)
- medium radiated (1000 RAD)
- heavily radiated (2000 RAD)

if player is lightly radiated longer than a day the player will get 50% sickness
if player is medium radiated longer than a day the player get 100% sickness.
If player reach heavily radiated the player will die in a day with 100% sickness.

When lightly radiated or medium the player has everyday a chance to cure from radiation.
When player reached cured state the radiation will fall off everyday.
When player has burn damage the burn will dissapear in lightly radiated when curing.


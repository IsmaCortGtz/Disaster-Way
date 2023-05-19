**<h1 align="center">Disaster Way</h1>**
<img width="1383" alt="Disaster Way Banner" src="./assets/images/banner.png">

***Language***
- [🇲🇽 Spanish](./README.es.md)
- 🇺🇸 English



<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#description">Description</a></li>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#custom-stage-format">Custom Stage Format</a></li>
        <li><a href="#building">Building</a></li>
        <li><a href="#adding-sounds">Adding Sounds</a></li>
      </ul>
    </li>
    <li>
      <a href="#credits">Credits</a>
      <ul>
        <li><a href="#music">Music</a></li>
        <li><a href="#sfx">SFX</a></li>
      </ul>
    </li>
    <li><a href="#license">License</a></li>
  </ol>
</details>





## About The Project

### Description

An Indie Game. You will need to dodge a fast bullets to survive, each level increase the difficulty of the game. In adition you can create your own stages with a custom difficulty following this format. In this game you can chose one of the three characters, of wich each one has its special ability. Every ability have a duration of 5 seconds. 



### Built With

<a href="https://godotengine.org/"><img width="100" alt="Godot Engine" src="https://godotengine.org/assets/press/logo_small_color_dark.svg"></a>

This game was build using the Godot Engine 3.5.1
You can download this version using [this link](https://downloads.tuxfamily.org/godotengine/3.5.1/).





## Getting Started



### Installation

You should use a pre-built binaty, is the easier way to install the game and play it inmediatly, you can download the bin files from [this link](https://github.com/IsmaCortGtz/Disaster-Way/releases).

The game are compiled for this plattaforms:
  * Windows
  * Linux
  * Android
  * [Web Browser](https://ismacortgtz.github.io/Disaster-Way/)



### Custom Stage Format

The game has a feature to add your own stages changing some variables of the Game room using a specific format, for example, this is the code for the common `Last Standing`:

```sh
1-800-4500-1500-1800-0.5-3.5-90-1-0-0
```

Each var are splitted with the `-` character, and all for them need to be a valid number up to 0. And some vars need to be float or integer. This are the menaings for the vars:

1. `gameModeType`: _`int`_. The type gamemode to play, we have two options here:
    - `1`: Last Standing
    - `2`: Time Trial
2. `playersMaxSpeed`: The max speed the players can get.
3. `playerAcel`: The acceleration the players will have.
4. `bulletsVelRange.x`: The min velocity of the bullets.
5. `bulletsVelRange.y`: The max velocity of the bullets.
6. `bulletsControllCooldown.x`: The min of time before other bullet will be shotted in the same spot.
7. `bulletsControllCooldown.y`: The max of time before other bullet will be shotted in the same spot.
8. `gameTimeTrialDuration`: The duration of the game if the game mode type is Time Trial. (Even if you are using Last Standig gamemode, this number needs to be up to 0)
9. `specialTimesUses`: _`int`_. The number of times that players can use them special ability.
10. `usingDemonBullets`: _`int`_. 1 or 0, it determines if the gameplay will have demon bullets or not.
11. `demonBulletsFrec`: _`int`_. The frequency at which each bullet point fires demon bullets. If is 0 the whole bullets will be demon ones.

***DISCLAIMER:*** The game doesn't have any system to limit the max value of any var, use it by your own responsibility.



### Building

Aditionally, you can build in your machine the project for any of the [supported plattaforms](https://docs.godotengine.org/en/3.5/tutorials/export/exporting_basics.html) by Godot 3.5.1.

Remember, to export for iOS and macOS you will need a mac to compile the XCode project.

This are the instroctions to build for your own the project.

1. Clone the repo
```sh
git clone https://github.com/IsmaCortGtz/Disaster-Way.git
``` 
2. Install Godot 3.5.1 and launch it, you can do it from [this link](https://downloads.tuxfamily.org/godotengine/3.5.1/).
3. Install the [sounds of the proyect](#adding-sounds).
4. Open in Godot the proyect you clone in the step #1.
5. Install the Godot Export Templates, you can follow [this instructions](https://docs.godotengine.org/en/3.5/tutorials/export/exporting_projects.html).
6. Configure the porject for the plattaform target, you should check [this reference](https://docs.godotengine.org/en/3.5/tutorials/export/index.html).

***DISCLAIMER:*** Godot Engine is 100% open source (you can find the [github page here](https://github.com/godotengine/godot)), for this reasson you can't export officially for any console.



### Adding sounds

The Music and SFX aren't included in the Github project, if you want to build it for your own you will need to put these files in this folders:

- `./assets/sounds/sfx/`
  - `breaking.wav` download the file [from here](https://freesound.org/people/Thingy17/sounds/470898/).
  - `click.wav` download the file [from here](https://freesound.org/people/EminYILDIRIM/sounds/540568/).
  - `move.wav` download the file [from here](https://freesound.org/people/Tissman/sounds/574592/).
  - `page.wav` download the file [from here](https://freesound.org/people/LittleRobotSoundFactory/sounds/288917/).
  - `click-pitched.wav` this file is the same that `click.wav` with a pitch scale of `0.6`.
  - `split.wav` download the file [from here](https://freesound.org/people/pjhedman/sounds/511388/).
- `./assets/sounds/soundtrack/`
  - `battle.mp3` download the file [from here](https://www.steven-obrien.net/#popcorn-~-main-loop).
  - `menu.mp3` download the file [from here](https://www.steven-obrien.net/#popcorn-~-menu-theme).



### Credits

#### **Music** 

Music by https://www.steven-obrien.net/
Popcorn - Menu Theme - Steven O'Brien


Music by https://www.steven-obrien.net/
Popcorn - Main Loop - Steven O'Brien

#### **SFX**

["Vidrios_Rotos.wav"](https://freesound.org/s/470898) by [Thingy17](https://freesound.org/people/Thingy17/) licensed under [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)

["Click_Standard_05.wav"](https://freesound.org/s/288917) by [LittleRobotSoundFactor](https://freesound.org/people/LittleRobotSoundFactory/) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

["menu move3"](https://freesound.org/s/574592) by [Tissman](https://freesound.org/people/Tissman/) licensed under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)

["UI Pop Up"](https://freesound.org/s/540568) by [EminYILDIRIM](https://freesound.org/people/EminYILDIRIM/) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

["Electronique FX5.wav"](https://freesound.org/s/511388) by [pjhedman](https://freesound.org/people/pjhedman/) licensed under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)



## License

The game is powered by Godot Engine, wich one is distributed under the [MIT License](https://opensource.org/license/mit/). See `engine.LICENSE` for more information.

Distributed under the GNU General Public License v3.0. See `LICENSE` for more information.

**GNU GPL v3**  
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
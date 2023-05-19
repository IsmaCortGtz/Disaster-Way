**<h1 align="center">Disaster Way</h1>**
<img width="1383" alt="image" src="./assets/images/banner.png">

***Idioma***
- 🇲🇽 Spanish
- [🇺🇸 English](./README.md)



<details>
  <summary>Tabla de Contenido</summary>
  <ol>
    <li>
      <a href="#sobre-el-proyecto">Sobre el Proyecto</a>
      <ul>
        <li><a href="#descripcion">Descripción</a></li>
        <li><a href="#hecho-con">Hecho con</a></li>
      </ul>
    </li>
    <li>
      <a href="#empezando">Empezando</a>
      <ul>
        <li><a href="#instalacion">Instalación</a></li>
        <li><a href="#formato-de-stages-personalizados">Formato de Stages Personalizados</a></li>
        <li><a href="#compilando">Compilando</a></li>
        <li><a href="#agregando-el-audio">Agregando el Audio</a></li>
      </ul>
    </li>
    <li>
      <a href="#creditos">Créditos</a>
      <ul>
        <li><a href="#Música">Música</a></li>
        <li><a href="#sfx">SFX</a></li>
      </ul>
    </li>
    <li><a href="#licencia">Licencia</a></li>
  </ol>
</details>





## Sobre el Proyecto

### Descripción

Un juego indie. En este juego esquivaras balas veloces para sobreivir, cada escenario incrementa la dificultad del juego. Además podras crear tus propios escenarios con una dificultad personalizada utilizando este formato. En este juego puedes elegir uno de los tres personajes, de los cuales cada uno tiene una habilidad especial. Cada habilidad tiene una duración de 5 segundos.



### Hecho con

<a href="https://godotengine.org/"><img width="100" alt="Godot Engine" src="https://godotengine.org/assets/press/logo_small_color_dark.svg"></a>

Este juego fue hecho usando Godot Engine version 3.5.1
Puedes descargar esta version usando [este enlace](https://downloads.tuxfamily.org/godotengine/3.5.1/).





## Empezando



### Instalación

Te recomiendo usar un binary pre-compilado, es la forma más facil de instalar el juego y jugar inmediatamente, puedes descargar los binarios desde [este enlace](https://github.com/IsmaCortGtz/Disaster-Way/releases).

El juego fue compilado para estas plataformas:
  * Windows
  * Linux
  * Android
  * [Navegador Web](https://ismacortgtz.github.io/Disaster-Way/)



### Formato de Stages Personalizados

El juego cuenta con una mecanica para añadir tus propios escenarios modificando algunas variables del Game room usando un formato especifico, por ejemplo, este es el codigo para el modo `Ultimo en Pie` clásico. 

```sh
1-800-4500-1500-1800-0.5-3.5-60-1
```

Cada variable es dividida mediante el caracter `-`, y cada uno necesita ser un valor valido mayor a 0. Además algunas variables necesitan ser decimales o enteros. Estos son los significados para las variables:

1. `gameModeType`: _`int`_. El modo de juego, aquí tenemos dos opciones:
    - `1`: Ultimo en Pie
    - `2`: Contrarreloj
2. `playersMaxSpeed`: La velocidad maxima para los jugadores.
3. `playerAcel`: La aceleración de los jugadores.
4. `bulletsVelRange.x`: La velocidad minima de las balas.
5. `bulletsVelRange.y`: La velocidad maxima de las balas.
6. `bulletsControllCooldown.x`: El tiempo minimo antes de que otra bala sea disparada desde el mismo punto.
7. `bulletsControllCooldown.y`: El tiempo maximo antes de que otra bala sea disparada desde el mismo punto.
8. `gameTimeTrialDuration`: La duración de la partida si el modo de juego es Contrarreloj. (Incluso si estas usando Ultimo en pie, este numero necesita ser mayor a 0).
9. `specialTimesUses`: _`int`_. El numero de veces que cada jugador puede usar su habilidad especial por partida.
10. `usingDemonBullets`: _`int`_. 1 o 0, esto determina si la partida tendra Demon Bullets o no.
11. `demonBulletsFrec`: _`int`_. La frecuencia con la que cada punto de disparo dispara una Demon Bullet. If es 0 todas las balas seran Demon.


***AVISO:*** El juego no cuenta con ningun limite para los valores maximos que cada variable puede tener, usalo bajo tu porpio riesgo.



### Compilando

Adicionalmente, puedes compilar el proyecto en tu porpia maquina para alguna de las [plataformas soportadas](https://docs.godotengine.org/en/3.5/tutorials/export/exporting_basics.html) por Godot 3.5.1.

Recuerda, para exportar para iOS y macOS necesitaras de una mac para compilar el proyecto de XCode.

Estas son las instrucciones para compilar el proyecto por tu cuenta:

1. Clona el repositorio
```sh
git clone https://github.com/IsmaCortGtz/Disaster-Way.git
``` 
2. Instala Godot 3.5.1 y ejecutalo, puedes hacerlo desde [este enlace](https://downloads.tuxfamily.org/godotengine/3.5.1/).
3. Instala los [sonidos del proyecto](#agregando-el-audio).
4. Abre en Godot el proyect que clonaste en el paso #1.
5. Instala las plantillas de exportación, puedes seguir [estas instrucciones](https://docs.godotengine.org/en/3.5/tutorials/export/exporting_projects.html).
6. Configure el proyecto para la plataforma objetivo, puedes checar [esta información](https://docs.godotengine.org/en/3.5/tutorials/export/index.html).

***AVISO:*** Godot Engine es 100% open source (puedes ver su [página de Github aquí](https://github.com/godotengine/godot)), por lo tanto no puedes exportar oficialmente a ninguna consola.



### Agregando el Audio

La música y los SFX no estan incluidos en el proyecto de Github, si quieres compilarlo por tu cuenta necesitaras agregar estos archivos en estos directorios:

- `./assets/sounds/sfx/`
  - `breaking.wav` descarga el archivo [de aquí](https://freesound.org/people/Thingy17/sounds/470898/).
  - `click.wav` descarga el archivo [de aquí](https://freesound.org/people/EminYILDIRIM/sounds/540568/).
  - `move.wav` descarga el archivo [de aquí](https://freesound.org/people/Tissman/sounds/574592/).
  - `page.wav` descarga el archivo [de aquí](https://freesound.org/people/LittleRobotSoundFactory/sounds/288917/).
  - `click-pitched.wav` este archivo es el mismo que `click.wav`con un _pitch scale_ de `0.6`.
  - `split.wav` descarga el archivo [de aquí](https://freesound.org/people/pjhedman/sounds/511388/).
- `./assets/sounds/soundtrack/`
  - `battle.mp3` descarga el archivo [de aquí](https://www.steven-obrien.net/#popcorn-~-main-loop).
  - `menu.mp3` descarga el archivo [de aquí](https://www.steven-obrien.net/#popcorn-~-menu-theme).



### Créditos

#### **Música** 
 
Música de https://www.steven-obrien.net/
Popcorn - Menu Theme - Steven O'Brien


Música de https://www.steven-obrien.net/
Popcorn - Main Loop - Steven O'Brien

#### **SFX**

["Vidrios_Rotos.wav"](https://freesound.org/s/470898) de [Thingy17](https://freesound.org/people/Thingy17/) licenciado bajo [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)

["Click_Standard_05.wav"](https://freesound.org/s/288917) de [LittleRobotSoundFactor](https://freesound.org/people/LittleRobotSoundFactory/) licenciado bajo [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

["menu move3"](https://freesound.org/s/574592) de [Tissman](https://freesound.org/people/Tissman/) licenciado bajo [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)

["UI Pop Up"](https://freesound.org/s/540568) de [EminYILDIRIM](https://freesound.org/people/EminYILDIRIM/) licenciado bajo [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

["Electronique FX5.wav"](https://freesound.org/s/511388) de [pjhedman](https://freesound.org/people/pjhedman/) licenciado bajo [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)


## License

Este juego esta construido en Godot Engine, el cual esta distribuido bajo la [licencia MIT](https://opensource.org/license/mit/). Lee `engine.LICENSE` para mas detalles.

Distibuido bajo la licencia GNU General Public License v3.0. Lee `LICENSE` para mas detalles.

**GNU GPL v3**  
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
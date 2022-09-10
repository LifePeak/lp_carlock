

<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://discord.gg/G9zzDPvF4Y">
    <img src="https://i.imgur.com/kqu8Gp4.png" alt="Logo" width="180" height="180">
  </a>

  <h3 align="center">LifePeak - Skripts</h3>

  <p align="center">
    An awesome README template to jumpstart your projects!
    <br />
    <a href="https://lifepeak-scripts.tebex.io"><strong>Explore us on Tebex  »»</strong></a>
    <br />
    <br />
    <a href="https://www.youtube.com/channel/UC8tftArZtDQz_0bohnnidoA">View Demos</a>
    ·
    <a href="https://discord.gg/G9zzDPvF4Y">Report Bug</a>
    ·
    <a href="https://discord.gg/G9zzDPvF4Y">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS 
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>
-->


<!-- ABOUT THE PROJECT -->
## Explore Lifepeak
### Whats Lifepeak-Skripts?
Lifepeak is a smal developing team of three members. We are we are specialised in FiveM-Skripting, Hosting, Managing Servers.






### What we Offer ?

This section list our Supported Programing Langues and Frameworks.

### Programing Langues:
![C#](https://img.shields.io/badge/c%23-%23239120.svg?style=for-the-badge&logo=c-sharp&logoColor=white)
![C++](https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white)
![Go](https://img.shields.io/badge/go-%2300ADD8.svg?style=for-the-badge&logo=go&logoColor=white)
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=java&logoColor=white)
![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
![PHP](https://img.shields.io/badge/php-%23777BB4.svg?style=for-the-badge&logo=php&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

### Frameworks:
![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
![Laravel](https://img.shields.io/badge/laravel-%23FF2D20.svg?style=for-the-badge&logo=laravel&logoColor=white)
![Qt](https://img.shields.io/badge/Qt-%23217346.svg?style=for-the-badge&logo=Qt&logoColor=white)
![Bootstrap](https://img.shields.io/badge/bootstrap-%23563D7C.svg?style=for-the-badge&logo=bootstrap&logoColor=white)

--------------
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Which Platforms we Supporting?
We supporting currently thies platforms if you have any Questins regarings Linux or Windows feel free to contact us.
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)


## Intresed? Find us on:

 * [![](https://img.shields.io/badge/Lifepeak-%237289DA.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/G9zzDPvF4Y)
 * [![](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](https://discord.gg/G9zzDPvF4Y)
 * [![](https://img.shields.io/badge/gitlab-%23181717.svg?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.lifepeak.de/lifepeak-freescripts)
 * [![](https://img.shields.io/badge/Google%20Chrome-4285F4?style=for-the-badge&logo=GoogleChrome&logoColor=yellow)](https://lifepeak.de/)

<!-- GETTING STARTED -->
# lp_carlock

lp_carlock is an simple all in one carlocking system for fivem.
You can lock/unlock and share your key with your frends.


### Preview
INSERT IMAGES/VIDEOS
#########################################
  

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Download the Skript at the  [Lifepeak-Gitlab](https://gitlab.lifepeak.de/lifepeak-freescripts/lp_carlock)
2. Costomise the config
   ```lua
   Config = {}
   Config.RequiredKey = Keys['U']
   Config.PlayerCarArea = 30
   Config.Locale = 'de'
   Config.EnableJobvehicle = true
   
   Config.AdminGroups = {
	   superadmin = true,
	   admin = true
   }
   
   ```
3. add the staring command to your server.cfg
   ```cfg
   start lp_carlock
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage
1. Stand next to your personal Vehicle and press ```U``` to lock or unlock your car.

2. Type ```lua /sharekey playerId ``` to share your key to your frends. (Works only for your personal vehicles. )
Type ```lua /revokekey playerId ``` to revoke the acces of your frend. (Works only for your personal vehicles. )
3. Your key not wokring well Type ```lua /fixcarlock``` fix them.
4. If your a an Admin and need the keys fom a Car next to you. Type ```lua /adminkeysplayerId ``` to get  keys. (Admin Groups get configureded in the Config file)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING 
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->


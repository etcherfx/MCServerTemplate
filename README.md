<div align ="center">

<img src="projectInfo/icon.png" width="180">

# MCServerTemplate

<span style="font-size:18px;">An easily deployable Minecraft server template.</span>

[![CodeFactor](https://www.codefactor.io/repository/github/etcherfx/mcservertemplate/badge/main?style=for-the-badge)](https://www.codefactor.io/repository/github/etcherfx/mcservertemplate/overview/main)
[![License](https://img.shields.io/github/license/etcherfx/MCServerTemplate?style=for-the-badge)](https://github.com/etcherfx/MCServerTemplate/blob/main/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/etcherfx/MCServerTemplate?style=for-the-badge)](https://github.com/etcherfx/MCServerTemplate/issues) <br>
[![GitHub Release](https://img.shields.io/github/release/etcherfx/MCServerTemplate?include_prereleases&style=for-the-badge)](https://github.com/etcherfx/MCServerTemplate/releases/latest)

</div>

## Links

- [Releases](https://github.com/etcherfx/MCServerTemplate/releases)

## Projects Used

- [Simerlol's Minecraft Server Template](https://replit.com/@SimerLol/Minecraft-Server-Template)

## Deployment

### Deploy from Github:

<a href="https://replit.com/github/etcherfx/MCServerTemplate" target="_blank"><img src="https://binbashbanana.github.io/deploy-buttons/buttons/remade/replit.svg" alt="Run on Replit"></a>

- Open the `Run on replit` button in a new tab and press `Import from Github`

  <img src="projectInfo/importGithub.png" width="450">

## Setting Java Versions

- In the files section on replit, click the three dots and hit `Show hidden files`

  <img src="projectInfo/replitHiddenFiles.png" width="350">

  > _Sometimes, there might only be a `Hide hidden files` option. In that case, you already have hidden files shown._

- Navigate to the `replit.nix` file and click on it to open it

  <img src="projectInfo/replitNix.png" width="250">

- Choose the Java version you want to use from below and replace the default Java version with the one you want to use:

  > _The default Java version is `pkgs.openjdk8-bootstrap`_

  | Minecraft Version | Java Version               |
  | ----------------- | -------------------------- |
  | `1.21+`           | `pkgs.jdk21_headless`      |
  | `1.17 - 1.20`     | `pkgs.openjdk17-bootstrap` |
  | `1.16-`           | `pkgs.openjdk8-bootstrap`  |

## Creating Enviornment Variables

- Click on the `Secrets` button in the tools section on the far left side of your screen

  <img src="projectInfo/replitTools.png" width="250">

- Click on the `New secret` button

  <img src="projectInfo/replitSecrets.png" width="550">

- Create a new secret with the key named `ngrok_token` and the value as your [authtoken](https://dashboard.ngrok.com/get-started/your-authtoken)

  > _Note: You need to create an ngrok account to get an authtoken_

- Do the same for the variables in the list below:

  | Key       | Value                                                                                                |
  | --------- | ---------------------------------------------------------------------------------------------------- |
  | `SERVER`  | The server software in all lowercase. e.g `purpur`                                                   |
  | `VERSION` | Version of Minecraft your server is running on. e.g `1.19.4`                                         |
  | `BUILD`   | The build number of your server software. _Only use this if you have `paper` as the server software_ |

- List of server software supported:

  - [Purpur](https://purpurmc.org/) (1.16.1 and above)
  - [Paper](https://papermc.io/) (1.8.8 and above)

- Here are some recommended build numbers for `paper`:

  | Minecraft Version | Build # |
  | ----------------- | ------- |
  | `1.21.4`          | `232`   |
  | `1.20.6`          | `151`   |
  | `1.19.4`          | `550`   |
  | `1.18.2`          | `388`   |
  | `1.17.1`          | `411`   |
  | `1.16.5`          | `794`   |
  | `1.15.2`          | `393`   |
  | `1.14.4`          | `245`   |
  | `1.13.2`          | `657`   |
  | `1.12.2`          | `1620`  |
  | `1.11.2`          | `1106`  |
  | `1.10.2`          | `918`   |
  | `1.9.4`           | `775`   |
  | `1.8.8`           | `445`   |

  > _To get a list of all build numbers for paper, visit [here](https://papermc.io/downloads/all)_

## Running the Server

- Run the repl and follow the instructions on the console
- Once the console displays `Done! For help, type "help"`, navigate to `status.log` and copy the IP address on `line 7` and enter it inside of Minecraft. The address should be something like `tcp://9.tcp.eu.ngrok.io:46797` and you want to copy IP part, which is the entire address **EXCEPT** the `tcp://` part.

## Server Optimization

- Follow [this](https://github.com/YouHaveTrouble/minecraft-optimization) server optimization guide

<div align ="center">

<img src="projectInfo/icon.png" width="180">

# MCServerTemplate

<h3>An easily deployable Minecraft server template.</h3>

</div>

## Links

- [Releases](https://github.com/etcherfx/MCServerTemplate/releases)

## Projects Used

- [Simerlol's Minecraft Server Template](https://replit.com/@SimerLol/Minecraft-Server-Template)

## Deployment

[![Deploy to Replit](https://img.shields.io/website?color=&down_message=Deploy%20to%20Replit&label=%20&logo=replit&up_message=Deploy%20to%20Replit&url=https%3A%2F%2Freplit.com)](https://replit.com/github/etcherfx/MCServerTemplate)

## Making the Server

- Open the `Deploy to replit` button in a new tab and press `Import from Github`

  <img src="projectInfo/importGithub.png" style="border-radius: 10px;" width="350">

- Click on the `Secrets` button in the tools section on the far left side of your screen

  <img src="projectInfo/replitTools.png" style="border-radius: 10px;" width="350">

- Create a new secret called `ngrok_region` and input one of the regional codes from the list below as the value (us, eu, ap, au, sa, jp, in).

  > _Choose the closest region for better network connectivity._

  ```
  us - United States (Ohio)
  eu - Europe (Frankfurt)
  ap - Asia/Pacific (Singapore)
  au - Australia (Sydney)
  sa - South America (Sao Paulo)
  jp - Japan (Tokyo)
  in - India (Mumbai)
  ```

  <img src="projectInfo/replitSecrets.png" style="border-radius: 10px;" width="350">

- Create another secret called `ngrok_token` and input your ngrok authtoken as the value.

  > _If you don't have a ngrok authtoken, you can [visit here](https://dashboard.ngrok.com/get-started/your-authtoken) and make an account to get your token._

- Run the repl and follow the instructions on the console.
- When you get to entering the build number for the server software, here are some recommended ones:
  - Paper:
    | Minecraft Version | Build # |
    | --- | --- |
    | `1.19.4` | `484` |
    | `1.18.2` | `388` |
    | `1.17.1` | `411` |
    | `1.16.5` | `794` |
    | `1.15.2` | `393` |
    | `1.14.4` | `245` |
    | `1.13.2` | `657` |
    | `1.12.2` | `1620` |
    | `1.11.2` | `1106` |
    | `1.10.2` | `918` |
    | `1.9.4` | `775` |
    | `1.8.8` | `445` |
    > _To get more build numbers for paper, visit [here](https://papermc.io/downloads/all)_
- Once the console displays `Done! For help, type "help"`, navigate to `status.log` and copy the IP address on `line 7` and enter it inside of Minecraft. The IP should be something like `tcp://9.tcp.eu.ngrok.io:46797` and you want to copy the whole address **EXCEPT** the `tcp://` part.

## Server Optimization

- Boost your repl
- Follow [this](https://github.com/YouHaveTrouble/minecraft-optimization) server optimization guide

## Setting Java Versions

- In the files section on replit, click the three dots and click `Show hidden files`

  <img src="projectInfo/replitHiddenFiles.png" style="border-radius: 10px;" width="350">

- Navigate to `replit.nix` and follow these intructions:
  - For Minecraft 1.16.x and below, do not change anything.
  - For Minecraft 1.17.x and above, make sure to change `pkgs.openjdk8-bootstrap` to `pkgs.graalvm17-ce`

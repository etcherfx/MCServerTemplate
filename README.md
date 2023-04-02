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

[![Deploy to Replit](https://img.shields.io/website?color=cyan&down_message=Deploy%20to%20Replit&label=%20&logo=replit&up_message=Deploy%20to%20Replit&url=https%3A%2F%2Freplit.com)](https://replit.com/github/etcherfx/MCServerTemplate)

## Making the Server

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

  > _If you don't have a ngrok authtoken, you can [visit here](https://dashboard.ngrok.com) and make an account to get your token._

- Run the repl and follow the instructions on the console.

  > _If your server is running on Purpur, ignore the build number input._

- Once the console displays `Done! For help, type "help"`, navigate to `status.log` and copy the IP address on `line 7` and enter it inside of Minecraft. The IP should be something like `tcp://9.tcp.eu.ngrok.io:46797` and you want to copy the whole address **EXCEPT** the `tcp://` part.

## Server Optimization

- Boost your repl
- Follow [this](https://github.com/YouHaveTrouble/minecraft-optimization) server optimization guide

## Setting Java Versions

- In the files section on replit, click the three dots and click `Show hidden files`

  <img src="projectInfo/replitHiddenFiles.png" style="border-radius: 10px;" width="350">

- Navigate to `replit.nix` and follow these intructions:
  - For Minecraft 1.16.x and below, do not change anything.
  - For Minecraft 1.17.x and above, make sure to change `pkgs.graalvm8-ce` to `pkgs.graalvm17-ce`

# What is this?
A collection of useful (at least to me 😁) PowerShell scripts and snippets - mostly for my own use, but feel free to adapt them to your own use case (be careful, obviously).

# Scripts
## MuteSlack
An automated way to "mute" slacks tray notification icon by simply replacing the icon version that has a red dot with the dotless version. See the [corresponding post on hashnode](https://hashnode.com/post/disable-slacks-tray-notification-dot-ckao7x0jy02mh4us1qz38la5s) for details.

## WindowsDefenderAutoConfig (for Delphi)
Tries to speed up build processes by adding files and executables touched during the build to Windows Defender's exclusion list. Somehow, Windows Defender _still_ scans a lot of files, though :(

## FileContentsToLowercase
A colleague needed to convert all contents in a (huge) set of XML files to lowercase, so I quickly came up with this script to do the job. (Very basic and doesn't care at all about encoding, so use with caution (and backup your data first!) :-))

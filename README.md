# What is this?
A collection of useful (at least to me 😁) PowerShell scripts and snippets - mostly for my own use, but feel free to adapt them to your own use case (be careful, obviously).

# Scripts
## RecalculateBacklogPriorities
Lets you work around Azure DevOps' default behavior of not showing all _New_ items on the Kanban board unless you reload several times (see [this bug report](https://developercommunity.visualstudio.com/t/in-boards-always-display-all-cards-ie-never-displa/759643) - hopefully fixed soon!). The script will move items in the given iteration closer to the top of the backlog by resetting their backlog priority to be below a defined maximum. The value that works for you depends on the size of your backlog, so feel free to experiment with the `$maxPrio` setting.

Since the script uses [AzureCLI](https://docs.microsoft.com/en-us/cli/azure/) and the [azure-devops extension](https://github.com/Azure/azure-devops-cli-extension) you obviously need to have these tools installed and also be logged in with Azure DevOps (run `az login` once before executing this script).

By default, the recalculation is only simulated (no work items harmed in the proces), so make sure to set `$dryRun = $false` if you want to actually update the items on the server.

## MuteSlack
An automated way to "mute" slacks tray notification icon by simply replacing the icon version that has a red dot with the dotless version. See the [corresponding post on hashnode](https://hashnode.com/post/disable-slacks-tray-notification-dot-ckao7x0jy02mh4us1qz38la5s) for details.

## WindowsDefenderAutoConfig (for Delphi)
Tries to speed up build processes by adding files and executables touched during the build to Windows Defender's exclusion list. Somehow, Windows Defender _still_ scans a lot of files, though :(

## FileContentsToLowercase
A colleague needed to convert all contents in a (huge) set of XML files to lowercase, so I quickly came up with this script to do the job. (Very basic and doesn't care at all about encoding, so use with caution (and backup your data first!) :-))

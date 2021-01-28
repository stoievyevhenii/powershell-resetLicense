# Instruction

## Installation

Run script in PowerShell with **ADMIN RIGHTS**!

## How to use

Script have several mode for work

1) Run without data request.
`PowerShell.exe [full_path_to_script] -EvalFolder [full_path_to_file] -OtherXMLFile [full_path_to_file]`
2) Run with data request.
`PowerShell.exe [full_path_to_script]`

    2.1. `PowerShell.exe [full_path_to_script] -OtherXMLFile [full_path_to_file]`

    2.2  `PowerShell.exe [full_path_to_script] -EvalFolder [full_path_to_file]`

## Task scheduler

If you confirm task creation , in the Task Scheduler you will find new item with next params:

* Task name - Reset JetBrains license
* Repeat - Every 20 days
* Action - `PowerShell.exe -Argument "[full_script_path] -EvalFolder [full_path_to_file] -OtherXMLFile [full_path_to_file]`

Full path to script will be getting automatically

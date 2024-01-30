# MFME Fruit Machine AHK Gen Toolkit

Requires AHKv2.

## Quick Start

Modify `config.json`

```
{
    "sets": [       
        {
            "platform": "mfme",
            "enable": true,
            "config": {
                "rom_dir": "s:\\roms-fullset\\slot-machines\\Fruits",  <--- Change this to your ROM dir
                "template_dir": "templates\\mfme",
                "keymap_dir": "keymapping\\mfme",
                "gametitle_dir": "gametitles\\mfme",
                "gamedb_overwrite_file": "gamedb\\mfme\\gamedb_mfme_overwrite.txt"
            }
        }       
    ]
}
```

If needed, modify `templates/mfme/.config.ini`.
```
[Settings]
EmuPath=c:\Programs\LaunchBox\Emulators\MFME-v20\MFME.exe
GameDbPath=.gamedb.txt
StartFullScreen=1
FullScreenWidth=1920 
FullScreenHeight=1080 
Debug=0

[RomPath]
RomDir=.
```

Run
```
python3 run.py
```

## Import to Launchbox

Emulator setup
![image](https://github.com/dsync89/mfme-fruit-machine-ahk-gen-toolkit/assets/12208390/6db94d26-070c-4c7c-ae33-95f5bc8c8daf)

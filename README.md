# MFME Fruit Machine AHK Gen Toolkit

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
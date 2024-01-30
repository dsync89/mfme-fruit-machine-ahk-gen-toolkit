# generate a .gamedb.txt file that list all the files in each game folder as a row in the format of
# GAMETITLE | FILE 1 | FILE 2 | FILE 3 ...

import os
import sys

# -----------------------------------------------------------
# Main
# -----------------------------------------------------------
if __name__ == "__main__":

    if len(sys.argv) != 2:
        print("Usage: python script.py <ROM_DIR>")
        exit(1)
    else:
        arg1 = sys.argv[1]        
        ROM_DIR = arg1

    # ROM_DIR = "r:\\ROMS-Pinball\\Future Pinball\\Future Pinball Recreated Tables [MODs, HACKs]"

    root_folder_path = ROM_DIR
    output_file_path = os.path.join(root_folder_path, '.gamedb.txt')

    directories = [d for d in os.listdir(root_folder_path) if os.path.isdir(os.path.join(root_folder_path, d))]

    with open(output_file_path, 'w') as output_file:
        for directory in directories:
            folder_path = os.path.join(root_folder_path, directory)
            files = [f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))]

            boot_media_files = []

            parent = os.path.join(root_folder_path, directory)

            for root, dirs, files in os.walk(folder_path):
                for file in files:
                    if file.endswith('.gam'):                      
                        relative_path = os.path.relpath(root, parent)
                        boot_media_files.append(os.path.join(relative_path, file))
        
            # reverse sort by name so that the most recent version appear first
            boot_media_files = sorted(boot_media_files, reverse=True)
            output_file.write(f"{directory} | {' | '.join(boot_media_files)}\n")

    print("Saved .gamedb to: {}".format(output_file_path))

### Linux Swift Install Guide:
This for only testing some swift code on the fly.

-> Head over to the official Swift Open Source repo at https://www.swift.org/getting-started/.
-> Install the toolchain
-> Download the exact swift package matching the linux distribution and architecture (x86)
-> Extract the downloaded tra.zip anywhere or same directory
-> Move the extracted folder to -> usr/share/swift -> to keep everything clean and separate 
 - Terminal command to move
 - sudo mv theextracted-swift-package-file /usr/share/swift
-> Then hop over to the moved file inside usr/share/swift directory and find the swift executable as "swift" inside usr/bin
-> copy the swift executable's path
-> Then export the path by editing the /etc/profile
    - sudo nano /etc/profile (Editing in nano editor)
    - add the export as last entry of the file, change if the path is different
     - export PATH="/usr/share/swift/usr/bin:$PATH"
    - save by "ctrl+x" and confirm "y" and Enter to Commit

-> Logout or restart to see changes
-> After Export check the swift version to confirm
 - swift --version

Note: Only by terminal command -> export PATH=/path/to/Swift/usr/bin:"${PATH}" -> Temporarily add the executable in path, no permanent solution.
# Udev rules for Hexcore keyboards (TENET 70, ANNE PRO 2D, etc.)
{ lib, writeTextFile }:

writeTextFile {
  name = "70-hexcore-link.rules";
  destination = "/lib/udev/rules.d/70-hexcore-link.rules";
  text = ''
    # Hexcore TENET 70 keyboard
    SUBSYSTEM=="usb", ATTR{idVendor}=="3311", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3311", MODE="0666", TAG+="uaccess"
    
    # Hexcore keyboards - legacy IDs
    SUBSYSTEM=="usb", ATTR{idVendor}=="04d9", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="04d9", MODE="0666", TAG+="uaccess"
    
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0483", MODE="0666", TAG+="uaccess"
  '';
}

{ lib, ... }: {
  # NetworkManager handles WiFi (KDE Plasma provides the UI)
  networking.networkmanager.enable = true;

  # Add /etc/hosts-style static host entries so internal domains resolve locally
  networking.extraHosts = ''
    20.15.80.95 attu-dev.cadence-ai.com milvus-dev.cadence-ai.com langfuse-dev.cadence-ai.com rag-dev.cadence-ai.com mongo-express-dev.cadence-ai.com flower.cadence-ai.com
    20.3.22.249 attu-preprod.cadence-ai.com mongo-express.cadence-ai.com flower-preprod.cadence-ai.com
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}

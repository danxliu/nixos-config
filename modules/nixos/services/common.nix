{
  ...
}:

{
  services.printing.enable = true;
  services.openssh.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.tailscale.enable = true;
}

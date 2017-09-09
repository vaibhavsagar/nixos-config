{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    
  ];

  boot.cleanTmpDir = true;
  networking.hostName = "nixos-1gb-sgp1-01";
  networking.firewall.allowPing = true;
  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  users.extraUsers.vaibhavsagar = {
    home = "/home/vaibhavsagar";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC61ymPYXnye/dljemtu6g7x97CssxdoKDqirJjH4Fmu/dw98+oDLspeyELH0FgIb+vbAVbXUv4KBqR7jDepGrA+OsgAOUooO6iOf+c+YvcaedNHmsWIKONrgY0w99d08dQ0uWe8IR/4ekeYhbqDNtHqo5rhYpR2YlH0kUo8fyRHERX95g/88a/o8oNCR8cAPrgHhShAL/AgSWU7rqg0cK2vei70RMInTSVT3usp1jSHCNhRaCJASgADMI06tWO/JbHT4iQYRWNMRAcJnCQKADQBE31uU99b+wHantfLwZ9z5H+Oj6OL4M7WpaiyBXulwPMhjP8ajfKUAUydI1HOGIqEXGwBi7f19UjGzwbaprZFPmh1fNVJ9BVkXlLLsro/Acd4GlcgVcapdm9ZEC4rKatG8Xcbkur1KAMSWSsjHCosEPIdAvARIDkpvNGp0/SSLwHbvb15bZjMiOZ9X5mXqo4MltLQx48GWcNoxH1R5jtYinUC1QTKEJLlQLiWcemOrLoh5TL8NuHCp5ic19NjaHuGgL82NQ9HG4Gs4+e2QvUKJLnVZZlf1QwcTOlQdzG9cNxH/fkvUuBDu3f2hb6lyK28ICM1iVKodJ6fzSU30E1FW8Snu0BQ+q+IgPMCp8oFvxz2AUoHA47TOMOn9xWHqf+Nh63RXaYEF5HDAGWeDQl/w== vaibhavsagar@gmail.com"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTdTEREyJN3Q/bh0IbSPj2M+TUlrN5vW/BLHE2z085pK8OLJ5tYj283WeRw782dpgao14awJTYeYV7akVWZSIORvH6FANU8bZfD/g7Xos7d50hCa+seOGueo7B27SniXlbFcC2fXdN49sKeqnVo9YldJyhivGxwNvRmp4WvE3p6RVRhWydRtv8b5x6WZC57UYaWF7zO+HtnjU1s5h6KKEOnG4ocRy7NE3hn3pUnyGC5k+POAHYqz9IAnmvjZxJR5/Y99T/EHNPznuo0e3cTJICa1k8/W9mX6eTGsJ1dxsbhqaNjjqpzbzhxKFtZfH4Y89aQgSHxEhbLAagUG2mJfR3UWV/Br8H/hQWDncc6Sh1fWm+w9DPyNmmdwy2L2Y455fXTGfuA/M2JnauipUuaw9uEirGvDNO0YjJWohHC/DeGq6q7gL68Venymaxsm0N0X33BdksVtw+RB8XpLZ6Hm+rCR71cnAPI0/IrJQKr7Seuvkedw6j7NQ4c5cdl08CEHITsoxX0r61CALgumLzdYw/T1/RIrQfh1RQVCWdEI1rVGuMvb1YuvM4QiITuNjlgJLiYM6gk3EucoqLDIbp21lkitF52imqnvA9gKvoZ60vbmW1bQ8ULABvzCqUfr+leK8bShx3f3tIR2/+ZgkjS+aE6ifPQ9rR5Tsy5SnDl8gIqQ== vaibhavsagar@gmail.com"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC19+d/67xRzzlzETcbM9ICHvzaCSxhovQDxXggs+ub8E8gC2vDImYoqoaefybHiGHXhOCPHuDRPWU4ZQTDjZxDEm7YgpCpFIQHZmxm3DxPb36hQOxCDcvUCmxKeyUacBe6IHu+PMuxf4nQuL1cFVtG076cuoFBOqgYsBpnQID6zfUQ1RIWgkIlKy/dCtCyILIcTbK6dOulC23IT0tGUF2gdkAuiglPO0SJTGL+cQQSdv86ZMoGczmnaeC8DFLczQ+m+PvfxYu/m6P14pUaLPo+46Ieb/w70QgzdnrZCFJpvZBo9ENqGcCiSNoS4K2OhIBF5bCs7XtypSzoQ92X6Ia9HLELLcHcfwD1qIiTzGHEAWjvWUMpH7W9bUQlC9kyYFPgLeHd3KQnfd7PetQD7efGhtLp0x3gUsSnBhUOeQQ8oVWF5MXihBeswzLPHO5SomNv7dh8cmRe6LUY/1Y7M/n3DGaJElQqPAC5KrQP9pHuT159N0aSRi5OknWTujE983+EJBgUtVbAMf4qg42odzvTkAcoNeuY2r7cMpskxnH30u6RneHYwaCyRB22kdLpUzgULHkwhsF1tWgkpyi99GSvO2yt0547ivxc/pUWPVedFOEsw45h3c2MOlT8deAQc7dnUYohI+J5+igyr4wVMng7IsXWAcP94pbeuudr7fX93w=="
    ];
    uid = 1000;
  };
}

{ 
      networking.hostName = "nixos";
      networking.dhcpcd.enable = false;
      networking.defaultGateway = {
        address =  "147.75.38.112";
        interface = "bond0";
      };
      networking.defaultGateway6 = {
        address = "2604:1380:0:3e00::";
        interface = "bond0";
      };
      networking.nameservers = [
        "147.75.207.207"
        "147.75.207.208"
      ];
    
      networking.bonds.bond0 = {
        driverOptions = {
          mode = "balance-tlb";
          xmit_hash_policy = "layer3+4";
          downdelay = "200";
          updelay = "200";
          miimon = "100";
        };

        interfaces = [
          "enp0s20f0" "enp0s20f1"
        ];
      };
    
      networking.interfaces.bond0 = {
        useDHCP = false;

        ipv4 = {
          routes = [
            {
              address = "10.0.0.0";
              prefixLength = 8;
              via = "10.99.19.0";
            }
          ];
          addresses = [
            {
              address = "147.75.38.113";
              prefixLength = 31;
            }
            {
              address = "10.99.19.1";
              prefixLength = 31;
            }
          ];
        };

        ipv6 = {
          addresses = [
            {
              address = "2604:1380:0:3e00::1";
              prefixLength = 127;
            }
          ];
        };
      };
    
      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC19+d/67xRzzlzETcbM9ICHvzaCSxhovQDxXggs+ub8E8gC2vDImYoqoaefybHiGHXhOCPHuDRPWU4ZQTDjZxDEm7YgpCpFIQHZmxm3DxPb36hQOxCDcvUCmxKeyUacBe6IHu+PMuxf4nQuL1cFVtG076cuoFBOqgYsBpnQID6zfUQ1RIWgkIlKy/dCtCyILIcTbK6dOulC23IT0tGUF2gdkAuiglPO0SJTGL+cQQSdv86ZMoGczmnaeC8DFLczQ+m+PvfxYu/m6P14pUaLPo+46Ieb/w70QgzdnrZCFJpvZBo9ENqGcCiSNoS4K2OhIBF5bCs7XtypSzoQ92X6Ia9HLELLcHcfwD1qIiTzGHEAWjvWUMpH7W9bUQlC9kyYFPgLeHd3KQnfd7PetQD7efGhtLp0x3gUsSnBhUOeQQ8oVWF5MXihBeswzLPHO5SomNv7dh8cmRe6LUY/1Y7M/n3DGaJElQqPAC5KrQP9pHuT159N0aSRi5OknWTujE983+EJBgUtVbAMf4qg42odzvTkAcoNeuY2r7cMpskxnH30u6RneHYwaCyRB22kdLpUzgULHkwhsF1tWgkpyi99GSvO2yt0547ivxc/pUWPVedFOEsw45h3c2MOlT8deAQc7dnUYohI+J5+igyr4wVMng7IsXWAcP94pbeuudr7fX93w== vaibhav.sagar@zalora.com"
    

        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC61ymPYXnye/dljemtu6g7x97CssxdoKDqirJjH4Fmu/dw98+oDLspeyELH0FgIb+vbAVbXUv4KBqR7jDepGrA+OsgAOUooO6iOf+c+YvcaedNHmsWIKONrgY0w99d08dQ0uWe8IR/4ekeYhbqDNtHqo5rhYpR2YlH0kUo8fyRHERX95g/88a/o8oNCR8cAPrgHhShAL/AgSWU7rqg0cK2vei70RMInTSVT3usp1jSHCNhRaCJASgADMI06tWO/JbHT4iQYRWNMRAcJnCQKADQBE31uU99b+wHantfLwZ9z5H+Oj6OL4M7WpaiyBXulwPMhjP8ajfKUAUydI1HOGIqEXGwBi7f19UjGzwbaprZFPmh1fNVJ9BVkXlLLsro/Acd4GlcgVcapdm9ZEC4rKatG8Xcbkur1KAMSWSsjHCosEPIdAvARIDkpvNGp0/SSLwHbvb15bZjMiOZ9X5mXqo4MltLQx48GWcNoxH1R5jtYinUC1QTKEJLlQLiWcemOrLoh5TL8NuHCp5ic19NjaHuGgL82NQ9HG4Gs4+e2QvUKJLnVZZlf1QwcTOlQdzG9cNxH/fkvUuBDu3f2hb6lyK28ICM1iVKodJ6fzSU30E1FW8Snu0BQ+q+IgPMCp8oFvxz2AUoHA47TOMOn9xWHqf+Nh63RXaYEF5HDAGWeDQl/w== vaibhavsagar@gmail.com"
    
      ];
    
      users.users.root.initialHashedPassword = "$6$FjnEegAHdlvZYeWg$s2sXhCpkS.kJzECO51B.9/d2xq8YfxTpc01hl0YwoNlgSqaTJ4JMHW0YK3vJmJyA0quZqoFrOwFj6sN0wxQhV/";
     }

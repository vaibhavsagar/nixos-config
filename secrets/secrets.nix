let
  vaibhavsagar-l14g3 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA8Ku07baZSVh7RsqD2KnKp8TflBrHB4nf7huRrhFxSj vaibhavsagar@gmail.com";
  vaibhavsagar-terra = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILaNMt6fk7OeLrzQnatLd4E2D/pegMvLANNK8Vgcba8A vaibhavsagar@gmail.com";
  users = [ vaibhavsagar-l14g3 vaibhavsagar-terra ];

  l14g3 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIUcppIPoHm7aGBsDkn6EZ4BIP8aovaFxxkmPy6CDMH3";
  terra = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICgZvkxq6XuJoea5QPCZu6Rc3fEwnq9I7+EOjyc8bF1A";
  systems = [ l14g3 terra ];

  all = users ++ systems;
in {
  "github-access-token.age" = {
    publicKeys = all;
    armor = true;
  };
  "uptrust-cache-ip-address.age" = {
    publicKeys = all;
    armor = true;
  };
  "uptrust-cache-ed25519-public-key.age" = {
    publicKeys = all;
    armor = true;
  };
  "uptrust-cache-rsa-public-key.age" = {
    publicKeys = all;
    armor = true;
  };
  "uptrust-cache-trusted-public-key.age" = {
    publicKeys = all;
    armor = true;
  };
}

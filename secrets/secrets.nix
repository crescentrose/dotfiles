let
  encryptionKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA12ptTQUplJQ1j/EMwJeWP9uCSqW2g0CYj047QJFtBc";
  defaultConfig = {
    publicKeys = [ encryptionKey ];
    armor = true;
  };
in
{
  "mpdscribble.age" = defaultConfig;
}

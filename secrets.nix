let
  vm-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWkzs6biYrl1By9qvWgWTHCTjBtqqiBozsDHZl5Fz04";
  hosts = [ vm-01 ];
in
{
  "secrets/passwords/local-admin.age" = {
    publicKeys = hosts;
    armor = true;
  };
}

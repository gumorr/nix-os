let
  GUMMI-VM-01 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWkzs6biYrl1By9qvWgWTHCTjBtqqiBozsDHZl5Fz04"

  systems = [ GUMMI-VM-01 ]
in
{
  "localAdminPwd.age" = {
    publicKeys = systems;
    armor = true;
  };
}

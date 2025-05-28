let
  userName = "unalome";
  email = "gautamyashwardhan@gmail.com";
in
{
    programs.git = {
        enable = true;
        userName = userName;
        userEmail = email;
    };
}

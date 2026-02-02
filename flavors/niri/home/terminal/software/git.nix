{ ... }:
{
  programs.git = {
    enable = true;
    userName = "tctinh";
    userEmail = "tctinh@tma.com.vn";
    extraConfig = {
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };
}

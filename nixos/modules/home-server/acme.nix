let
  domainName = "tetocorp.ie";
in {
  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@tetocorp.ie";
  };
}

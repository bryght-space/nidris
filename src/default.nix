with (import ./helpers.nix);
let
  getByRevision = revision: name: builtins.getAttr name (channelFromRevision revision);
  revisions = {
    "0.5.1" = ["896ee5ffc634473f63ce70829568c9b8156a13cf" "idris2" ];
    "0.5.0" = ["948ef8a6c5fd2c71a5e45aecd5cc997740e91024" "idris2" ];
  };

  getByVersion = version :
    let
      p        = builtins.getAttr version revisions;
      revision = builtins.elemAt p 0;
      items    = builtins.tail p;
      f        = n: getByRevision revision n;
    in
      builtins.map f items;
      idris = version : getByVersion version;
      idris2PackagesChannel = idris2PackagesChannelFromRevision 5794a5150e6640352b7e63967a2fc6a56fb12d93;
      inigo = idris2PackagesChannel.inigo;
in version : [ (idris version) inigo ]

'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "e1e6007eb6cf9e4f76ce5d612271c48c",
"version.json": "ff947081b3606564a9ae030801c501b1",
"index.html": "55844e1ff0e6883c43cee0a400680441",
"/": "55844e1ff0e6883c43cee0a400680441",
"vercel.json": "c31ca871b53abdde9fc4de7b7e7548e0",
"main.dart.js": "8a9c430c9013898727f9a4255224534a",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"styles/loader.css": "853a7a3e456cfd00e77d8b697ecb2a29",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/logo_transparent.png": "8e1af33b60ce51a87fedc5f916036295",
"icons/Icon-192.png": "744edcb4e2b685712841c3386149e5f0",
"icons/Icon-maskable-192.png": "744edcb4e2b685712841c3386149e5f0",
"icons/favicon-32.png": "c3a274779a2dd56a7dbdfc7365915c9f",
"icons/Icon-maskable-512.png": "619b604d5a254f86790311898d2a9a83",
"icons/Icon-512.png": "619b604d5a254f86790311898d2a9a83",
"manifest.json": "0deaae8e39809c2ff452137010621800",
"log_rocket.js": "b7f76122b2aa6edf948d79f6b7cf05a8",
"assets/AssetManifest.json": "5e78b5fc8c12472f8a641ac24979ec1d",
"assets/NOTICES": "7c916f79257eb54f91cb6c74b716fb74",
"assets/FontManifest.json": "f3df27c6fe84cb318f6897a54faae891",
"assets/AssetManifest.bin.json": "7da585c039f6c59172c2e4c5cd356d83",
"assets/packages/ui/fonts/GeistMono-SemiBold.otf": "02036797116901c5db4a3a629561e588",
"assets/packages/ui/fonts/Geist-UltraLight.otf": "b64b37fbec0a925067cbf530e4962fec",
"assets/packages/ui/fonts/GeistMono-Light.otf": "92c6dfb1c2854b6b0fd3f63ab5af9b7a",
"assets/packages/ui/fonts/Geist-Thin.otf": "8603d0fe0def4273ebeee670eedcfb86",
"assets/packages/ui/fonts/Geist-Bold.otf": "d3e1d3dc690224fd330969af598a9c31",
"assets/packages/ui/fonts/Geist-Black.otf": "cf003c4f85b590cf60bec1e111ebaaf5",
"assets/packages/ui/fonts/Geist-Regular.otf": "4d02716b4f2f2e4d9c568c8d24e8e74d",
"assets/packages/ui/fonts/GeistMono-UltraLight.otf": "45ea4a4ba1034f7fa081c8b7ee958734",
"assets/packages/ui/fonts/GeistMono-Thin.otf": "cbf62a8e76578e03404b0314787d9477",
"assets/packages/ui/fonts/GeistMono-UltraBlack.otf": "cfad4eb45ce5dff853a6c84c8a7d441b",
"assets/packages/ui/fonts/Geist-Light.otf": "21f434e8c2b53240a0c459b9d119f22f",
"assets/packages/ui/fonts/GeistMono-Regular.otf": "42af0dfdb5e9e272e7ac28868b5b99fb",
"assets/packages/ui/fonts/GeistMono-Bold.otf": "fce632a1c87f36e92fb23ae5618176ce",
"assets/packages/ui/fonts/Geist-SemiBold.otf": "2c0b1d3e7b1c71bedc2eecf78f7a1d1d",
"assets/packages/ui/fonts/Geist-Medium.otf": "f7ceaf00b58d396cf93ff1ea43740027",
"assets/packages/ui/fonts/GeistMono-Medium.otf": "b1f17a06e50fba3f1e9695c2a8ae0783",
"assets/packages/ui/fonts/GeistMono-Black.otf": "d72857791f93bbf88629ab9601ebfa14",
"assets/packages/ui/fonts/Geist-UltraBlack.otf": "f3591a030925294b2bb427e6a6c9b0d8",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/packages/paipfood_package/lib/l10n/app_localizations.dart": "366d4bd2600af4c8d78e3c9498742de4",
"assets/packages/paipfood_package/lib/l10n/app_pt_BR.arb": "927b321d016eb0293537f943d797f291",
"assets/packages/paipfood_package/lib/l10n/app_pt.arb": "f7608db7fb79d2050a9033fefc07939d",
"assets/packages/paipfood_package/lib/l10n/app_en.arb": "3325546895fb0e3fea6abeec88b7f751",
"assets/packages/paipfood_package/lib/l10n/l10n_exports.dart": "1b5e36a7c172f7bbe2060d0fa5921b97",
"assets/packages/paipfood_package/lib/l10n/l10n_extension.dart": "0cac0b4e178f6e9d5a4cac6db64e9c20",
"assets/packages/paipfood_package/lib/l10n/app_localizations_pt.dart": "61e83de8a564be6d9e81b06fce252045",
"assets/packages/paipfood_package/lib/l10n/app_localizations_en.dart": "1e892660a49669cb910ece8ded0cd491",
"assets/packages/paipfood_package/assets/payments/elo.svg": "a29b316659df4ba946dab439101a0193",
"assets/packages/paipfood_package/assets/payments/visa.svg": "f6bd47453b14530ca47d9623a01580c7",
"assets/packages/paipfood_package/assets/payments/master.svg": "6bf7e532c1c782a529f19fb4af7aa01c",
"assets/packages/paipfood_package/assets/payments/diners.svg": "1e1ca58bb93ad0dbd4413360ee0ccfc0",
"assets/packages/paipfood_package/assets/payments/vrRefeicao.svg": "5889d35f33de3275e4a9ec6c708dd6c0",
"assets/packages/paipfood_package/assets/payments/pix.svg": "c9d9acd105ffe60ea76dafae3ab918fb",
"assets/packages/paipfood_package/assets/payments/amex.svg": "ab25fd320ec57f2700bb1faa055d957e",
"assets/packages/paipfood_package/assets/payments/cash.svg": "e815d1f84d0e36197787db97efb811c4",
"assets/packages/paipfood_package/assets/payments/vrAlimentacao.svg": "38cda3da9d27a11594c0b0821c91ee41",
"assets/packages/paipfood_package/assets/payments/hiper.svg": "a52c53d4d5371a9ccac6e05d36748c09",
"assets/packages/paipfood_package/assets/pt_BR.svg": "253ebcf81629b72140123224e21f72c0",
"assets/packages/paipfood_package/assets/flags/TG.png": "9e7c8855f45249cafafc769afd168b36",
"assets/packages/paipfood_package/assets/flags/ME.png": "9b8c6d291028d24cd83c4ad8cfa4e5bc",
"assets/packages/paipfood_package/assets/flags/LA.png": "92ac9f84fa63e2d097029c81a47ed486",
"assets/packages/paipfood_package/assets/flags/MR.png": "f50c0e4c615907e4c1459ed5d2b9e880",
"assets/packages/paipfood_package/assets/flags/NI.png": "9a9953a4b8c59651776f3f4adcd13956",
"assets/packages/paipfood_package/assets/flags/LV.png": "593ea19ad467ac0ddf34e2b8d626b007",
"assets/packages/paipfood_package/assets/flags/OM.png": "4d0d2eea7b5abf60019aa6df9cc31d2c",
"assets/packages/paipfood_package/assets/flags/AF.png": "a02ed52f57b95474c7403e6fa5693f75",
"assets/packages/paipfood_package/assets/flags/CY.png": "c02e40dac14a77e4006038c27e470dd8",
"assets/packages/paipfood_package/assets/flags/BJ.png": "c920fd41e32ffacdd0a530a96bb68990",
"assets/packages/paipfood_package/assets/flags/AQ.png": "22923bb12de6215b55a3a53ea7a8584a",
"assets/packages/paipfood_package/assets/flags/CN.png": "aef4c7f59f5404214bcb40f7000ee15e",
"assets/packages/paipfood_package/assets/flags/CO.png": "c623d886d67c049fd50fb818707abbe0",
"assets/packages/paipfood_package/assets/flags/CX.png": "bb6a91c8c2769104814effcf25a9b068",
"assets/packages/paipfood_package/assets/flags/AG.png": "f425d1dce68b14dc1da23811011f58d3",
"assets/packages/paipfood_package/assets/flags/MS.png": "7c86d795edee13c3a24492868f8a7754",
"assets/packages/paipfood_package/assets/flags/MD.png": "643bd592025d51e21bc747e3bcee004f",
"assets/packages/paipfood_package/assets/flags/ZM.png": "ba438cae3879be81e3ea20bfbb618727",
"assets/packages/paipfood_package/assets/flags/VN.png": "75b75a645ff65f9e32e0f7b8c94daba3",
"assets/packages/paipfood_package/assets/flags/TF.png": "e017de4ee683784da0c6a6b657020660",
"assets/packages/paipfood_package/assets/flags/TD.png": "60db6b9716c028bcfd34221aaa23636f",
"assets/packages/paipfood_package/assets/flags/YT.png": "63bf875aa739dd58fdef756f8428d8c7",
"assets/packages/paipfood_package/assets/flags/LB.png": "c7d17f7ea93eb0f25668bee4de60a5e9",
"assets/packages/paipfood_package/assets/flags/MF.png": "e3411ae2ebe7af4694a37677e800aaad",
"assets/packages/paipfood_package/assets/flags/LU.png": "fea65a01fb1f7e0d6060113f45d18d31",
"assets/packages/paipfood_package/assets/flags/MQ.png": "77f10109287e7ca814b3e9169ce36ec0",
"assets/packages/paipfood_package/assets/flags/CZ.png": "e2dc2b0bdbd03b0bc546927f28b50b29",
"assets/packages/paipfood_package/assets/flags/AE.png": "7c40c40b5e50fb2b0b3c138f45504c4d",
"assets/packages/paipfood_package/assets/flags/CM.png": "69cba1ac38dca66fd70fb648d602593a",
"assets/packages/paipfood_package/assets/flags/BI.png": "01b5d6b2e39495027cf3ff493d99caa1",
"assets/packages/paipfood_package/assets/flags/AR.png": "75af6b6b05f84f5cc5d30663cd64a8f9",
"assets/packages/paipfood_package/assets/flags/AS.png": "0baccf2d55fbfdbd9308319b9064f7b9",
"assets/packages/paipfood_package/assets/flags/BH.png": "46af89776241eebefe18d164c3c214cf",
"assets/packages/paipfood_package/assets/flags/CL.png": "ef64c483e4228f8dcb74727bfe69d2a3",
"assets/packages/paipfood_package/assets/flags/AD.png": "f66d44f7281d0a058dd8d9189d877e45",
"assets/packages/paipfood_package/assets/flags/MP.png": "3fb6b51e3a1d514d1b3ff7e155b6e309",
"assets/packages/paipfood_package/assets/flags/LT.png": "6a9df841dcf660d7cd08daac0cc326ab",
"assets/packages/paipfood_package/assets/flags/MG.png": "f5a260ed4f5aa92f647db64f4094efdc",
"assets/packages/paipfood_package/assets/flags/LC.png": "8091985f32731601300c01512215ecf7",
"assets/packages/paipfood_package/assets/flags/TR.png": "b8493b459e246bff31ca58c9e71e1e6a",
"assets/packages/paipfood_package/assets/flags/UA.png": "cf2a16b632589b3c4b7089487556e5cc",
"assets/packages/paipfood_package/assets/flags/TV.png": "4af3272c17c989e23da9a3c2a35bc7b3",
"assets/packages/paipfood_package/assets/flags/VI.png": "65e4e246958ae96c527899616d0cfd19",
"assets/packages/paipfood_package/assets/flags/TA.png": "48b34ee918c4f500b9ceb507f7adecd0",
"assets/packages/paipfood_package/assets/flags/MT.png": "34643222247bd7bcd79489c55d24e183",
"assets/packages/paipfood_package/assets/flags/NO.png": "29ffeec28429dfe1702b1664a3cecf6a",
"assets/packages/paipfood_package/assets/flags/MC.png": "d0a414064d56b47c6d91eaab248f13aa",
"assets/packages/paipfood_package/assets/flags/CH.png": "d39fea2e1dc1e94b0d473d2d0f4f81d3",
"assets/packages/paipfood_package/assets/flags/BL.png": "b7731a3e4bb61b91bcc8d83b283d2ba4",
"assets/packages/paipfood_package/assets/flags/AW.png": "c9841b4f7b5a3bd5de0925ac8fbffe44",
"assets/packages/paipfood_package/assets/flags/BZ.png": "a3fbdb57fdd262987f21992f4227f6a1",
"assets/packages/paipfood_package/assets/flags/BM.png": "3bf13d9d2449ba088de6bfa8f8e7604f",
"assets/packages/paipfood_package/assets/flags/CI.png": "be22235bb6f3795c5238d51a9e528f90",
"assets/packages/paipfood_package/assets/flags/MU.png": "e691d487fa372222803974f5d4508ebe",
"assets/packages/paipfood_package/assets/flags/US.png": "31056cd794f711a2deb75210b0f5c360",
"assets/packages/paipfood_package/assets/flags/TW.png": "fa753f011c8b60532c430e60d8c2f8a5",
"assets/packages/paipfood_package/assets/flags/YE.png": "5d6e084bd7bb0e2b01ebdc6ebed388c5",
"assets/packages/paipfood_package/assets/flags/MW.png": "abfd0ec2527b868ddac74ba450706216",
"assets/packages/paipfood_package/assets/flags/NL.png": "3ddaebc3fbdfa51cb048006701b97208",
"assets/packages/paipfood_package/assets/flags/LS.png": "06abf7781c40ba01fe2968bff7c8cab6",
"assets/packages/paipfood_package/assets/flags/BO.png": "ff2c7a87325d5d7fa0c4068f973edd5c",
"assets/packages/paipfood_package/assets/flags/AT.png": "de5f2deacdd4a509241f2fe88f526f3d",
"assets/packages/paipfood_package/assets/flags/CK.png": "2f79a0dab02064a5e3e51482270f5241",
"assets/packages/paipfood_package/assets/flags/AC.png": "f254e20b9f154cd8eba7ffec8e444da9",
"assets/packages/paipfood_package/assets/flags/BY.png": "2f858c87d051c3398f8b50953100a7ea",
"assets/packages/paipfood_package/assets/flags/AU.png": "207925985e996e529aff78a0871b97a3",
"assets/packages/paipfood_package/assets/flags/BN.png": "9238542da0451a35bdd00eb06cf81b56",
"assets/packages/paipfood_package/assets/flags/MA.png": "de90a21571a9dd1f74af36d172638536",
"assets/packages/paipfood_package/assets/flags/NZ.png": "796130404e97851856c90b2b2226ec66",
"assets/packages/paipfood_package/assets/flags/LR.png": "beb16cd05499cd40da8168af6831644c",
"assets/packages/paipfood_package/assets/flags/MV.png": "4ec757e5facae51bb3cb35cc9014b8e6",
"assets/packages/paipfood_package/assets/flags/TC.png": "6d92a12aaa143b42e64607e9c9fa41b9",
"assets/packages/paipfood_package/assets/flags/UG.png": "3171b25e241d1cfefa4d5bca23cef4cc",
"assets/packages/paipfood_package/assets/flags/TT.png": "4ae74f2ced621e05e4a581667b32b3dc",
"assets/packages/paipfood_package/assets/flags/PL.png": "20e05cb326629415e2e6453f10e2c1f6",
"assets/packages/paipfood_package/assets/flags/RS.png": "ce2289ede2f7086694d7ff2a4299c541",
"assets/packages/paipfood_package/assets/flags/IN.png": "2cbb7842ea638816ef224a998fe61f0b",
"assets/packages/paipfood_package/assets/flags/GE.png": "27586b22e54022e0d96824aab9e58b2c",
"assets/packages/paipfood_package/assets/flags/GR.png": "0dcded57d7c72b129e5cdbe2e4e7f225",
"assets/packages/paipfood_package/assets/flags/GS.png": "171efa13bb6c760f4135ffc95574b9d7",
"assets/packages/paipfood_package/assets/flags/GD.png": "74c5531475bfc89e92885aa71c9b210d",
"assets/packages/paipfood_package/assets/flags/IO.png": "75cbd98201536b7371e3c299abe55840",
"assets/packages/paipfood_package/assets/flags/HK.png": "bc0c908826e865c5c739e63117d1ce4e",
"assets/packages/paipfood_package/assets/flags/KP.png": "fddb7d45edef6a72a4606bc05b69e25a",
"assets/packages/paipfood_package/assets/flags/KG.png": "f11947bbb55c229c1ae33a2ecd8373f8",
"assets/packages/paipfood_package/assets/flags/PM.png": "a84033768bdfb354490d6a9dce662639",
"assets/packages/paipfood_package/assets/flags/SV.png": "0052cc54e1038da3d2d611f3375088d2",
"assets/packages/paipfood_package/assets/flags/RE.png": "a84033768bdfb354490d6a9dce662639",
"assets/packages/paipfood_package/assets/flags/SA.png": "c928e0d526588983748fd1b221b69a5e",
"assets/packages/paipfood_package/assets/flags/SC.png": "4c856234535ae879c3890f58200a5788",
"assets/packages/paipfood_package/assets/flags/ST.png": "d7d5612f752b23e96d7c9d3989ce09f8",
"assets/packages/paipfood_package/assets/flags/KE.png": "e1b120ded8513387a812cf93e152ea4b",
"assets/packages/paipfood_package/assets/flags/IM.png": "80afa2eb940166941d3bd8e994a22409",
"assets/packages/paipfood_package/assets/flags/KR.png": "e37daade6ab25b49bd3efd7de88c46c8",
"assets/packages/paipfood_package/assets/flags/GF.png": "01be318089fee67cf92573deecdd8aaa",
"assets/packages/paipfood_package/assets/flags/DJ.png": "3f903793e4c0cc01c0c142cfd5ca89b3",
"assets/packages/paipfood_package/assets/flags/GQ.png": "9511c2c1f968cfd31ef73658738b2851",
"assets/packages/paipfood_package/assets/flags/GE-OS.png": "e105bdcfe60049e459ec8fe7399d6b2f",
"assets/packages/paipfood_package/assets/flags/GP.png": "595564db5f48e6c39a23f378dab76ca2",
"assets/packages/paipfood_package/assets/flags/DK.png": "d970b754ed6fdbeb6d7cd1e253683ed4",
"assets/packages/paipfood_package/assets/flags/GG.png": "4c256841ccd6dfc8620f397ef88060aa",
"assets/packages/paipfood_package/assets/flags/IL.png": "4f1a9339e831912e8aaf09b10d6927b2",
"assets/packages/paipfood_package/assets/flags/PN.png": "ddd3bb483a573f691a2df622ece57f1e",
"assets/packages/paipfood_package/assets/flags/SB.png": "72733886f20a598b7dadbf96b1adb9fc",
"assets/packages/paipfood_package/assets/flags/PY.png": "80411ab4560367442bbd8cfaa440ae51",
"assets/packages/paipfood_package/assets/flags/RU.png": "92f21475981e2a2c0996ed39e5fa7bf1",
"assets/packages/paipfood_package/assets/flags/KW.png": "974d27c500eeb25811d983bfe022423e",
"assets/packages/paipfood_package/assets/flags/DO.png": "eaf8f57b45655867c6dd899d854bdf1a",
"assets/packages/paipfood_package/assets/flags/GT.png": "5b0931b1c0e4db2c13393903d4ccb9ee",
"assets/packages/paipfood_package/assets/flags/GB.png": "7e4026b539c2c1fe774ca33e45f6b45a",
"assets/packages/paipfood_package/assets/flags/GU.png": "d19ada90dc8bbd37ae2a229d02ec268a",
"assets/packages/paipfood_package/assets/flags/JE.png": "d370e602fb896adaf9e61f66e835a47f",
"assets/packages/paipfood_package/assets/flags/HM.png": "6623bfa1039f33c0b58bc0fcbbb6849b",
"assets/packages/paipfood_package/assets/flags/SG.png": "364bbf88db01cc1c06ed5a303d55632a",
"assets/packages/paipfood_package/assets/flags/PK.png": "b8ed8d5cf6a7170d6a25ef2454ff92ee",
"assets/packages/paipfood_package/assets/flags/SR.png": "933f5c700534e27af42face48a836108",
"assets/packages/paipfood_package/assets/flags/SE.png": "54ec932d77d3ce9132770ca777c99cf1",
"assets/packages/paipfood_package/assets/flags/JP.png": "f156a53b50668490b84013f8b82de1ed",
"assets/packages/paipfood_package/assets/flags/GW.png": "f672392235e17b0a4605971c7c86e64c",
"assets/packages/paipfood_package/assets/flags/EH.png": "8a2d69c27d1edc092135b43653fecf48",
"assets/packages/paipfood_package/assets/flags/DZ.png": "9e8b35e2d8940fcd8b26e859c9f574e4",
"assets/packages/paipfood_package/assets/flags/GA.png": "aed0092894259aba316ff0d01b269389",
"assets/packages/paipfood_package/assets/flags/FR.png": "dc55aa18c8e794fee6c34f738f03076a",
"assets/packages/paipfood_package/assets/flags/DM.png": "4b7fdfc1bcb6dc88475a18afead75405",
"assets/packages/paipfood_package/assets/flags/HN.png": "4f30ce7e18d17dea950f783c06df3be7",
"assets/packages/paipfood_package/assets/flags/SD.png": "1705bd39e3569799b4bb07933bcfd907",
"assets/packages/paipfood_package/assets/flags/RW.png": "b5b2aac5975e3544f4a7105dde2086d8",
"assets/packages/paipfood_package/assets/flags/PH.png": "a3c5aeefe5ecd7daeb6fa0d8bf02a2f2",
"assets/packages/paipfood_package/assets/flags/SS.png": "c75fbc2967cf1d06f48ffd0c4d3e87b8",
"assets/packages/paipfood_package/assets/flags/QA.png": "d42f10f824399b6fe83366fa70954241",
"assets/packages/paipfood_package/assets/flags/PE.png": "5d53b4c322f5c0779aeac87a5e7c8bb4",
"assets/packages/paipfood_package/assets/flags/PR.png": "138272586abc1a487a90a06292ec1742",
"assets/packages/paipfood_package/assets/flags/SI.png": "cef1077211127fd95dc2fd631036336e",
"assets/packages/paipfood_package/assets/flags/HT.png": "bdeab566d1465e3b2adaf2e1826e3e96",
"assets/packages/paipfood_package/assets/flags/ES.png": "b878503c237f43c875f48c2b41c7bb4d",
"assets/packages/paipfood_package/assets/flags/GL.png": "e23ea9c7331b4a38484b14159c91899d",
"assets/packages/paipfood_package/assets/flags/GM.png": "e37b8ff036e150494ede269f03f315be",
"assets/packages/paipfood_package/assets/flags/ER.png": "8002732c05d7092647d5f60ee06f74fa",
"assets/packages/paipfood_package/assets/flags/FI.png": "29645826962f4529b5943432e9aec0fa",
"assets/packages/paipfood_package/assets/flags/EE.png": "6a9bba8f1d6fa988461bce15af5fd752",
"assets/packages/paipfood_package/assets/flags/KN.png": "a46d215fc9667384a29708d8c5447e14",
"assets/packages/paipfood_package/assets/flags/HU.png": "abc64cba203131de6475d91315a11012",
"assets/packages/paipfood_package/assets/flags/IQ.png": "2a9beba49c71cd7d3cbb3864fc4265fc",
"assets/packages/paipfood_package/assets/flags/KY.png": "af78930883ea9456c5abf92fa845b72a",
"assets/packages/paipfood_package/assets/flags/SH.png": "57c5f3b1cbdd98083423ab457540f110",
"assets/packages/paipfood_package/assets/flags/PS.png": "4a6abe62594ebd355b45d6d615e50dcf",
"assets/packages/paipfood_package/assets/flags/PF.png": "b0679debd5e1f20c7ed570b03df70f01",
"assets/packages/paipfood_package/assets/flags/SJ.png": "f405e25f568805b6f1d69f5ca006724a",
"assets/packages/paipfood_package/assets/flags/ID.png": "8033a222b6ca94e610ec2023aa058754",
"assets/packages/paipfood_package/assets/flags/IS.png": "733ee5dda880ac07b74b76a92621841c",
"assets/packages/paipfood_package/assets/flags/EG.png": "ab44b1f55502afeefbf87f774f0ae46a",
"assets/packages/paipfood_package/assets/flags/FK.png": "751d203e491cfd391d3135decb3e4dac",
"assets/packages/paipfood_package/assets/flags/FJ.png": "5e41707ff02a184c20d9519c007d648f",
"assets/packages/paipfood_package/assets/flags/GN.png": "1b55a6237e08c5d1c7cc07a741938c43",
"assets/packages/paipfood_package/assets/flags/GY.png": "a7b329d4ced0007e8e23a05b6cff0695",
"assets/packages/paipfood_package/assets/flags/IR.png": "494d435acd537a885e13455d90f12ca6",
"assets/packages/paipfood_package/assets/flags/KM.png": "a364cef76134031f8b18ccf65c3fa085",
"assets/packages/paipfood_package/assets/flags/IE.png": "f9d7ed721ac231a23e646982f6fe72d9",
"assets/packages/paipfood_package/assets/flags/KZ.png": "eadadaecf7194083938e574b40130b90",
"assets/packages/paipfood_package/assets/flags/RO.png": "dbf807582ce2651f62504906775f74b4",
"assets/packages/paipfood_package/assets/flags/SK.png": "91164709f83038b9a0b8c4dccaa74992",
"assets/packages/paipfood_package/assets/flags/PG.png": "fa86d6726c20781fbb65d44153967b84",
"assets/packages/paipfood_package/assets/flags/PT.png": "22e8013ce3d8ad18c0571d02938b9797",
"assets/packages/paipfood_package/assets/flags/SO.png": "4445cec8bbedd7c724534a856917db20",
"assets/packages/paipfood_package/assets/flags/SX.png": "3f5d59880ae75663d9b4dc02dfdba38e",
"assets/packages/paipfood_package/assets/flags/HR.png": "79d12caecda8a4f2dd52188164982e83",
"assets/packages/paipfood_package/assets/flags/KI.png": "64633486addafd73824287bdf506b19b",
"assets/packages/paipfood_package/assets/flags/JM.png": "295e12bf495c2641471486e2ccae2a41",
"assets/packages/paipfood_package/assets/flags/EU.png": "e7311a831d60fa5da89587aff1c0ed00",
"assets/packages/paipfood_package/assets/flags/GE-AB.png": "091aa16dc5bbbd818568b557d89fe175",
"assets/packages/paipfood_package/assets/flags/EC.png": "cee51a79cc8c7f1fcb737eef10ea1de9",
"assets/packages/paipfood_package/assets/flags/ET.png": "741e4a7b3a83c5ad313f8bd39591a4c1",
"assets/packages/paipfood_package/assets/flags/FO.png": "503b0cf2b4eddcfcb1f90e03fde2feb1",
"assets/packages/paipfood_package/assets/flags/KH.png": "a0a3c87a6880694b16fbf2c8829073b6",
"assets/packages/paipfood_package/assets/flags/SY.png": "0a539fcd01717e7b93601acd66aebe17",
"assets/packages/paipfood_package/assets/flags/SN.png": "21a044d06e6a4b924dc945a236235c6d",
"assets/packages/paipfood_package/assets/flags/PW.png": "f7ae371f21981868c9275a999cb0f251",
"assets/packages/paipfood_package/assets/flags/SL.png": "a643ac16b9e2657d74b520c0aa1c016c",
"assets/packages/paipfood_package/assets/flags/FM.png": "9dc100e23be1e50f17b909689f1dfc37",
"assets/packages/paipfood_package/assets/flags/GI.png": "c7c11c9c105a49030b86846af9871fa8",
"assets/packages/paipfood_package/assets/flags/DE.png": "a2b53bbaefa33eb0254ed105afd8d780",
"assets/packages/paipfood_package/assets/flags/GH.png": "f17905208550832b4a4a54cdab0a90ae",
"assets/packages/paipfood_package/assets/flags/JO.png": "0074f9cce87e637ce54875c725fda070",
"assets/packages/paipfood_package/assets/flags/IT.png": "b73af83bd38c0ab643d74d450418cd4e",
"assets/packages/paipfood_package/assets/flags/PA.png": "df1eba9ee8f29f62ab881a11c6a12d7e",
"assets/packages/paipfood_package/assets/flags/SZ.png": "639215b22c6d77ba00fc207849c12cca",
"assets/packages/paipfood_package/assets/flags/SM.png": "b7275cd318fc73b92dda2cb03da4f1da",
"assets/packages/paipfood_package/assets/flags/TN.png": "bcd5b049960eb213359aad48079be866",
"assets/packages/paipfood_package/assets/flags/ML.png": "a613ed3c37d1a97cbc096ba3b2e4cabb",
"assets/packages/paipfood_package/assets/flags/CG.png": "5bfe9de546b9816bef21db8fc10004e7",
"assets/packages/paipfood_package/assets/flags/AX.png": "9e87db1b5a40273ad23195a6a17d16fe",
"assets/packages/paipfood_package/assets/flags/AO.png": "f1996a55b0ecfd9f36be512a7eeef5da",
"assets/packages/paipfood_package/assets/flags/BT.png": "e47b331544f89f8d528cd9d66e0041c5",
"assets/packages/paipfood_package/assets/flags/BB.png": "cd563fed7b7e5a364fafabcfbadea710",
"assets/packages/paipfood_package/assets/flags/CF.png": "3a54dcf2c63fb9db31f7f02f25f7cf8d",
"assets/packages/paipfood_package/assets/flags/MM.png": "cb32abb56b4c935e5f46150f2a36f2f4",
"assets/packages/paipfood_package/assets/flags/LI.png": "be5fe6badab8ed75bb1a8a2303614261",
"assets/packages/paipfood_package/assets/flags/NA.png": "5365f4cbc8ec5349a8ee38f6946ab60c",
"assets/packages/paipfood_package/assets/flags/MZ.png": "50d688cb9447019cae7bdaefd909141f",
"assets/packages/paipfood_package/assets/flags/TO.png": "deb0ee4131abc0f1560034b82510fb0e",
"assets/packages/paipfood_package/assets/flags/VG.png": "fd10c680a492c1f3465fc4bf18f0f720",
"assets/packages/paipfood_package/assets/flags/VE.png": "8dcce09718e1042fb6f4d3f92bc988f0",
"assets/packages/paipfood_package/assets/flags/TZ.png": "6f1fb501e32b5818ba3a40dd95bb166f",
"assets/packages/paipfood_package/assets/flags/TM.png": "1b42f6003d73365cf11dd9d5eb5c8f81",
"assets/packages/paipfood_package/assets/flags/MX.png": "7d167fc3df2132f015b8345a94567ea6",
"assets/packages/paipfood_package/assets/flags/NC.png": "9ffe6fff07ac97247dbdf45feb210e55",
"assets/packages/paipfood_package/assets/flags/MO.png": "600ef6ed3e8bdb3d954b8f57a7d6390c",
"assets/packages/paipfood_package/assets/flags/LK.png": "6d2c387154aaf9b25913c68727700972",
"assets/packages/paipfood_package/assets/flags/CD.png": "cd08c4cd45d8971e62ac71625c7dfe1b",
"assets/packages/paipfood_package/assets/flags/AL.png": "79a5c342483dedade12fff285fe413c4",
"assets/packages/paipfood_package/assets/flags/BW.png": "7f17cc9ae818b5c1b489f39f3ad2d55e",
"assets/packages/paipfood_package/assets/flags/CR.png": "3a5a77e36f887e4f980def50d68d8223",
"assets/packages/paipfood_package/assets/flags/BV.png": "525ea81421774266b9a6b8353b13be29",
"assets/packages/paipfood_package/assets/flags/AM.png": "b51d93edc810485da197bdb216db8461",
"assets/packages/paipfood_package/assets/flags/AZ.png": "1083dac668f748bc4b1eb7e88b2ccc6b",
"assets/packages/paipfood_package/assets/flags/BA.png": "c835fe8a9992f73c72d686b9b327497c",
"assets/packages/paipfood_package/assets/flags/MN.png": "b17adf976d81653847ae83ffb2d80008",
"assets/packages/paipfood_package/assets/flags/NU.png": "6aa6a9e0d2148ecfd14d7cd7af62ac42",
"assets/packages/paipfood_package/assets/flags/MY.png": "440601e1302919cc496377058ce6cd96",
"assets/packages/paipfood_package/assets/flags/TL.png": "e093038238943e20a1cc4254acca40d2",
"assets/packages/paipfood_package/assets/flags/WS.png": "42af76977a34da0c8df3a1b0a58cf6f1",
"assets/packages/paipfood_package/assets/flags/TH.png": "6d368dc61c175df66abb7ffc1453b03b",
"assets/packages/paipfood_package/assets/flags/XK.png": "da4f3f5b9d83d6ad706e47907cc0a029",
"assets/packages/paipfood_package/assets/flags/NF.png": "9b06b8b55268c447a3cd38fe5aebd061",
"assets/packages/paipfood_package/assets/flags/LY.png": "a66f70bac580b72767a9dfa3a25753cd",
"assets/packages/paipfood_package/assets/flags/AI.png": "ece497a2e42c09c63fe94e23f4432e2c",
"assets/packages/paipfood_package/assets/flags/BR.png": "9be65c28c1e620d2443399f20c1ebffc",
"assets/packages/paipfood_package/assets/flags/CV.png": "db7665b42b9a3ff202065ed58992e72e",
"assets/packages/paipfood_package/assets/flags/BE.png": "e96f4c64fa070574506502a9981ad403",
"assets/packages/paipfood_package/assets/flags/CA.png": "bed0c937d3907cf204dcb9f2ceff888a",
"assets/packages/paipfood_package/assets/flags/BD.png": "b381dae3313d733b510ba7f4c02cf954",
"assets/packages/paipfood_package/assets/flags/CW.png": "33efaf5367b646e962826742e645e90e",
"assets/packages/paipfood_package/assets/flags/BS.png": "f4044258e78c5a3e6574ca8479e94f01",
"assets/packages/paipfood_package/assets/flags/NG.png": "2a484e6f9bc5861ce38cae3c03fcaea4",
"assets/packages/paipfood_package/assets/flags/MK.png": "fa313955cd2d651bd58d9c4001a482c7",
"assets/packages/paipfood_package/assets/flags/NP.png": "23882cc279098374f85135a99d4941ca",
"assets/packages/paipfood_package/assets/flags/VA.png": "87002ca2d02df09d1265fe5abeed8bcd",
"assets/packages/paipfood_package/assets/flags/UZ.png": "1fe1d684ab625ff6c9c05031cbac2b94",
"assets/packages/paipfood_package/assets/flags/UM.png": "31056cd794f711a2deb75210b0f5c360",
"assets/packages/paipfood_package/assets/flags/TK.png": "c593c1b4d4ae0daa3eaa74cbe611689c",
"assets/packages/paipfood_package/assets/flags/VC.png": "d63655d02d4b7a9eabb235371d7def2f",
"assets/packages/paipfood_package/assets/flags/ZW.png": "4cf48c3b22c09435982cb6e7e1c54a66",
"assets/packages/paipfood_package/assets/flags/NR.png": "5832a7417f7dfbc84ba0e8c53ca2c806",
"assets/packages/paipfood_package/assets/flags/NE.png": "29d50e669af73710dc0fcf2176eb72c7",
"assets/packages/paipfood_package/assets/flags/CU.png": "6e9cbd87eb22d532be9b688c1481e700",
"assets/packages/paipfood_package/assets/flags/BQ.png": "6a2feb5cb0105fc2c8dadf8a3fc086b7",
"assets/packages/paipfood_package/assets/flags/BF.png": "9aa175a3b59b0212555cebf4f8454c23",
"assets/packages/paipfood_package/assets/flags/BG.png": "2dca83b7c6ab124c22be942969db3923",
"assets/packages/paipfood_package/assets/flags/CC.png": "a721180a182d6449c011c4228208c3eb",
"assets/packages/paipfood_package/assets/flags/MH.png": "c4022403a7bc17836bb4756bc7ad6e68",
"assets/packages/paipfood_package/assets/flags/ZA.png": "e444176ae31f23f2d485cb44a5177a49",
"assets/packages/paipfood_package/assets/flags/UY.png": "613479d571f701d1e45ef93b83fb8f12",
"assets/packages/paipfood_package/assets/flags/WF.png": "cad080acbad5acf60bb8ee59f5576dd6",
"assets/packages/paipfood_package/assets/flags/VU.png": "c476f26657e62d26e0ac50e71e56a76d",
"assets/packages/paipfood_package/assets/flags/TJ.png": "f211317fd77fe665340a56e4d812e442",
"assets/packages/paipfood_package/assets/en.svg": "3e487ac0040f4f9dfce29374a7dbd9a7",
"assets/packages/paipfood_package/assets/lotties/lottie_download.json": "6d084560f3511c41aba9e457f62f655e",
"assets/packages/paipfood_package/assets/bg_empty_state.svg": "c8649c3bf4085764fb6e5b87b635687d",
"assets/packages/paipfood_package/assets/pt.svg": "5b1eab48ed167e4cd2e244df06589987",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "6ebc7bc5b74956596611c6774d8beb5b",
"assets/packages/hugeicons/lib/fonts/hugeicons-stroke-rounded.ttf": "85511f0673daae174f9e9f28a9e0c86e",
"assets/packages/flutter_breakpoints/assets/demo.gif": "855dc91376ba541f079c96ca7ffa1de6",
"assets/packages/lucide_icons_flutter/assets/lucide.ttf": "09ceef8f7467f518c11ff9297543dcdd",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w500.ttf": "7d9aea0ec0eb3e6cd76124b50d1ae83b",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w100.ttf": "555caa3e6592639cd4b76b60f9bb4995",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w300.ttf": "904024f5104e1316f350484ff64d9396",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w400.ttf": "018c3b90a34a3cb086be1759eec35c20",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w600.ttf": "0e6707d57a50f57349fba3c9aa22738c",
"assets/packages/lucide_icons_flutter/assets/build_font/LucideVariable-w200.ttf": "8df6d1bf4050204dcb0b66fb1f2baf6c",
"assets/packages/shadcn_ui/fonts/GeistMono-SemiBold.otf": "02036797116901c5db4a3a629561e588",
"assets/packages/shadcn_ui/fonts/Geist-UltraLight.otf": "b64b37fbec0a925067cbf530e4962fec",
"assets/packages/shadcn_ui/fonts/GeistMono-Light.otf": "92c6dfb1c2854b6b0fd3f63ab5af9b7a",
"assets/packages/shadcn_ui/fonts/Geist-Thin.otf": "8603d0fe0def4273ebeee670eedcfb86",
"assets/packages/shadcn_ui/fonts/Geist-Bold.otf": "d3e1d3dc690224fd330969af598a9c31",
"assets/packages/shadcn_ui/fonts/Geist-Black.otf": "cf003c4f85b590cf60bec1e111ebaaf5",
"assets/packages/shadcn_ui/fonts/Geist-Regular.otf": "4d02716b4f2f2e4d9c568c8d24e8e74d",
"assets/packages/shadcn_ui/fonts/GeistMono-UltraLight.otf": "45ea4a4ba1034f7fa081c8b7ee958734",
"assets/packages/shadcn_ui/fonts/GeistMono-Thin.otf": "cbf62a8e76578e03404b0314787d9477",
"assets/packages/shadcn_ui/fonts/GeistMono-UltraBlack.otf": "cfad4eb45ce5dff853a6c84c8a7d441b",
"assets/packages/shadcn_ui/fonts/Geist-Light.otf": "21f434e8c2b53240a0c459b9d119f22f",
"assets/packages/shadcn_ui/fonts/GeistMono-Regular.otf": "42af0dfdb5e9e272e7ac28868b5b99fb",
"assets/packages/shadcn_ui/fonts/GeistMono-Bold.otf": "fce632a1c87f36e92fb23ae5618176ce",
"assets/packages/shadcn_ui/fonts/Geist-SemiBold.otf": "2c0b1d3e7b1c71bedc2eecf78f7a1d1d",
"assets/packages/shadcn_ui/fonts/Geist-Medium.otf": "f7ceaf00b58d396cf93ff1ea43740027",
"assets/packages/shadcn_ui/fonts/GeistMono-Medium.otf": "b1f17a06e50fba3f1e9695c2a8ae0783",
"assets/packages/shadcn_ui/fonts/GeistMono-Black.otf": "d72857791f93bbf88629ab9601ebfa14",
"assets/packages/shadcn_ui/fonts/Geist-UltraBlack.otf": "f3591a030925294b2bb427e6a6c9b0d8",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/l10n/app_pt_BR.arb": "d29a6ee600ca894c3d007c89dfa2944b",
"assets/lib/l10n/app_pt.arb": "ca134819d9f23d0cf65bf96148cb6eea",
"assets/lib/l10n/app_en.arb": "668a7ffb406b3b1b77cbee927165fa4b",
"assets/lib/l10n/l18n_extension.dart": "668eb313e387f951f2c1c7c74d25bfca",
"assets/AssetManifest.bin": "c705f950c5f8adad8af7c965357125ab",
"assets/fonts/MaterialIcons-Regular.otf": "8e975932a8b821a310da71188c52f592",
"assets/assets/images/error.gif": "6f6a838e6529afe7b5698c8028f7b2b1",
"assets/assets/images/login_image.jpg": "cc338e81b5dc5fb5ba13c8813d24862a",
"assets/assets/images/shop_3d.png": "8579d36bbb3109eafa37f7528e18e7d0",
"assets/assets/images/logo_dark.svg": "f339797e212df565466ea86a92d987b9",
"app.js": "8bbbe11197e5ba53cb0491d3cddcc7ee",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

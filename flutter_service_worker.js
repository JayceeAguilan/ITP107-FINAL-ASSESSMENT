'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "813d741da31e997ff950474ef6915536",
".git/config": "ccdd1424b9f62712e377341438cb893f",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "bb52979615017ec8c36411a475d2fd9c",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "36effc148d922753231c5a0c1d13f49e",
".git/logs/refs/heads/main": "345c9fda9903609313be0aef8abb0f02",
".git/logs/refs/remotes/origin/gh-pages": "a9fd65d72c1fb30cd6a15df1596dbd6b",
".git/objects/02/1d4f3579879a4ac147edbbd8ac2d91e2bc7323": "9e9721befbee4797263ad5370cd904ff",
".git/objects/06/5a156ad876ae75d08bca0aabc8c1e01f285abb": "1338ac20d12542d14345378e2fe2be26",
".git/objects/08/d738e71aacc014bd5ddd72a193c90d7cab41d1": "e43fbd3f72d1aa5b3baa337ba6db8e73",
".git/objects/09/c3589a34c1d97ca8c67ab17ff142f1e211773b": "9a8d5aeb1a9146d153e683b3789a94ec",
".git/objects/09/dd22a154d791ee3a977edd277a18b3cb4c365b": "c9da37fd344454e22f45cfb2c7ff79d2",
".git/objects/10/fb6d292a8c12739ff4cbb3404268f71fe4bd16": "f819170c92b7fcc166707be14857d4ef",
".git/objects/13/28eb7d09632e74145dfa74d2ac591c6ed01e0c": "009c2a2b3fd29fc5aaa47b335d68a6c8",
".git/objects/16/894781fb95ad2030c5c18f6685c572fda24fdd": "3a48860555839497b1a4ed2405f2bab1",
".git/objects/1b/e4ef80dccccbaf0a91d4e22a055ceed376255c": "630bf902133f36ae493e1e9d9c4b7dd0",
".git/objects/20/3a3ff5cc524ede7e585dff54454bd63a1b0f36": "4b23a88a964550066839c18c1b5c461e",
".git/objects/21/769da011c782b2416e356c27a3b30a2a62379b": "18aa86029ceaad852e32ccdbc886dad9",
".git/objects/24/933e547330df5bb735682254a4f517e275e0da": "b9295f6e9fe5dc5c13f4624950630be2",
".git/objects/29/f22f56f0c9903bf90b2a78ef505b36d89a9725": "e85914d97d264694217ae7558d414e81",
".git/objects/2c/9754fcb446710183b67f0c6e8b3666fd1f092d": "1434b1e38a4d0532ede12886a2526a57",
".git/objects/2d/0471ef9f12c9641643e7de6ebf25c440812b41": "d92fd35a211d5e9c566342a07818e99e",
".git/objects/2d/892c9f393d822a4ca9ec1c9ec9ef70d7f2ab07": "b8352ee5fdeab9b6b93440575e5980f6",
".git/objects/31/329a86b0a7d4bde89bb97b151bc204c2a2ea9c": "9cea24a58c9507073f0a195f973ec702",
".git/objects/34/e6bc69f487c4bc1b8e9decbdfd82eb56bd7487": "47cdc2842dbfb60e31352732daf55687",
".git/objects/38/cf31b0d4ceb7bf931580ce0eae8bccf4dbc819": "61f7fc6346b03e924eacc089b0a6853c",
".git/objects/3b/b0860a0981211a1ab11fced3e6dad7e9bc1834": "3f00fdcdb1bb283f5ce8fd548f00af7b",
".git/objects/3d/13de1fd7a83b1c818bf8320322ded2f2b9c750": "ec5a2019e30b5d5d18104285a3a9e0f4",
".git/objects/3d/dbe9c78d2658bc3517d7e13b13a466b80dd1be": "57e6eabe3c31ed6adc1cabf6979e0f8d",
".git/objects/40/66750a86ef6f695338b55c529a5aa15a1ff060": "994debfb50c67a04a64cd0b46ecc077e",
".git/objects/44/28f91b84d2837f2069a256ef2bc81dc5529d44": "1a60f29ce16fc1fb0234b5a10e65a806",
".git/objects/44/bd08629db0f77f7495893f12d4f06a0e535ca1": "cf95e0522efe1f1dd9bfa62d4f669c14",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4c/070ce32dedb330ef92a5516221d2b30d3aef8a": "06b2c6bed96bdb74a3e6810a973ee45b",
".git/objects/4d/bf9da7bcce5387354fe394985b98ebae39df43": "534c022f4a0845274cbd61ff6c9c9c33",
".git/objects/4f/e2ab98fd86db0693ea0c3c9a613e403f5bfc69": "4f995e5fbfab8f4584b53b6a1fa96f7e",
".git/objects/4f/fbe6ec4693664cb4ff395edf3d949bd4607391": "2beb9ca6c799e0ff64e0ad79f9e55e69",
".git/objects/57/1ebd9ec36c59b546f63d841d78458755115812": "f878f08ba1f4c72778265f6fea7ae5aa",
".git/objects/58/6c4d6fb8d43eeddeee971a50a3810491acacb6": "ef2df45c1380859e4f525ffce64efddb",
".git/objects/59/61e29c579e6cd6a6d5db9e8f465daec5722b73": "9f1b8a69fdeac03a9dbcfeb337f976bf",
".git/objects/62/053788d2695d3ca718c1ee5b042cc286e4c895": "3abf3cdb5b0c92317163c64a3b921b03",
".git/objects/63/d515559a833d05925e5f3ead8d11299c8ec6bb": "ae5685963946597f110c1de3de6d6a7c",
".git/objects/67/35f1211eeb287fdc061854a6818f0a2b19b1fe": "4dc7543dc78c02fe2aa0d7c0bd2721d8",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/6d/129440ce5c328f82d48d9bbe9292ec19b407d9": "ed169de32b666e78f45bfda1c350ee4a",
".git/objects/6d/9ffc6da133b86d46f65c09854940af37981435": "ec190bfc572dbf084df80fbb8a10c298",
".git/objects/70/7f2c5e9a1cd676c41accd983d6a918552f3968": "c0b57f95b546e5312e9ed452c8ee5fa7",
".git/objects/70/95aab4d6710115c6d4eeed51b08f9ff08569f0": "a035efc1579487db10d47eef58e3b29a",
".git/objects/74/1c01f303ac8ea54bcd9864447d1d3ea39604a7": "6bffc6034ba3fb11a365ba96d69adc22",
".git/objects/76/666042c780cbc902e97f7b322bbfdf8d161401": "ef5fc04f996468869836ddbd557299c9",
".git/objects/7a/6c1911dddaea52e2dbffc15e45e428ec9a9915": "f1dee6885dc6f71f357a8e825bda0286",
".git/objects/7c/815e98a581d882424471aad2952cfba8f1f4cc": "300c0115c323ae60a3f6504ee95f147e",
".git/objects/7c/976ef99c971aeca3623d67f71e4323054113a2": "b519a59393fd2fdfdea7156ba7777a22",
".git/objects/80/73486ff3b4aff9052e6d098192e9bfadac13fc": "83783453d62f5c7c9ea8a4ebe845461b",
".git/objects/83/2c5d26a0fd02d8b0c3e79ea9cc96d562ab2f31": "3f9509542d94b1f958772600bd07e789",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/89/8c49062dcbf4dd66241331d192a0d0fb91c25a": "ae242b259a948d3c668a4b1987b80196",
".git/objects/8a/9f1b9c55d791bd0edde6af1a1da43c2ba82c78": "eda321c9a53cfb4060c9a02eb490092c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8b/484c2af536e423b54db460c201ac8afb3c1e5e": "ca9d4d0402e879ccae4353758ee5de50",
".git/objects/8e/f6e6724a6c2db1b50952b06a0dcc41861b9774": "d67cbc310fbd00128755635077969590",
".git/objects/90/2444e5e2dbd9ced27ff81d93581fc088697edb": "56f61503fa560e166eafe0e20a640825",
".git/objects/92/e188aac758e74a616000f6741fd673501f2f73": "d0554c591295fc2d4f3de12450ab2126",
".git/objects/98/0d49437042d93ffa850a60d02cef584a35a85c": "8e18e4c1b6c83800103ff097cc222444",
".git/objects/98/deebf4705a81851c58a5738ff308883c3c628d": "d8e89f1222574bcaf0358b6e03f5f7e6",
".git/objects/9b/3ef5f169177a64f91eafe11e52b58c60db3df2": "91d370e4f73d42e0a622f3e44af9e7b1",
".git/objects/9b/b39ed1204a992a3205a0424b77a39cb85ba675": "bbe13a6f5f698eb12d5d9f3169186e94",
".git/objects/9c/6218228378c9d968ee58dfeedc6df829b396d3": "9b6675e86dcea3bcfaf0a7f90450f990",
".git/objects/9e/3b4630b3b8461ff43c272714e00bb47942263e": "accf36d08c0545fa02199021e5902d52",
".git/objects/a7/affa715b91382c81de830d2103b565d961ae06": "8cfde63b72121d9f3893eb01f52e296a",
".git/objects/a9/ed0fb0190138e4bce5451abd647578fade90b0": "f1089cfb9e08dd457736548a19968fa6",
".git/objects/aa/e732d5b8f58347da211db6778f77fc894dd56d": "a855db90e5b4782a2ff737bd6d6e6213",
".git/objects/ac/70f9a07230acdb9acffdf1ac9681c04d79b985": "c94877c851ed8f49f268831652c471e6",
".git/objects/ad/af4c117f5bad40aff2c21fd159a2cae09ccaa4": "3168bc8961942ff2aaef43b26c3d9bda",
".git/objects/b5/c3ff68187ccaa2b007a20875366b29190055c7": "5091117043d8850ab1a1fc384348a173",
".git/objects/b5/dad100cc4d95e0fa66c2b98845508931578432": "21c1b82de5b8cd646a72a72df9af28fa",
".git/objects/b6/b8806f5f9d33389d53c2868e6ea1aca7445229": "b14016efdbcda10804235f3a45562bbf",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/bc/62df047df3a5f7bb3ee32d200d3d51c14db481": "609d2a094cb4dbf3eb39f177a5bb7eeb",
".git/objects/be/d3f2c8a9ff7001583c72acfebd64be54db6509": "ff796235c528fc3b63038052e0c69f27",
".git/objects/bf/4782ab3cdc06aeb8388e711f9c84cfcf793f33": "4e421f12637770c54c50f74e4a6177f1",
".git/objects/c2/92e3ff0ab454112ed079188834fa43eeed7876": "945e9190226f43aeaa9436ecf695d447",
".git/objects/c4/016f7d68c0d70816a0c784867168ffa8f419e1": "fdf8b8a8484741e7a3a558ed9d22f21d",
".git/objects/c6/03e0d45d6189e168e36ce213bfa2a61b39e2a0": "85565722cca73cb1bb12523e06257900",
".git/objects/c7/7663172ca915a99a594ca17d06f527db05657d": "6335b074b18eb4ebe51f3a2c609a6ecc",
".git/objects/c8/d61649cee7358eb67fe37ef84934efb0bb6cf4": "eeb9a4e1f1e67cc8c4fe631222b5e26c",
".git/objects/c9/8f410efd4a740df07179cb606e190a378b34b1": "1c28a658dc1cf70509e03eaec07e6879",
".git/objects/ca/3bba02c77c467ef18cffe2d4c857e003ad6d5d": "316e3d817e75cf7b1fd9b0226c088a43",
".git/objects/cb/0e6561ef78fef4e6638816922a39f35a87d764": "f74ccff4a2a0b989ec28d33b1e3a07e5",
".git/objects/cd/f0f4e5b6df709bceec51e94f5340c0d9fb4d82": "8f0d2a825d1e4d83f163c9d0f83dabdc",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/d7/f538566a13d92a7825879a2d4c000ef078e6de": "482013947841a7600ac85964b9f1a90b",
".git/objects/d9/58e90beadf8708416789ae265889af7bd7df5b": "82523a270259bb98e8612e01813d3719",
".git/objects/de/f20e39fd1b1e3cb2f08dd665d70f2786f80d10": "089a0e7249dd1ad7da4f102fa10ee7cc",
".git/objects/e3/e9ee754c75ae07cc3d19f9b8c1e656cc4946a1": "14066365125dcce5aec8eb1454f0d127",
".git/objects/e4/1877eda94de858200150497da5bee2ec22fdab": "d6bde315a0c32a4529e5e9b300ae3d52",
".git/objects/e4/65d40a8515b0e4f1bf064a5d5794b010a81c49": "95ddb96ce4177930df34dfccff43f736",
".git/objects/e8/137a9dccb52bf2945bcefeaeb7d622751dec14": "4e967650b815b307a20202747089b8d1",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/4f22124c9e4fd5b8283ec1ef1b1ba2a765292e": "c5869541ba9e8284f375c56bef75d2fa",
".git/objects/ed/5df8a5274b589657f375a34f780a0464dd3ed6": "cf3b63b9a6a2e3284469453d83644a49",
".git/objects/ed/b55d4deb8363b6afa65df71d1f9fd8c7787f22": "886ebb77561ff26a755e09883903891d",
".git/objects/ed/de959e520954faa2fae7ff7151411360ebd906": "172098f0c9a7d5567393e04e2ef5a352",
".git/objects/ee/aa837b0b4d20d8ba5a1b0d2964404a5c19316e": "84425ea4a13d2cbbb377265b7307eff8",
".git/objects/f0/126112fae8926c28242f397fe4eed96def5655": "2d9ab0ff2e4e9c7ae0b60c9a6ece4839",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/959857ae1861e9dce03c09f501aa639ac805d4": "289605c86bff9965db1b8ae923b4dbd0",
".git/objects/f4/e9b7565a2f4c6b3323e01b94ae79c5618d0fe6": "6734cce395864377f440d61782b0031a",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/f9/0dedf8cfb3a5257cce322392fe98c3afd496b4": "1f6f770bb44dccb5ec64a884de759a87",
".git/objects/fb/01ef04e2776f27a3c4c7fd534f74d0813b9144": "76602261c4ceff240dad2414c73e6678",
".git/objects/fd/b55ab87da16e3a8709a6be07b15e65be5ed30b": "5bc74684878e89d7d80f688fab2d3fc8",
".git/objects/fe/3b987e61ed346808d9aa023ce3073530ad7426": "dc7db10bf25046b27091222383ede515",
".git/objects/fe/a65efc52b16ff72b801f30cd6c04d2d6e01803": "ffed57fb54eaa376a55d1ef448a90ab5",
".git/refs/heads/main": "95a83204af8c5d0ec3e7ccb806c4ed12",
".git/refs/remotes/origin/gh-pages": "95a83204af8c5d0ec3e7ccb806c4ed12",
"assets/AssetManifest.bin": "a02b3d2dc4a2fa2cfeabb61e21c83c46",
"assets/AssetManifest.bin.json": "c3ac95160242f8248573ab30e1cb31ff",
"assets/AssetManifest.json": "55a39c6e9cc70ebbe7ad67d65019bcb5",
"assets/assets/images/aly.jpg": "0cf9b9f3c393218ad7bca47a90325fb6",
"assets/assets/images/haidee.jpg": "a79a947782c009812313ba14d888fc4b",
"assets/assets/images/joyce.jpg": "7ade2fb5362311d50c1369b134252c17",
"assets/assets/images/king.jpg": "b2a2acb685a4482a7444202a7a22f436",
"assets/assets/images/kurt.jpg": "d87b9f67e1216baf66bb37c760fd61d9",
"assets/assets/images/mary.jpg": "ef0fcc2a0e1940bb653c232392dec1ab",
"assets/assets/images/profile.jpg": "d31a33f79a643617cb1a76ad7f71d83f",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "567b4aae201fe10c02b489d60cd10adb",
"assets/NOTICES": "e340da516f2b0e7fd58125ce2b19e64c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "d7e79115dc20db79a1acf44a608c1d20",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "1b01451669857cd27ba6dadfb9a8b4c5",
"/": "1b01451669857cd27ba6dadfb9a8b4c5",
"main.dart.js": "11bd1b57db2138bf84c6264431185842",
"manifest.json": "4765df2891a6ebb86b08c63c8999143f",
"version.json": "5cd12675fabbf11779100b2a0f37b5b8"};
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

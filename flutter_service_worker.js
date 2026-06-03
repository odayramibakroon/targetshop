'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "72286fe87c4fa5a8a5165530c8b1409a",
"assets/AssetManifest.bin.json": "52ab84063b49ed767e00186c0a9571a6",
"assets/AssetManifest.json": "08fa427f622014b1ffba139490baaee6",
"assets/assets/fonts/ar/NotoSansArabic-Bold.ttf": "441ecf2fddbed1dbc214e8c9cba21b58",
"assets/assets/fonts/ar/NotoSansArabic-Medium.ttf": "716f85d4ee1b67c289ea2dc1d0ad7632",
"assets/assets/fonts/ar/NotoSansArabic-Regular.ttf": "9312b42d104b5903a29b24a65a77933b",
"assets/assets/fonts/en/Roboto-Bold.ttf": "dd5415b95e675853c6ccdceba7324ce7",
"assets/assets/fonts/en/Roboto-Medium.ttf": "7d752fb726f5ece291e2e522fcecf86d",
"assets/assets/fonts/en/Roboto-Regular.ttf": "303c6d9e16168364d3bc5b7f766cfff4",
"assets/assets/images/app.png": "fa19054f161143bc46e2f994c23058ff",
"assets/assets/images/applogo.png": "6dfa3666641b5cb9b524b48ed756847b",
"assets/assets/images/backg.svg": "d26ec9e53a8d505b95468169d6e26ef0",
"assets/assets/images/carrot.png": "89465a6bf2fb971e298b4025923410ee",
"assets/assets/images/circle.png": "1f0ad4f86bdca3f9cc7ada597cdf1c93",
"assets/assets/images/crt.png": "5d98b1337b94880be949525fe62a6cce",
"assets/assets/images/doodle_bg.png": "da70de0e59507a5f3ea7c9045e7d3f86",
"assets/assets/images/img1.png": "15bdea56cf3c3d36a1037b7dc752e61b",
"assets/assets/images/img2.png": "98af4b4ea55b11bebcb8ce291a8153c8",
"assets/assets/images/img3.png": "a1d59197bf5edbbfcb9b9397f64b6a28",
"assets/assets/images/img4.png": "7b2cf2cee76984233ad07b76ec4ed142",
"assets/assets/images/imgp.png": "c0b6244950821400107696cb457299e7",
"assets/assets/images/imgprofile.png": "36d0ccf318545a98d8481e5255de7c62",
"assets/assets/images/item.png": "96e808446094b63293e912717d4609a6",
"assets/assets/images/item1.png": "60847bdbee91a77460b2f88cd7b5cb90",
"assets/assets/images/item3.png": "ca7ea7097dbc3a9bae236508d0cbc8d8",
"assets/assets/images/item4.png": "94f446f6f80ef274993f57393853ac03",
"assets/assets/images/item5.png": "cc0bf39296be65a043f1003b56401cda",
"assets/assets/images/pageone.png": "317913118529dc7f7381331432044ee4",
"assets/assets/images/pagethree.png": "317913118529dc7f7381331432044ee4",
"assets/assets/images/pagetwo.png": "0f892a534b6f38f2b4df9cc937dc7b20",
"assets/assets/images/splash/whatsapp_dark.png": "5a6a35367797887c5c020acda979f9ab",
"assets/assets/images/splash/whatsapp_light.png": "2e53b6516d7baf50ffaaea8641c1c09a",
"assets/assets/images/spr.png": "db521f5e7759ea452faeb034dfce73c8",
"assets/assets/images/verifiedaccount.png": "d994593a9299a1f24b5a8cd0e95d452c",
"assets/FontManifest.json": "49a866c3e91d5f0974b044907e42d436",
"assets/fonts/MaterialIcons-Regular.otf": "2b6443694d29041b6ef169af9ecfca77",
"assets/NOTICES": "085816a7658c74ac6ac8e9665a7ff503",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
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
"flutter_bootstrap.js": "7ca89a4880d90113dc906197a8f17d7c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "3ba5b52fac44f4a6dc2e3f7696445f0b",
"/": "3ba5b52fac44f4a6dc2e3f7696445f0b",
"main.dart.js": "04826fe1e21126208230326a02f68855",
"manifest.json": "cacf7154edf9f30cfc5f539f3f337ced",
"version.json": "0d1c61083d5d00a8a34778987b363b7d"};
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

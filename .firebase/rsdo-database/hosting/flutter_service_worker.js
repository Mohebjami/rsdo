'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "d116db9380e0c32e33576ecdf06079ed",
"assets/AssetManifest.bin.json": "df22ca8a8ae5dce2be990acf54e69c83",
"assets/AssetManifest.json": "42065d0c2bb0af07e520afc4a7b640f4",
"assets/assets/admin.png": "b7ecf80871abcc96f9ec5cb41b4563c8",
"assets/assets/analytics.png": "ccd7d9d05c40e939a141456008f7c336",
"assets/assets/Client.png": "8396d1ca4d57921d4801039b5eb4ee7f",
"assets/assets/Clinet.png": "b4419deb68296570642a517837b1dc8f",
"assets/assets/database-table.png": "f31dde5d5662ae951938ded18fd3b9fa",
"assets/assets/database.png": "28921be2e22e3977e1b3aed9a77afeaf",
"assets/assets/download.png": "0d6b57be9b9deda2b9cc4b21bcfeb571",
"assets/assets/henrique.jpg": "11fe3746f89335227dec224f73683d7e",
"assets/assets/logo.png": "0b98042feedcc89dd4d3adb6991d66eb",
"assets/assets/no-wifi.png": "0289c3d0b6f5abeaefab6d057f014284",
"assets/assets/paid.png": "91895c401e7f0ea79a27ec19724be63d",
"assets/assets/project.jpg": "a4c942d21966c193c012642d7c4f41b7",
"assets/assets/recycle-bin.png": "44d498a48f2c24ab9f7165bc901b97ef",
"assets/assets/senddata.png": "35a008b6744efa962cf981db4c8abd85",
"assets/assets/surveyr.png": "1c68649bb9b661b81b29218ec43d8899",
"assets/assets/test.jpg": "7aecc3890041f6945f68ba6122ca9e88",
"assets/assets/trash.png": "e3ee50b7b8406b5f0c0bd1b6dd4db053",
"assets/assets/upload.png": "488a756eafc781e829bd893da230b409",
"assets/assets/user.png": "e9ace2e2dac30ed544ae393f52a0a0e0",
"assets/assets/welcome.jpg": "8880112a61b5997da9e0dcbbf0485ce1",
"assets/FontManifest.json": "547bb5d8266c5a2e140db2749d7e689c",
"assets/fonts/LibreBaskerville-Regular.ttf": "fac7df0a4714aacd0bfbca6cf57a488c",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/MaterialIcons-Regular.otf": "391a1cce556457b987619e65f1e77f0e",
"assets/NOTICES": "04641a1c6b235c4270589aa40a3194b6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "7737f5fc722b6a040ac15271ea8d92fb",
"canvaskit/canvaskit.js.symbols": "c5efe8c4c528c87d6d3b89998f3916c1",
"canvaskit/canvaskit.wasm": "6812ea43965530e949b9b74209d49969",
"canvaskit/chromium/canvaskit.js": "2f82009588e8a72043db753d360d488f",
"canvaskit/chromium/canvaskit.js.symbols": "8aee53b6c2f3937ec2e6b52fe0b63c88",
"canvaskit/chromium/canvaskit.wasm": "ab07fbfc0e3cb4c6778d791ca5951048",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "c2a129b5ada256d1eca56a94fd851c43",
"canvaskit/skwasm.wasm": "896b91d35d8069237ef09954668ebf06",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4af2b91eb221b73845365e1302528f07",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "df48bb1aeb311820a468ba636ffd2945",
"/": "df48bb1aeb311820a468ba636ffd2945",
"main.dart.js": "c5033d8e4e0cbd3fdd40224f32ea0592",
"manifest.json": "41111e77f5a4bc42273b6131a5dda33d",
"version.json": "e64af5e8d0fa4530937c16ed2a1207ab"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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

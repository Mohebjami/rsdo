'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "c565a21ba8ede5154e792e9c1bf15ede",
"assets/AssetManifest.bin.json": "823142bb088f88a166b289547d5fc742",
"assets/AssetManifest.json": "6161ec22c1858426206e3c0fda7cc1d0",
"assets/assets/17.png": "5ddf4dfa30eb2a60000c55caab751e93",
"assets/assets/2.png": "ba4560c5eee94de476b17b0ec86f9c71",
"assets/assets/3.png": "eadd3c45cfb7f6721136e5000352e953",
"assets/assets/AdminLogin.png": "0642f3411320dcfbad68b7274e201a81",
"assets/assets/AlreadPaid.JPG": "cc49c21243160857ff94ae6d8bace355",
"assets/assets/henrique.jpg": "11fe3746f89335227dec224f73683d7e",
"assets/assets/icon/Add%2520admin.png": "96aa96e2bb5fd2281cc7a802672e3910",
"assets/assets/icon/AddDistributor.png": "bec4d69cca1b3f01045a0494a4b11017",
"assets/assets/icon/DeleteData.png": "fe84a2c4511ef79cc7e670f9d1d6d187",
"assets/assets/icon/DeletePaid.png": "06f3c4d468b6a8c8e1b4133121ec92e8",
"assets/assets/icon/Export.png": "66e65c26de16f1fa03134c4005ecc4d6",
"assets/assets/icon/Import.png": "d3201313c783dbee4482f642bf8a3aa6",
"assets/assets/icon/menu.png": "380a7a872efd266b7e0d729c4f3e3271",
"assets/assets/icon/SearchBeneficiaris.png": "bd853ea1407222cf38a3564e76cd9fe9",
"assets/assets/icon/SearchPaid.png": "9eb9cf5704ee6db5358e1fcdb9b7eded",
"assets/assets/logo.png": "b01f82abfefb621e69a5d441fe868f1f",
"assets/assets/no-wifi.png": "0289c3d0b6f5abeaefab6d057f014284",
"assets/assets/p1.png": "6b704be71d97e13c23d873a368e8c648",
"assets/assets/p2.png": "7d90d92f4cff9ff558e0b4001144492c",
"assets/assets/p3.png": "a5b4283662476641ab5cbf98334d69f9",
"assets/assets/project.jpg": "10523adff8480f974862bdb23e34aec9",
"assets/assets/rsdo.png": "8b558d8b769972176250466050f1efe6",
"assets/assets/SearchB.JPG": "ab0d5fe474720e4f0047980a75f99a40",
"assets/assets/searchback.png": "901818f822b81976764819bc2dc25fb5",
"assets/assets/seccsess.JPG": "b2396c435b55a729e8f9c948f3d2eca0",
"assets/assets/test.jpg": "0cfd4851cfb107d3f9bd029d9802292c",
"assets/assets/wat.png": "43e4ac64a7a7169b8a0e590b8518dfe3",
"assets/assets/welcome.jpg": "8880112a61b5997da9e0dcbbf0485ce1",
"assets/FontManifest.json": "fe3b049a4c81a1ff75503fa5ad4d07b6",
"assets/fonts/ANTQUAB.TTF": "714eac0421a6bdd26e69255776f0ffed",
"assets/fonts/BAHNSCHRIFT.TTF": "dcafedb1482e7a86e4c0c07f6b1dc079",
"assets/fonts/LibreBaskerville-Regular.ttf": "fac7df0a4714aacd0bfbca6cf57a488c",
"assets/fonts/LilitaOne-Regular.ttf": "ce83b4bfa37f53ea2a3fc97088af7181",
"assets/fonts/MaterialIcons-Regular.otf": "640357d5630b4db3efc481e7e9c2e334",
"assets/NOTICES": "69c1d210fb7ac98ab8ca7361e25f9b94",
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
"index.html": "b8b48e1b051d1829e43b46681a70f8b4",
"/": "b8b48e1b051d1829e43b46681a70f8b4",
"main.dart.js": "04df9ffa5036df49b58aa079e403aaa7",
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

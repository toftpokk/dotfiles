// My userjs
user_pref("middlemouse.paste",false); // middle click paste
user_pref("signon.rememberSignons",false); // no remember passwords
user_pref("browser.contentblocking.category","strict"); // strict content blocking 
// Sponsored Shortcuts, src:arkenfox
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.pinned", "[]");
// Pocket
user_pref("extensions.pocket.enabled", false);
// Data collection
user_pref("browser.discovery.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("dom.private-attribution.submission.enabled", false);
// Userchrome
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets",true);
// Transparency
user_pref("gfx.webrender.all",true);

// sidebar
user_pref("sidebar.revamp", true);
// sidebar visibility
user_pref("sidebar.visibility", "always-show");
// sidebar tools
user_pref("sidebar.main.tools", "history");
// vertical tabs
user_pref("sidebar.verticalTabs", true);

// alt to show top menu
user_pref("ui.key.menuAccessKeyFocuses", false);

// disable gestures
user_pref("browser.gesture.swipe.left", "");
user_pref("browser.gesture.swipe.right", "");
// opening newtab lets you choose containers
// user_pref("privacy.userContext.newTabContainerOnLeftClick.enabled", true);

// ARKENFOX disable geolocation
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_geoclue", false); // [FF102+] [LINUX]

// ARKENFOX disable about:addons recommendations (Uses google analytics)
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);

// Font
// Assuming default font Noto Sans Thai
user_pref("font.name.sans-serif.th","Noto Sans Thai Looped")

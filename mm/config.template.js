/* Magic Mirror Config Sample
 *
 * By Michael Teeuw https://michaelteeuw.nl
 * MIT Licensed.
 *
 * For more information on how you can configure this file
 * See https://github.com/MichMich/MagicMirror#configuration
 *
 */

var config = {
  address: "localhost", 	// Address to listen on, can be:
  // - "localhost", "127.0.0.1", "::1" to listen on loopback interface
  // - another specific IPv4/6 to listen on a specific interface
  // - "0.0.0.0", "::" to listen on any interface
  // Default, when address config is left out or empty, is "localhost"
  port: 8080,
  basePath: "/", 	// The URL path where MagicMirror is hosted. If you are using a Reverse proxy
  // you must set the sub path here. basePath must end with a /
  ipWhitelist: ["127.0.0.1", "::ffff:127.0.0.1", "::1"], 	// Set [] to allow all IP addresses
  // or add a specific IPv4 of 192.168.1.5 :
  // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.1.5"],
  // or IPv4 range of 192.168.3.0 --> 192.168.3.15 use CIDR format :
  // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.3.0/28"],

  useHttps: false, 		// Support HTTPS or not, default "false" will use HTTP
  httpsPrivateKey: "", 	// HTTPS private key path, only require when useHttps is true
  httpsCertificate: "", 	// HTTPS Certificate path, only require when useHttps is true

  language: "${MM_LANGUAGE}",
  logLevel: ["INFO", "LOG", "WARN", "ERROR"], // Add "DEBUG" for even more logging
  timeFormat: 24,
  units: "metric",
  // serverOnly:  true/false/"local" ,
  // local for armv6l processors, default
  //   starts serveronly and then starts chrome browser
  // false, default for all NON-armv6l devices
  // true, force serveronly mode, because you want to.. no UI on this device

  modules: [
    {
      module: "alert",
    },
    {
      module: "updatenotification",
      position: "top_bar"
    },
    {
      module: "clock",
      position: "top_left",
      config: {
        showPeriod: false
      }
    },
    {
      module: "calendar",
      header: "US Holidays",
      position: "top_left",
      config: {
        calendars: [
          {
            symbol: "calendar-check",
            url: "webcal://www.calendarlabs.com/ical-calendar/ics/76/US_Holidays.ics"
          }
        ]
      }
    },
    {
      module: "compliments",
      position: "lower_third"
    },
    {
      module: "weather",
      position: "top_right",
      config: {
        weatherProvider: "openweathermap",
        type: "current",
        location: "${OW_LOCATION}",
        locationID: "", //ID from http://bulk.openweathermap.org/sample/city.list.json.gz; unzip the gz file and find your city
        apiKey: "${OW_API_KEY}"
      }
    },
    {
      module: "weather",
      position: "top_right",
      header: "Weather Forecast",
      config: {
        weatherProvider: "openweathermap",
        type: "forecast",
        location: "${OW_LOCATION}",
        locationID: "", //ID from http://bulk.openweathermap.org/sample/city.list.json.gz; unzip the gz file and find your city
        apiKey: "${OW_API_KEY}"
      }
    },
    {
      module: 'MMM-SmartTouch',
      position: 'bottom_center',    // This can be any of the regions.(bottom-center Recommended)
      config: {
        // The config property is optional.
      }
    },
    {
      module: "MMM-Face-Multi-User-Recognition-SMAI",
      position: "top_right",
      config: {
        useMMMFaceRecoDNN: true
      }
    },
    {
      module: "MMM-Spotify",
      position: "bottom_left",
      config: {
        debug: false, // debug mode
        style: "mini", // "default" or "mini" available (inactive for miniBar)
        moduleWidth: 360, // width of the module in px
        control: "default", // "default" or "hidden"
        showAlbumLabel: false, // if you want to show the label for the current song album
        showVolumeLabel: false, // if you want to show the label for the current volume
        showAccountName: false, // also show the current account name in the device label; usefull for multi account setup
        showAccountButton: false, // if you want to show the "switch account" control button
        showDeviceButton: true, // if you want to show the "switch device" control button
        useExternalModal: false, // if you want to use MMM-Modal for account and device popup selection instead of the build-in one (which is restricted to the album image size)
        updateInterval: 1000, // update interval when playing
        idleInterval: 30000, // update interval on idle
        defaultAccount: 0, // default account number, attention : 0 is the first account
        defaultDevice: null, // optional - if you want the "SPOTIFY_PLAY" notification to also work from "idle" status, you have to define your default device here (by name)
        allowDevices: [], //If you want to limit devices to display info, use this. f.e. allowDevices: ["RASPOTIFY", "My Home speaker"],
        onStart: null, // disable onStart feature with `null`
        // if you want to send custom notifications when suspending the module, f.e. switch MMM-Touch to a different "mode"
        notificationsOnSuspend: [
          {
            notification: "TOUCH_SET_MODE",
            payload: "myNormalMode",
          },
          {
            notification: "WHATEVERYOUWANT",
            payload: "sendMe",
          }
        ],
        // if you want to send custom notifications when resuming the module, f.e. switch MMM-Touch to a different "mode"
        notificationsOnResume: [
          {
            notification: "TOUCH_SET_MODE",
            payload: "mySpotifyControlMode",
          },
        ],
        deviceDisplay: "Listening on ", // text to display in the device block (default style only)
        volumeSteps: 5, // in percent, the steps you want to increase or decrese volume when reacting on the "SPOTIFY_VOLUME_{UP,DOWN}" notifications
        // miniBar is no longer supported, use at your own "risk". Will be removed in a future version
        miniBarConfig: {
          album: false, // display Album name in miniBar style
          scroll: true, // scroll title / artist / album in miniBar style
          logo: false, // display Spotify logo in miniBar style
        }
      }
    },
    {
      module: 'MMM-GoogleTrafficTimes',
      position: 'top_left',
      config: {
        key: '<GOOGLE MAP API KEY>',
        origin: '<Address of origin location>',
        destination1: '<Address of destination 1>',
        destination2: '',
        destination3: '',
        AvoidHighways: false,
        AvoidTolls: false,

      },
    }
  ]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {
  module.exports = config;
}

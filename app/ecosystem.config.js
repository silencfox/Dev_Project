module.exports = {
    apps: [{
      name: "devsu-app",
      script: "./index.js",
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: "300M"
    }]
  }
  
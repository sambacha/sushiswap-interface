module.exports = {
  apps: [
    {
      name: 'SushiLayer',
      script: './node_modules/react-scripts/scripts/start.js',
      instances: 0,
      exec_mode: 'cluster',
      watch: true,
      env: {
        NODE_ENV: 'production',
        PORT: '3000'
      }
    }
  ]
};

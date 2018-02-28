const path = require('path');
const BrowserSyncPlugin = require('browser-sync-webpack-plugin');


module.exports = {
  entry: './src/js/app.js',
  output: {
    path: path.resolve(__dirname, 'cloudkitchen/static/js'),
    filename: 'bundle.js'
  },
  watch: true,
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          {
            loader: "style-loader", // creates style nodes from JS strings
          },
          {
            loader: "css-loader", // translate CSS into CommonJS
            options: {
              url: false,
              minimize: true,
              sourceMap: true,
              importLoaders: 1
            }
          },
          {
            loader: 'postcss-loader',
            options: {
              sourceMap: true
            }
          },
          {
            loader: "sass-loader", // compiles SCSS to CSS
            options: {
              sourceMap: true
            }
          }
        ]
      },
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: '/node_mdodules/',
        query: {
          presets: ['es2015'],
        }
      }
    ]
  },
  plugins: [
    new BrowserSyncPlugin(
      // BrowserSync options
      {
        // browse to http://localhost:3000/ during development
        //host: 'localhost',
        //port: 3000,
        // proxy the Webpack Dev Server endpoint
        // (which should be serving on http://localhost:3100/)
        // through BrowserSync
        proxy: 'http://localhost:8000/',
        files: ['./**/*.html', ]
      },
      // plugin options
      {
        // prevent BrowserSync from reloading the page
        // and let Webpack Dev Server take care of this
        reload: true
      }
    )
  ]
};
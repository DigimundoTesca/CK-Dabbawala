const path = require('path');
const BrowserSyncPlugin = require('browser-sync-webpack-plugin');
const ExtractTextWebpackPlugin  = require('extract-text-webpack-plugin');

module.exports = {
  entry: './src/js/app.js',
  output: {
    path: path.resolve(__dirname, 'cloudkitchen/static/js'),
    filename: "bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: ExtractTextWebpackPlugin.extract({
          fallback: 'style-loader', // inject CSS to page
          use: [{
            loader: "css-loader", // translate CSS into CommonJS modules
            options: {
              url: false,
              minimize: true
            }
          }, {
            loader: 'postcss-loader', // Run post css actions
          }, {
            loader: "sass-loader", // compiles SCSS to CSS
          }
          ]
        })
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
    new ExtractTextWebpackPlugin({
      filename: '../css/style.css',
      disable: false,
      allChunks: false
    }),
    new BrowserSyncPlugin(
      {
        proxy: 'http://localhost:8000/',
        files: ['./**/*.html', ],
        open: false
      },
      {
        reload: true
      }
    )
  ],
  devtool: '#source-map'
};

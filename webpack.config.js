const path = require('path');

module.exports = {
  entry: './src/login/login.js',
  output: {
    path: path.resolve(__dirname, 'cloudkitchen/static/js'),
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          {
            loader: "style-loader", // creates style nodes from JS strings
          }, 
          {
            loader: "css-loader", // translate CSS into CcmmonJS
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
  }
};
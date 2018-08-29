const path = require('path')
const UglifyJsPlugin = require('uglifyjs-webpack-plugin')

// https://webpack.js.org/configuration/#options
module.exports = {
  serve: {
    content: './dist'
  },
  mode: 'development',
  target: 'node',
  context: path.resolve(__dirname),
  devtool: 'source-map',
  entry: './src/index.js',
  stats: {
    //object
    assets: false,
    colors: false,
    errors: true,
    errorDetails: true,
    hash: false
    // ...
  },
  output: {
    // libraryTarget: 'umd',
    libraryTarget: 'commonjs2',
    library: 'whatis',
    filename: 'whatis.js',
    path: path.resolve(__dirname, './dist')
  },
  optimization: {
    // sideEffects: fa,
    minimizer: [
      new UglifyJsPlugin({
        cache: true,
        parallel: true,
        sourceMap: true
      })
    ]
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /(node_modules)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env'],
            plugins: ['@babel/plugin-proposal-object-rest-spread']
          }
        }
      }
    ]
  }
}

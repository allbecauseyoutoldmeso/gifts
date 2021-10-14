module.exports = {
  env: {
    browser: true,
    node: true
  },
  parser: '@babel/eslint-parser',
  ignorePatterns: ['public/*'],
  rules: {
    semi: ['off'],
    quotes: ['error', 'single']
  }
}

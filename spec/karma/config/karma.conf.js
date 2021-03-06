'use strict';

module.exports = function(config) {
  config.set({
    basePath: '../..',
    frameworks: ['jasmine'],

    files: [
      '../vendor/assets/javascripts/jquery-2.2.4.min.js',
      '../vendor/assets/javascripts/jasmine-jquery.js',
      '../app/assets/javascripts/registrations.js',
      '../app/assets/javascripts/email_validator.js',
      '../app/assets/javascripts/error_formatter.js',
      '../app/assets/javascripts/required_validator.js',
      'javascripts/*.js',
    ],
    exclude: [
    ],

    preprocessors: {
    },

    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    plugins : [
      'karma-phantomjs-launcher',
      'karma-jasmine'
    ],
    browsers: ['PhantomJS'],
    singleRun: true
  })
};

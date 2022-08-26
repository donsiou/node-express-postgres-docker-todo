'use strict';

const config = require('../config/default');
const { logger } = require('../server/logger');
const { runMigrations } = require('./migrate');

runMigrations(config, logger).catch(error => {
  logger.error(error);
  process.exit(-1);
});

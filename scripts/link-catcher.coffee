# Description:
#   listens for links in the chat and saves them to a PG data store
#
# Dependencies:
#   "pg": "~0.10.2"
#
# Configuration:
#   DATABASE_URL
#
# Commands:
#   None
#
# Notes:
#   Run the following SQL to setup the table and column for storage.
#
#   CREATE TABLE links (
#  
#   )
#
# Author:
#   ShadowBan

Postgres = require 'pg'

# sets up hooks to persist the brain into postgres.
module.exports = (robot) ->

  robot.hear /https?:\/\/[^\s]*/i, (res) ->
    database_url = process.env.DATABASE_URL

    if !database_url?
      throw new Error('link-catcher requires a DATABASE_URL to be set.')

    client = new Postgres.Client(database_url)
    client.connect()
    robot.logger.debug "link-catcher connected to #{database_url}."

    client.on "error", (err) ->
      robot.logger.error err

    client.query('INSERT INTO test (url) VALUES ($1)', [res.match.join('')])



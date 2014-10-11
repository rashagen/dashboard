# Create the meteor collection
@BitcoinAddresses = new Meteor.Collection('bitcoinaddresses')

Schemas = {}

Schemas.BitcoinAddresses = new SimpleSchema

  #  regEx: SimpleSchema.RegEx.Id
  ## Owner
  userId:
    type: String
    regEx: SimpleSchema.RegEx.Id
  # BitcoinAddresses info
  walletId:
    type: String
    regEx: SimpleSchema.RegEx.Id
  label:
    type: String
    optional: true
  address:
    type: String
  balance:
    type: Number
    defaultValue: 0

# Attach the schema to the collection
BitcoinAddresses.attachSchema Schemas.BitcoinAddresses

# Add the created / updated fields
BitcoinAddresses.timed()

# Ensure every document is owned by a user
BitcoinAddresses.owned()
  #Transactions.find(userId: @userId).length

BitcoinAddresses.allow
  insert: (userId, item) ->
    if not userId?
      throw new Meteor.Error 400, "You need to log in to insert."
    _.extend item, userId: userId
  update: (userId, doc, filedNames, modifier) ->
    if userId isnt doc.userId
      throw new Meteor.Error 400, "You can only edit your own entries."
    true
  remove: (userId, doc) ->
    if doc.userId isnt userId
      throw new Meteor.Error 400, "You can only delete your own entries."
    true
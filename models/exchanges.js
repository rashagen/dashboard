this.Exchanges = new Mongo.Collection('exchanges');

if (this.Schemas == null) {
  this.Schemas = {};
}

Schemas.exchangeCredentials = new SimpleSchema({
  secret: {
    type: String,
    optional: true
  },
  APIKey: {
    type: String,
    optional: true
  },
  exchange: {
    type: String,
    optional: true,
    allowedValues: Meteor.settings["public"].coyno.supportedExchangeTypes
  },
  accessToken: {
    type: String,
    optional: true
  },
  refreshToken: {
    type: String,
    optional: true
  },
  externalId: {
    type: String
  }
});

Schemas.Exchanges = new SimpleSchema({
  userId: {
    type: String,
    regEx: SimpleSchema.RegEx.Id
  },
  label: {
    type: String
  },
  exchange: {
    type: String,
    allowedValues: Meteor.settings["public"].coyno.supportedExchangeTypes
  },
  credentials: {
    type: Schemas.exchangeCredentials
  },
  subNode : {
    type: Schemas.nodeReference,
    optional: true
  }
});

Exchanges.attachSchema(Schemas.Exchanges);

Exchanges.timed();

Exchanges.owned();

Exchanges.allow({
  insert: function(userId, item) {
    if (userId == null) {
      throw new Meteor.Error(400, "You need to log in to insert.");
    }
    return _.extend(item, {
      userId: userId
    });
  },
  update: function(userId, doc, filedNames, modifier) {
    if (userId !== doc.userId) {
      throw new Meteor.Error(400, "You can only edit your own entries.");
    }
    return true;
  },
  remove: function(userId, doc) {
    if (doc.userId !== userId) {
      throw new Meteor.Error(400, "You can only delete your own entries.");
    }
    return true;
  }
});

Exchanges.helpers({
  update: function () {
    Meteor.call('updateExchange', this);
  },
  type: function () {
    return this.exchange;
  }
});

if (Meteor.isServer) {
  Exchanges.after.insert(function (userId, doc) {
    Exchanges.findOne({_id: doc._id}).update();
  });
  Exchanges._ensureIndex({userId: 1, "credentials.externalId": 1}, {unique: true});
}



Exchanges.simpleSchema().messages({
  noaccess: "The credentials are invalid. We cannot get access to Coinbase.",
  wrongpermissions: "These API credentials have too many or too few permissions. Please allow only(!) 'addresses'",
  coinbaseapisecretwrongformat: "Provided string is not of the Coinbase API secret format.",
  coinbaseapikeywrongformat: "Provided string is not of the Coinbase API secret format.",
  deactivated: "These API credentials are disabled. You need to enable them first through Coinbase."
});


// ---
// generated by coffee-script 1.9.0

Meteor.publish("transfers", function (page, numberOfResults) {
  var self = this;
  var totalAvailableResults = Transfers.find({}).count();
  var handle = Transfers.find({}, {skip: parseInt(page-1)*parseInt(numberOfResults), limit: numberOfResults, sort: {createdAt: -1}}).observeChanges({
    added: function(id, fields){
      self.added("transfers", id, fields);
      fields.totalAvailable = totalAvailableResults;
    },
    changed: function(id, fields) {
      self.changed("transfers", id, fields);
      fields.totalAvailable = totalAvailableResults;
    },
    removed: function(id) {
      self.removed("transfers", id);
    }
  });
  self.ready();
  self.onStop(function() {
    handle.stop();
  });
});

Meteor.publish("bitcoinwallets", function () {
  return BitcoinWallets.find({userId: this.userId});
});

Meteor.publish("bitcoinaddresses", function () {
  return BitcoinAddresses.find({userId: this.userId});
});

Meteor.publish('user', function() {
  return Meteor.users.find({_id: this.userId});
});

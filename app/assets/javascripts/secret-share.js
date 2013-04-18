var SS = (function () {
  function Secret(id, text) {
    this.id = id;
    this.text = text;
  }

  Secret.prototype.save = function (callback) {
    var that = this;

    $.post("/secrets.json", {
      secret: {
        id: this.id,
        text: this.text
      }
    }, function () {
      // TODO: We should handle potential errors.

      that.id = response.id;

      _(saveCallbacks).each(function (saveCallback) {
        saveCallback();
      });
    });
  };

  Secret.all = [];
  Secret.saveCallbacks = [];
  Secret.fetchAll = function (callback) {
    $.getJSON(
      "/secrets.json",
      function (data) {
        Secret.all = [];
        _.each(data, function (datum) {
          Secret.all.push(new Secret(datum.id, datum.text));
        });

        if (callback) {
          callback(Secret.all);
        }
      }
    );
  };

  function SecretsListView(el, fetchSecretsFn) {
    this.$el = $(el);
    this.fetchSecretsFn = fetchSecretsFn;
  }

  SecretsListView.prototype._insertSecrets = function (secrets) {
    var ul = $("<ul></ul");
    _.each(secrets, function (secret) {
      ul.append($("<li></li>").text(secret.text));
    });

    this.$el.html(ul);
  };

  SecretsListView.prototype.render = function () {
    var that = this;

    // Expect fetchSecretsFn to fetch secrets, then pass them to
    // a callback: that._insertSecrets.
    this.fetchSecretsFn(function () {
      // notice that I needed to use the anonymous function trick.
      that._insertSecrets();
    });
  };

  function SecretFormView(textField, button, callback) {
    this.$textField = $(textField);
    this.$button = $(button);
  }

  SecretFormView.bind = function () {
    var that = this;

    that.buttonClickHandler = function () {
      that.submit();
    };
    that.$button.click(this.buttonClickHandler);
  };

  SecretFormView.unbind = function () {
    var that = this;

    that.$buttion.off('click', buttonClickHandler);
    delete that.buttonClickHandler;
  }

  SecretFormView.submit = function () {
    var that = this;

    var newSecret = new Secret(null, that.$textField.val());
    // clear text field
    $textField.val("");

    callback(newSecret);
  };

  return {
    Secret: Secret,
    SecretsView: SecretsView,
    SecretFormView: SecretFormView
  };
})();

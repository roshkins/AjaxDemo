var SS = (function () {
  function Secret(id, text) {
    this.id = null;
    this.text = text;

    this.save = function () {
      $.post("/secrets.json", {
        id: this.id,
        text: this.text
      }, function (response) {
        console.log(response);
        this.id = response.id;
      });
    }
  };

  Secret.all = [];
  Secret.fetchAll = function (callback) {
    $.getJSON(
      "/secrets.json",
      function (data) {
        Secret.all = [];
        _.each(data, function (datum) {
          Secret.all.push(new Secret(
            datum.id, datum.text));
        });

        callback();
      }
    );
  };

  function SecretsLister(el, secrets) {
    this.render = function () {
      el.empty();

      var ul = $("<ul></ul");
      _.each(secrets, function (secret) {
        ul.append($("<li></li>").text(secret.text));
      });

      $(el).html(ul);
    };
  };

  return {
    Secret: Secret,
    SecretsLister: SecretsLister
  };
})();

// Generated by CoffeeScript 1.4.0
(function() {
  var LampResponses;

  describe("Lamp", function() {
    beforeEach(function() {
      this.lamp = new Lamp;
      return jasmine.Ajax.useMock();
    });
    describe(".letters", function() {
      beforeEach(function() {
        var _this = this;
        this.lamp.letters({
          success: function(json) {
            return _this.json = json;
          }
        });
        return this.request = mostRecentAjaxRequest();
      });
      return it("calls the success callback with an array of letters json", function() {
        this.request.response(LampResponses.letters.success);
        return expect(this.json.length).toEqual(2);
      });
    });
    describe(".count", function() {
      beforeEach(function() {
        var _this = this;
        this.lamp.letters({
          success: function(json) {
            return _this.json = json;
          }
        });
        return this.request = mostRecentAjaxRequest();
      });
      return it("retuns an ajax with a hash of counts", function() {
        this.request.response(LampResponses.letters_count.success);
        expect(this.json.unlocked).toBeDefined();
        return expect(this.json.locked).toBeDefined();
      });
    });
    describe(".letter", function() {
      beforeEach(function() {
        var _this = this;
        this.lamp.letter(1, {
          success: function(json) {
            return _this.json = json;
          }
        });
        return this.request = mostRecentAjaxRequest();
      });
      return it("calls the success callback with the letter json", function() {
        this.request.response(LampResponses.letter.success);
        return expect(this.json.id).toBeDefined();
      });
    });
    return describe(".unlock", function() {
      beforeEach(function() {
        var _this = this;
        this.onError = jasmine.createSpy('onError');
        this.lamp.unlock(1, 'Jack', "Your mom's house", {
          success: function(json) {
            return _this.json = json;
          },
          error: this.onError
        });
        return this.request = mostRecentAjaxRequest();
      });
      describe("with a correct key", function() {
        return it("returns the unlocked letter json", function() {
          this.request.response(LampResponses.letter_unlock.success);
          return expect(this.json.id).toBeDefined();
        });
      });
      return describe("with an incorrect key", function() {
        return it("call the error callback", function() {
          this.request.response(LampResponses.letter_unlock.unprocessible);
          return expect(this.onError).toHaveBeenCalled();
        });
      });
    });
  });

  LampResponses = {
    letters: {
      success: {
        status: 200,
        responseText: '[{"_id":"50f36b165caa7dd371000001","id":"1","unlocked":true,"foundBy":"","foundLocation":"","foundDate":"","foundCount":0},{"_id":"50f36b165caa7dd371000002","id":"2","unlocked":true,"foundBy":"","foundLocation":"","foundDate":"","foundCount":0}]'
      }
    },
    letter: {
      success: {
        status: 200,
        responseText: '{"id":"3","key":"correct","unlocked":true,"_id":"50f36b165caa7dd37100000b","finders":[{"foundDate":"2013-01-14T02:19:02.181Z","foundLocation":"The Park","foundBy":"Joey"}]}'
      }
    },
    letter_unlock: {
      success: {
        status: 200,
        responseText: '{"id":"3","key":"correct","unlocked":true,"_id":"50f36b165caa7dd37100000b","finders":[{"foundDate":"2013-01-14T02:19:02.181Z","foundLocation":"The Park","foundBy":"Joey"}]}'
      },
      not_found: {
        status: 404
      },
      unprocessible: {
        status: 422
      }
    },
    letters_count: {
      success: {
        status: 200,
        responseText: '{"locked":1,"unlocked":2}'
      }
    }
  };

}).call(this);

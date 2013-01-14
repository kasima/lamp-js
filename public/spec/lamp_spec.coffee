describe "Lamp", ->
  beforeEach ->
    @lamp = new Lamp
    jasmine.Ajax.useMock()

  describe ".letters", ->
    beforeEach ->
      @lamp.letters
        success: (json) =>
          @json = json
      @request = mostRecentAjaxRequest()

    it "calls the success callback with an array of letters json", ->
      @request.response(LampResponses.letters.success)
      expect(@json.length).toEqual(2)

  describe ".count", ->
    beforeEach ->
      @lamp.count
        success: (json) =>
          @json = json
      @request = mostRecentAjaxRequest()

    it "retuns an ajax with a hash of counts", ->
      @request.response(LampResponses.letters_count.success)
      expect(@json.unlocked).toBeDefined()
      expect(@json.locked).toBeDefined()

  describe ".letter", ->
    beforeEach ->
      @lamp.letter 1
        success: (json) =>
          @json = json
      @request = mostRecentAjaxRequest()

    it "calls the success callback with the letter json", ->
      @request.response(LampResponses.letter.success)
      expect(@json.id).toBeDefined()

  describe ".unlock", ->
    beforeEach ->
      @onError = jasmine.createSpy 'onError'

      @lamp.unlock 1, 'Jack', "Your mom's house",
        success: (json) =>
          @json = json
        error: @onError
      @request = mostRecentAjaxRequest()

    describe "with a correct key", ->
      it "returns the unlocked letter json", ->
        @request.response(LampResponses.letter_unlock.success)
        expect(@json.id).toBeDefined()

    describe "with an incorrect key", ->
      it "call the error callback", ->
        @request.response(LampResponses.letter_unlock.unprocessible)
        expect(@onError).toHaveBeenCalled()

LampResponses =
  letters:
    success:
      status: 200
      responseText: '[{"_id":"50f36b165caa7dd371000001","id":"1","unlocked":true,"foundBy":"","foundLocation":"","foundDate":"","foundCount":0},{"_id":"50f36b165caa7dd371000002","id":"2","unlocked":true,"foundBy":"","foundLocation":"","foundDate":"","foundCount":0}]'

  letter:
    success:
      status: 200
      responseText: '{"id":"3","key":"correct","unlocked":true,"_id":"50f36b165caa7dd37100000b","finders":[{"foundDate":"2013-01-14T02:19:02.181Z","foundLocation":"The Park","foundBy":"Joey"}]}'

  letter_unlock:
    success:
      status: 200
      responseText: '{"id":"3","key":"correct","unlocked":true,"_id":"50f36b165caa7dd37100000b","finders":[{"foundDate":"2013-01-14T02:19:02.181Z","foundLocation":"The Park","foundBy":"Joey"}]}'

    not_found:
      status: 404

    unprocessible:
      status: 422

  letters_count:
    success:
      status: 200
      responseText: '{"locked":1,"unlocked":2}'

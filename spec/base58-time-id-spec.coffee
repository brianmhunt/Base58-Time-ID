{WorkspaceView} = require 'atom'
Base58TimeId = require '../lib/base58-time-id'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Base58TimeId", ->
  describe "generate_id", ->
    it "returns an ID", ->
      id = Base58TimeId.generate_id()
      expect(typeof id).toEqual('string')
      expect(id.length).toBeLessThan(4)

    it "generates different ids over time", (done) ->
      id = Base58TimeId.generate_id()
      create_id = ->
        other_id = Base58TimeId.generate_id()
        expect(id).toEqual(other_id)
        done()
      setTimeout(create_id, 1100)

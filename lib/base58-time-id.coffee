#
#  base58-time-id
#
# Generate a random value from the time. So we get a new value every second.
# We use base 58 on the basis that it contains the best visual diversity
# and it is a fairly large base of alphanumerics.

# The MOD value balances long ids with uniqueness.
# To keep to 3 base 58 digits the largest number we can have is:
#    58 ^ 3 = 195,112.
# This is conveniently relatively prime to 24*60*60 (otherwise popular
# times of day would yield the same identifiers).
MOD = 58 * 58 * 58  # 3x base58 digits.

module.exports =
  # base58TimeIdView: null
  activate: ->
    atom.workspaceView.command "base58-time-id:new", => @get_new_id()
    @last_id = null

  generate_id: ->
    bases = require 'bases'
    time = new Date().getTime()
    return bases.toBase58(time % MOD)

  get_new_id: ->
    editor = atom.workspace.activePaneItem
    @last_id = @generate_id()
    editor.insertText(@last_id)

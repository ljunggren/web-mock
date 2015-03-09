Feature: Evaluating numerous REST calls
 
Scenario Outline: Accessing server pages with different devices should returned properly formatted content
Given a user accessing environment '<environment>'
When accessing the page '<page>'
And passing the parameters '<parameters>'
Then the content returned should be '<format>'
And the content returned should contain '<keys>'

Examples:

|environment   | page               | parameters                     | format   | keys      |
|test          | test_get_phone.jsp | format=json&aid=A-111111       | json     | A-111111  |

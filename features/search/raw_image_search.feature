Feature: Raw image search
  In order to get raw image search results
  As a user
  I want to search using image queries

  Background:
    Given I am on the search page

  @javascript
  Scenario Outline: I perform raw image search
    Given I select the "Raw Image" tab
    And I fill in "<ra>" for "Right ascension (deg)"
    And I fill in "<dec>" for "Declination (deg)"
    And I fake siap search request for catalogue "<catalogue>" with "<results>"
    And I press "Search SkyMapper"
    Then I should be on the raw image search results page
    And I wait for "Fetching results..."
    And I should see "Query returned <count> objects."
    And I should see raw image search parameters with values ("<ra>", "<dec>")
    And I should see results for catalogue "<catalogue>" as "<results>" in all pages with limit "50"
    And I should see raw image results as "<results>" in all pages with limit "50" in proper order
    Then I follow "Back"
    And I should see the "Raw Image" tab
    And I should see search field "Right ascension (deg)" with value "<ra>"
    And I should see search field "Declination (deg)" with value "<dec>"
  Examples:
    | catalogue | ra        | dec      | results                 | count |
    | image     | 181.16129 | -1.18844 | skymapper_image_query_1 | 36    |
    | image     | 7.01299   | -8.2162  | skymapper_image_query_3 | 1000  |

  @javascript
  Scenario Outline: I perform raw image search returns empty
    Given I select the "Raw Image" tab
    And I fill in "<ra>" for "Right ascension (deg)"
    And I fill in "<dec>" for "Declination (deg)"
    And I fake siap search request for catalogue "<catalogue>" with "<results>"
    And I press "Search SkyMapper"
    Then I should be on the raw image search results page
    And I wait for "Fetching results..."
    And I should see "Query returned <count> objects."
    And I should see raw image search parameters with values ("<ra>", "<dec>")
    And I should not see any results
  Examples:
    | catalogue | ra        | dec      | results                 | count |
    | image     | 178.83871 | -1.18844 | skymapper_image_query_2 | 0     |

  @javascript
  Scenario Outline: I can submit raw image search with the follow values
    Given I select the "Raw Image" tab
    And I fill in "<value>" for "<field>"
    Then I should not see any errors for "<field>"
  Examples:
    | field                 | value      |
    | Right ascension (deg) | 0          |
    | Right ascension (deg) | 00:00:00   |
    | Right ascension (deg) | 00 00 00   |
    | Right ascension (deg) | 15 15 15   |
    | Right ascension (deg) | 23 59 00   |
    | Right ascension (deg) | 23:59:00   |
    | Right ascension (deg) | 359.999999 |
    | Right ascension (deg) | 123.123456 |
    | Declination (deg)     | -90        |
    | Declination (deg)     | -90:00:00  |
    | Declination (deg)     | -90 00 00  |
    | Declination (deg)     | 90:00:00  |
    | Declination (deg)     | 90 00 00  |
    | Declination (deg)     | 90         |
    | Declination (deg)     | 12.123456  |

  @javascript
  Scenario Outline: I cannot submit raw image search if form has errors
    Given I select the "Raw Image" tab
    And I fill in "<value>" for "<field>"
    Then I should see error "<error>" for "<field>"
  Examples:
    | field                 | value       | error                                                                                             |
    | Right ascension (deg) | -1          | This field should be a number in one of the following formats HH:MM:SS.S or HH MM SS.S or DDD.DD. |
    | Right ascension (deg) | -01:12:12   | This field should be a number in one of the following formats HH:MM:SS.S or HH MM SS.S or DDD.DD. |
    | Right ascension (deg) | 360         | Value in degrees should be a number greater than or equal to 0 and less than or equal to 360.     |
    | Right ascension (deg) | 24:00:00    | Value in degrees should be a number greater than or equal to 0 and less than or equal to 360.     |
    | Right ascension (deg) | 1.123456789 | This field should be a number in one of the following formats HH:MM:SS.S or HH MM SS.S or DDD.DD. |
    | Right ascension (deg) | 7abc        | This field should be a number in one of the following formats HH:MM:SS.S or HH MM SS.S or DDD.DD. |
    | Right ascension (deg) | 7abc        | This field should be a number in one of the following formats HH:MM:SS.S or HH MM SS.S or DDD.DD. |
    | Declination (deg)     | -91         | Value in degrees should be a number greater than or equal to -90 and less than or equal to 90.    |
    | Declination (deg)     | -91:00:00   | Value in degrees should be a number greater than or equal to -90 and less than or equal to 90.    |
    | Declination (deg)     | -91 00 00   | Value in degrees should be a number greater than or equal to -90 and less than or equal to 90.    |
    | Declination (deg)     | 91          | Value in degrees should be a number greater than or equal to -90 and less than or equal to 90.    |
    | Declination (deg)     | 1.123456789 | This field should be a number in one of the following formats DD:MM:SS.S or DD MM SS.S or DDD.DD. |
    | Declination (deg)     | 7abc        | This field should be a number in one of the following formats DD:MM:SS.S or DD MM SS.S or DDD.DD. |
    | Declination (deg)     | 7abc        | This field should be a number in one of the following formats DD:MM:SS.S or DD MM SS.S or DDD.DD. |

  @javascript
  Scenario Outline: I cannot submit raw image search if form has errors (required errors)
    Given I select the "Raw Image" tab
    And I press "Search SkyMapper"
    And I fill in "" for "<field>"
    And I press "Search SkyMapper"
    Then I should see error "<error>" for "<field>"
  Examples:
    | field                 | error                   |
    | Right ascension (deg) | This field is required. |
    | Declination (deg)     | This field is required. |

  @javascript
  Scenario Outline: I can download an image file
    Given I select the "Raw Image" tab
    And I fill in "<ra>" for "Right ascension (deg)"
    And I fill in "<dec>" for "Declination (deg)"
    And I fake siap search request for catalogue "<catalogue>" with "<results>"
    And I press "Search SkyMapper"
    Then I should be on the raw image search results page
    And I wait for "Fetching results..."
    And I should see "Query returned <count> objects."
    And I should see raw image search parameters with values ("<ra>", "<dec>")
    And I should see results for catalogue "<catalogue>" as "<results>" in all pages with limit "50"
    Then I fake request for first image link
    And I click the first image link
    And I pause for 1 seconds
    Then I should see "You are about to download an image that is approximately 512MB."
    And I download the image file
  Examples:
    | catalogue | ra        | dec      | results                 | count |
    | image     | 181.16129 | -1.18844 | skymapper_image_query_1 | 36    |

  @javascript
  Scenario Outline: I can see raw image search object details
    Given I select the "Raw Image" tab
    And I fill in "<ra>" for "Right ascension (deg)"
    And I fill in "<dec>" for "Declination (deg)"
    And I fake siap search request for catalogue "<catalogue>" with "<results>"
    And I press "Search SkyMapper"
    Then I should be on the raw image search results page
    And I wait for "Fetching results..."
    And I should see "Query returned <count> objects."
    And I should see results for catalogue "<catalogue>" as "<results>" in all pages with limit "50"
    And I should see raw image results as "<results>" in all pages with limit "50" in proper order
    And I click on the object in row "<row>"
    Then I should see details for the object in row "<row>" with image results "<results>"
  Examples:
    | catalogue | ra        | dec       | results                 | count | row |
    | image     | 181.16129 | -1.18844  | skymapper_image_query_1 | 36    | 1   |
    | image     | 12:04:39  | -01:53:04 | skymapper_image_query_1 | 36    | 1   |
    | image     | 7.01299   | -8.2162   | skymapper_image_query_3 | 1000  | 2   |
    | image     | 00:28:03  | -08 12 58 | skymapper_image_query_3 | 1000  | 2   |
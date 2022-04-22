#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Feature: Sample

    Background:
        Given I have deployed the business network definition ..
        And I have added the following participants of type org.example.blockchainbank.SampleParticipant
            | participantId   | firstName | lastName |
            | mustafizur118@gmail.com | mustafizur     | A        |
            | shakil@gmail.com   | shakil       | B        |
        And I have added the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | mustafizur118@gmail.com | 10    |
            | 2       | shakil@gmail.com   | 20    |
        And I have issued the participant org.example.blockchainbank.SampleParticipant#mustafizur@GMAIL.com with the identity mustafizur1
        And I have issued the participant org.example.blockchainbank.SampleParticipant#shakil@GMAIL.com with the identity shakil1

    Scenario: mustafizur can read all of the assets
        When I use the identity mustafizur1
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | mustafizur118@gmail.com | 10    |
            | 2       | shakil@gmail.com   | 20    |

    Scenario: shakil can read all of the assets
        When I use the identity mustafizur1
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | mustafizur@GMAIL.com | 10    |
            | 2       | shakil@GMAIL.com   | 20    |

    Scenario: mustafizur can add assets that she owns
        When I use the identity mustafizur1
        And I add the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 3       | mustafizur@GMAIL.com | 30    |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 3       | mustafizur@GMAIL.com | 30    |

    Scenario: mustafizur cannot add assets that shakil owns
        When I use the identity mustafizur1
        And I add the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 3       | shakil@GMAIL.com   | 30    |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: shakil can add assets that he owns
        When I use the identity shakil1
        And I add the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 4       | shakil@GMAIL.com   | 40    |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 4       | shakil@GMAIL.com   | 40    |

    Scenario: shakil cannot add assets that mustafizur owns
        When I use the identity shakil1
        And I add the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 4       | mustafizur@GMAIL.com | 40    |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: mustafizur can update her assets
        When I use the identity mustafizur1
        And I update the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | mustafizur@GMAIL.com | 50    |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | mustafizur@GMAIL.com | 50    |

    Scenario: mustafizur cannot update shakil's assets
        When I use the identity mustafizur1
        And I update the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 2       | shakil@GMAIL.com   | 50    |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: shakil can update his assets
        When I use the identity shakil1
        And I update the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner         | value |
            | 2       | shakil@GMAIL.com | 60    |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner         | value |
            | 2       | shakil@GMAIL.com | 60    |

    Scenario: shakil cannot update mustafizur's assets
        When I use the identity shakil1
        And I update the following asset of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | mustafizur@GMAIL.com | 60    |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: mustafizur can remove her assets
        When I use the identity mustafizur1
        And I remove the following asset of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 1       |
        Then I should not have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 1       |

    Scenario: mustafizur cannot remove shakil's assets
        When I use the identity mustafizur1
        And I remove the following asset of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 2       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: shakil can remove his assets
        When I use the identity shakil1
        And I remove the following asset of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 2       |
        Then I should not have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 2       |

    Scenario: shakil cannot remove mustafizur's assets
        When I use the identity shakil1
        And I remove the following asset of type org.example.blockchainbank.SampleAsset
            | assetId |
            | 1       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: mustafizur can submit a transaction for her assets
        When I use the identity mustafizur1
        And I submit the following transaction of type org.example.blockchainbank.SampleTransaction
            | asset | newValue |
            | 1     | 50       |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner           | value |
            | 1       | mustafizur@GMAIL.com | 50    |
        And I should have received the following event of type org.example.blockchainbank.SampleEvent
            | asset   | oldValue | newValue |
            | 1       | 10       | 50       |

    Scenario: mustafizur cannot submit a transaction for shakil's assets
        When I use the identity mustafizur1
        And I submit the following transaction of type org.example.blockchainbank.SampleTransaction
            | asset | newValue |
            | 2     | 50       |
        Then I should get an error matching /does not have .* access to resource/

    Scenario: shakil can submit a transaction for his assets
        When I use the identity shakil1
        And I submit the following transaction of type org.example.blockchainbank.SampleTransaction
            | asset | newValue |
            | 2     | 60       |
        Then I should have the following assets of type org.example.blockchainbank.SampleAsset
            | assetId | owner         | value |
            | 2       | shakil@GMAIL.com | 60    |
        And I should have received the following event of type org.example.blockchainbank.SampleEvent
            | asset   | oldValue | newValue |
            | 2       | 20       | 60       |

    Scenario: shakil cannot submit a transaction for mustafizur's assets
        When I use the identity shakil1
        And I submit the following transaction of type org.example.blockchainbank.SampleTransaction
            | asset | newValue |
            | 1     | 60       |
        Then I should get an error matching /does not have .* access to resource/

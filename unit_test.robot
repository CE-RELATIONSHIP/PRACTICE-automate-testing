*** Settings ***
Library    RequestsLibrary
Suite Setup    Create Session    my_api    http://127.0.0.1:5000
Suite Teardown    Delete All Sessions

*** Variables ***
${NEXT5_ENDPOINT}    /next5
${HEADERS}    {"Content-Type": "application/json"}

*** Test Cases ***
Test when x is 1
    ${response}=    GET    ${NEXT5_ENDPOINT}/1
    Status Should Be    200
    Should Be Equal As Numbers   ${response.json()}   6
    Log    ${\n}Result: ${response.json()}    console=True

Test when x is -10
    ${response}=    GET    ${NEXT5_ENDPOINT}/-10
    Status Should Be    200
    Should Be Equal As Numbers   ${response.json()}   -5
    Log    ${\n}Result: ${response.json()}    console=True

Test when x is 1.5
    ${response}=    GET    ${NEXT5_ENDPOINT}/1.5
    Status Should Be    200
    Should Be Equal As Numbers   ${response.json()}   6.5
    Log    ${\n}Result: ${response.json()}    console=True

*** Keywords ***
GET
    [Arguments]    ${endpoint}
    ${response}=    GET On Session    my_api    ${endpoint}    expected_status=anything 
    RETURN    ${response}

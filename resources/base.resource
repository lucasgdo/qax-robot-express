*** Settings ***
Library    libs/database.py
Library    Browser
Library    JSONLibrary
Resource    env.resource
Resource    pages/components/Alert.resource
Resource    pages/components/Header.resource
Resource    pages/components/Notice.resource
Resource    pages/LoginPage.resource
Resource    pages/SignupPage.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TaskListPage.resource
Resource    services.resource

*** Keywords ***
Start Session
    New Browser    browser=${BROWSER}    headless=False
    New Page    ${BASE_URL}

Get Fixture
    [Arguments]    ${file_name}    ${scenario}
    ${data}    Load Json From File    ${EXECDIR}/resources/fixtures/${file_name}.json    encoding=utf-8
    RETURN    ${data}[${scenario}]

Reset User
    [Arguments]    ${user}
    Clean User From Database    ${user}[email]
    Insert User Into Database    ${user}

Create Task
    [Arguments]    ${user}    ${task}
    POST User Session    ${user}
    POST New Task    ${task}

Log In
    [Arguments]    ${user}
    Submit Login Form    ${user}
    User Should Be Logged In    ${user}[name]
*** Settings ***
Documentation    Cenários de teste de remoção de tarefas
Resource    ../../resources/base.resource
Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder apagar uma tarefa
    ${data}    Get Fixture    tasks    delete
    Reset User    ${data}[user]
    Create Task    ${data}[user]    ${data}[task]
    Log In    ${data}[user]
    Remove Task    ${data}[task][name]
    Task Should Not Exist    ${data}[task][name]
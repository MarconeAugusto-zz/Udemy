*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}        http://automationpractice.com
${BROWSER}    firefox

*** Keywords ***
### Setup e Teardown
Abrir navegador
    Open Browser        about:blank            ${BROWSER}

Fechar navegador
    Close Browser

### Passo a passo
Acessar a pagina home do site
    Go To               ${URL}
    Title Should Be     My Store

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text          name=search_query      ${PRODUTO}

Clicar no botão Pesquisar
    Click Element       name=submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element is Visible     css=#center_column > h1
    Title Should Be                   Search - My Store
    Page Should Contain Image         xpath=//*[@id="center_column"]//*[@src="http://automationpractice.com/img/p/7/7-home_default.jpg"]
    Page Should Contain Link          xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]

Conferir mensagem de erro "No results were found for your search "${PRODUTO}""
    Wait Until Element is Visible     xpath=//*[@id="center_column"]/h1
    Title Should Be                   Search - My Store
    Page Should Contain Element       xpath=//*[@id="center_column"]/*[@class="alert alert-warning"][contains(text(),"${PRODUTO}")]
    Page Should Contain Element       xpath=//*[@id="center_column"]//span[@class="heading-counter"][contains(text(),"0 results have been found.")]

Mause sobre a categoria "${CATEGORIA}"
    Wait Until Element is Visible     xpath=//*[@id="block_top_menu"]/ul
    Mouse Over                        xpath=//*[@id="block_top_menu"]//a[@class="sf-with-ul"][contains(text(),"${CATEGORIA}")]

Clicar na sub categoria "${CATEGORIA}"
    Mouse Down                        xpath=//*[@id="block_top_menu"]//a[@class="sf-with-ul"][contains(text(),"Women")]
    Click Element                     xpath=//*[@id="block_top_menu"]//a[contains(text(),"${CATEGORIA}")]

Conferir categoria Summer Dresses
    Wait Until Element is Visible     xpath=//*[@id="center_column"]/div[1]/div
    Page Should Contain Element       xpath=//*[@id="center_column"]//a[contains(text(),"Printed Summer Dress")]
    Page Should Contain Element       xpath=//*[@id="center_column"]/ul/li[2]/div/div[2]/h5/a[contains(text(),"Printed Summer Dress")]
    Page Should Contain Element       xpath=//*[@id="center_column"]//a[contains(text(),"Printed Chiffon Dress")]

Clicar no botão "Add to cart" do produto
    Wait Until Element is Visible     xpath=//*[@id="center_column"]/h1
    Mouse Over                        xpath=//*[@id="center_column"]/ul/li/div/div[1]/div/a[1]/img
    Click Element                     xpath=//*[@id="center_column"]//*[@class="button ajax_add_to_cart_button btn btn-default"]

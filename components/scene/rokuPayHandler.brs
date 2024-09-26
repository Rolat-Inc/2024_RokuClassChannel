sub initializeChannelStore()
    m.global.addFields({
        channelStore: createObject("roSGNode", "ChannelStore"),
        isUserActive: true  ' In a real scenario, this should be initialized in false
    })

    verifyUserActive()
end sub

sub verifyUserActive()
    m.global.channelStore.command = "getPurchases"
    m.global.channelStore.observeField("purchases", "onGetPurchases")
end sub

sub onGetPurchases(event as object)
    m.global.unobserveField("purchases")
    purchases = event.getData()

    if purchases.getChildCount() > 0 then
        dateTime = createObject("roDateTime")
        now = dateTime.asSeconds()

        for each purchase in purchases
           dateTime.fromISO8601String(purchase.expirationDate)
           productExpirationDate = dateTime.asSeconds()

           if productExpirationDate > now then m.global.isUserActive = true
           exit for
        end for
    end if
end sub

sub showSubscriptionOptions()
    m.global.channelStore.command = "getCatalog"
    m.global.channelStore.observeField("catalog", "onGetCatalog")
end sub

sub onGetCatalog(event as object)
    m.global.unobserveField("catalog")
    dialogSubscriptionButtons = []
    m.activeCatalogItems = []
    catalog = event.getData()

    if catalog.getChildCount() > 0 then
        for each product in catalog
            dialogSubscriptionButtons.push(product.name + " - " + product.cost)
            m.activeCatalogItems.push({
                code: product.code,
                name: product.name
            })
        end for

        showSubscriptionsDialog(dialogSubscriptionButtons)
    else
        showErrorDialog("There are no subscriptions available")
    end if
end sub

sub showSubscriptionsDialog(dialogSubscriptionButtons as object)
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = "Subscriptions"
    dialog.message = "Please select a subscription"
    dialog.buttons = dialogSubscriptionButtons
    
    m.top.getScene().dialog = dialog

    dialog.observeField("buttonSelected", "onSusbscriptionSelected")
end sub

sub onSusbscriptionSelected(event as object)
    m.top.getScene().dialog.unobserveField("buttonSelected")

    buttonSelectedIndex = event.getData()
    subscription = m.activeCatalogItems[buttonSelectedIndex]

    createOrder(subscription)
end sub

sub createOrder(subscription as object)
    order = createObject("RoSGNode", "ContentNode")
    product = order.createChild("ContentNode")

    product.addFields({
        code: subscription.code,
        name: subscription.name,
        qty: 1
    })

    doOrder(order)
end sub

sub doOrder(order as object)
    m.global.channelStore.order = order
    m.global.channelStore.command = "doOrder"
    m.global.channelStore.observeField("orderStatus", "onOrderStatusChange")
end sub

sub onOrderStatusChange(event as object)
    m.global.channelStore.unobserveField("orderStatus")

    orderStatus = event.getData()

    if orderStatus <> invalid and orderStatus.status = 1 then
        m.global.isUserActive = true
        m.top.getScene().videoMessage = {
            control: "continueSubscriptionFlow"
        }
    else
        showErrorDialog("Failed to process your payment, please try again.")
    end if
end sub

sub showErrorDialog(message = "" as string)
    dialog = CreateObject("roSGNode", "Dialog")
    dialog.title = "Error"
    dialog.message = message
    m.top.getScene().dialog = dialog
end sub
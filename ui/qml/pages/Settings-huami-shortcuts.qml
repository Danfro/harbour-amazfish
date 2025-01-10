import QtQuick 2.0
import uk.co.piggz.amazfish 1.0
import QtQml.Models 2.1

import "../components"
import "../components/platform"

PagePL {
    id: page
    title: qsTr("Huami Display Items")

    ListModel {
        id: displayItems
    }

    Column
    {
        id: column
        width: parent.width
        anchors.top: parent.top
        anchors.margins: styler.themePaddingMedium
        spacing: styler.themePaddingLarge

        ListView {
            id: view
            width: parent.width
            height: page.height * 0.6
            model: displayItems
            spacing: 4
            cacheBuffer: 50
            clip: true
            delegate: DraggableItem {
                Item {
                    height: textSwitch.height * 1.5
                    width: view.width

                    TextSwitchPL {
                        id: textSwitch
                        text: itemText
                        checked: itemVisible
                        width: parent.width / 2
                        y: (parent.height - height) / 2
                        onCheckedChanged: {
                            itemVisible = checked;
                        }
                    }
                }
                draggedItemParent: page
                onMoveItemRequested: {
                    displayItems.move(from, to, 1);
                }
            }
        }

        ButtonPL {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Save Settings")
            onClicked: {
                saveDisplayItems();
                saveSettings();
            }
        }

        Timer {
            //Allow data to sync
            id: tmrSetDelay
            repeat: false
            interval: 500
            running: false
            onTriggered: {
                DaemonInterfaceInstance.applyDeviceSetting(Amazfish.SETTING_DEVICE_DISPLAY_ITEMS);
                app.pages.pop();
            }
        }
    }


    Component.onCompleted: {
        buildDisplayItemsModel();
    }

    function saveSettings() {
        tmrSetDelay.start();
    }

    function displayName(name) {
        const translations = {
            "status": qsTr("Status"),
            "hr": qsTr("HR"),
            "workout": qsTr("Workout"),
            "weather": qsTr("Weather"),
            "notifications": qsTr("Notifications"),
            "more": qsTr("More"),
            "dnd": qsTr("DND"),
            "alarm": qsTr("Alarm"),
            "takephoto": qsTr("Take Photo"),
            "music": qsTr("Music"),
            "stopwatch": qsTr("Stopwatch"),
            "timer": qsTr("Timer"),
            "findphone": qsTr("Find Phone"),
            "mutephone": qsTr("Mute Phone"),
            "nfc": qsTr("NFC"),
            "alipay": qsTr("AliPay"),
            "watchface": qsTr("Watch Face"),
            "settings": qsTr("Settings"),
            "activity": qsTr("Activity"),
            "eventreminder": qsTr("Event Reminder"),
            "compass": qsTr("Compass"),
            "pai": qsTr("PAI"),
            "worldclock": qsTr("World Clock"),
            "timer_stopwatch": qsTr("Timer/Stopwatch"),
            "stress": qsTr("Stress"),
            "period": qsTr("Period"),
            "goal": qsTr("Goal"),
            "sleep": qsTr("Sleep"),
            "spo2": qsTr("SpO2"),
            "events": qsTr("Events"),
            "widgets": qsTr("Widgets"),
            "breathing": qsTr("Breathing"),
            "steps": qsTr("Steps"),
            "distance": qsTr("Distance"),
            "calories": qsTr("Calories"),
            "pomodoro": qsTr("Pomodoro"),
            "alexa": qsTr("Alexa"),
            "battery": qsTr("Battery"),
            "temperature": qsTr("Temperature"),
            "barometer": qsTr("Barometer"),
            "flashlight": qsTr("Flashlight")
        };
        if (translations[name] !== undefined) {
            return translations[name];
        }
        return name;
    }

    function buildDisplayItemsModel() {
        var saveditems = AmazfishConfig.deviceDisplayItems.split(",");

        for (var i = 0; i < saveditems.length; i++) {
            if (saveditems[i] !== "") {
                displayItems.append({"itemId": saveditems[i], "itemText": displayName(saveditems[i]), "itemVisible": true});
            }
        }

        var items = DaemonInterfaceInstance.supportedDisplayItems();
        for (i = 0; i < items.length; i++) {
            if (saveditems.indexOf(items[i]) < 0) {
                displayItems.append({"itemId": items[i], "itemText": displayName(items[i]), "itemVisible": false});
            }
        }
    }

    function saveDisplayItems() {
        var items = "";
        for(var i = 0; i < displayItems.count; ++i) {
            console.log(displayItems.get(i).itemText, displayItems.get(i).itemVisible );
            if (displayItems.get(i).itemVisible) {
                items = items + displayItems.get(i).itemId + ",";
            }
        }
        console.log(items);
        AmazfishConfig.deviceDisplayItems = items;
    }
}


